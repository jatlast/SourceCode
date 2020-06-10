/************************************************************************
*                                                                       *
*  PROGRAM ID         : LogInHelp.cpp							            *
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

#include "cgicc/Cgicc.h"

#include "ConnectionsFunctions/ConnectionsFormLayout.h"
#include "Connections_Templates/Connections_Templates.h"
#include "LinkMap/LinkMap.h" // associative map class
#include "DB_Table_Base/Login_Info.h"
#include "CommentMacro.h" // contains the contains the comment macro def of "dout"
#include "SendMailBlat/SendMailBlat.h"
using std::flush;
using namespace cgicc;

int
main ()
{
	// make this the very first thig printed to prevent CGI ERRORS...
	cout << "Content-Type: text/html\n\n" << flush;

	string Program_Name("LogInHelp.exe");
	
	bool email_password	 = false;
	bool email_user_name = false;
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
	
	// Begin HTML
//	cout << HTTPHTMLHeader() << endl << flush;
	
	// Determine what the user wants to do...
	form_iterator submit = cgi.getElement("submit");
	if( submit != cgi.getElements().end() )
	{
		if ( !submit->isEmpty() )
		{
			if(submit->getValue() == "Email Me My Password")
			{
				email_password = true;
			}
			else if(submit->getValue() == "Email Me My User Name")
			{
				email_user_name = true;
			}
		}
		else
		{
			dout << "<!-- This should never happen.  No value supplied for submit -->\n";
		}
	}
	else
	{
		dout << "<!-- This should never happen.  submit not supplied to cgi-->\n";
	}
	
	
	cfl.Html_Begin(Map, 1, LOG_IN_HELP);
	
	if( email_password )
	{
		//	Create a Login_Info object to hold all the Form and Database data...
		Login_Info login_info("getLoginInfoByUserNameMaidenName", "");
		
		dout << "<!-- determining if user_name and password_hint match... -->" << endl;
		
		//	Get the data entered by the user from the form fields...
		login_info.Get_Form_Info_From_Cgi(cgi);
		
		string Sql_buf("");
		
		Sql_buf += ("\"" + login_info.Get_FormData_From_ColumnName("user_name") + "\", \"" + login_info.Get_FormData_From_ColumnName("password_hint") + "\"");
		
		bool Return_Status = false;
		login_info.Set_Get_Info_Sql( Sql_buf );
		
		dout << "<!-- Sql: " << login_info.Get_Get_Info_Sql() << " -->\n" << endl;
		
		Return_Status = login_info.Get_Info_From_DB(Map);
		
		if(Return_Status == false)
		{
			dout << "<!-- ERROR: DB or Message error. -->\n" << endl;
			dout << "<!-- Sql: " << login_info.Get_Get_Info_Sql() << " -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, User Name or Mother's Maiden Name incorrect.<BR>Please try again...</font>\n" << endl;
			cfl.Html_AddHistoryButton(-1, "Back");
		}
		else if(Return_Status == true)
		{
			string UserName = login_info.Get_DBData_From_ColumnName("user_name");
			string Password = login_info.Get_DBData_From_ColumnName("password");
			string Email	= login_info.Get_DBData_From_ColumnName("email");
			string MailSubject = "\"Here is your " + Map.PrintValue( "WHICH_CONNECTIONS" ) + " login information...\"";
			string MailBody = "\"Your user name is (" + UserName + ") and your password is (" + Password + ").  To log in point your favorite browser to " + Map.PrintValue( "ROOT" ) + "/LogIn.html\"";
			// Send the user their info via email...
			SendMailBlat(Map
				, Email
				, MailSubject
				, Map.PrintValue("EMAIL")// This is the default admin email from the linkmap.dat (ie. admin@connections.com)
				, ""
				, MailBody
				, Map.PrintValue("SMTP_HOST")// This is the default smtp host (i.e., smtpout.bellatlantic.net)
				);
			
			cout << "<font face=geneva,arial color=blue size=+1>Success: Your Password has been sent to your personal email address.</FONT><br>" << endl;
		}
		else
		{
			dout << "<!-- ERROR: DB Error. -->\n" << endl;
			dout << "<!-- Sql: " << login_info.Get_Get_Info_Sql() << " -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, an unknown error has occured.<BR>Please try again...</font>\n" << endl;
			cout << "<!-- This should never happen.  Return_Status = \"" << Return_Status << "\" -->\n" << endl;
			cfl.Html_AddHistoryButton(-1, "Back");
		}
	}
	else if( email_user_name )
	{
		//	Create a Login_Info object to hold all the Form and Database data...
		Login_Info login_info("getLoginInfoByEmailMaidenName", "");
		dout << "<!-- determining if email and password_hint match... -->" << endl;
		
		//	Get the data entered by the user from the form fields...
		login_info.Get_Form_Info_From_Cgi(cgi);
		
		string Sql_buf("");
		
		Sql_buf += ("\"" + login_info.Get_FormData_From_ColumnName("email") + "\", \"" + login_info.Get_FormData_From_ColumnName("password_hint") + "\"");
		
		bool Return_Status = false;
		login_info.Set_Get_Info_Sql( Sql_buf );
		
		dout << "<!-- Sql: " << login_info.Get_Get_Info_Sql() << " -->\n" << endl;
		
		Return_Status = login_info.Get_Info_From_DB(Map);
		
		if(Return_Status == false)
		{
			dout << "<!-- ERROR: DB or Message error. -->\n" << endl;
			dout << "<!-- Sql: " << login_info.Get_Get_Info_Sql() << " -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, Email Address or Mother's Maiden Name incorrect.<BR>Please try again...</font>\n" << endl;
			cfl.Html_AddHistoryButton(-1, "Back");
		}
		else if(Return_Status == true)
		{
			string UserName = login_info.Get_DBData_From_ColumnName("user_name");
			string Password = login_info.Get_DBData_From_ColumnName("password");
			string Email	= login_info.Get_DBData_From_ColumnName("email");
			string MailSubject = "\"Here is your " + Map.PrintValue( "WHICH_CONNECTIONS" ) + " login information...\"";
			string MailBody = "\"Your user name is (" + UserName + ") and your password is (" + Password + ").  To log in point your favorite browser to " + Map.PrintValue( "ROOT" ) + "/LogIn.html\"";
			// Send the user their info via email...
			SendMailBlat(Map
				, Email
				, MailSubject
				, Map.PrintValue("EMAIL")// This is the default admin email from the linkmap.dat (ie. admin@connections.com)
				, "baumbach@bellatlantic.net"
				, MailBody
				, Map.PrintValue("SMTP_HOST")// This is the default smtp host (i.e., smtpout.bellatlantic.net)
				);
			
			cout << "<font face=geneva,arial color=blue size=+1>Success: Your User Name has been sent to your personal email address.</FONT><br>" << endl;
		}
		else
		{
			dout << "<!-- ERROR: DB Error. -->\n" << endl;
			dout << "<!-- Sql: " << login_info.Get_Get_Info_Sql() << " -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, an unknown error has occured.<BR>Please try again...</font>\n" << endl;
			cout << "<!-- This should never happen.  Return_Status = \"" << Return_Status << "\" -->\n" << endl;
			cfl.Html_AddHistoryButton(-1, "Back");
		}
	}
	else // not directly accessable user error
	{
		cout << "<BR>This page is not directly accessable.  It must be called by Index.html" << endl;
		// redirect to index.html
		cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "LogInHelp.html");
		
	}// ... end not directly accessable else clause
	
	cfl.Html_End(Map);
	
	// No chance for failure in this example
	return EXIT_SUCCESS;
	
}// end main
