/************************************************************************
*                                                                       *
*  PROGRAM ID         : SendWink.cpp							            *
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
#include <iostream>	// defines the standard input and output functions
#include <fstream>	// defines the standard file input and output functions

#include "cgicc/Cgicc.h"

#include "DB_Table_Base/Profile_Info.h"
#include "Connections_Templates/Connections_Templates.h"
#include "CommentMacro.h" // contains the contains the comment macro def of "dout"
#include "SendMailBlat/SendMailBlat.h"

using std::flush;
using std::string;
using namespace cgicc;

int
main ()
{
	// make this the very first thig printed to prevent CGI ERRORS...
	cout << "Content-Type: text/html\n\n" << flush;

	string Program_Name("SendWink.exe");
	
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
	
	cfl.Html_Begin(Map, 1, SEND_WINK);
	
	// Get user_name and password from cookie list
	bool cookies_found = false;
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

	form_iterator wink_at = cgi.getElement("winked_at");
	if( wink_at != cgi.getElements().end() && cookies_found )
	{
		//	Create a Profile_Info object to hold all the Form and Database data...
		Profile_Info profile_info("wink_send", "");
		
		dout << "<!-- determining if user_name and password_hint match... -->" << endl;
		
		string Sql_buf("");
		
		Sql_buf += ("\"" + cookie_name + "\", \"" + wink_at->getValue() + "\"");
//		Sql_buf += ("\"\", \"" + cookie_name + "\"");
		
		bool Return_Status = false;
		profile_info.Set_Get_Info_Sql( Sql_buf );
		
		dout << "<!-- Sql: " << profile_info.Get_Get_Info_Sql() << " -->\n" << endl;
		
		Return_Status = profile_info.Get_Info_From_DB(Map);
		
		if(Return_Status == false)
		{
			if (profile_info.DB_Table_Base_Error_Number >= 800 && profile_info.DB_Table_Base_Error_Number < 811)
			{
				cout<< "<table width=\"511\" height=\"165\" border=\"0\" cellpadding=\"4\" cellspacing=\"0\" background=\"" << Map.PrintValue( "IMAGES" ) << "/orange_box.gif\">\n"
					<< "  <tr> \n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "  </tr>\n"
					<< "  <tr> \n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td><span class=\"BlackTextMedium\">We are sorry but you can not send </span> \n"
					<< "      <span class=\"BlackTextLargeBold\">" << wink_at->getValue() << "</span> <span class=\"BlackTextMedium\">a wink \n"
					<< "      until your previous wink expires.</span></td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "  </tr>\n"
					<< "  <tr>\n"
					<< "    <td>&nbsp;</td>\n"

					<< "	<td align=\"center\">\n"
					<< "		<a href=\"" << Map.PrintValue( "CGIBIN" ) << "/ViewWinks.exe\" class=\"NavText\">view who has winked at you...</a>\n"
					<< "	</td>\n"
					<< "    <td height=\"48\">&nbsp;</td>\n"
					<< "  </tr>\n"
					<< "  <tr> \n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "  </tr>\n"
					<< "</table>\n";
			}
			else
			{
				dout << "<!-- ERROR: DB or Message error. -->\n" << endl;
				dout << "<!-- Sql: " << profile_info.Get_Get_Info_Sql() << " -->\n" << endl;
				cout<< "<table width=\"511\" height=\"165\" border=\"0\" cellpadding=\"4\" cellspacing=\"0\" background=\"" << Map.PrintValue( "IMAGES" ) << "/orange_box.gif\">\n"
					<< "  <tr> \n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "  </tr>\n"
					<< "  <tr> \n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td><span class=\"BlackTextMedium\">We are sorry but our system will not currently allow you to send </span> \n"
					<< "      <span class=\"BlackTextLargeBold\">" << wink_at->getValue() << "</span> <span class=\"BlackTextMedium\">a wink.\n"
					<< "      <BR>Please try again later.</span></td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "  </tr>\n"
					<< "  <tr>\n"
					<< "    <td>&nbsp;</td>\n"

					<< "	<td align=\"center\">\n"
					<< "		<a href=\"" << Map.PrintValue( "CGIBIN" ) << "/ViewWinks.exe\" class=\"NavText\">view who has winked at you...</a>\n"
					<< "	</td>\n"
					<< "    <td height=\"48\">&nbsp;</td>\n"
					<< "  </tr>\n"
					<< "  <tr> \n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "  </tr>\n"
					<< "</table>\n";
			}
		}
		else if(Return_Status == true)
		{
			string mail_flag = "wink";
			string user_name = profile_info.Get_DBActual_From_ColumnName("user_name");
			string email	 = profile_info.Get_DBActual_From_ColumnName("email"	);
			string age		 = profile_info.Get_DBActual_From_ColumnName("age"		);
			string sex		 = profile_info.Get_DBActual_From_ColumnName("sex"		);
			string height	 = profile_info.Get_DBActual_From_ColumnName("height"	);
			string weight	 = profile_info.Get_DBActual_From_ColumnName("weight"	);
			string hair		 = profile_info.Get_DBActual_From_ColumnName("hair"		);
			string eyes		 = profile_info.Get_DBActual_From_ColumnName("eyes"		);
			string city		 = profile_info.Get_DBActual_From_ColumnName("city"		);
			string state	 = profile_info.Get_DBActual_From_ColumnName("state"	);
			string country	 = profile_info.Get_DBActual_From_ColumnName("country"	);
			string photo_1	 = profile_info.Get_DBActual_From_ColumnName("photo_1"	);
			
			string photo_display("");

			if(photo_1 == "Nothing" || photo_1.length() < 1)
			{
				photo_display = Map.PrintValue( "IMAGES" ) + "/" + Map.PrintValue( "NO_PIC_SMALL" );
			}
			else
			{
				photo_display = Map.PrintValue( "PICTURES" ) + "/60X60_" + photo_1;
			}

			string his_her("");
			string he_she("");
			string him_her("");

			if(sex == "Female")
			{
				his_her = "her";
				he_she	= "she";
				him_her	= "her";
			}
			else
			{
				his_her = "his";
				he_she	= "he";
				him_her	= "him";
			}
			string file_name = Map.PrintValue("DOS_PICTURES_FOLDER");
			file_name += cookie_name + "_wink_" + user_name + ".html";
//			file_name += cookie_name + "_wink_" + user_name;

			string Mail_Body("");

			// open the output file
			std::ofstream file( file_name.c_str() );

			if( file )
			{
				file << "<HTML>\n"
					<< "    <HEAD>\n"
					<< "        <title>Wink Notification</title> \n"
					<< "        <meta content=\"http://schemas.microsoft.com/intellisense/ie3-2nav3-0\" name=\"vs_targetSchema\">\n"
					<< "        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\">\n"
					<< "        <style type=\"text/css\">.cBT { FONT-SIZE: 11px; COLOR: #333333; FONT-FAMILY: Verdana }\n"
					<< "	.cH { FONT-WEIGHT: 700; FONT-SIZE: 12px; COLOR: #d00078; FONT-FAMILY: Verdana }\n"
					<< "	.cNL { FONT-WEIGHT: 400; FONT-SIZE: 11px; COLOR: #2042c0; FONT-FAMILY: Verdana }\n"
					<< "	.cUIL { FONT-SIZE: 11px; COLOR: #0038cc; FONT-FAMILY: Verdana }\n"
					<< "	.cMP { FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #3d3d3d; FONT-FAMILY: Verdana }\n"
					<< "	.cLB { FONT-SIZE: 10px; COLOR: #0038cc; FONT-FAMILY: Verdana }\n"
					<< "	.cBT2 { FONT-SIZE: 11px; COLOR: #3d3d3d; FONT-FAMILY: Verdana }\n"
					<< "	.cUNSBT { FONT-SIZE: 9px; COLOR: #6699cc; FONT-FAMILY: Verdana }\n"
					<< "	</style>\n"
					<< "    </HEAD>\n"
					<< "    <body bgColor=\"#f7f7f7\">\n"
					<< "        <table cellSpacing=\"0\" cellPadding=\"0\" width=\"640\">\n"
					<< "            <tr>\n"
					<< "                <td bgColor=\"#FCD294\" colSpan=\"3\"><IMG height=\"3\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\"></td>\n"
					<< "            </tr>\n"
					<< "            <tr>\n"
					<< "                <td bgColor=\"#FCF2DC\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "WINK_MAIL_LOGO" ) << "\" width=\"150\" height=\"40\"></td>\n"
					<< "            </tr>\n"
					<< "            <tr>\n"
					<< "                <td bgColor=\"#FCD294\" colSpan=\"3\"><IMG height=\"3\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\"></td>\n"
					<< "            </tr>\n"
					<< "            <tr>\n"
					<< "                <td bgColor=\"#FCF2DC\" colSpan=\"3\"><IMG height=\"1\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\"></td>\n"
					<< "            </tr>\n"
					<< "            <tr>\n"
					<< "                <td bgColor=\"#FCF2DC\" colSpan=\"3\"><IMG height=\"1\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\"></td>\n"
					<< "            </tr>\n"
					<< "        </table>\n"
					<< "        <table cellSpacing=\"0\" cellPadding=\"0\" width=\"640\">\n"
					<< "            <tr>\n"
					<< "                <td><IMG height=\"18\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"640\"></td>\n"
					<< "            </tr>\n"
					<< "        </table>\n"
					<< "        <table cellSpacing=\"0\" cellPadding=\"0\" width=\"640\">\n"
					<< "            <tr>\n"
					<< "                <td><IMG height=\"57\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"15\"></td>\n"
					<< "                <td bgColor=\"#ffffff\"><IMG height=\"57\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"11\"></td>\n"
					<< "                <td bgColor=\"#ffffff\">\n"
					<< "                    <P><IMG height=\"4\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"372\">\n"
					<< "                        <span class=\"cBT\">\n"
					<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/FixUrl.cgi?turl=" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "&mf=wink\" class=\"cLB\">" << user_name << "</A> liked your profile and sent you a \"wink\" to let you know " + he_she + " is interested in getting to know you.<br><br>  Take a look - if you like what you see, click on <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/FixUrl.cgi?turl=" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "&mf=wink\" class=\"cLB\">" << user_name << "</A>'s picture to see " + his_her + " full profile. You can then choose to wink back, or subscribe and send <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/FixUrl.cgi?turl=" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "&mf=wink\" class=\"cLB\">" << user_name << "</A> an email!\n"
					<< "                        </span><IMG height=\"4\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"372\">\n"
					<< "                    </P>\n"
					<< "                </td>\n"
					<< "                <td bgColor=\"#ffffff\"><IMG height=\"8\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"11\"></td>\n"
					<< "                <td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"2\" height=\"20\"></td>\n"
					<< "                <td><IMG height=\"8\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"6\"></td>\n"
					<< "                <td>&nbsp;</td>\n"
					<< "                <td><IMG height=\"8\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"25\"></td>\n"
					<< "            </tr>\n"
					<< "            <tr>\n"
					<< "                <td><IMG height=\"6\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"15\"></td>\n"
					<< "                <td><IMG height=\"6\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"11\"></td>\n"
					<< "                <td><IMG height=\"6\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"372\"></td>\n"
					<< "                <td><IMG height=\"6\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"11\"></td>\n"
					<< "                <td><IMG height=\"6\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"4\"></td>\n"
					<< "                <td><IMG height=\"6\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"6\"></td>\n"
					<< "                <td><IMG height=\"6\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"200\"></td>\n"
					<< "                <td><IMG height=\"6\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"25\"></td>\n"
					<< "            </tr>\n"
					<< "        </table>\n"
					<< "        <table cellSpacing=\"0\" cellPadding=\"0\">\n"
					<< "            <tr>\n"
					<< "                <td colSpan=\"7\"><IMG height=\"10\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"640\"></td>\n"
					<< "            </tr>\n"
					<< "			<tr>\n"
					<< "				<td bgcolor=\"#ffffff\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"4\" height=\"20\"></td>\n"
					<< "				<td bgcolor=\"#ffffff\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"10\" height=\"20\"></td>\n"
					<< "				<td bgcolor=\"#ffffff\" colspan=\"3\"><span class=\"cH\">Wink Details</span></td>\n"
					<< "				<td align=\"right\" valign=\"middle\" bgcolor=\"#ffffff\"><a href=\"" << Map.PrintValue( "CGIBIN" ) << "/FixUrl.cgi?turl=" << Map.PrintValue( "ROOT" ) << "/SimpleSearch.html\" class=\"cNL\">Search other users  >></a>&nbsp;&nbsp;</td>\n"
					<< "				<td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"2\" height=\"20\"></td>\n"
					<< "			</tr>\n"
					<< "<tr>\n"
					<< "	<td bgcolor=\"#ffffff\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"4\" height=\"20\"></td>\n"
					<< "	<td bgcolor=\"#ffffff\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"10\" height=\"20\"></td>\n"
					<< "	<td bgcolor=\"#ffffff\"><!-- Begin Result -->\n"
					<< "		<table width=\"154\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n"
					<< "			<tr>\n"
					<< "				<td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"4\" height=\"1\"></td>\n"
					<< "				<td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"77\" height=\"1\"></td>\n"
					<< "				<td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"56\" height=\"1\"></td>\n"
					<< "				<td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"8\" height=\"1\"></td>\n"
					<< "				<td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"4\" height=\"1\"></td>\n"
					<< "				<td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"5\" height=\"1\"></td>\n"
					<< "			</tr>\n"
					<< "			<tr>\n"
					<< "				<td bgcolor=\"#FCD294\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"4\" height=\"22\"></td>\n"
					<< "				<td width=\"141\" colspan=\"2\" bgcolor=\"#FCD294\"><a href=\"" << Map.PrintValue( "CGIBIN" ) << "/FixUrl.cgi?turl=" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "&mf=wink\" class=\"cUIL\">" << user_name << "</a></td>\n"
					<< "				<td colspan=\"2\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"12\" height=\"22\"></td>\n"
					<< "				<td rowspan=\"8\" bgcolor=\"#ffffff\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"5\" height=\"195\"></td>\n"
					<< "			</tr>\n"
					<< "			<tr>\n"

					<< "				<td colspan=\"2\" bgcolor=\"#FCF2DC\"><a href=\"" << Map.PrintValue( "CGIBIN" ) << "/FixUrl.cgi?turl=" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "&mf=wink\"><img src=\"" + photo_display + "\" border=\"0\"></a></td>\n"
					
					<< "				<td align=\"center\" valign=\"middle\" width=\"64\" height=\"100\" colspan=\"2\" bgcolor=\"#FCF2DC\">\n"
					<< "					<span class=\"cMP\">\n"
					<< "				<br><br><br><a href=\"" << Map.PrintValue( "CGIBIN" ) << "/FixUrl.cgi?turl=" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "&mf=wink\" class=\"cLB\">View Full Profile...</a></span></td>\n"
					<< "				<td rowspan=\"4\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"4\" height=\"158\"></td>\n"
					<< "			</tr>\n"
					<< "			<tr>\n"
					<< "				<td colspan=\"4\" bgcolor=\"#FCD294\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"145\" height=\"8\"></td>\n"
					<< "			</tr>\n"
					<< "			<tr>\n"
					<< "				<td bgcolor=\"#FCD294\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"4\" height=\"41\"></td>\n"
					<< "				<td colspan=\"2\" bgcolor=\"#FCD294\" width=\"133\"><span class=\"cBT2\">\n"
					<< "			I'm " << age << "&nbsp;" << height << "<br>" << weight << "<br>" << city << ", " << state << "\n"
					<< "			</span>\n"
					<< "				</td>\n"
					<< "				<td bgcolor=\"#FCD294\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"8\" height=\"41\"></td>\n"
					<< "			</tr>\n"
					<< "			<tr>\n"
					<< "				<td colspan=\"4\" bgcolor=\"#FCD294\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"145\" height=\"9\"></td>\n"
					<< "			</tr>\n"
					<< "			<tr>\n"
					<< "				<td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"4\" height=\"3\"></td>\n"
					<< "				<td colspan=\"3\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"141\" height=\"3\"></td>\n"
					<< "				<td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"4\" height=\"3\"></td>\n"
					<< "			</tr>\n"
					<< "			<tr>\n"
					<< "				<td colspan=\"5\" bgcolor=\"#ffffff\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"149\" height=\"12\"></td>\n"
					<< "			</tr>\n"
					<< "		</table>\n"
					<< "	</td>\n"
					<< "	<td bgcolor=\"#ffffff\">\n"
					<< "		<table width=\"154\" cellpadding=\"0\" cellspacing=\"0\" >\n"
					<< "			<tr>\n"
					<< "				<td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"154\" height=\"1\"></td>\n"
					<< "			</tr>\n"
					<< "		</table>\n"
					<< "	</td>\n"
					<< "	<td bgcolor=\"#ffffff\">\n"
					<< "		<table width=\"154\" cellpadding=\"0\" cellspacing=\"0\" >\n"
					<< "			<tr>\n"
					<< "				<td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"154\" height=\"1\"></td>\n"
					<< "			</tr>\n"
					<< "		</table>\n"
					<< "	</td>\n"
					<< "	<td bgcolor=\"#ffffff\">\n"
					<< "		<table width=\"154\" cellpadding=\"0\" cellspacing=\"0\" >\n"
					<< "			<tr>\n"
					<< "				<td><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"154\" height=\"1\"></td>\n"
					<< "			</tr>\n"
					<< "		</table>\n"
					<< "	</td>\n"
					<< "		<td background=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\"><img src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"2\" height=\"20\"></td>\n"
					<< "</tr>\n"
					<< "<tr>\n"
					<< "	<td colSpan=\"7\"><IMG height=\"10\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"640\"></td>\n"
					<< "</tr>\n"
					<< "	</table>\n"
					<< "	<table cellSpacing=\"0\" cellPadding=\"0\">\n"
					<< "		<tr>\n"
					<< "			<td colSpan=\"7\"><IMG height=\"10\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"640\"></td>\n"
					<< "		</tr>\n"
					<< "	</table>\n"
					<< "	<table cellSpacing=\"0\" cellPadding=\"0\" bgColor=\"#f7f7f7\">\n"
					<< "		<tr>\n"
					<< "			<td><IMG height=\"1\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"45\"></td>\n"
					<< "			<td colSpan=\"2\"></td>\n"
					<< "			<td><IMG height=\"1\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"45\"></td>\n"
					<< "		</tr>\n"
					<< "	</table>\n"
					<< "	<table cellSpacing=\"0\" cellPadding=\"0\">\n"
					<< "		<tr>\n"
					<< "			<td colSpan=\"7\"><IMG height=\"10\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"640\"></td>\n"
					<< "		</tr>\n"
					<< "	</table>\n"
					<< "	<table cellSpacing=\"0\" cellPadding=\"0\" width=\"640\" bgColor=\"#f7f7f7\">\n"
					<< "		<tr>\n"
					<< "			<td><span class=\"cBT\">P.S. As a member of " + Map.PrintValue( "WHICH_CONNECTIONS" ) + " you are automatically notified when other " + Map.PrintValue( "WHICH_CONNECTIONS" ) + " members express interest in you.</span></td>\n"
					<< "		</tr>\n"
					<< "		<tr>\n"
					<< "			<td><IMG height=\"10\" src=\"" << Map.PrintValue( "IMAGES" ) << "/spacer.gif\" width=\"640\"></td>\n"
					<< "		</tr>\n"
					<< "	</table>\n"
					<< "<br>\n"
					<< "<br>\n"
					<< "    </body>\n"
					<< "</HTML>\n";

					file.close();
			}
			else
			{
				dout << "<!-- ERROR: Could not open file (" + file_name + "). -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, the system was unable to process your wink requests.<BR>Please try again...</font>\n" << endl;
				cfl.Html_AddHistoryButton(-1, "Back");
			}



			string MailSubject		= "\"" + Map.PrintValue( "WHICH_CONNECTIONS" ) + " Winks...\"";
			string MailBody			= "\"You have received a wink from " + cookie_name + ".  Just log in to view the user's profile by pointing your favorite browser to " + Map.PrintValue( "ROOT" ) + "/LogIn.html\"";
			// Send the user their info via email...

			int blat_return = SendMailBlat(Map									// Map
//												, "jatlast@yahoo.com"			// To
//												, "jatlast@hotmail.com"			// To
//												, "baumbach@optonline.net"		// To
//												, Map.PrintValue("EMAIL")		// To
												, email							// To
												, MailSubject					// Subject
												, Map.PrintValue("EMAIL")		// From
												, ""							// BCC
												, ""							// Body (Not used by function)
												, file_name						// Full path to the HTML file to attach
												, Map.PrintValue("SMTP_HOST")	// This is the default smtp host (i.e., smtpout.bellatlantic.net)
											);
			if(blat_return == 0)
			{
				cout<< "<table width=\"511\" height=\"165\" border=\"0\" cellpadding=\"4\" cellspacing=\"0\" background=\"" << Map.PrintValue( "IMAGES" ) << "/orange_box.gif\">\n"
					<< "  <tr> \n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "  </tr>\n"
					<< "  <tr> \n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td><span class=\"BlackTextMedium\">You have successfully sent </span> \n"
					<< "      <span class=\"BlackTextLargeBold\">" << user_name << "</span> <span class=\"BlackTextMedium\">a wink \n"
					<< "      to let " << him_her << " know you are interested.</span></td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "  </tr>\n"
					<< "  <tr>\n"
					<< "    <td>&nbsp;</td>\n"

					<< "	<td align=\"center\">\n"
					<< "		<a href=\"" << Map.PrintValue( "CGIBIN" ) << "/ViewWinks.exe\" class=\"NavText\">view who has winked at you...</a>\n"
					<< "	</td>\n"
					<< "    <td height=\"48\">&nbsp;</td>\n"
					<< "  </tr>\n"
					<< "  <tr> \n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "    <td>&nbsp;</td>\n"
					<< "  </tr>\n"
					<< "</table>\n";
			}
			else
			{
				dout << "<!-- ERROR: Blat Error. -->\n" << endl;
				dout << "<!-- Blat Return: " << blat_return << " -->\n" << endl;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, the system was unable to process your wink requests.<BR>Please try again...</font>\n" << endl;
				cfl.Html_AddHistoryButton(-1, "Back");
			}
		}
		else
		{
			dout << "<!-- ERROR: DB Error. -->\n" << endl;
			dout << "<!-- Sql: " << profile_info.Get_Get_Info_Sql() << " -->\n" << endl;
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

