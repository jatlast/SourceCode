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

/* Header Files */

#include <string>
#include <iostream>

#include "cgicc/Cgicc.h"
#include "cgicc/CGIEnvironment.h"

#include "SendMailBlat/SendMailBlat.h"
#include "Connections_Templates/Connections_Templates.h"
#include "LinkMap/LinkMap.h" // associative map class
#include "ConnectionsFunctions/ConnectionsFormLayout.h"
#include "AddJavaScript/AddJavaScript.h"
#include "CommentMacro.h" // contains the contains the comment macro def of "dout"

using std::flush;
using namespace cgicc;

bool
Search_Template(class DB_Table_Base *& Base_Ptr, const string & Program_Name)
{	
	// make this the very first thig printed to prevent CGI ERRORS...
	cout << "Content-Type: text/html\n\n" << flush;

	bool NotLoginInfo = false;
	bool SuccessfulUpdate = true;
	
	CConnectionsFormLayout cfl;
	
	//		Create a new Cgicc object containing all the CGI data...
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
	
	//cfl.Html_1_BeginEntireAndTitle(Map);
	
	///////////////////////////////////////////
	// Determine if the user is logged in...
	///////////////////////////////////////////
	
	// Get user_name and password from cookie list
	bool cookies_found = false;
	string cookie_name("");
	string cookie_password("");
	if(Get_Cookie_Name_Password(cgi, cookie_name, cookie_password))
	{
		if( !cookie_name.empty() )
		{
			//dout << "<!-- FOUND: cookie_name     : " << cookie_name     << "-->\n";
			//dout << "<!-- FOUND: cookie_password : " << cookie_password << "-->\n";
			cookies_found = true;
		}
		else
		{
			dout << "<!-- ERROR: cookie_name     : " << cookie_name     << "-->\n";
			dout << "<!-- ERROR: cookie_password : " << cookie_password << "-->\n";
		}
	}
	
//	cfl.Html_Begin(Map, cookies_found, 1);
	
	/////////////////// END Determine if the user is logged in ///////////////////////////
	
	/* Removed 3-30-02 so both Simple and Advanced require the user to be logged in...
	if (Program_Name == "AdvancedSearch.exe" && !cookies_found)
	{
	cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "LogIn.html" );
	}
	*/
	
	//	Get the data entered by the user from the form fields...
	Base_Ptr->Get_Form_Info_From_Cgi(cgi);
	

	// prepare the sql statement
	string Sql_buf("");
	
	/* Removed 3-30-02 so both Simple and Advanced require the user to be logged in...
	if (Program_Name == "AdvancedSearch.exe")
	{
	*/
	for(unsigned int i=0; i<Base_Ptr->Vect.size(); i++)
	{
		Sql_buf += ("\"" + Base_Ptr->Vect[i].web_form_data + (i+1 == Base_Ptr->Vect.size() ? "\", \"" + cookie_name + "\"" : "\", ") );
	}
	/* Removed 3-30-02 so both Simple and Advanced require the user to be logged in...
	}
	*/
	
	/* Removed 3-30-02 so both Simple and Advanced require the user to be logged in...
	else
	{
	for(unsigned int i=0; i<Base_Ptr->Vect.size(); i++)
	{
	Sql_buf += ("\"" + Base_Ptr->Vect[i].web_form_data + (i+1 == Base_Ptr->Vect.size() ? "\"" : "\", ") );
	}
	}
	*/
	
	
	bool Return_Status = false;
	
	Base_Ptr->Set_Get_Info_Sql( Sql_buf );
	
	Return_Status = Base_Ptr->Search_The_DB(Map
		, Program_Name
		, atoi(Base_Ptr->Get_FormData_From_ColumnName("index").c_str())
		, atoi(Base_Ptr->Get_FormData_From_ColumnName("search_limit").c_str())
		, cookies_found
		);
	if(Return_Status == false)
	{
		dout << "<!-- ERROR: DB or Message error. -->\n" << endl;
		dout << "<!-- Sql: " << Base_Ptr->Get_Get_Info_Sql() << " -->\n" << endl;
		
		cout << "<font face=geneva,arial color=blue size=+1>" << Base_Ptr->DB_Table_Base_Error_Text << "</font>\n" << endl;
		if(Base_Ptr->DB_Table_Base_Error_Number == 201)// user does not exist
		{
			cfl.Html_AddRedirect(Map.PrintValue( "CGIBIN" ), "ManageEmailVerification.cgi" );
		}
		else if(Base_Ptr->DB_Table_Base_Error_Number == 140)// user does not exist
		{
			cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "CreateLogin.html" );
		}
		else if(Base_Ptr->DB_Table_Base_Error_Number >= 600 && Base_Ptr->DB_Table_Base_Error_Number < 700)
		{
			if (Program_Name == "AdvancedSearch.exe")
			{
				cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "PaymentOptions.html" );
			}
			else // Take user to CreateLogin.html if SimpleSearch.exe fails...
			{
				cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "CreateLogin.html" );
			}
		}
		else if(Base_Ptr->DB_Table_Base_Error_Number >= 700 && Base_Ptr->DB_Table_Base_Error_Number < 800)
		{
			if (Program_Name == "AdvancedSearch.exe")
			{
				cfl.Html_AddRedirect(Map.PrintValue( "CGIBIN" ), "GenPicUpload.exe" );
			}
			else // Take user to CreateLogin.html if SimpleSearch.exe fails...
			{
				// since this is the force_pic_upload code the user should be able to use SimpleSearch.exe...
			//	cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "CreateLogin.html" );
			}
		}
		else
		{
			cout << "<!-- ERROR: DB error code ("<< Base_Ptr->DB_Table_Base_Error_Number <<") not recognized. -->\n" << endl;
			cfl.Html_AddHistoryButton(-1, "Back");
		}
	}
	else
	{
		dout << "<!-- Sql: " << Base_Ptr->Get_Get_Info_Sql() << " -->\n" << endl << flush;
	}
	
	cfl.Html_End(Map);
	
	return EXIT_SUCCESS;
}

bool
SingleProfile_Template(class DB_Table_Base *& Base_Ptr, const string & Program_Name)
{	
	// make this the very first thig printed to prevent CGI ERRORS...
	cout << "Content-Type: text/html\n\n" << flush;

	bool NotLoginInfo = false;
	bool SuccessfulUpdate = true;
	
	CConnectionsFormLayout cfl;
	
	//		Create a new Cgicc object containing all the CGI data...
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
//	cfl.Html_Begin(Map, 1, SINGLE_PROFILE);
	//cfl.Html_1_BeginEntireAndTitle(Map);
	
	string mf(""); // for mail_flag
	
	// Get user_name and password from cookie list
	bool cookies_found = false;
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
		// "mf" is for mail flag.  It is set to "wink" when coming from links embeded into mails...
		form_iterator mail_flag = cgi.getElement("mf");	
		if( mail_flag != cgi.getElements().end() )
		{
			if ( mail_flag->isEmpty() )
			{
				dout << "<!-- ERROR: mf (" << mail_flag->getValue() << ") was passed without a value.\n";
				cout << "<BR>You have to log in to view this page." << endl;
				dout << "<BR>cookie_name : " << cookie_name << endl;
				dout << "<BR>cookie_password : " << cookie_password << endl;
				cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "Login.html" );
			}
			else
			{
				mf = mail_flag->getValue();
			}
		}
		else
		{
			dout << "<!-- ERROR: mf was not passed.\n";
			cout << "<BR>You have to log in to view this page." << endl;
			dout << "<BR>cookie_name : " << cookie_name << endl;
			dout << "<BR>cookie_password : " << cookie_password << endl;
			cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "Login.html" );
		}
	}
	
	/*
	cfl.Html_2_BeginEntireBody(cookies_found);
	cfl.Html_3_BeginMainTable();
	cfl.Html_4_HeaderRow(Map);
	cfl.Html_5_BeginNavigationAndMainBodyRow();
	cfl.Html_6_NavigationTableDataCell(Map, cookies_found);
	cfl.Html_7_BeginMainDataCell(Map);
	*/
	
	//	Get the data entered by the user from the form fields...
	Base_Ptr->Get_Form_Info_From_Cgi(cgi);
	
	// prepare the sql statement
	string Sql_buf("");

	if ( mf == "wink" )
	{
		Sql_buf += ("\"" + Base_Ptr->Get_FormData_From_ColumnName("user_name") + "\", \"" + Base_Ptr->Get_FormData_From_ColumnName("user_name") + "\"" );
	}
	else
	{
		Sql_buf += ("\"" + Base_Ptr->Get_FormData_From_ColumnName("user_name") + "\", \"" + cookie_name + "\"" );
	}
	
	bool Return_Status = false;
	
	// ??????????? This does not look right.  Shouldn't it be Set_Get_Info_Sql ?????????????
	Base_Ptr->Set_Update_Info_Sql( Sql_buf );
	
	if (Program_Name == "SingleProfile.exe")
	{
		string PictureNumber;
		form_iterator pictur_number = cgi.getElement("picture_number");
		if( pictur_number != cgi.getElements().end() )
		{
			if ( pictur_number->isEmpty() )
			{
				PictureNumber = "1";
				dout << "<!-- picture_number (" << PictureNumber << ") -->\n";
			}
			else
			{
				PictureNumber += pictur_number->getValue();
				dout << "<!-- picture_number (" << PictureNumber << ") -->\n";
			}
		}
		else
		{
			PictureNumber = "1";
			dout << "<!-- picture_number (" << PictureNumber << ") -->\n";
		}
		
		Return_Status = Base_Ptr->SingleSearch_The_DB(Map, Program_Name, PictureNumber);
	}// END if SingleProfile.exe
	else if (Program_Name == "GenSendMail.exe")
	{
		Return_Status = Base_Ptr->GenSendMail_The_DB(Map, Program_Name);
	}// END if GenSendMail.exe
	else
	{
		cout << "ERROR: this should never happen.  " << Program_Name << " is an unrecognized program name\n";
	}
	
	if(Return_Status == false)
	{
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
		else if(Base_Ptr->DB_Table_Base_Error_Number == 205)
		{
			cfl.Html_AddHistoryButton(-1, "Back");
		}
		else if(Base_Ptr->DB_Table_Base_Error_Number >= 299 && Base_Ptr->DB_Table_Base_Error_Number < 300)
		{
			cfl.Html_AddHistoryButton(-1, "Back");
		}
		else if(Base_Ptr->DB_Table_Base_Error_Number >= 600 && Base_Ptr->DB_Table_Base_Error_Number < 700)
		{
			cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "PaymentOptions.html" );
		}
		else if(Base_Ptr->DB_Table_Base_Error_Number >= 700 && Base_Ptr->DB_Table_Base_Error_Number < 800)
		{
			cfl.Html_AddRedirect(Map.PrintValue( "CGIBIN" ), "GenPicUpload.exe" );
		}
		else
		{
			cout << "<BR><font face=geneva,arial color=blue size=+1>The user you are tying to view may no longer exist.<BR>Please update your bookmarks.</font>\n" << endl;
			cout << "<!-- ERROR: DB error code ("<< Base_Ptr->DB_Table_Base_Error_Number <<") not recognized. -->\n" << endl;
			cfl.Html_AddHistoryButton(-1, "Back");
		}
	}
	else
	{
		dout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl << flush;
	}
	
	cfl.Html_End(Map);
	/*
	cfl.Html_8_EndMainDataCell();
	cfl.Html_9_EndNavigationAndMainRow();
	cfl.Html_10_CopyrightRow(Map);
	cfl.Html_11_EndMainTable();
	cfl.Html_12_EndEntireBody();
	cfl.Html_13_EndEntireHTML();
	*/
	return EXIT_SUCCESS;
}


bool
Update_Template(class DB_Table_Base *& Base_Ptr, const string & Program_Name)
{
	// make this the very first thig printed to prevent CGI ERRORS...
	cout << "Content-Type: text/html\n\n" << flush;

	bool PopUp = false;
	bool SuccessfulUpdate = true;
	//	instantiate the class that defines the form layouts for the page...
	CConnectionsFormLayout cfl;
	
	//		Create a new Cgicc object containing all the CGI data...
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

	//	instantiate a AddJavaScript object using the Login_Info Vecotr created above...
	AddJavaScript js(Base_Ptr->Vect);
	
	if( Program_Name != "CreateLogin.exe")
	{
		cfl.Html_Begin(Map, 0, CREATE_LOGIN);
	}
	else if( Program_Name != "UpdateLogin.exe")
	{
		cfl.Html_Begin(Map, 1, UPDATE_LOGIN);
	}
	else if( Program_Name != "UpdateConact.exe")
	{
		cfl.Html_Begin(Map, 1, UPDATE_CONTACT);
	}
	else if( Program_Name != "UpdatePersonal.exe")
	{
		cfl.Html_Begin(Map, 1, UPDATE_PERSONAL);
	}
	else if( Program_Name != "UpdateAbout.exe")
	{
		cfl.Html_Begin(Map, 1, UPDATE_ABOUT);
	}
	else
	{
		cfl.Html_Begin(Map, 1, 1);
	}


//	cfl.Html_1_BeginEntireAndTitle(Map);
	///////////////////////////////////////////
	// Determine if the user is logged in...
	///////////////////////////////////////////
	
	bool cookies_found = false;
	string cookie_name("");
	string cookie_password("");
	
	if( Program_Name != "CreateLogin.exe")
	{
		// Get user_name and password from cookie list
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
			cfl.Html_AddProcessingGif(Map);
			cout << "<BR>You must log in to view this page." << endl << flush;
			dout << "<BR>cookie_name : " << cookie_name << endl << flush;
			dout << "<BR>cookie_password : " << cookie_password << endl << flush;
			cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "LogIn.html" );
			SuccessfulUpdate = false;
		}
	}
	
	/////////////////// END Determine if the user is logged in ///////////////////////////
	
		/*
		cfl.Html_2_BeginEntireBody(cookies_found);
		cfl.Html_3_BeginMainTable();
		cfl.Html_4_HeaderRow(Map);
		cfl.Html_5_BeginNavigationAndMainBodyRow();
		cfl.Html_6_NavigationTableDataCell(Map, cookies_found);
		cfl.Html_7_BeginMainDataCell(Map);
		*/
	
	// if submit has been pressed which indicates the program calling itself
	form_iterator submit = cgi.getElement("submit");
	
	if( submit != cgi.getElements().end() )
	{
		if (! submit->isEmpty() )
		{
			dout << "<!-- Processing Update... 1-->" << endl;
			
			//	The following block of code handles the Update of the user's info...
			
			if( cookies_found && Program_Name == "SendMail.exe")
			{
				// this is a hack but it puts the current user_name in the right place...
				Base_Ptr->Vect[2].web_form_data = cookie_name.data();
				dout << "<!-- Changed " << Base_Ptr->Vect[2].db_column_name << " to " << cookie_name.data() << " -->" << endl << flush;
			}			
			if(SuccessfulUpdate)
			{
				
				//	Get the data entered by the user from the form fields...
				
				Base_Ptr->Get_Form_Info_From_Cgi(cgi);

				// Escape Quotation Marks...
				if( cookies_found && Program_Name == "UpdateAbout.exe")
				{
					// screen_quote...
					Base_Ptr->Vect[1].web_form_data = Escape_Quotation_Marks(Base_Ptr->Vect[1].web_form_data);
					// about_info...
					Base_Ptr->Vect[2].web_form_data = Escape_Quotation_Marks(Base_Ptr->Vect[2].web_form_data);
				}			
								
				// Start Affiliate tracking code...
				if( Program_Name == "CreateLogin.exe")
				{
					string cookie_name("ckuid");
					string cookie_value("");
					
					// Get "ckuid" from cookie list
					if(Get_Single_Cookie_By_Name(cgi, cookie_name, cookie_value))
					{
						if( !cookie_value.empty() )
						{
							dout << "<!-- FOUND: " << cookie_name << "     : " << cookie_value << "-->\n";
							// put the current ckuid in the right place...
							Base_Ptr->Vect[13].web_form_data = cookie_value.data();
							dout << "<!-- Changed " << Base_Ptr->Vect[13].db_column_name << " to " << cookie_value.data() << " -->" << endl << flush;
						}
						else
						{
							dout << "<!-- ERROR: " << cookie_name << "     : " << cookie_value << "-->\n";
						}
					}
					else
					{
						dout << "<!-- Warning: cookie (" << cookie_name << ") not foud -->\n";
					}
				}
				else
				{
					dout << "<!-- Program Name (" << Program_Name << ") -->\n";
				}
				// End Affiliate tracking code...

				// prepare the sql statement
				string Sql_buf("");
				for(unsigned int i=0; i<Base_Ptr->Vect.size(); i++)
				{
					Sql_buf += ("\"" + Base_Ptr->Vect[i].web_form_data + (i+1 == Base_Ptr->Vect.size() ? "\"" : "\", ") );
				}
				
				// Add the user's IP address to the end of the sql statement...
				if( Program_Name == "CreateLogin.exe")
				{
					Sql_buf += ", \"" + env.getRemoteAddr() + "\"";
				}

				bool Return_Status = false;
				// initialize the appropriate sql base member variable
				Base_Ptr->Set_Update_Info_Sql( Sql_buf );
				// error checking
				dout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl << flush;
				// call the database to update the table using the update stored procedure
				Return_Status = Base_Ptr->Update_Info_In_DB(Map);
				if(PopUp)
				{
					cfl.Html_2_BeginPopUpFormat(Map);
				}
				
				if(Return_Status == false)
				{
					dout << "<!-- ERROR: DB Error. -->\n" << endl << flush;
					dout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl << flush;
					if(Program_Name == "CreateLogin.exe")
					{
						cout << "<font face=geneva,arial color=blue size=+1>Sorry, The user name you have chosen is already in use.<BR>Please use the back button and try again...</font>\n" << endl;
					}
					else
					{
						cout << "<font face=geneva,arial color=blue size=+1>Sorry, your information could not be updated.<BR>Please use the back button and try again...</font>\n" << endl;
					}
					cfl.Html_AddHistoryButton(-1, "Back");
					SuccessfulUpdate = false;
				}
				else if(Return_Status == true)
				{
					// if user is updating password information reset cookie
					if ( Base_Ptr->Get_FormData_From_ColumnName("password") != "form_name not found")
					{
						// Since the user_name and password may have changed update the cookies
						cfl.Html_AddNamePasswordCookie(Base_Ptr->Get_FormData_From_ColumnName("user_name"), Base_Ptr->Get_FormData_From_ColumnName("password") );
					}
					if(Program_Name == "SendMail.exe")
					{
						cout << "<font face=geneva,arial color=black size=+1>Your message has been sent to <B>\"" << Base_Ptr->Get_FormData_From_ColumnName("sent_to") << "\"</B></font>.\n" << endl << flush;
						cfl.Html_AddHistoryJump(-2);
					}
					else
					{
						cout << "<font face=geneva,arial color=black size=+1>Your profile has been updated.</FONT>\n"<< flush;
						if(Program_Name == "SendMail.exe")
						{
							cfl.Html_AddHistoryButton(-2, "Back");							
						}
						else if(Program_Name == "CreateLogin.exe")
						{
							// Since the profile was successfully created access the DB to retrieve the 
							//  user's email verification code...

							Sql_buf = "";
							Sql_buf += ("\"" + Base_Ptr->Get_FormData_From_ColumnName("user_name") + "\", \"" + Base_Ptr->Get_FormData_From_ColumnName("password") + "\"");
							Return_Status = false;
							Base_Ptr->Set_Get_Info_Sql( Sql_buf );
							cout << "<!-- Sql: " << Base_Ptr->Get_Get_Info_Sql() << " -->\n" << endl << flush;
							Return_Status = Base_Ptr->Get_Info_From_DB(Map);
							if(Return_Status == false)
							{
								dout << "<!-- ERROR: DB Error. -->\n" << endl << flush;
								dout << "<!-- Sql: " << Base_Ptr->Get_Get_Info_Sql() << " -->\n" << endl << flush;
								cout << "<font face=geneva,arial color=blue size=+1>Sorry, your Login Info information could not be accessed.<BR>Please use the back button and try again...</font>\n" << endl;
								SuccessfulUpdate = false;
								cfl.Html_AddHistoryButton(-1, "Back");
							}
							else if(Return_Status == true)
							{
								string VerificationCode = Base_Ptr->Get_DBActual_From_ColumnName("email_verification_code");
								string UserName = Base_Ptr->Get_DBData_From_ColumnName("user_name");
								string Password = Base_Ptr->Get_DBData_From_ColumnName("password");
								string Email	= Base_Ptr->Get_DBData_From_ColumnName("email");
								string MailSubject = "\"Here is your " + Map.PrintValue( "WHICH_CONNECTIONS" ) + " email verification code...\"";
///////////////////////////////////
/////// WARNING ///////////////////
///////////////////////////////////
// Do not change the			///
// format of the MailBody text	///
//								///
// Body Text must be quoted		///
// | is replaced with /n		///
///////////////////////////////////
							string MailBody = "\"\
----------- Email Verification Code -----------|\
   Code:      " + VerificationCode + "|\
   User Name: " + Base_Ptr->Get_FormData_From_ColumnName("user_name") + "|\
   Password:  " + Base_Ptr->Get_FormData_From_ColumnName("password") + "|\
-----------------------------------------------|\
||\
----------- How To Verify Email ---------------------------|\
There are 4 different ways for you to verify your email|\
address using the Email Verification Code (" + VerificationCode + ").|\
  (1) Automatic|\
  (2) Cut and Paste|\
  (3) Manual|\
  (4) Reply|\
-----------------------------------------------------------|\
||\
--------------------------- (1) ---------------------------|\
------------------------ Automatic ------------------------|\
-----------------------------------------------------------|\
Simply click on the link below to automatically verify your|\
email address...|\
" + Map.PrintValue( "CGIBIN" ) + "/ManageEmailVerification.cgi?submit=Verify_My_Email_Address&user_name=" + UserName + "&password=" + Password + "&email=" + Email + "&email_verification_code=" + VerificationCode + "|\
|\
If this does not work try following the steps below under|\
Cut and Paste...|\
-----------------------------------------------------------|\
|||\
--------------------------- (2) ---------------------------|\
---------------------- Cut and Paste ----------------------|\
-----------------------------------------------------------|\
  (1) Copy the above link by highlighting it then holding|\
      down the Control key then the C key. (Ctrl-C)|\
|\
  (2) Past the link into your favorite browser's Address|\
      field by holding down the Control key then|\
      the V key. (Ctrl-V)|\
|\
  (3) Press the Enter key to automatically verify your|\
      email address.|\
|\
If this does not work try following the steps below|\
under Manual...|\
-----------------------------------------------------------|\
|||\
--------------------------- (3) ---------------------------|\
-------------------------- Manual -------------------------|\
-----------------------------------------------------------|\
  (1) Log in to " + Map.PrintValue( "ROOT" ) + "/index.html which|\
      automatically takes you to the Member Home page.|\
|\
  (2) From the Member Home page click Update/Verify Email|\
      under Update Profile... which takes you to the|\
      Email Verification Form.|\
|\
  (3) Put the Email Verification Code (" + VerificationCode + ")|\
      into the Verification Code field under Option 2.|\
|\
  (4) Click the Verify_My_Email_Address button.|\
|\
If this does not work try following the steps below|\
under Reply...|\
--------------------------------------------------------|\
|||\
--------------------------- (4) ---------------------------|\
-------------------------- Reply --------------------------|\
-----------------------------------------------------------|\
  (1) Reply to this mail making sure it contains all the|\
      above text|\
|\
  (2) Wait for a few hours for the site administrator to|\
      verify your email address|\
|\
  (3) Log in to " + Map.PrintValue( "ROOT" ) + "/index.html to see if your|\
      email address has been verified.|\
---------------------------------------------------------------|\
||\
Thank you,|\
 |\
" + Map.PrintValue( "WHICH_CONNECTIONS" ) + "|\
" + Map.PrintValue( "EMAIL" ) + "|\
\"";

							// Send the user their info via email...
							SendMailBlat(Map
								, Email
								, MailSubject
								, Map.PrintValue("EMAIL")// This is the default admin email from the linkmap.dat (ie. admin@connections.com)
								, "" // BCC is not necessary
								, MailBody
								, Map.PrintValue("SMTP_HOST")// This is the default smtp host (i.e., smtpout.bellatlantic.net)
								);
							cfl.Html_AddRedirect(Map.PrintValue( "CGIBIN" ), "UpdateContact.exe");
							}
							else
							{
								dout << "<!-- ERROR: DB Error. -->\n" << endl << flush;
								dout << "<!-- Sql: " << Base_Ptr->Get_Get_Info_Sql() << " -->\n" << endl << flush;
								cout << "<font face=geneva,arial color=blue size=+1>Sorry, your Login Information information could not be accessed because of an unknown error.<BR>Please use the back button and try again...</font>\n" << endl;
								cout << "<!-- This should never happen.  Return_Status = \"" << Return_Status << "\" -->\n" << endl << flush;
								SuccessfulUpdate = false;
								cfl.Html_AddHistoryButton(-1, "Back");
							}
						}
						else if(Program_Name == "UpdateLogin.exe")
						{
							cfl.Html_AddRedirect(Map.PrintValue( "CGIBIN" ), "UpdateContact.exe");
						}
						else if(Program_Name == "UpdateContact.exe")
						{
							cfl.Html_AddRedirect(Map.PrintValue( "CGIBIN" ), "UpdatePersonal.exe");
						}
						else if(Program_Name == "UpdatePersonal.exe")
						{
							cfl.Html_AddRedirect(Map.PrintValue( "CGIBIN" ), "UpdateAbout.exe");
						}
						else if(Program_Name == "UpdateAbout.exe")
						{
							// Left over from trying to fix the Perl Program admin cgi...
							//cfl.Html_AddNamePasswordCookie(cookie_name, cookie_password);
							cfl.Html_AddRedirect(Map.PrintValue( "CGIBIN" ), "GenHome.exe");
						}
						else
						{
							cfl.Html_AddRedirect(Map.PrintValue( "CGIBIN" ), "GenHome.exe");
						}
						
					}
				}
				else
				{
					dout << "<!-- ERROR: DB Error. -->\n" << endl << flush;
					dout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl << flush;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, your information could not be added because of an unknown error.<BR>Please use the back button and try again...</font>\n" << endl;
					cout << "<!-- This should never happen.  Return_Status = \"" << Return_Status << "\" -->\n" << endl << flush;
					cfl.Html_AddHistoryButton(-1, "Back");
					SuccessfulUpdate = false;
				}
			}// end if SuccessfulUpdate
			else
			{
				dout << "<!-- ERROR: Update Not Successful. -->\n" << endl << flush;
				dout << "<!-- Sql: " << Base_Ptr->Get_Update_Info_Sql() << " -->\n" << endl << flush;
				cout << "ERROR: New User Was Not Added.<br>" << endl << flush;
				cout << "<!-- This means a cookie was not found???. -->\n" << flush;
				
			}
		} // end if (! submit->isEmpty() )
		
	}
	else if( cookies_found ) // this is the first time in
	{
		
		if(SuccessfulUpdate)
		{			
			cout << "	<FORM method=\"POST\" action=\"" << Map.PrintValue( "CGIBIN" ) << "/" << Program_Name << "\" onsubmit=\"return checkForm(this)\" >" << endl << flush;
			
			
			if(PopUp)
			{
				cfl.Html_2_BeginPopUpFormat(Map);
			}
			
			string Sql_buf("");
			
			Sql_buf += ("\"" + cookie_name + "\", \"" + cookie_password + "\"");
			
			bool Return_Status = false;
			
			Base_Ptr->Set_Get_Info_Sql( Sql_buf );
			cout << "<!-- Sql: " << Base_Ptr->Get_Get_Info_Sql() << " -->\n" << endl << flush;
			
			Return_Status = Base_Ptr->Get_Info_From_DB(Map);
			
			if(Return_Status == false)
			{
				dout << "<!-- ERROR: DB Error. -->\n" << endl << flush;
				dout << "<!-- Sql: " << Base_Ptr->Get_Get_Info_Sql() << " -->\n" << endl << flush;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, your table information could not be accessed.<BR>Please use the back button and try again...</font>\n" << endl;
				SuccessfulUpdate = false;
				cfl.Html_AddHistoryButton(-1, "Back");
			}
			else if(Return_Status == true)
			{
				// Begin Notice of deletion...
				cout << "          <TABLE border=\"0\" width=\"80%\" cellpadding=\"5\">\n"
					<< "            <TR>\n"
					<< "              <TD height=\"54\">\n"
					<< "                <DIV align=\"left\">\n"
					<< "                  <FONT face=\"Arial, Helvetica, sans-serif\" size=\"3\"><STRONG><FONT color=\"#FF0000\">Notice! If you do not complete the entire registration process your account will not become activated and will be deleted from the system.</FONT></STRONG></FONT>\n"
					<< "                </DIV>\n"
					<< "              </TD>\n"
					<< "            </TR>\n"
					<< "          </TABLE>\n" << flush;
				
				// Begin redundancy...
				cout << "    <TABLE border=\"0\" width=\"651\" cellspacing=\"10\" cellpadding=\"2\">\n" << endl << flush;
				for(unsigned int i=0; i<Base_Ptr->Vect.size(); i++)
				{
					Base_Ptr->Print_Current_And_Change(Base_Ptr->Vect[i].db_column_name);				
				}
				// ...End Redundancy
				cout << "" << endl;
				cout << "	<tr>" << endl;
				cout << "      <td width=\"122\"></td>" << endl;
				cout << "      <td width=\"100\"><font face=\"Arial, Helvetica, sans-serif\" size=\"2\"><input type=\"submit\" name=\"submit\" value=\"submit\"></font></td>" << endl << flush;
				cout << "    </tr>" << endl;
				cout << "   </FORM>" << endl;
				cout << "  </table>\n" << endl;
			}
			else
			{
				dout << "<!-- ERROR: DB Error. -->\n" << endl << flush;
				dout << "<!-- Sql: " << Base_Ptr->Get_Get_Info_Sql() << " -->\n" << endl << flush;
				cout << "<font face=geneva,arial color=blue size=+1>Sorry, your table information could not be accessed because of an unknown error.<BR>Please use the back button and try again...</font>\n" << endl;
				cout << "<!-- This should never happen.  Return_Status = \"" << Return_Status << "\" -->\n" << endl << flush;
				SuccessfulUpdate = false;
				cfl.Html_AddHistoryButton(-1, "Back");
			}
			// if this is the UpdateAbout Program do not check user_name via JavaScript...
			if ( Base_Ptr->Get_FormData_From_ColumnName("screen_quote") != "form_name not found"
				|| Base_Ptr->Get_FormData_From_ColumnName("sex_preference") != "form_name not found"
				|| Base_Ptr->Get_FormData_From_ColumnName("street_address") != "form_name not found"
				)
			{
				js.ToggleFlag("user_name");
			}
		}// end if(SuccessfulUpdate)
	}// end first time in (Select)
	else // not directly accessable user error
	{
		cfl.Html_2_BeginPopUpFormat(Map);
		cout << "<BR>This page is not directly accessable.  It must be called by LogIn.html" << endl;
		// redirect to index.html
		cfl.Html_AddRedirect(Map.PrintValue( "ROOT" ), "LogIn.html");
		
	}// ... end not directly accessable else clause
	
	
		/*
		cfl.Html_8_EndMainDataCell();
		cfl.Html_9_EndNavigationAndMainRow();
		cfl.Html_10_CopyrightRow(Map);
		cfl.Html_11_EndMainTable();
*/
		if(Program_Name == "UpdateBilling.exe")
		{
			js.InsertJavaScriptFile( Map.PrintValue( "ROOT" ), "JavaScript/UpdateBilling.js" );
		}
		else if( Program_Name == "UpdateAbout.exe")
		{
			js.InsertJavaScriptFile( Map.PrintValue( "ROOT" ), "JavaScript/UpdateAbout.js" );
		}
		else
		{
			//cout << "Java Script Dump (" << js.faf_vect << ")" << endl;
			js.InsertJavaScript();
		}
		cfl.Html_End(Map);
		/*
		cfl.Html_12_EndEntireBody();
		cfl.Html_13_EndEntireHTML();
		*/
	
	// No chance for failure in this example
	return SuccessfulUpdate;
	
}// end Update_Template


bool
Get_Cookie_Name_Password(const Cgicc& cgi, string& cookie_name, string& cookie_password)
{
	//dout << "<!-- Start Get_Cookie_Name_Password -->\n";
	bool return_value	= true;
	//	Get the cookies if there are any...
	
	// Get a pointer to the environment
	const CgiEnvironment& cgiEnv = cgi.getEnvironment();
	
	//	Get the cookies if there are any...
	vector<HTTPCookie> cookieList = cgiEnv.getCookieList();
	
	form_iterator Admin_Field = const_cast<FormEntry *>(cgi.getElement("admin_field"));
	form_iterator User_Name_Admin = const_cast<FormEntry *>(cgi.getElement("user_name"));
	form_iterator Password_Admin = const_cast<FormEntry *>(cgi.getElement("password"));
	if( Admin_Field != cgi.getElements().end() )
	{
		if ( Admin_Field->isEmpty() )
		{
			//dout << "<!-- This should never happen : Admin_Field (" << Admin_Field << ") -->\n";
		}
		else
		{
			if ( User_Name_Admin->isEmpty() || Password_Admin->isEmpty() )
			{
				dout << "<!-- This should never happen : User_Name_Admin OR Password_Admin is empty -->\n";
			}
			else
			{
				cookie_name = User_Name_Admin->getValue();
				//dout << "<!-- FOUND ADMIN: cookie_name    : (" << cookie_name     << ") -->\n";
				cookie_password = Password_Admin->getValue();
				//dout << "<!-- FOUND ADMIN: cookie_password    : (" << cookie_name     << ") -->\n";
			}
		}
	}
	else
	{
		// Get user_name and password from cookie list
		if(cookieList.size() > 0)
		{
			for(unsigned int i=0; i<cookieList.size(); i++)
			{
				// The space is necessary because that is how the cookie names are stored sometimes
				if(cookieList[i].getName() == " cookie_name" || cookieList[i].getName() == "cookie_name")
				{
					if(cookieList[i].getValue() != "NULL")
					{
						cookie_name = cookieList[i].getValue();
					//	dout << "<!-- FOUND: cookie_name    : (" << cookie_name     << ") -->\n";
					}
					else
					{
					//	dout << "<!-- Bad: cookie_name    : (" << cookie_name     << ") -->\n";
						return_value = false;
					}
				}
				else if(cookieList[i].getName() == " cookie_password" || cookieList[i].getName() == "cookie_password")
				{
					if(cookieList[i].getValue() != "NULL")
					{
						cookie_password = cookieList[i].getValue();
					//	dout << "<!-- FOUND: cookie_password: (" << cookie_password << ") -->\n";
					}
					else
					{
					//	dout << "<!-- Bad: cookie_password: (" << cookie_password << ") -->\n";
						return_value = false;
					}
				}
			}
		}
		else
		{
		//	dout << "<!-- cookieList.size: (" << cookieList.size() << ") -->\n";
			return_value = false;
		}
	}
	
	
	if (cookie_name.empty() || cookie_password.empty() || cookie_name == "NULL" || cookie_password == "NULL")
	{
	//	dout << "<!-- cookie_name    : (" << cookie_name     << ") -->\n";
	//	dout << "<!-- cookie_password: (" << cookie_password << ") -->\n";
		return_value = false;
	}
	
	//dout << "<!-- End Get_Cookie_Name_Password -->\n";
	return return_value;
}

bool
Get_Single_Cookie_By_Name(const Cgicc& cgi, const string cookie_name, string& cookie_value)
{
	//dout << "<!-- Start Get_Single_Cookie_By_Name -->\n";
	bool return_value	= true;
	
	// Get a pointer to the environment
	const CgiEnvironment& cgiEnv = cgi.getEnvironment();
	
	//	Get the cookie if it exists...
	vector<HTTPCookie> cookieList = cgiEnv.getCookieList();
	
	// Get the cookie sought from the cookie list...
	if(cookieList.size() > 0)
	{
		for(unsigned int i=0; i<cookieList.size(); i++)
		{
			// The space is necessary because that is how the cookie names are stored sometimes
			string cookie_name_with_leading_space = " " + cookie_name;

			if(cookieList[i].getName() == cookie_name_with_leading_space || cookieList[i].getName() == cookie_name)
			{
				if(cookieList[i].getValue() != "NULL")
				{
					cookie_value = cookieList[i].getValue();
					dout << "<!-- FOUND: " << cookie_name << "   : (" << cookie_value     << ") -->\n";
				}
				else
				{
					dout << "<!-- Bad: " << cookie_name << "    : (" << cookie_value     << ") -->\n";
					return_value = false;
				}
			}
		}
	}
	else
	{
		dout << "<!-- cookieList.size: (" << cookieList.size() << ") -->\n";
		return_value = false;
	}
	
	
	if (cookie_name.empty() || cookie_value.empty() || cookie_value == "NULL")
	{
		dout << "<!-- looking for cookie: (" << cookie_name  << ") -->\n";
		dout << "<!-- value of cookie   : (" << cookie_value << ") -->\n";
		return_value = false;
	}
	
	dout << "<!-- End Get_Single_Cookie_By_Name -->\n";
	return return_value;
}

string
Escape_Quotation_Marks(const string & string_to_replace)
{
	dout << "<!-- Pre Escaped Quotes: (" << string_to_replace << ") -->\n";
	// convert the "subject" character array to a std::string ...
	string string_to_return;  // Create a string.
	
	for(int i = 0; string_to_replace[i] != NULL; i++)
	{
		if (string_to_replace[i] == '\"')
		{
			string_to_return += "\"\"";
		}
		else
		{
			string_to_return += string_to_replace[i];
		}
	}
	dout << "<!-- Post Escaped Quotes: (" << string_to_return << ") -->\n";
	return string_to_return;
}
