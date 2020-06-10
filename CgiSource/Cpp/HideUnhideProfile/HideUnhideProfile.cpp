/************************************************************************
*                                                                       *
*  PROGRAM ID         : HideUnhideProfile.cpp							            *
*                                                                       *
*  DESCRIPTION        : Update a user's Profile.                        *
*   This program depends on all the database tables.				    *
*	Service database.                                                   *
*																		*
*  ENTRY POINTS       : LogIn.html			  					        *
*                                                                       *
*  INPUT                                                                *
*  PARAMETERS         : This is a CGI script that is called by the      *
*	UpdateProfile.html page                                             *
*                                                                       *
*  INPUT FILES        : UpdateProfile.html                              *
*                                                                       *
*  OUTPUT FILES       :												    *
*                                                                       *
*  DB TABLES          : All User Profile tables                         *
*                                                                       *
*  COMPOSITE                                                            *
*  FILES              : ????     These are the modules that are         *
*                                required if this application is        *
*                                migrated to another platform such      *
*                                as UNIX.                               *
*                                                                       *
*  DEPENDENT                                                            *
*  PROGRAMS           : Requires Cgicc.C files, Web, & Database         *
*                                                                       *
*  COMPILE/LINK                                                         *
*  PROCEDURES         :											        *
*                                                                       *
*************************************************************************
*                                                                       *
*                         MODIFICATION LOG                              *
*                                                                       *
* Date      Auth   Description                                 SR#      *
* --------  -----  ------------------------------------------  -------- *
* 7-08-00   JTB    Initial Release                                      *
*                                                                       *
*************************************************************************/

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


#include <string>
#include <iostream>

#include "cgicc/CgiDefs.h"
#include "cgicc/Cgicc.h"
#include "cgicc/HTMLClasses.h"

#include "ConnectionsFunctions/ConnectionsFormLayout.h"
#include "Connections_Templates/Connections_Templates.h"
#include "LinkMap/LinkMap.h" // associative map class
#include "DB_Table_Base/Login_Info.h"
#include "CommentMacro.h" // contains the contains the comment macro def of "dout"


using std::flush;
using namespace cgicc;

int
main ()
{
	// make this the very first thig printed to prevent CGI ERRORS...
	cout << "Content-Type: text/html\n\n" << flush;

	string Program_Name("HideUnhideProfile.exe");
	string caller = "";
	bool cookies_found = false;
	//	instantiate the class that defines the form layouts for the page...
	CConnectionsFormLayout cfl;
	
	//	Create a new Cgicc object containing all the CGI data...
	Cgicc cgi;
	
    // Get a pointer to the environment so the Server Name can be retrieved...
    const CgiEnvironment& env = cgi.getEnvironment();

	// Read the file containg the current URL configurations...
	LinkMap Map( cfl.GetLinkMapPath(), env.getServerName() );
	
	// EXIT and print error HTML if the LinkMap.dat file could not be opened...	
	if(Map.PrintValue("ERROR") == "1")
	{
//		cout << HTTPHTMLHeader() << endl << flush;
		cfl.Html_DefaultErrorMessagePage(Map);
		return EXIT_FAILURE;
	}	

	//	Create a Login_Info object to hold all the Form and Database data...
	DB_Table_Base * Base_Ptr = new Login_Info("hideUnhideProfile");
	
	
	// Begin HTML
//	cout << HTTPHTMLHeader() << endl << flush;
	cfl.Html_Begin(Map, 1, HIDE_UNHIDE_PROFILE);
	

	// Get user_name and password from cookie list
	string cookie_name("");
	string cookie_password("");
	if(Get_Cookie_Name_Password(cgi, cookie_name, cookie_password))
	{
		if( !cookie_name.empty() )
		{
			// this is a hack but it puts the current user_name in the right place...
			//login_info.Vect[1].web_form_data = cookie_name.data();
			dout << "<!-- FOUND: cookie_name     : " << cookie_name     << "-->\n";
			dout << "<!-- FOUND: cookie_password : " << cookie_password << "-->\n";
			cookies_found = true;
		}
		else
		{
			dout << "<!-- ERROR: cookie_name     : " << cookie_name     << "-->\n";
			dout << "<!-- ERROR: cookie_password : " << cookie_password << "-->\n";
		}
	}


		string Sql_buf("");
		
		Sql_buf += ("\"" + cookie_name + "\", \"" + cookie_password + "\"");
		
		bool Return_Status = false;
		Base_Ptr->Set_Update_Info_Sql( Sql_buf );
		
		dout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl;
		
		Return_Status = Base_Ptr->Update_Info_In_DB(Map);
		
		if(Return_Status == false)
		{
			dout << "<!-- ERROR: DB or Message error. -->\n" << endl;
			dout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl;
			cout << "<font face=geneva,arial color=blue size=+1>" << Base_Ptr->DB_Table_Base_Error_Text << "</font>\n" << endl;
			if (Base_Ptr->DB_Table_Base_Error_Number >= 100 && Base_Ptr->DB_Table_Base_Error_Number < 200)
			{
				cfl.Html_MemberLogIn(Map);
			}
			else if(Base_Ptr->DB_Table_Base_Error_Number >= 600 && Base_Ptr->DB_Table_Base_Error_Number < 700)
			{
				cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "PaymentOptions.html" );
			}
			else
			{
				cout << "<!-- ERROR: DB error code ("<< Base_Ptr->DB_Table_Base_Error_Number <<") not recognized. -->\n" << endl;
				cfl.Html_AddHistoryButton(-1, "Back");
			}
		}
		else if(Return_Status == true)
		{
			cout << "<font face=geneva,arial color=blue size=+1>Your profile should have been updated.<BR>\n"
				<< "Use the Back button below to return to your Member Home page then use your browser's refresh button to make sure your profile is Hidden/UnHidden.<BR>\n"
				<< "If not, use the Hide/Unhide link again to return to this page then try using your browser's refresh button on the page you are now reading.<BR></font>\n" << endl << flush;
				cfl.Html_AddHistoryButton(-1, "Back");
			//cfl.Html_AddRedirect(Map.PrintValue( "CGIBIN" ), "GenHome.exe");	
		}
		else
		{
			cout << "<!-- This should never happen! -->\n" << endl;
			cout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl;
			cout << "<font face=geneva,arial color=blue size=+1>" << Base_Ptr->DB_Table_Base_Error_Text << "</font>\n" << endl;
			cfl.Html_AddHistoryButton(-1, "Back");
		}

		cfl.Html_End(Map);
	
	// No chance for failure in this example
	return EXIT_SUCCESS;
	
}// end main
