// ConnectionsFormLayout.cpp: implementation of the CConnectionsFormLayout class.
//
//////////////////////////////////////////////////////////////////////

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

#include <iostream>

#include "ConnectionsFunctions/ConnectionsFormLayout.h"
//#include "LinkMap/LinkMap.h"
using std::cout;
using std::endl;
using std::flush;

const string EXPIRES("60 * 60 * 1000"); //= 3,600,000 = One Hour

//#define NAV_TOP		// define for top navigation
#define NAV_SIDE	// define for bottom navigation


//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CConnectionsFormLayout::CConnectionsFormLayout() //: public LinkMap
{
	
}


char *
CConnectionsFormLayout::GetLinkMapPath()
{
	// All boxes...
	//return "D:\\wwwroot\\PC\\PCTest\\cgi-bin\\LinkMap.dat";
	return "cgi-bin\\LinkMap.dat";
	//	return "LinkMap.dat";
}


////////////////////////////////////////////////////////////////////
//
//  Html_DefaultErrorMessagePage...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_DefaultErrorMessagePage(LinkMap & Map)
{
	cout << "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd\">\n"
		<< "<HTML>\n"
		<< "  <HEAD>\n"
		<< "    <TITLE>\n"
		<< "      " << Map.PrintValue("HTML_HEAD") << "\n"
		<< "    </TITLE>\n"
		<< "  </HEAD>\n"
		<< "  <BODY>\n"
		<< "\n\n<!-- ERROR MESSAGE: " << Map.PrintValue("ERROR_INFO") << " -->\n\n"
		<< "    <TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"4\" width=\"800\">\n"
		<< "      <TR>\n"
		<< "        <TD colspan=\"2\" bgcolor=\"" << Map.PrintValue("HTML_HEADFOOT_BGCOLOR") << "\" height=\"47\" valign=\"middle\">\n"
		<< "          <FONT face=\"Times New Roman\" size=\"6\">&nbsp;<FONT face=\"Arial, Helvetica, sans-serif\" size=\"5\">" << Map.PrintValue("WHICH_CONNECTIONS") << ".</FONT></FONT><FONT face=\"Arial, Helvetica, sans-serif\" size=\"5\">com</FONT>\n"
		<< "        </TD>\n"
		<< "      </TR>\n"
		<< "      <TR>\n"
		<< "        <TD bgcolor=\"" << Map.PrintValue("HTML_NAV_BGCOLOR") << "\" valign=\"top\" width=\"150\" height=\"483\">\n"
		<< "          <TABLE border=\"0\" cellpadding=\"4\" cellspacing=\"4\" width=\"150\">\n"
		<< "            <TR>\n"
		<< "              <TD width=\"143\" height=\"94\">\n"
		<< "                <DIV align=\"left\">\n"
		<< "                  <TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n"
		<< "                    <TR>\n"
		<< "                      <TD>\n"
		<< "                      </TD>\n"
		<< "                    </TR>\n"
		<< "                  </TABLE>\n"
		<< "                </DIV>\n"
		<< "              </TD>\n"
		<< "            </TR>\n"
		<< "          </TABLE>\n"
		<< "        </TD>\n"
		<< "        <TD width=\"666\" bgcolor=\"" << Map.PrintValue("HTML_BODY_BGCOLOR") << "\" height=\"483\" valign=\"top\">\n"
		<< "          <TABLE border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n"
		<< "            <TR>\n"
		<< "              <TD width=\"36\">\n"
		<< "                &nbsp;\n"
		<< "              </TD>\n"
		<< "              <TD width=\"586\">\n"
		<< "                &nbsp;\n"
		<< "              </TD>\n"
		<< "            </TR>\n"
		<< "            <TR>\n"
		<< "              <TD width=\"36\">\n"
		<< "                &nbsp;\n"
		<< "              </TD>\n"
		<< "              <TD width=\"586\">\n"
		<< "                <H3>\n"
		<< "                  <FONT face=\"Tahoma, Arial, helvetica\" color=\"#0033CC\">Hmmm... We have a problem</FONT>\n"
		<< "                </H3>\n"
		<< "                <UL type=\"none\">\n"
		<< "                  <LI>\n"
		<< "                    <FONT face=\"Tahoma, Arial, helvetica\" size=\"2\">For some reason, the the file you are looking for is not here. It could be that you have an old link, the file was replaced with a newer version, or we have a bad link.</FONT>\n"
		<< "                    <P>\n"
		<< "                      <FONT face=\"Tahoma, Arial, helvetica\" size=\"2\">If you think it is our problem, please send us some mail, so we can fix it. Please include the filename and the url you are looking for, and the name of the site (if any) that is linking you to " << Map.PrintValue("WHICH_CONNECTIONS") << ". (If the file has been removed or updated here, we can ask them to update their link.)</FONT>\n"
		<< "                    </P>\n"
		<< "                  </LI>\n"
		<< "                  <LI>\n"
		<< "                    <FONT face=\"Tahoma, Arial, helvetica\" size=\"2\">Report missing files to us at <A href=\"" << Map.PrintValue("MAIIL") << "?Subject=Missing File Report\">" << Map.PrintValue("MAIIL") << "</A>\n"
		<< "                    <BR>\n"
		<< "                    </FONT>\n"
		<< "                  </LI>\n"
		<< "                  <LI>\n"
		<< "                    <FONT face=\"Tahoma, Arial, helvetica\" size=\"2\">Return to <A href=\"" << Map.PrintValue("ROOT") << "\">" << Map.PrintValue("WHICH_CONNECTIONS") << ".com</A>\n"
		<< "                    <BR>\n"
		<< "                    </FONT>\n"
		<< "                  </LI>\n"
		<< "                </UL>\n"
		<< "              </TD>\n"
		<< "            </TR>\n"
		<< "          </TABLE>\n"
		<< "            </DIV>\n"
		<< "        </TD>\n"
		<< "      </TR>\n"
		<< "      <TR>\n"
		<< "        <TD colspan=\"2\" bgcolor=\"" << Map.PrintValue("HTML_HEADFOOT_BGCOLOR") << "\" height=\"23\" valign=\"middle\">\n"
		<< "          <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">" << Map.PrintValue("WHICH_CONNECTIONS") << ".Com</FONT> <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><BR>\n"
		<< "           Copyright &copy; 1999 " << Map.PrintValue("WHICH_CONNECITONS") << ".Com. All rights reserved.</FONT>\n"
		<< "        </TD>\n"
		<< "      </TR>\n"
		<< "    </TABLE>\n"
		<< "  </BODY>\n"
		<< "</HTML>\n" 
		<< flush;
}


////////////////////////////////////////////////////////////////////
//
//  Html_MemberLogIn...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_MemberLogIn(LinkMap & Map)
{
	cout << "      <FORM onsubmit=\"return checkForm(this)\" method=\"POST\" action=\"" << Map.PrintValue("CGIBIN") << "/GenHome.exe\">\n"
		<< "            <DIV align=\"left\">\n"
		<< "              <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG>Members Login:</STRONG></FONT> \n"
		<< "              \n"
		<< "          <TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"4\" width=\"50%\">\n"
		<< "            <TR>\n"
		<< "                  \n"
		<< "              <TD> <FONT color=\"#333333\" face=\"arial, Helvetica, sans-serif\" size=\"1\">User \n"
		<< "                Name:</FONT> </TD>\n"
		<< "                  \n"
		<< "              <TD> \n"
		<< "                <INPUT name=\"user_name\" size=\"10\">\n"
		<< "                  </TD>\n"
		<< "                </TR>\n"
		<< "                <TR>\n"
		<< "                  \n"
		<< "              <TD> <FONT color=\"#333333\" face=\"arial, Helvetica, sans-serif\" size=\"1\">Password:</FONT> \n"
		<< "              </TD>\n"
		<< "                  \n"
		<< "              <TD> \n"
		<< "                <INPUT name=\"password\" size=\"10\" type=\"password\" value=\"\">\n"
		<< "                  </TD>\n"
		<< "                </TR>\n"
		<< "                <TR>\n"
		<< "                  \n"
		<< "              <TD>&nbsp;</TD>\n"
		<< "                  \n"
		<< "              <TD> \n"
		<< "                <INPUT type=\"submit\" name=\"submit\" value=\"submit\">\n"
		<< "                  </TD>\n"
		<< "                </TR>\n"
		<< "              </TABLE>\n"
		<< "            \n"
		<< "        </DIV>\n"
		<< "        <font face=\"Arial, Helvetica, sans-serif\"><A href=\"../LogInHelp.html\"><FONT size=\"2\" color=\"navy\">Need help signing in?</FONT></A> <BR>\n"
		<< "        <BR>\n"
		<< "        <A href=\"../CreateLogin.html\"><FONT size=\"2\" color=\"red\">Enter A New Profile!</FONT></A> \n"
		<< "        <BR>\n"
		<< "        </font> \n"
		<< "      </FORM>\n"
		<< "<SCRIPT type=\"text/javascript\" language=\"javascript\">\n"
		<< "<!--\n"
		<< "\n"
		<< "function checkForm(theForm)\n"
		<< "{\n"
		<< "  if (theForm.user_name.value == \"\")\n"
		<< "  {\n"
		<< "    alert(\"Please enter a value for the \\\"User Name\\\" field.\")\n"
		<< "    theForm.user_name.focus()\n"
		<< "    return (false)\n"
		<< "  }\n"
		<< "\n"
		<< "  if (theForm.password.value == \"\")\n"
		<< "  {\n"
		<< "    alert(\"Please enter a value for the \\\"Password\\\" field.\")\n"
		<< "    theForm.password.focus()\n"
		<< "    return (false)\n"
		<< "  }\n"
		<< "\n"
		<< "  if (theForm.password.value.length < 4)\n"
		<< "  {\n"
		<< "    alert(\"Please enter at least 4 characters in the \\\"Password\\\" field.\")\n"
		<< "    theForm.password.focus()\n"
		<< "    theForm.password.select()\n"
		<< "    return (false)\n"
		<< "  }\n"
		<< "\n"
		<< "  if (theForm.password.value.length > 8)\n"
		<< "  {\n"
		<< "    alert(\"Please enter at most 8 characters in the \\\"Password\\\" field.\")\n"
		<< "    theForm.password.focus()\n"
		<< "    theForm.password.select()\n"
		<< "    return (false)\n"
		<< "  }\n" 
		<< "}\n"
		<< "// ...End hiding JavaScript form old browsers -->\n"
		<< "</SCRIPT>\n"
		<< flush;
}


////////////////////////////////////////////////////////////////////
//
//  HtmlBeginEntireAndTitle...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_2_BeginPopUpFormat(LinkMap & Map)
{
	// Output the HTTP headers for an HTML document, and the HTML 4.0 DTD info
	cout << "	<BODY bgcolor=" << Map.PrintValue("HTML_POPUP_BGCOLOR") << ">" << endl << flush;
	cout << "" << endl;
}

////////////////////////////////////////////////////////////////////
//
//  Html_AddProcessingGif...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_AddProcessingGif(LinkMap & Map)
{
	cout << "		<IMG alt=\"Animated Processing message gif\"\n"
		<< "		src=\"" << Map.PrintValue( "IMAGES" ) << Map.PrintValue( "PROCESSINGSYMBOL" ) << "\n"
		<< "		width=\"228\"\n"
		<< "		height=\"16\"\n"
		<< "		border=\"0\"\n"
		<< "		align=\"middle\">\n"
		<< flush;
}

////////////////////////////////////////////////////////////////////
//
//  Html_AddHistoryButton...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_AddHistoryButton(const int PagesToJump, const string & Label)
{
	cout << "<!--    Back the user up " << PagesToJump << " pages  -->\n"
		<< "<FORM>"
		<< "<P align=\"center\" style=\"line-height: 100%\">\n"
		<< "	<INPUT TYPE=\"BUTTON\" Value=\"" << Label << "\" onClick=\"History()\">\n"
		<< "</P>\n"
		<< "</FORM>"
		<< "<SCRIPT type=\"text/javascript\" language=\"javascript\">\n"
		<< "<!--\n"
		<< "	function History()\n"
		<< "	{\n"
		<< "		window.history.go(" << PagesToJump << ")\n"	
		<< "	}\n"
		<< "//-->\n"
		<< "</SCRIPT>\n"
		
		<< flush;
}

////////////////////////////////////////////////////////////////////
//
//  Html_AddHistoryJump...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_AddHistoryJump(const int PagesToJump)
{
	cout << "		<!--    Back the user up " << PagesToJump << " pages  -->\n"
		<< "		<SCRIPT type=\"text/javascript\" language=\"javascript\">\n"
		<< "		<!--\n"
		<< "            document.onLoad = History()\n"
		<< "			function History()\n"
		<< "			{\n"
		<< "				window.history.go(" << PagesToJump << ")\n"	
		<< "			}\n"
		<< "		//-->\n"
		<< "		</SCRIPT>\n"
		<< flush;
}

////////////////////////////////////////////////////////////////////
//
//  Html_AddCloseButton...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_AddCloseButton()
{
	cout << "<!--    Close Window Button  -->\n"
		<< "<FORM>"
		<< "      <P\n"
		<< "       align=\"center\"\n"
		<< "       style=\"line-height: 100%\">\n"
		<< "        <INPUT\n"
		<< "         type=\"button\"\n"
		<< "         value=\"Close\"\n"
		<< "         onclick=\"window.close();\">\n"
		<< "      </P>" 
		<< "</FORM>"
		<< endl << flush;
}

////////////////////////////////////////////////////////////////////
//
//  Html_AddNamePasswordCookie...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_AddNamePasswordCookie(const string & name, const string & password)
{
	cout << "		<SCRIPT type=\"text/javascript\" language=\"javascript\">\n"
		<< "		<!--\n"
		<< " 			var Then = new Date()\n"
		<< " 			Then.setTime(Then.getTime() + " << EXPIRES << ")\n"
		<< " 			document.cookie=\"cookie_name="     << name     << "; expires=\" + Then.toGMTString() + \"; path=/\"\n"
		<< " 			document.cookie=\"cookie_password=" << password << "; expires=\" + Then.toGMTString() + \"; path=/\"\n"
		<< "		// ...-->\n"
		<< "		</SCRIPT> \n"
		<< endl << flush;
}

////////////////////////////////////////////////////////////////////
//
//  Html_DeleteNamePasswordCookie...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_DeleteNamePasswordCookie(const string & name, const string & password)
{
	cout << "		<SCRIPT type=\"text/javascript\" language=\"javascript\">\n"
		<< "		<!--\n"
		<< " 			var expireDate = new Date()\n"
		<< " 			expireDate.setYear(expireDate.getYear() - 1)\n"
		<< " 			document.cookie=\"cookie_name="     << name     << "; expires=\" + expireDate.toGMTString() + \"; path=/\"\n"
		<< " 			document.cookie=\"cookie_password=" << password << "; expires=\" + expireDate.toGMTString() + \"; path=/\"\n"
		<< "		// ...-->\n"
		<< "		</SCRIPT> \n"
		<< endl << flush;
}


////////////////////////////////////////////////////////////////////
//
//  Html_AddRedirect...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_AddRedirect(const string & path, const string & page)
{
	cout << "       <SCRIPT type=\"text/javascript\" language=\"javascript\">\n"
		<< "		<!--\n"
		<< "			window.location = \"" << path << "/" << page << "\"\n"
		<< "		//-->\n"
		<< "		</SCRIPT>\n"
		<< endl << flush;
}

////////////////////////////////////////////////////////////////////
//
//  HtmlAddAutoClose...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_AddAutoClose()
{
	cout << "<SCRIPT type=\"text/javascript\" language=\"javascript\">\n"
		<< "<!--\n"
		
		<< "if(confirm(\"This page will not function properly because the user name cookie has not been set for the current user.  You will now be redirected to the Home Page.\"))\n"
		<< "{\n"
		<< "    window.close()\n"
		<< "}\n"
		<< "else\n"
		<< "{\n"
		<< "    window.close()\n"
		<< "}\n"
		
		<< "// ...-->\n"
		<< "</SCRIPT>\n"
		<< endl << flush;
	
}

#ifdef NAV_TOP

////////////////////////////////////////////////////////////////////
//
//  Html_Begin...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_Begin(LinkMap & Map, bool LoggedIn, int WhichPage)
{
	string bgcolor_on	( Map.PrintValue("HTML_NAV_BGCOLOR_ON"	) );
	string bgcolor_off	( Map.PrintValue("HTML_NAV_BGCOLOR_OFF"	) );
	
	string fontcolor_on	( Map.PrintValue("HTML_NAV_FONTCOLOR_ON" ) );
	string fontcolor_off( Map.PrintValue("HTML_NAV_FONTCOLOR_OFF") );
	
	
	cout << "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" "
		<< "\"http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd\">\n"
		<< "<HTML>\n"
		<< "<HEAD>\n"
		<< "<TITLE>" << Map.PrintValue("HTML_TITLE") << "</TITLE>\n"
		<< "</HEAD>\n" 
		<< flush;
	if (!LoggedIn)
	{
		cout << "	<!-- Begin Entire Body Logged In-->\n"
			<< "	<BODY>\n" << flush;
		//			<< "   <BODY onLoad=\"rotate()\">\n" << flush;
	}
	else
	{
		cout << "	<!-- Begin Entire Body NOT Logged In-->\n"
			<< "	<BODY>\n" << flush;
	}
	cout << "<!-- Begin Main Table -->\n"
//		<< "    <TABLE cellspacing=\"3\" cellpadding=\"3\" width=\"585\" border=\"0\">\n"
		<< "    <TABLE cellspacing=\"4\" cellpadding=\"0\" width=\"585\" border=\"0\">\n"
		<< "      <!-- Begin Header Row -->\n"
		<< "      <TBODY>\n"
		<< "        <TR>\n" 
		<< "<!-- Begin Header Row -->\n"
		<< "          <TD valign=\"center\" width=\"573\" height=\"50\">\n"
		<< "            <TABLE width=\"700\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n"
		<< "              <TR bgcolor=" << Map.PrintValue("HTML_HEADFOOT_BGCOLOR") << " align=\"left\">\n"
		<< "                <TD height=\"17\" colspan=\"13\">\n"
		<< "                  <IMG alt=\"" << Map.PrintValue("WHICH_CONNECTIONS") << " Logo\" src=\"" << Map.PrintValue("IMAGES") << "/" << Map.PrintValue("LOGO") << "\">\n"
		<< "                </TD>\n"
		<< "              </TR>\n"
		<< "              <TR align=\"left\">\n"
		<< "                <TD height=\"15\" colspan=\"13\">\n"
		<< "                  &nbsp;\n"
		<< "                </TD>\n"
		<< "              </TR><!-- End Header Row -->\n"
		<< "<!-- Begin Navigation and Main Body Row -->\n"
		<< "			  <TR>\n"
		<< "<!-- Begin Navigation Table Data Cell-->\n";
	
	// Do not show Nav while creating/updating profile...
	if(
		WhichPage == CREATE_LOGIN
		||	WhichPage == UPDATE_LOGIN
		||	WhichPage == UPDATE_CONTACT
		||	WhichPage == UPDATE_PERSONAL
		||	WhichPage == UPDATE_ABOUT
		)
	{
		cout << "<!-- Hide Navigation Table While Entering/Updating Profiile Info -->\n";
		
	}
	else
	{
		cout << "<!-- WhichPage = (" << WhichPage << ") -->\n";
		// GenHome...
		if(WhichPage == GEN_HOME)
		{
			cout << "                <TD bgcolor=" << bgcolor_on << " align=\"center\" width=\"105\">\n"
				<< "                  <STRONG><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenHome.exe\"><FONT size=\"2\" face=\"Arial\" color=" << fontcolor_on << ">Member Home</FONT></A></STRONG>\n"
				<< "                </TD>\n"
				<< "                <TD bgcolor=" << bgcolor_on << " width=\"2\" align=\"center\">\n"
				<< "                  <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/nav_vert_bar.gif\" width=\"2\" height=\"20\"></FONT></STRONG>\n"
				<< "                </TD>\n";
		}
		else
		{
			cout << "                <TD bgcolor=" << bgcolor_off << " align=\"center\" width=\"105\">\n"
				<< "                  <STRONG><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenHome.exe\"><FONT size=\"2\" face=\"Arial\" color=" << fontcolor_off << ">Member Home</FONT></A></STRONG>\n"
				<< "                </TD>\n"
				<< "                <TD bgcolor=" << bgcolor_off << " width=\"2\" align=\"center\">\n"
				<< "                  <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/nav_vert_bar.gif\" width=\"2\" height=\"20\"></FONT></STRONG>\n"
				<< "                </TD>\n";
		}
		// GenInbox...
		if(WhichPage == GEN_INBOX)
		{
			cout << "                <TD bgcolor=" << bgcolor_on << " width=\"60\" align=\"center\">\n"
				<< "                  <STRONG><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenInbox.exe\"><FONT size=\"2\" face=\"Arial\" color=" << fontcolor_on << ">Inbox</FONT></A></STRONG>\n"
				<< "                </TD>\n"
				<< "                <TD bgcolor=" << bgcolor_on << " width=\"2\" align=\"center\">\n"
				<< "                  <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"#FFFFFF\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/nav_vert_bar.gif\" width=\"2\" height=\"20\"></FONT></STRONG>\n"
				<< "                </TD>\n";
		}
		else
		{
			cout << "                <TD bgcolor=" << bgcolor_off << " width=\"60\" align=\"center\">\n"
				<< "                  <STRONG><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenInbox.exe\"><FONT size=\"2\" face=\"Arial\" color=" << fontcolor_off << ">Inbox</FONT></A></STRONG>\n"
				<< "                </TD>\n"
				<< "                <TD bgcolor=" << bgcolor_off << " width=\"2\" align=\"center\">\n"
				<< "                  <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"#FFFFFF\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/nav_vert_bar.gif\" width=\"2\" height=\"20\"></FONT></STRONG>\n"
				<< "                </TD>\n";
		}
		
		// GenOUtbox...
		if(WhichPage == GEN_OUTBOX)
		{
			cout << "                <TD bgcolor=" << bgcolor_on << " width=\"70\" align=\"center\">\n"
				<< "                  <STRONG><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenOutbox.exe\"><FONT size=\"2\" face=\"Arial\" color=" << fontcolor_on << ">Outbox</FONT></A></STRONG>\n"
				<< "                </TD>\n"
				<< "                <TD bgcolor=" << bgcolor_on << " width=\"2\" align=\"center\">\n"
				<< "                  <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"#FFFFFF\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/nav_vert_bar.gif\" width=\"2\" height=\"20\"></FONT></STRONG>\n"
				<< "               </TD>\n";
		}
		else
		{
			cout << "                <TD bgcolor=" << bgcolor_off << " width=\"70\" align=\"center\">\n"
				<< "                  <STRONG><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenOutbox.exe\"><FONT size=\"2\" face=\"Arial\" color=" << fontcolor_off << ">Outbox</FONT></A></STRONG>\n"
				<< "                </TD>\n"
				<< "                <TD bgcolor=" << bgcolor_off << " width=\"2\" align=\"center\">\n"
				<< "                  <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"#FFFFFF\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/nav_vert_bar.gif\" width=\"2\" height=\"20\"></FONT></STRONG>\n"
				<< "               </TD>\n";
		}
		// AdvancedSearch...
		if(WhichPage == ADVANCED_SEARCH)
		{
			cout << "                <TD bgcolor=" << bgcolor_on << " width=\"130\" align=\"center\">\n"
				<< "                  <STRONG><A href=\"" << Map.PrintValue( "ROOT" ) << "/AdvancedSearch.html\"><FONT size=\"2\" face=\"Arial\" color=" << fontcolor_on << ">Advanced Search</FONT></A></STRONG>\n"
				<< "                </TD>\n"
				<< "                <TD bgcolor=" << bgcolor_on << " width=\"2\" align=\"center\">\n"
				<< "                  <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"#FFFFFF\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/nav_vert_bar.gif\" width=\"2\" height=\"20\"></FONT></STRONG>\n"
				<< "                </TD>\n";
		}
		else
		{
			cout << "                <TD bgcolor=" << bgcolor_off << " width=\"130\" align=\"center\">\n"
				<< "                  <STRONG><A href=\"" << Map.PrintValue( "ROOT" ) << "/AdvancedSearch.html\"><FONT size=\"2\" face=\"Arial\" color=" << fontcolor_off << ">Advanced Search</FONT></A></STRONG>\n"
				<< "                </TD>\n"
				<< "                <TD bgcolor=" << bgcolor_off << " width=\"2\" align=\"center\">\n"
				<< "                  <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"#FFFFFF\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/nav_vert_bar.gif\" width=\"2\" height=\"20\"></FONT></STRONG>\n"
				<< "                </TD>\n";
		}
		// SimpleSearch...
		if(WhichPage == SIMPLE_SEARCH)
		{
			cout << "                <TD bgcolor=" << bgcolor_on << " width=\"122\" align=\"center\">\n"
				<< "                  <STRONG><A href=\"" << Map.PrintValue( "ROOT" ) << "/SimpleSearch.html\"><FONT size=\"2\" face=\"Arial\" color=" << fontcolor_on << ">Simple Search</FONT></A></STRONG>\n"
				<< "                </TD>\n"
				<< "                <TD bgcolor=" << bgcolor_on << " width=\"2\" align=\"center\">\n"
				<< "                  <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"#FFFFFF\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/nav_vert_bar.gif\" width=\"2\" height=\"20\"></FONT></STRONG>\n"
				<< "                </TD>\n";
		}
		else{
			cout << "                <TD bgcolor=" << bgcolor_off << " width=\"122\" align=\"center\">\n"
				<< "                  <STRONG><A href=\"" << Map.PrintValue( "ROOT" ) << "/SimpleSearch.html\"><FONT size=\"2\" face=\"Arial\" color=" << fontcolor_off << ">Simple Search</FONT></A></STRONG>\n"
				<< "                </TD>\n"
				<< "                <TD bgcolor=" << bgcolor_off << " width=\"2\" align=\"center\">\n"
				<< "                  <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"#FFFFFF\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/nav_vert_bar.gif\" width=\"2\" height=\"20\"></FONT></STRONG>\n"
				<< "                </TD>\n";
		}
		// Email...
		cout << "                <TD bgcolor=" << bgcolor_off << " width=\"90\" align=\"center\">\n"
			<< "                  <STRONG><A href=\"mailto:" << Map.PrintValue( "EMAIL" ) << "\"><FONT size=\"2\" face=\"Arial\" color=" << fontcolor_off << ">Contact us</FONT></A></STRONG>\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_off << " width=\"2\" align=\"center\">\n"
			<< "                  <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"#FFFFFF\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/nav_vert_bar.gif\" width=\"2\" height=\"20\"></FONT></STRONG>\n"
			<< "                </TD>\n"
			// LogOut...
			<< "                <TD bgcolor=" << bgcolor_off << " width=\"85\" align=\"center\">\n"
			<< "                  <STRONG><A href=\"" << Map.PrintValue( "ROOT" ) << "/LogOut.html\"><FONT size=\"2\" face=\"Arial\" color=" << fontcolor_off << ">Log Out</FONT></A></STRONG>\n"
			<< "                </TD>\n"
			<< "              </TR>\n"
			<< "              <TR>\n"
			
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"105\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"2\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"60\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"2\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"70\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"2\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"130\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"2\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"122\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"2\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"90\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"2\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n"
			<< "                <TD bgcolor=" << bgcolor_on << " width=\"85\">\n"
			<< "                  &nbsp;\n"
			<< "                </TD>\n";
		} // End else if creating / updating profile info.
		cout << "              </TR>\n"
			<< "            </TABLE>\n"
			<< "          </TD>\n"
			<< "        </TR>\n"
			<< "<!-- Begin Main Data Cell -->\n"
			<< "        <TR>\n"
			//		<< "          <TD valign=\"top\" width=\"573\" height=\"283\">\n"
			<< "          <TD valign=\"top\" bgcolor=" << Map.PrintValue("HTML_BODY_BGCOLOR") << ">\n"
			<< flush;
}

/**********************************************************************
*
*  Html_End...
*
**********************************************************************/
void CConnectionsFormLayout::Html_End(LinkMap & Map)
{
	cout << "<!-- End Main Data Cell -->\n"
		<< "          </TD>\n"
		<< "        </TR>\n"

		//	New style footer as image...
		<< "<!-- Begin Footer Row -->\n"
		<< "  <TR>\n"
		<< "    <TD colspan=\"2\" bgcolor=" << Map.PrintValue("HTML_HEADFOOT_BGCOLOR") << " height=\"50\" valign=\"middle\"> <img  alt=\"" << Map.PrintValue("WHICH_CONNECTIONS") << " Footer\" src=\"" << Map.PrintValue("IMAGES") << "/" << Map.PrintValue("FOOTER") << "\"></TD>\n"
		<< "  </TR><!-- End Footer Row -->\n"
		
/*	Comment out old style footer...

		<< "<!-- Begin Copyright Row -->\n"
		<< "<TR>\n"
		<< "<TD width=\"659\" colspan=\"2\" bgcolor=" << Map.PrintValue("HTML_HEADFOOT_BGCOLOR") << " height=\"23\" valign=\"middle\">\n"
		<< "<FONT face=\"Arial, helvetica\" size=\"4\">" << Map.PrintValue( "WHICH_CONNECTIONS" ) << ".com</FONT>\n"
		<< "<BR>\n"
		<< "<FONT face=\"Arial, helvetica\" size=\"2\">Copyright &copy; " << Map.PrintValue( "COPYRIGHT_YEAR" ) << " " 
		<< Map.PrintValue( "WHICH_CONNECTIONS" ) << ".com. All rights reserved.</FONT?\n"
		<< "</TD>\n"
		<< "<!-- End Copyright Row -->\n"
		<< "</TR>\n" 
*/

		<< "      </TBODY>\n"
		<< "<!-- End Main Table -->\n"
		<< "	</TABLE>\n"
		<< "<!-- End Entire Body -->\n"
		<< "  </BODY>\n"
		<< "</HTML>\n"
		<< flush;
}

#endif // #ifdef NAV_TOP

#ifdef NAV_SIDE

////////////////////////////////////////////////////////////////////
//
//  Html_Begin...
//
////////////////////////////////////////////////////////////////////
void CConnectionsFormLayout::Html_Begin(LinkMap & Map, bool LoggedIn, int WhichPage, char * UniqueID)
{
	cout << "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" "
		<< "\"http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd\">\n"
		<< "<HTML>\n"
		<< "<HEAD>\n"
		<< "<TITLE>" << Map.PrintValue("HTML_TITLE") << "</TITLE>\n"
//		<< "<link href=\"" << Map.PrintValue("ROOT") << "/css/" << Map.PrintValue("STYLE_SHEET") << "\" rel=\"stylesheet\" type=\"text/css\">\n"
		<< "</HEAD>\n" << flush;
	
	if (!LoggedIn)
	{
		cout << "	<!-- Begin Entire Body Logged In-->\n"
			<< "	<BODY>\n" << flush;
		//			<< "   <BODY onLoad=\"rotate()\">\n" << flush;
	}
	else
	{
		cout << "	<!-- Begin Entire Body NOT Logged In-->\n"
			<< "	<BODY>\n" << flush;
	}
	cout << "<!-- Begin Main Table -->\n"
//		<< "<TABLE border=\"0\" cellpadding=\"3\" cellspacing=\"3\" width=\"800\">\n"
		<< "<TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"4\" width=\"800\">\n"
		<< "<!-- Begin Header Row -->\n"
		<< "  <TR>\n"
		<< "    <TD colspan=\"2\" bgcolor=" << Map.PrintValue("HTML_HEADFOOT_BGCOLOR") << " height=\"50\" valign=\"middle\"> <img  alt=\"" << Map.PrintValue("WHICH_CONNECTIONS") << " Logo\" src=\"" << Map.PrintValue("IMAGES") << "/" << Map.PrintValue("LOGO") << "\"></TD>\n"
		<< "  </TR><!-- End Header Row -->\n"
		<< "<!-- Begin Navigation and Main Body Row -->\n"
		<< "<TR>\n"
		<< "<!-- Begin Navigation Table Data Cell-->\n"
		<< "<TD bgcolor=" << Map.PrintValue("HTML_NAV_BGCOLOR") << " valign=\"top\" width=\"150\">&nbsp; \n"
		<< "\n"
		<< "<TABLE border=\"0\" cellpadding=\"4\" cellspacing=\"0\" width=\"100%\">\n";
	// Do not show Nav while creating/updating profile...
	if(
		WhichPage == CREATE_LOGIN
		||	WhichPage == UPDATE_LOGIN
		||	WhichPage == UPDATE_CONTACT
		||	WhichPage == UPDATE_PERSONAL
		||	WhichPage == UPDATE_ABOUT
		)
	{
		cout << "<!-- Hide Navigation Table While Entering/Updating Profiile Info -->\n";
	}
	else
	{
		cout << "<!-- WhichPage = (" << WhichPage << ") -->\n";
		if (!LoggedIn)
		{
			// Remove rotate()
			/*
			// Featured Profiles...
			cout << "<TR>\n"
			<< "  <TD height=\"131\" width=\"143\">\n"
			<< "    <P align=\"center\">\n"
			<< "       <FONT face=\"Arial, Helvetica, sans-serif\">Featured Profiles</FONT>\n"
			<< "    </P>\n"
			<< "    <P align=\"center\">\n"
			<< "       <IMG alt=\"You must be a member to view her personal ad!\" border=\"0\" src=\"/Pictures/Thursday436_1.jpg\" width=\"57\" height=\"57\" name=\"FeatureFemale\">&nbsp; \n"
			<< "	   <IMG alt=\"You must be a member to view his personal ad!\" border=\"0\" src=\"/Pictures/fixlogin_1.jpg\" width=\"57\" height=\"57\" name=\"FeatureMale\">\n"
			<< "      <BR>\n"
			<< "    </P>\n"
			<< "  </TD>\n"
			<< "</TR>\n"
			
			  << "\n"
			*/
			// Home...
			cout << "<TR>\n"
				<< "<TD><A href=\"" << Map.PrintValue( "ROOT" ) << "/index.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Home</FONT></A></TD>\n"
				<< "</TR>\n"
				<< "\n"
				// Log In...
				<< "<TR>\n"
				<< "<TD><A href=\"" << Map.PrintValue( "ROOT" ) << "/LogIn.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Log In</FONT></A></TD>\n"
				<< "</TR>\n"
				<< "\n"
				// Create New...
				<< "<TR> \n"
				<< "<TD><A href=\"" << Map.PrintValue( "ROOT" ) << "/CreateLogin.html\"><FONT size=\"2\" face=\"Arial\" color=\"Red\">Enter a new profile...</FONT></A></TD>\n"
				<< "</TR>\n"
				<< "\n"
				// Remove rotate()
				/*
				<< "<SCRIPT type=\"text/javascript\" language=\"javascript\">\n"
				<< "<!--\n"
				<< "\n"
				<< "MaleImages   = new Array(\"/Pictures/18630x.jpg\",\"/Pictures/fixlogin_1.jpg\",\"/Pictures/13017x.jpg\",\"/Pictures/9169x.jpg\",\"/Pictures/8986x.jpg\",\"/Pictures/9414x.jpg\")\n"
				<< "FemaleImages = new Array(\"/Pictures/Thursday436_1.jpg\",\"/Pictures/18536x.jpg\",\"/Pictures/18026x.jpg\",\"/Pictures/17137x.jpg\",\"/Pictures/15942x.jpg\",\"/Pictures/13475x.jpg\",\"/Pictures/22347x.jpg\",\"/Pictures/Lena.jpg\")\n"
				<< "thisMale     = 1\n"
				<< "thisFemale   = 1\n"
				<< "imgCtMale    = MaleImages.length\n"
				<< "imgCtFemale  = FemaleImages.length\n"
				<< "\n"
				<< "function rotate() \n"
				<< "{\n"
				<< "	if (document.images) \n"
				<< "	{\n"
				<< "		thisMale++\n"
				<< "		if (thisMale == imgCtMale) \n"
				<< "		{\n"
				<< "			thisMale = 0\n"
				<< "		}\n"
				<< "		document.FeatureMale.src=MaleImages[thisMale]\n"
				<< "\n"
				<< "		thisFemale++\n"
				<< "		if (thisFemale == imgCtFemale) \n"
				<< "		{\n"
				<< "			thisFemale = 0\n"
				<< "		}\n"
				<< "		document.FeatureFemale.src=FemaleImages[thisFemale]\n"
				<< "\n"
				<< "	  	setTimeout(\"rotate()\", 3 * 1000)\n"
				<< "  	}\n"
				<< "} // end rotate\n"
				<< "\n"
				<< "// ...End hiding JavaScript form old browsers -->\n"
				<< "</SCRIPT>\n"
				*/
				<< flush;
			
		}
		else
		{
			// Member Home...
			cout << "<TR>\n"
				<< "<TD><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenHome.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Member Home</FONT></A></TD>\n"
				<< "</TR>\n"
				<< "\n";
			// Inbox...
			cout << "<TR>\n"
				<< "<TD><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenInbox.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Inbox</FONT></A></TD>\n"
				<< "</TR>\n"
				<< "\n";
			// Outbox...
			cout << "<TR>\n"
				<< "<TD><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenOutbox.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Outbox</FONT></A></TD>\n"
				<< "</TR>\n"
				<< "\n";
			// Advanced Search...
			cout << "<TR>\n"
				<< "<TD><A href=\"" << Map.PrintValue( "ROOT" ) << "/AdvancedSearch.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Advanced Search</FONT></A></TD>\n"
				<< "</TR>\n"
				<< "\n";
		}
		// Simple Search...
		cout << "<TR>\n"
			<< "<TD><A href=\"" << Map.PrintValue( "ROOT" ) << "/SimpleSearch.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Simple Search</FONT></A></TD>\n"
			<< "</TR>\n"
			<< "\n"
			// Contact Us...
			<< "<TR>\n"
			<< "<TD><A href=\"mailto:" << Map.PrintValue( "EMAIL" ) << "\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Contact us</FONT></A></TD>\n"
			<< "</TR>\n"
			<< "\n";
		if (LoggedIn)
		{
			// Log Out...
			cout << "<TR>\n"
				<< "<TD><A href=\"" << Map.PrintValue( "ROOT" ) << "/LogOut.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Log Out</FONT></A></TD>\n"
				<< "</TR>\n"
				<< "\n";
		}
		cout << "<TR>\n"
			<< "<TD>&nbsp;</TD>\n"
			<< "</TR>\n"
			<< "\n"
//			<< "<TR>\n"
//			<< "<TD>&nbsp;</TD>\n"
//			<< "</TR>\n"
			<< "\n"
			<< "<TR>\n"
			//////////////////////////////////////////
			// OneMonkey TextAd Request JavaScript...
			//////////////////////////////////////////
			<< "<TD><SCRIPT type=\"text/javascript\" src=\"" << Map.PrintValue( "ADV_CGIBIN" ) << "/" << Map.PrintValue( "ADV_RETRIEVE" ) << "?host_unique_id=" << Map.PrintValue( "ADV_HOST_UNIQUE_ID" ) << "&search_unique_id=" << UniqueID << "\"></SCRIPT></TD>\n"
			<< "</TR>\n";
	}
	cout << "<TR>\n"
		<< "<TD></TD>\n"
		<< "</TR>\n"
		<< "\n"


/*
		<< "<TR>\n"
		<< "<TD>\n"
		<< "<DIV align=\"left\">\n"
		<< "<TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n"
		<< "<TR>\n"
		<< "<TD></TD>\n"
		<< "</TR>\n"
		<< "\n"
		<< "</TABLE>\n"
		<< "</DIV>\n"
		<< "</TD>\n"
		<< "</TR>\n"
*/
		<< "<!-- End Navigation Table -->\n"
		<< "</TABLE>\n"
		<< "<!-- End Navigation Table Data Cell-->\n"
		<< "</TD>\n"
		<< "<!-- Begin Main Data Cell -->\n"
		<< "<TD bgcolor=" << Map.PrintValue("HTML_BODY_BGCOLOR") << " valign=\"top\" width=\"650\">\n"
		<< flush;
}

/**********************************************************************
*
*  Html_End...
*
**********************************************************************/
void CConnectionsFormLayout::Html_End(LinkMap & Map)
{
	cout << "<!-- End Main Data Cell -->\n"
		<< "</TD>\n" 
		<< "<!-- End Navigation and Main Row -->\n"
		<< "</TR>\n" 

		//	New style footer as image...
		<< "<!-- Begin Footer Row -->\n"
		<< "  <TR>\n"
		<< "    <TD colspan=\"2\" bgcolor=" << Map.PrintValue("HTML_HEADFOOT_BGCOLOR") << " height=\"50\" valign=\"middle\"> <img  alt=\"" << Map.PrintValue("WHICH_CONNECTIONS") << " Footer\" src=\"" << Map.PrintValue("IMAGES") << "/" << Map.PrintValue("FOOTER") << "\"></TD>\n"
		<< "  </TR><!-- End Footer Row -->\n"
		
/*	Comment out old style footer...

		<< "<!-- Begin Copyright Row -->\n"
		<< "<TR>\n"
		<< "<TD width=\"659\" colspan=\"2\" bgcolor=" << Map.PrintValue("HTML_HEADFOOT_BGCOLOR") << " height=\"23\" valign=\"middle\">\n"
		<< "<FONT face=\"Arial, helvetica\" size=\"4\">" << Map.PrintValue( "WHICH_CONNECTIONS" ) << ".com</FONT>\n"
		<< "<BR>\n"
		<< "<FONT face=\"Arial, helvetica\" size=\"2\">Copyright &copy; " << Map.PrintValue( "COPYRIGHT_YEAR" ) << " " 
		<< Map.PrintValue( "WHICH_CONNECTIONS" ) << ".com. All rights reserved.</FONT?\n"
		<< "</TD>\n"
		<< "<!-- End Copyright Row -->\n"
		<< "</TR>\n" 
*/
		<< "<!-- End Main Table -->\n"
		<< "</TABLE>\n"
		<< "<!-- End Entire Body -->\n"
		<< "</BODY>\n"
		<< "<!-- End Entire HTML -->\n"
		<< "</HTML>\n" 
		<< endl << flush;
}

#endif // #ifdef NAV_SIDE
