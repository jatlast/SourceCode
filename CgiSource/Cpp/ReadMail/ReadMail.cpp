/************************************************************************
*                                                                       *
*  PROGRAM ID         : ReadMail.cpp & ReplyMail				        *
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

#include "ConnectionsFunctions/ConnectionsFormLayout.h"
#include "Connections_Templates/Connections_Templates.h"
#include "LinkMap/LinkMap.h" // associative map class
#include "DB_Table_Base/ReadMail_Info.h"
#include "CommentMacro.h" // contains the contains the comment macro def of "dout"

using std::flush;
using namespace cgicc;

int
main ()
{
	// make this the very first thig printed to prevent CGI ERRORS...
	cout << "Content-Type: text/html\n\n" << flush;

	string Program_Name("ReadMail.exe");
	string checkbox = "";
	bool cookies_found = false;
	bool show_stopper = false;
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
		
	DB_Table_Base * Base_Ptr = NULL;	
	
	// Begin HTML
//	cout << HTTPHTMLHeader() << endl << flush;
//	cfl.Html_Begin(Map, 1, READ_MAIL);
	
	form_iterator the_caller = cgi.getElement("the_caller");
	if( the_caller != cgi.getElements().end() )
	{
		if ( the_caller->isEmpty() )
		{
			dout << "<!-- ERROR: the_caller was not passed.\n";
		}
		else
		{
			//	Create a Login_Info object to hold all the Form and Database data...
			if(the_caller->getValue() == "GenInbox.exe" || the_caller->getValue() == "ReadMail.exe")
			{
				Base_Ptr = new ReadMail_Info("readReceivedMail", "");
			}
			else if(the_caller->getValue() == "GenOutbox.exe")
			{
				Base_Ptr = new ReadMail_Info("readSentMail", "");
			}
			else
			{
				cfl.Html_Begin(Map, 1, READ_MAIL, "0");
				cout << "Fatal ERROR: program called without the_caller passed!\n" << endl;
				show_stopper = true;
			}
		}
	}
	else
	{
		cfl.Html_Begin(Map, 1, READ_MAIL, "0");
		cout << "Fatal ERROR 2: program called without the_caller passed!\n" << endl;
		show_stopper = true;
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
	else
	{
		cfl.Html_Begin(Map, 0, READ_MAIL, "0");
		cfl.Html_AddProcessingGif(Map);
		cout << "<BR>You must log in to view this page." << endl;
		dout << "<!-- cookie_name     : " << cookie_name << "-->\n";
		dout << "<!-- cookie_password : " << cookie_password << "-->\n";
		cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "LogIn.html" );
	}
	
	if(!show_stopper)
	{
		
		form_iterator mail_id = cgi.getElement("mail_id");
		if( mail_id != cgi.getElements().end() && cookies_found)
		{
			string Sql_buf("");
			
			Sql_buf += ("\"" + cookie_name + "\", \"" + cookie_password + "\", \"" + mail_id->getValue().c_str() + "\"");
			
			bool Return_Status = false;
			Base_Ptr->Set_Get_Info_Sql( Sql_buf );
			
			dout << "<!-- Sql: " << Base_Ptr->Get_Get_Info_Sql() << " -->\n" << endl;
			
			Return_Status = Base_Ptr->Get_Info_From_DB(Map);
			
			if(Return_Status == false)
			{
				cfl.Html_Begin(Map, 1, READ_MAIL, "0");
				dout << "<!-- ERROR: DB or Message error. -->\n" << endl;
				dout << "<!-- Sql: " << Base_Ptr->Get_Get_Info_Sql() << " -->\n" << endl;
				
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
				cfl.Html_Begin(Map, 1, READ_MAIL, const_cast<char *>(Base_Ptr->Get_DBData_From_ColumnName("search_unique_id")));
				// remove seconds and miliseconds from the date fields...
				string when_sent_string = Base_Ptr->Get_DBData_From_ColumnName("when_sent");
				if(when_sent_string.size() > 20)
				{
					when_sent_string.replace(when_sent_string.size()-9, 7, "");
				}
				cout << "<FORM method=\"POST\" action=\"" << Map.PrintValue( "CGIBIN" ) << "/SendMail.cgi\">\n"
					<< "      <table width=\"100%\" border=\"0\" cellspacing=\"3\" cellpadding=\"3\">\n"
					<< "        <tr> \n";
				if(the_caller->getValue() == "ReadMail.exe" || the_caller->getValue() == "GenOutbox.exe" )
				{
						cout << "          <td align=\"left\" width=\"500\" height=\"37\"> <font face=\"Arial, Helvetica, sans-serif\" size=\"2\"><a href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenInbox.exe\">Inbox</A></font> </td>\n";
				}
				else
				{
					cout << "          <td align=\"left\" width=\"250\" height=\"37\"> <font face=\"Arial, Helvetica, sans-serif\" size=\"2\"><a href=\"" << Map.PrintValue( "CGIBIN" ) << "/ReadMail.exe?mail_id=" << Base_Ptr->Get_DBData_From_ColumnName("mail_id") << "&amp;the_caller=ReadMail.exe\">Reply</A></font> </td>\n"
						<< "          <td align=\"left\" width=\"250\" height=\"37\"> <font face=\"Arial, Helvetica, sans-serif\" size=\"2\"><a href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenInbox.exe\">Inbox</A></font> </td>\n";
				}
				cout << "        </tr>\n"
					<< "        <tr> \n";

					if(!strcmp(Base_Ptr->Get_DBData_From_ColumnName("photo_1"), "Nothing") || strlen(Base_Ptr->Get_DBData_From_ColumnName("photo_1")) < 1)
					cout << "          <td><a href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << Base_Ptr->Get_DBData_From_ColumnName("sent_from") << "\"><img alt=\"Take another look at " << Base_Ptr->Get_DBData_From_ColumnName("sent_from") << "'s detailed profile.\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_LARGE" ) << "\" width=\"180\" height=\"180\" border=\"0\"></a></td>\n";
					else
					cout << "          <td><a href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << Base_Ptr->Get_DBData_From_ColumnName("sent_from") << "\"><img alt=\"Take another look at " << Base_Ptr->Get_DBData_From_ColumnName("sent_from") << "'s detailed profile.\" src=\"" << Map.PrintValue( "PICTURES" ) << "/180x180_" << Base_Ptr->Get_DBData_From_ColumnName("photo_1")	<< "\" width=\"180\" height=\"180\" border=\"0\"></a></td>\n";

					cout << "          <td></td>\n"
					<< "        </tr>\n"
					<< "        <tr> \n"
					<< "          <td width=\"37%\"><font size=\"2\" face=\"Arial, Helvetica, sans-serif\">From: \n"
					<< "            <strong>" << Base_Ptr->Get_DBData_From_ColumnName("sent_from") << "</strong> Age: <strong>"	<< Base_Ptr->Get_DBData_From_ColumnName("age") << "</strong></font></td>\n"
					<< "          <td width=\"63%\"></td>\n"
					<< "        </tr>\n"
					<< "        <tr> \n"
					<< "          <td width=\"37%\"><font size=\"2\" face=\"Arial, Helvetica, sans-serif\"><strong>"<< Base_Ptr->Get_DBData_From_ColumnName("city")	<< "</strong> \n"
					<< "            , <strong>"	<< Base_Ptr->Get_DBData_From_ColumnName("state") << "</strong></font></td>\n"
					<< "          <td width=\"63%\"></td>\n"
					<< "        </tr>\n"
					<< "        <tr> \n"
					<< "          <td width=\"37%\"><font size=\"2\" face=\"Arial, Helvetica, sans-serif\"> \n"
					<< "            Date: <strong>"	<< when_sent_string	<< "</strong></font></td>\n"
					<< "          <td width=\"63%\"></td>\n"
					<< "        </tr>\n"
					<< "        <tr> \n"
					<< "          <td width=\"37%\"></td>\n"
					<< "          <td width=\"63%\"></td>\n"
					<< "        </tr>\n"
					<< "      </table>\n"
					<< "      <table width=\"100%\" align=\"center\" border=\"0\" cellpadding=\"3\" cellspacing=\"3\">\n"
					<< "        <tr> \n"
					<< "          <td align=\"left\" width=\"500\"> <font face=\"Arial, Helvetica, sans-serif\" size=\"2\"> \n"
					<< "            Subject:<br>\n";

				if(the_caller->getValue() == "ReadMail.exe" || the_caller->getValue() == "GenOutbox.exe")
				{
					cout << "          <INPUT type=\"text\" maxlength=\"128\" size=\"65\" name=\"subject\" wrap=\"none\" value=\"RE: " << Base_Ptr->Get_DBData_From_ColumnName("subject") << "\">\n"
						<< "        </tr>\n"
						<< "        <tr> \n"
						<< "          <td align=\"left\" width=\"500\" height=\"37\"><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Text:<br>\n"
						<< "          <TEXTAREA rows=\"20\" cols=\"65\" name=\"message_text\" wrap=\"none\">\n\n\n--------------------------------------------------------------\nPrevious Message From " << Base_Ptr->Get_DBData_From_ColumnName("sent_from") << ":\n\n" << Base_Ptr->Get_DBData_From_ColumnName("message_text") << "</TEXTAREA>\n"
						<< "        </tr>\n"
						<< "        <tr> \n"
						<< "          <td align=\"left\" width=\"250\" height=\"37\"><INPUT type=\"submit\" value=\"Submit\" name=\"submit\"></td>\n"
						<< "          <td align=\"left\" width=\"250\" height=\"37\"> <font face=\"Arial, Helvetica, sans-serif\" size=\"2\"><a href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenInbox.exe\">Inbox</A></font> </td>\n"
						<< "        </tr>\n";
				}
				else
				{
					cout << "            <b>" << Base_Ptr->Get_DBData_From_ColumnName("subject") << "</b> </font> </td>\n"
						<< "        </tr>\n"
						<< "        <tr> \n"
						<< "          <td align=\"left\" width=\"500\" height=\"37\"><font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Text:<br>\n"
						<< "            <b>" << Replace_Returns_With_Breaks(Base_Ptr->Get_DBData_From_ColumnName("message_text")) << "</b> </font></td>\n"
						<< "        </tr>\n"
						<< "        <tr> \n"
						<< "          <td align=\"left\" width=\"250\" height=\"37\"> <font face=\"Arial, Helvetica, sans-serif\" size=\"2\"><a href=\"" << Map.PrintValue( "CGIBIN" ) << "/ReadMail.exe?mail_id=" << Base_Ptr->Get_DBData_From_ColumnName("mail_id") << "&amp;the_caller=ReadMail.exe\">Reply</A></font> </td>\n"
						<< "          <td align=\"left\" width=\"250\" height=\"37\"> <font face=\"Arial, Helvetica, sans-serif\" size=\"2\"><a href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenInbox.exe\">Inbox</A></font> </td>\n"
						<< "        </tr>\n";
				}
				
				cout << "      </table>\n"
					<< "      <p>&nbsp;</p>\n"
					<< "	<!--  sent_to -->\n"
					<< "		<INPUT type=\"hidden\" name=\"sent_to\" value=\"" << Base_Ptr->Get_DBData_From_ColumnName("sent_from") << "\">\n"
					<< "	<!--  sent_from -->\n"
					<< "		<INPUT type=\"hidden\" name=\"sent_from\" value=\"" << Base_Ptr->Get_DBData_From_ColumnName("sent_to") << "\">\n"
					<< "	</FORM>"
					<< endl;				
			}
			else
			{
				cfl.Html_Begin(Map, 1, READ_MAIL, "0");
				cout << "<!-- This should never happen! -->\n" << endl;
				cout << "<!-- Sql: " << Base_Ptr->Get_Get_Info_Sql() << " -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, an unknown error has occured.<BR>Please try again...</font>\n" << endl;
				cfl.Html_AddHistoryButton(-1, "Back");
			}
		}
		else // not directly accessable user error
		{
			cfl.Html_Begin(Map, 0, READ_MAIL, "0");
			cfl.Html_2_BeginPopUpFormat(Map);
			cfl.Html_AddProcessingGif(Map);
			cout << "<BR>You must log in to view this page." << endl;
			// redirect to index.html
			cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "LogIn.html");
		}// ... end not directly accessable else clause
	}// ... end show_stopper test
	cfl.Html_End(Map);
	
	delete Base_Ptr;
	
	return EXIT_SUCCESS;
}// end main
