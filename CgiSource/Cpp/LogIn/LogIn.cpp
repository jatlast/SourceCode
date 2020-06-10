/************************************************************************
*                                                                       *
*  PROGRAM ID         : UpdateLogin.cpp                               *
*                                                                       *
*  DESCRIPTION        : Update a user's Profile.                        *
*   This program depends on all the database tables.				    *
*	Service database.                                                   *
*																		*
*  ENTRY POINTS       : GetLoginInfo.html  					        *
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
#include "LinkMap/LinkMap.h" // associative map class
#include "DB_Table_Base/Login_Info.h"
#include "CommentMacro.h" // contains the contains the comment macro def of "dout"

// defining DEBUG_OFF turns off TracingAndTiming...
#define DEBUG_OFF 1
#include "TracingAndTiming/TracingAndTiming.h"

using std::flush;
using namespace cgicc;

int
main ()
{
	// make this the very first thig printed to prevent CGI ERRORS...
	cout << "Content-Type: text/html\n\n" << flush;

	//	instantiate the class that defines the form layouts for the page...
	CConnectionsFormLayout cfl;
	
	//	Create a new Cgicc object containing all the CGI data...
	Cgicc cgi;
	
    // Get a pointer to the environment so the Server Name can be retrieved...
    const CgiEnvironment& env = cgi.getEnvironment();

	// Read the file containg the current URL configurations...
	LinkMap Map( cfl.GetLinkMapPath(), env.getServerName() );
		
// Define a TracingAndTiming object...
// Define a TracingAndTiming object...
	Debug MyMain("LogIn",false);
    MyMain.specify("D;ERROR,SUCCESS,LogIn");	// Enable Dbg/Dbx for the specified comma seperated strings
    MyMain.specify("M;LogIn");				// Enable Timing  for the specified comma seperated strings
	MyMain.specify("T;LogIn");				// Enable Tracing for the specified comma seperated strings
	MyMain.specify("O;C:/Required/LOG/TracingAndTiming.log");// specify the log file
    //MyMain.TimeStart("LogIn", "START");// Start the Timer

	// EXIT and print error HTML if the LinkMap.dat file could not be opened...	
	if(Map.PrintValue("ERROR") == "1")
	{
//		cout << HTTPHTMLHeader() << endl << flush;
		cfl.Html_DefaultErrorMessagePage(Map);

		MyMain.Dbg("ERROR", "LinkMap could not be opened.");// Print error message to the log
		//MyMain.TimeEnd("LogIn", "END");// End the Timer
		return EXIT_FAILURE;
	}
	
	//	Create a Login_Info object to hold all the Form and Database data...
	Login_Info login_info("LogIn");
	
	// Begin HTML
//	cout << HTTPHTMLHeader() << endl << flush;
	
	cfl.Html_Begin(Map, 0, LOG_IN);

	form_iterator submit = cgi.getElement("submit");
	if( submit != cgi.getElements().end() )
	{
		if (! submit->isEmpty() )
		{
			// remove the current Cookies...
			cfl.Html_DeleteNamePasswordCookie(login_info.Get_FormData_From_ColumnName("user_name"), login_info.Get_FormData_From_ColumnName("password") );

			dout << "<!-- determining if user_name and password match... -->" << endl;
			
			//	The following block of code handles the Update of the user's login_info...
			//	Get the data entered by the user from the form fields...
			login_info.Get_Form_Info_From_Cgi(cgi);
			
			string Sql_buf("");
			
			for(unsigned int i=0; i<login_info.Vect.size(); i++)
			{
				Sql_buf += ("\"" + login_info.Vect[i].web_form_data + (i+1 == login_info.Vect.size() ? "\"" : "\", ") );
			}
			
			bool Return_Status = false;
			login_info.Set_Update_Info_Sql( Sql_buf );
			
			dout << "<!-- Sql: " << login_info.Get_Update_Info_Sql() << " -->\n" << endl;
			
			Return_Status = login_info.Update_Info_In_DB(Map);
			
			cfl.Html_2_BeginPopUpFormat(Map);
			
			if(Return_Status == false)
			{
				// Log the events
				MyMain.Dbg("ERROR", "DB or Message error");
				MyMain.Dbg("ERROR", "Sql: ", login_info.Get_Update_Info_Sql() );
				MyMain.Dbg("ERROR", "<font face=geneva,arial color=blue size=+1>Sorry, user name or password incorrect.<BR>Please try again...</font>");
				
				dout << "<!-- ERROR: DB or Message error. -->\n" << endl;
				dout << "<!-- Sql: " << login_info.Get_Update_Info_Sql() << " -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, user name or password incorrect.<BR>Please try again...</font>\n" << endl;
				cfl.Html_MemberLogIn(Map);
			}
			else if(Return_Status == true)
			{
				// Log the events
				MyMain.Dbg("SUCCESS", "user_name/password = ", "(" + login_info.Get_FormData_From_ColumnName("user_name") + ")/(" + login_info.Get_FormData_From_ColumnName("password") + ")");

				cfl.Html_AddProcessingGif(Map);
				cfl.Html_AddNamePasswordCookie(login_info.Get_FormData_From_ColumnName("user_name"), login_info.Get_FormData_From_ColumnName("password") );
				cfl.Html_AddRedirect(Map.PrintValue( "CGIBIN" ), "GenHome.exe");	
			}
			else
			{
				// Log the events
				MyMain.Dbg("ERROR", "This should never happen.  Return_Status = ", Return_Status);
				MyMain.Dbg("ERROR", "Sql: ", login_info.Get_Update_Info_Sql() );
				MyMain.Dbg("ERROR", "<font face=geneva,arial color=blue size=+1>Sorry, an unknown error has occured.<BR>Please try again...</font>");

				dout << "<!-- ERROR: DB Error. -->\n" << endl;
				dout << "<!-- Sql: " << login_info.Get_Update_Info_Sql() << " -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, an unknown error has occured.<BR>Please try again...</font>\n" << endl;
				cout << "<!-- This should never happen.  Return_Status = \"" << Return_Status << "\" -->\n" << endl;
			cfl.Html_AddHistoryButton(-1, "Back");
			}
		}
	}
	else // not directly accessable user error
	{
		//cfl.Html_2_BeginPopUpFormat(Map);
		cfl.Html_AddProcessingGif(Map);
		// Log the events
		MyMain.Dbg("ERROR", "You must be logged in to view this page.");

		cout << "<BR>You must log in to view this page." << endl;
		// redirect to index.html
		cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "LogIn.html");
	}// ... end not directly accessable else clause
	
	cfl.Html_End(Map);
	
	// Duration Time Stamp
	//MyMain.TimeEnd("LogIn", "END");// End the Timer

	return EXIT_SUCCESS;
	
}// end main
