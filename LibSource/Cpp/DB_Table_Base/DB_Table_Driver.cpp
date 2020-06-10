// Using Visual C++ version 4.x and later to compile a C++ program with the /Zi option generates the following warning: 
// warning C4786: 'identifier' : identifier was truncated to '255' characters in the debug information 
// See http://support.microsoft.com/support/kb/articles/Q122/5/39.ASP

// Since the above states that these warning can be ignored
// Try and Disable Warning C4786... 
#pragma warning ( disable : 4786 )

// Compiler Warning (level 1) C4251
// 'identifier' : class 'type' needs to have dll-interface to be used by clients of class 'type2'
// The specified base class was not declared with the __declspec(dllexport) keyword.
// A base class or structure must be declared with the __declspec(dllexport) keyword if a function in a derived class is to be exported.

// Since the program seems to work properly 
// Try and disable warning C4251
#pragma warning ( disable : 4251 )

#include <vector>
#include <string>

#include <iostream>

#include "DB_Table_Base.h"
//#include "AddJavaScript/AddJavaScript.h"
#include "LinkMap/LinkMap.h" // associative map class
#include "ConnectionsFunctions/ConnectionsFormLayout.h"
#include "Connections_Templates/Connections_Templates.h"

//#incude "Login_Info.h"
//#include "Contact_Info.h"
#include "About_Info.h"
//#include "Personal_Info.h"
//#include "AdvancedSearch_Info.h"

using std::cout;
using std::endl;
using std::flush;
using cgicc::Cgicc;

int main()
{
	// make this the very first thig printed to prevent CGI ERRORS...
	cout << "Content-Type: text/html\n\n" << flush;

	Cgicc cgi;
	
	// Get a pointer to the environment so the user's IP address can be retrieved...
    const CgiEnvironment& env = cgi.getEnvironment();

	//	instantiate the class that defines the form layouts for the page...
	CConnectionsFormLayout cfl;
	
	// Read the file containg the current URL configurations...
	//LinkMap Map( cfl.GetLinkMapPath() );

	// For testing on Burns...
	//LinkMap Map( "D:\\MyData\\Personal\\Projects\\Connections\\PersianConnectionsWebDev\\cgi-bin\\LinkMap.dat" );
	
	// For testing on Grimes...
	//LinkMap Map( "C:\\wwwroot\\Test_Connections\\cgi-bin\\LinkMap.dat" );

	// For testing on New ValuWeb Box...
	LinkMap Map( "C:\\wwwroot\\Latin_Love_Match.com\\cgi-bin\\LinkMap.dat" );

	// EXIT and print error HTML if the LinkMap.dat file could not be opened...	
	if(Map.PrintValue("ERROR") == "1")
	{
//		cout << HTTPHTMLHeader() << endl << flush;
		cfl.Html_DefaultErrorMessagePage(Map);
		return EXIT_FAILURE;
	}
	
//	cout << HTTPHTMLHeader() << endl << flush;

	cout << "<HTML>" << endl;

	cout << "<HEAD>" << endl;
	cout << "<TITLE></TITLE>" << endl;
	cout << "</HEAD>" << endl;
	cout << "<BODY BGCOLOR=\"#FFFFFF\" TEXT=\"#000000\" LINK=\"#0000FF\" VLINK=\"#800080\" ALINK=\"#FF0000\">" << endl;

	cout << "Begin execution of DB_Table_Driver.cpp...<BR>\n" << endl << flush;

	cout << "cgicc env.getRemoteAddr() = (" << env.getRemoteAddr() << ")" << endl;

	cout << "Linkmap DBNAME = (" << Map.PrintValue("DBNAME") << ")" << endl;
	cout << "Linkmap DBUSER = (" << Map.PrintValue("DBUSER") << ")" << endl;
	cout << "Linkmap DBPWD  = (" << Map.PrintValue("DBPWD") << ")" << endl;
	
	//db_table_base_namespace::DB_Table_Base * Base_Ptr = new Login_Info("getLoginInfoByNamePassword", "updateLoginInfo");
	//db_table_base_namespace::DB_Table_Base * Base_Ptr = new Contact_Info("getContactInfoByNamePassword", "updateLoginInfo");
	db_table_base_namespace::DB_Table_Base * Base_Ptr = new About_Info("getAboutInfoByNamePassword", "updateAboutInfo");
	//db_table_base_namespace::DB_Table_Base * Base_Ptr = new Personal_Info("getPersonalInfoByNamePassword", "updatePersonalInfo");
	//db_table_base_namespace::DB_Table_Base * Base_Ptr = new AdvancedSearch_Info("advancedSearch", "");
	

	//cout << "\nBefore DB calls...1\n" << flush;
	// test login_info script
	//Sql_buf =  "\"54\", \"Jason\", \"\", \"janesays\", \"password hint\", \"baumbach@bellatlantic.net\", \"0\", \"2000-07-25 19:13:47.800\", \"\"";
	// test contact_info script
	//Base_Ptr->Set_Update_Info_Sql("\"\", \"Jason\", \"Baumbach\", \"116 Willow\", \"Hoboken\", \"2\", \"0\", \"\", \"212-687-0987\"");
	// test mail script
//	Base_Ptr->Set_Update_Info_Sql("\"ann\", \"jatlast\", \"Hello again and again and again.\"");
	Base_Ptr->Set_Get_Info_Sql("\"administrator\", \"janesays\"");

	//cout << "\nAfter DB calls...1\n" << flush;
	//Base_Ptr->Set_Get_Info_Sql( "\"0\", \"%\", \"%\", \"%\", \"%\", \"%\", \"18\", \"99\", \"10\", \"0\"" );

	//Base_Ptr->Get_Form_Info_From_Cgi(cgi);
	Base_Ptr->Get_Info_From_DB(Map);

	//cout << "\nAfter DB calls...2\n" << flush;
	
	//int start = 1;
	//int limit = 4;

	//cout << "<!-- SQL " << Base_Ptr->Get_Get_Info_Sql() << "-->" << endl;

	//cout << "\nAfter DB calls...3\n" << flush;

	cout << "\nAbout Info Before: ----\n\n " << Base_Ptr->Get_DBData_From_ColumnName("about_yourself") << endl << flush;

	cout << "\nAbout Info After: ----\n\n " << Replace_Email_With_Links( Base_Ptr->Get_DBData_From_ColumnName("about_yourself"), "persianconnections", Map ) << endl << flush;


	//for(int i=0; i<Base_Ptr->Vect.size(); i++)
	//cout << Base_Ptr->Vect[i] << endl;



	//cout << "<!-- TEST (" << Base_Ptr->test << ")-->" << endl;

	
	cout << "</BODY>" << endl;
	cout << "</HTML>" << endl;

	//delete Base_Ptr;
}