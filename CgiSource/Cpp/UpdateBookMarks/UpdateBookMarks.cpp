/************************************************************************
*                                                                       *
*  PROGRAM ID         : UpdateBookMarks.cpp                             *
*                                                                       *
*  DESCRIPTION        : Update a user's BookMarks.                      *
*   This program depends on the book_marks and login_info				*
*	database tables.													*
*																		*
*  ENTRY POINTS       : SingleProfile.exe			  					        *
*                                                                       *
*  INPUT                                                                *
*  PARAMETERS         : This is a CGI script that is called from the    *
*	hyperlink in the SingleProfile.exe results page                           *
*                                                                       *
*  INPUT FILES        :						                            *
*                                                                       *
*  OUTPUT FILES       :												    *
*                                                                       *
*  DB TABLES          : book_marks and login_info                       *
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

	string Program_Name("UpdateBookMarks.exe");
	string add_remove = "";
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
	Login_Info login_info("updateBookMarks");
	
	
	// Begin HTML
//	cout << HTTPHTMLHeader() << endl << flush;
	cfl.Html_Begin(Map, 1, UPDATE_BOOKMARKS);

	

	form_iterator caller_itr = cgi.getElement("add_remove");
	if( caller_itr != cgi.getElements().end() )
	{
		if ( caller_itr->isEmpty() )
		{
			add_remove = "Undefined";
			dout << "<!-- add_remove (" << add_remove << ")\n";
		}
		else
		{
			add_remove += caller_itr->getValue();
			dout << "<!-- add_remove (" << add_remove << ")\n";
		}
	}
	else
	{
		add_remove = "Undefined2";
		dout << "<!-- add_remove (" << add_remove << ")\n";
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


	form_iterator book_mark = cgi.getElement("book_mark");
	if( book_mark != cgi.getElements().end() && cookies_found )
	{
		string Sql_buf("");
		
		Sql_buf += ("\"" + cookie_name + "\", \"" + cookie_password + "\", \"" + book_mark->getValue().c_str() + "\", \"" + add_remove + "\"");
		
		bool Return_Status = false;
		login_info.Set_Update_Info_Sql( Sql_buf );
		
		dout << "<!-- Sql: " << login_info.Get_Update_Info_Sql() << " -->\n" << endl;
		
		Return_Status = login_info.Update_Info_In_DB(Map);
		
		if(Return_Status == false)
		{
			dout << "<!-- ERROR: DB or Message error. -->\n" << endl;
			dout << "<!-- Sql: " << login_info.Get_Update_Info_Sql() << " -->\n" << endl;
			cout << "<font face=geneva,arial color=blue size=+1>Sorry, "
				<< book_mark->getValue().c_str()
				<< " could not be added to your bookmarks page.<BR>Please try again...</font>\n" << endl;
			cfl.Html_MemberLogIn(Map);
		}
		else if(Return_Status == true)
		{
			cout<< "<table width=\"511\" height=\"165\" border=\"0\" cellpadding=\"4\" cellspacing=\"0\" background=\"" << Map.PrintValue( "IMAGES" ) << "/orange_box.gif\">\n"
				<< "  <tr> \n"
				<< "    <td>&nbsp;</td>\n"
				<< "    <td>&nbsp;</td>\n"
				<< "    <td>&nbsp;</td>\n"
				<< "  </tr>\n"
				<< "  <tr> \n"
				<< "    <td>&nbsp;</td>\n"
				<< "    <td><span class=\"BlackTextMedium\">You have successfully updated </span> \n"
				<< "      <span class=\"BlackTextLargeBold\">" << book_mark->getValue().c_str() << "</span><span class=\"BlackTextMedium\">\n"
				<< "    in your bookmarks page.</span></td>\n"
				<< "    <td>&nbsp;</td>\n"
				<< "  </tr>\n"
				<< "  <tr>\n"
				<< "    <td>&nbsp;</td>\n"

				<< "	<td align=\"center\">\n"
				<< "		<a href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenBookMarks.exe\" class=\"NavText\">view your bookmarks...</a>\n"
				<< "	</td>\n"
				<< "    <td height=\"48\">&nbsp;</td>\n"
				<< "  </tr>\n"
				<< "  <tr> \n"
				<< "    <td>&nbsp;</td>\n"
				<< "    <td>&nbsp;</td>\n"
				<< "    <td>&nbsp;</td>\n"
				<< "  </tr>\n"
				<< "</table>\n";

//			cfl.Html_AddHistoryButton(-2, "Back");
		}
		else
		{
			cout << "<!-- This should never happen! -->\n" << endl;
			cout << "<!-- Sql: " << login_info.Get_Update_Info_Sql() << " -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, an unknown error has occured.<BR>Please try again...</font>\n" << endl;
			cfl.Html_AddHistoryButton(-1, "Back");
		}
	}
	else // not directly accessable user error
	{
		cfl.Html_2_BeginPopUpFormat(Map);
		cout << "<BR>This page is not directly accessable.  It must be called from within the Inbox or Outbox" << endl;
		// redirect to LogIn.html
		cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "LogIn.html");
		
	}// ... end not directly accessable else clause

		cfl.Html_End(Map);
	
	// No chance for failure in this example
	return EXIT_SUCCESS;
	
}// end main
