/************************************************************************
*                                                                       *
*  PROGRAM ID         : GenInbox.cpp							            *
*                                                                       *
*  DESCRIPTION        : Update a user's Profile.                        *
*   This program depends on all the database tables.				    *
*	Service database.                                                   *
*																		*
*  ENTRY POINTS       : index.html			  					        *
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

	//	Create a new Cgicc object containing all the CGI data...
	Cgicc cgi;
	
	// Begin HTML
//	cout << HTTPHTMLHeader() << endl << flush;

	string Program_Name("GenInbox.exe");
	string index = "";
	bool cookies_found = false;
	//	instantiate the class that defines the form layouts for the page...
	CConnectionsFormLayout cfl;
	
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
	DB_Table_Base * Base_Ptr = new Login_Info("genInbox");	
	
	//cfl.Html_Begin(Map, 1, GEN_INBOX);

	/*
	cfl.Html_1_BeginEntireAndTitle(Map);
	cfl.Html_2_BeginEntireBody(1);
	cfl.Html_3_BeginMainTable();
	cfl.Html_4_HeaderRow(Map);
	cfl.Html_5_BeginNavigationAndMainBodyRow();
	cfl.Html_6_NavigationTableDataCell(Map, 1); // Assume the user is logged in
	cfl.Html_7_BeginMainDataCell(Map);
	*/
	

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
	else
	{
		cfl.Html_Begin(Map, 0, GEN_INBOX, "0");
		cfl.Html_AddProcessingGif(Map);
		cout << "<BR>You must log in to view this page." << endl;
		dout << "<!-- cookie_name     : " << cookie_name << "-->\n";
		dout << "<!-- cookie_password : " << cookie_password << "-->\n";
		cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "LogIn.html" );
	}


	form_iterator submit = cgi.getElement("submit");
	if( submit != cgi.getElements().end() )
	{
		if (! submit->isEmpty() )
		{
			dout << "<!-- determining if user_name and password match... -->" << endl;
			
			//	The following block of code handles the Update of the user's login_info...
			//	Get the data entered by the user from the form fields...
			Base_Ptr->Get_Form_Info_From_Cgi(cgi);
			
			string Sql_buf("");

			Sql_buf += ("\"" + Base_Ptr->Get_FormData_From_ColumnName("user_name") + "\", \"" + Base_Ptr->Get_FormData_From_ColumnName("password") + "\"");
			
			bool Return_Status = false;
			Base_Ptr->Set_Update_Info_Sql( Sql_buf );
			
			dout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl;
			
			Return_Status = Base_Ptr->GenMailbox_The_DB(Map, Program_Name, atoi(index.c_str()), 7);
			
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
				cfl.Html_AddNamePasswordCookie(Base_Ptr->Get_FormData_From_ColumnName("user_name"), Base_Ptr->Get_FormData_From_ColumnName("password") );
			}
			else
			{
				dout << "<!-- ERROR: DB Error. -->\n" << endl;
				dout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl;
				cout << "<!-- This should never happen.  Return_Status = \"" << Return_Status << "\" -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, an unknown error has occured.<BR>Please try again...</font>\n" << endl;
			cfl.Html_AddHistoryButton(-1, "Back");
			}
		}
	}
	else if( cookies_found )
	{
		string Sql_buf("");
		
		Sql_buf += ("\"" + cookie_name + "\", \"" + cookie_password + "\"");
		
		bool Return_Status = false;
		Base_Ptr->Set_Update_Info_Sql( Sql_buf );
		
		dout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl;
		
		Return_Status = Base_Ptr->GenMailbox_The_DB(Map, Program_Name, atoi(index.c_str()), 7);
		
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
			// All the output is generated in GenMailbox_The_DB
		}
		else
		{
			cout << "<!-- This should never happen! -->\n" << endl;
			cout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, an unknow error has occured.<BR>Please try again...</font>\n" << endl;
			cfl.Html_AddHistoryButton(-1, "Back");
		}
	}
	else // not directly accessable user error
	{
		cfl.Html_Begin(Map, 0, GEN_INBOX, "0");
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
	

	// No chance for failure in this example
	return EXIT_SUCCESS;
	
}// end main
