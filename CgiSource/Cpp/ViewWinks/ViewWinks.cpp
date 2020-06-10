/************************************************************************
*                                                                       *
*  PROGRAM ID         : ViewWinks.cpp									*
*                                                                       *
*  DESCRIPTION        : Displays user's who winked at this user			*
*																		*
*  ENTRY POINTS       : GenHome.exe			  					        *
*                                                                       *
*  INPUT                                                                *
*  PARAMETERS         : This is a CGI script that is called from the    *
*	hyperlink in the GenHome.exe results page                           *
*                                                                       *
*  INPUT FILES        :						                            *
*                                                                       *
*  OUTPUT FILES       :												    *
*                                                                       *
*  DB TABLES          : wink and login_info			                    *
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
* 6-04-01   JTB    Initial Release                                      *
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
//#include "cgicc/CGIEnvironment.h"

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
	DB_Table_Base * Base_Ptr = new Login_Info("wink_view");
	// Begin HTML
//	cout << HTTPHTMLHeader() << endl << flush;

	//cfl.Html_Begin(Map, 1, VIEW_WINKS);

	/*
	cfl.Html_1_BeginEntireAndTitle(Map);
	cfl.Html_2_BeginEntireBody(1);
	cfl.Html_3_BeginMainTable();
	cfl.Html_4_HeaderRow(Map);
	cfl.Html_5_BeginNavigationAndMainBodyRow();
	cfl.Html_6_NavigationTableDataCell(Map, 1); // Assume the user is logged in
	cfl.Html_7_BeginMainDataCell(Map);
	*/

	string index = "";
	form_iterator index_form = cgi.getElement("index");
	if( index_form != cgi.getElements().end() )
	{
		if ( index_form->isEmpty() )
		{
			index = "1";
			dout << "<!-- index1 (" << index << ") -->\n";
		}
		else
		{
			index += index_form->getValue();
			dout << "<!-- index2 (" << index << ") -->\n";
		}
	}
	else
	{
		index = "1";
		dout << "<!-- index3 (" << index << ") -->\n";
	}

	// Get user_name and password from cookie list
	string cookie_name("");
	string cookie_password("");
	if(Get_Cookie_Name_Password(cgi, cookie_name, cookie_password))
	{
		if( !cookie_name.empty() )
		{
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

	if( cookies_found )
	{
		string Sql_buf("");
		
		Sql_buf += ("\"" + cookie_name + "\", \"" + cookie_password + "\"");
		
		bool Return_Status = false;

		Base_Ptr->Set_Update_Info_Sql( Sql_buf );
		
		dout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl;
		
		Return_Status = Base_Ptr->ViewWinks_The_DB(Map, "ViewWinks.exe", atoi(index.c_str()), 10);

		
		if(Return_Status == false)
		{
			dout << "<!-- ERROR: DB or Message error. -->\n" << endl;
			dout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl;
			cout << "<font face=geneva,arial color=blue size=+1>" << Base_Ptr->DB_Table_Base_Error_Text << "</font>\n" << endl;
			if (Base_Ptr->DB_Table_Base_Error_Number >= 100 && Base_Ptr->DB_Table_Base_Error_Number < 200)
			{
				cfl.Html_MemberLogIn(Map);
			}
			else if(Base_Ptr->DB_Table_Base_Error_Number == 201)
			{
				cfl.Html_AddRedirect(Map.PrintValue( "CGIBIN" ), "ManageEmailVerification.cgi" );
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
			// Success!  Nothing further needs to be done.
			// All the output is generated in ViewWinks_The_DB
		}
		else
		{
			cout << "<!-- This should never happen! -->\n" << endl;
			cout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, an unknown error has occured.<BR>Please try again...</font>\n" << endl;
			cfl.Html_AddHistoryButton(-1, "Back");
		}
	}
	else // not directly accessable user error
	{
		cfl.Html_Begin(Map, 0, VIEW_WINKS, "0");
		cfl.Html_2_BeginPopUpFormat(Map);
		cout << "<BR>You must be logged in to view this page." << endl;
		// redirect to index.html
		cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "LogIn.html");
	}// ... end not directly accessable else clause
	
		cfl.Html_End(Map);
		/*
		cfl.Html_8_EndMainDataCell();
		cfl.Html_9_EndNavigationAndMainRow();
		cfl.Html_10_CopyrightRow(Map);
		cfl.Html_11_EndMainTable();
		cfl.Html_12_EndEntireBody();
		*/
	
	return EXIT_SUCCESS;
	
}// end main
