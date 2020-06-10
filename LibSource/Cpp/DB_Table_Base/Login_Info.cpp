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

#include "Login_Info.h"
#include "DB_Table_Base.h"


using std::cout;
using std::endl;

using db_table_base_namespace::DB_Table_Base;

Login_Info::Login_Info(const string & get_sql, const string & update_sql)
//: DB_Table_Base::get_info_sql(get_sql), DB_Table_Base::update_info_sql(update_sql)
{
	//										db_column_name				, db_column_data,   db_column_actual, web_form_name			, web_form_data, web_form_hidden_data	, row_number, vartype		, length
	DB_Table_Base::DB_Table_Info column1 ("user_id"						,	""			,		""			, ""					,	""		   ,			""			,		1	, NTBSTRINGBIND	,	USER_ID					);
	DB_Table_Base::DB_Table_Info column2 ("user_name"					,	""			,		""			, "User Name"			,	""		   ,			""			,		2	, NTBSTRINGBIND	,	USER_NAME				);
	DB_Table_Base::DB_Table_Info column3 ("membership_type"				,	""			,		""			, ""					,	""		   ,			""			,		3	, NTBSTRINGBIND	,	MEMBERSHIP_TYPE			);
	DB_Table_Base::DB_Table_Info column4 ("password"					,	""			,		""			, "Password"			,	""		   ,			""			,		4	, NTBSTRINGBIND	,	PASSWORD				);
	DB_Table_Base::DB_Table_Info column5 ("password_hint"				,	""			,		""			, "Mother's Maiden Name",	""		   ,			""			,		5	, NTBSTRINGBIND	,	PASSWORD_HINT			);
	DB_Table_Base::DB_Table_Info column6 ("email"						,	""			,		""			, "Email"				,	""		   ,			""			,		6	, NTBSTRINGBIND	,	EMAIL					);
	DB_Table_Base::DB_Table_Info column7 ("sex"							,	""			,		""			, "Sex"					,	""		   ,			""			,		7	, NTBSTRINGBIND	,	SEX						);
	DB_Table_Base::DB_Table_Info column8 ("creation_date"				,	""			,		""			, "Creatioin Date"		,	""		   ,			""			,		8	, NTBSTRINGBIND	,	CREATION_DATE			);
	DB_Table_Base::DB_Table_Info column9 ("last_login"					,	""			,		""			, "Last Login"			,	""		   ,			""			,		9	, NTBSTRINGBIND	,	LAST_LOGIN				);
	DB_Table_Base::DB_Table_Info column10("photo_submitted"				,	""			,		""			, ""					,	""		   ,			""			,		10	, NTBSTRINGBIND	,	PHOTO_SUBMITTED			);
	DB_Table_Base::DB_Table_Info column11("date_started_paying"			,	""			,		""			, ""					,	""		   ,			""			,		11	, NTBSTRINGBIND	,	DATE_STARTED_PAYING		);
	DB_Table_Base::DB_Table_Info column12("email_verification_code"		,	""			,		""			, ""					,	""		   ,			""			,		12	, NTBSTRINGBIND	,	EMAIL_VERIFICATION_CODE	);
	DB_Table_Base::DB_Table_Info column13("is_email_verified"			,	""			,		""			, ""					,	""		   ,			""			,		13	, NTBSTRINGBIND	,	IS_EMAIL_VERIFIED		);
	DB_Table_Base::DB_Table_Info column14("affiliate_tracking_id"		,	""			,		""			, ""					,	""		   ,			""			,		14	, NTBSTRINGBIND	,	AFFILIATE_TRACKING_ID	);
	DB_Table_Base::DB_Table_Info column15("affiliate_action_status"		,	""			,		""			, ""					,	""		   ,			""			,		15	, NTBSTRINGBIND	,	AFFILIATE_ACTION_STATUS	);
	
	DB_Table_Base::Vect.push_back(column1 );
	DB_Table_Base::Vect.push_back(column2 );
	DB_Table_Base::Vect.push_back(column3 );
	DB_Table_Base::Vect.push_back(column4 );
	DB_Table_Base::Vect.push_back(column5 );
	DB_Table_Base::Vect.push_back(column6 );
	DB_Table_Base::Vect.push_back(column7 );
	DB_Table_Base::Vect.push_back(column8 );
	DB_Table_Base::Vect.push_back(column9 );
	DB_Table_Base::Vect.push_back(column10);
	DB_Table_Base::Vect.push_back(column11);
	DB_Table_Base::Vect.push_back(column12);
	DB_Table_Base::Vect.push_back(column13);
	DB_Table_Base::Vect.push_back(column14);
	DB_Table_Base::Vect.push_back(column15);
	
	DB_Table_Base::get_info_sql		= get_sql;
	DB_Table_Base::update_info_sql	= update_sql;

	DB_Table_Base::DB_Table_Base_Error_Text = "Login_Info Constructor";

	//cout << "Within Login_Info(string, string) -------------" << endl;	
}


Login_Info::Login_Info(const string & update_sql)// : DB_Table_Base::Vect(9), DB_Table_Base::sql(sql_statement)
//: DB_Table_Base::get_info_sql(get_sql), DB_Table_Base::update_info_sql("")
{
	//										db_column_name	, db_column_data,	db_column_actual, web_form_name		, web_form_data	, web_form_hidden_data	, row_number, vartype		, length
	DB_Table_Base::DB_Table_Info column1("user_name"		,	""			,		""			, "User Name"		,	""			,			""			,		1	, NTBSTRINGBIND	,	USER_NAME);
	DB_Table_Base::DB_Table_Info column2("password"			,	""			,		""			, "Password"		,	""			,			""			,		2	, NTBSTRINGBIND	,	PASSWORD);
	
	DB_Table_Base::Vect.push_back(column1);
	DB_Table_Base::Vect.push_back(column2);
	//Vect.push_back(column3);
	//Vect.push_back(column4);
	DB_Table_Base::get_info_sql = "";
	DB_Table_Base::update_info_sql = update_sql;
	//cout << "Within Login_Info(string) -------------" << endl;	
}

void
Login_Info::Print_Current_And_Change( const string & name )
{
	int column_number = Get_RowNumber_From_ColumnName( name );
	
	int index = column_number - 1;
	
	switch (column_number)
	{
	case 1 :
		cout << "	<!--    user_id  " << Vect[index].db_column_data << " -->\n"
			
			<< "		<INPUT\n"
			<< "         type=\"hidden\"\n"
			<< "         name=\"db_user_id\"\n"
			<< "         value=\"" << Vect[index].db_column_data << "\">\n"
			<< endl;

		break;
	case 2 : 
		Print_Current(Vect[index]);
		cout << "	<!--  user_name -->\n"
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"120\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             face=\"Arial, Helvetica, sans-serif\" size=\"2\"> <FONT color=\"Red\"><STRONG>*</STRONG></FONT>User Name: </FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"335\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"left\">\n"
			<< "             <INPUT\n"
			<< "             type=\"text\"\n"
			<< "             name=\"user_name\"\n"
			<< "             value=\"" << Vect[index].db_column_data << "\"\n"
			<< "             size=\"20\"> <FONT\n"
			<< "             size=\"2\"\n"
			<< "             color=\"#FF0000\">Others will see this name</FONT>\n"
			<< "          </TD>\n"
			<< "        </TR>\n"
			<< endl;
					
		break;
	case 3 :
		cout << "	<!--    membership_type  " << Vect[index].db_column_data << " -->\n"

			<< "		<INPUT\n"
			<< "         type=\"hidden\"\n"
			<< "         name=\"db_membership_type\"\n"
			<< "         value=\"" << Vect[index].db_column_data << "\">\n"
			<< endl;
			
		break;
	case 4 :
		Print_Current(Vect[index]);
		cout << "        <!--    password  -->\n"
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"120\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"right\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\">\n"
			<< "               <FONT\n"
			<< "               face=\"Arial, Helvetica, sans-serif\" size=\"2\"><FONT color=\"Red\"><STRONG>*</STRONG></FONT>Password:</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"335\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"left\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\"><INPUT\n"
			<< "               type=\"password\"\n"
			<< "               name=\"password\"\n"
			<< "             value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               maxlength=\"8\"><FONT\n"
			<< "               size=\"2\"\n"
			<< "               color=\"#FF0000\"> Store for future use</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "        </TR>\n"
			<< "\n"
			<< "        <!--    verify_password   -->\n"
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"120\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"right\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\">\n"
			<< "               <FONT\n"
			<< "               face=\"Arial, Helvetica, sans-serif\" size=\"2\"><FONT color=\"Red\"><STRONG>*</STRONG></FONT>Verify Password:</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"335\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"left\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\"><INPUT\n"
			<< "               type=\"password\"\n"
			<< "               name=\"verify_password\"\n"
			<< "             value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"20\"\n"
			<< "               maxlength=\"8\"><FONT\n"
			<< "               size=\"2\"\n"
			<< "               color=\"#FF0000\"> Compare password inputs</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "        </TR>\n"
			<< endl;
		
		break;
	case 5 :
		cout << "        <!--    password_hint -->\n"
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"120\"\n"
			<< "           height=\"22\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             face=\"Arial, Helvetica, sans-serif\" size=\"2\"><FONT color=\"Red\"><STRONG>*</STRONG></FONT>Mother's Maiden Name:</FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"335\"\n"
			<< "           height=\"22\"\n"
			<< "           align=\"left\"><INPUT\n"
			<< "             name=\"password_hint\"\n"
			<< "             value=\"" << Vect[index].db_column_data << "\"\n"
			<< "             size=\"20\"> <FONT\n"
			<< "             color=\"#FF0000\"\n"
			<< "             size=\"2\">To get your password</FONT>\n"
			<< "          </TD>\n"
			<< "        </TR>\n"
			<< endl;
			
		break;
	case 6 :
		Print_Current(Vect[index]);
		cout << "        <!--  email -->\n"
			<< "		<INPUT\n"
			<< "         type=\"hidden\"\n"
			<< "         name=\"email\"\n"
			<< "         value=\"" << Vect[index].db_column_data << "\">\n"
			<< endl;
			
		break;
	case 7 :
		Print_Current(Vect[index]);
		cout << "        <!--    Sex   -->\n"
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"120\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             face=\"Arial, Helvetica, sans-serif\" size=\"2\">Sex:</FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"335\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"left\"><SELECT\n"
			<< "             size=\"1\"\n"
			<< "             name=\"sex\">\n"
			<< "              <OPTION Selected\n"
			<< "              value=\"" << Vect[index].db_column_actual << "\">\n"
			<< "              " << Vect[index].db_column_data << "\n"
			<< "              </OPTION>\n"
			<< "              <OPTION\n"
			<< "               value=\"0\">\n"
			<< "                Prefer not to say\n"
			<< "              </OPTION>\n"
			<< "              <OPTION\n"
			<< "               value=\"1\">\n"
			<< "                Male\n"
			<< "              </OPTION>\n"
			<< "              <OPTION\n"
			<< "               value=\"2\">\n"
			<< "                Female\n"
			<< "              </OPTION>\n"
			<< "            </SELECT>\n"
			<< "          </TD>\n"
			<< "        </TR>\n"
			<< endl;
		
		break;
	case 8 :
		{
			// remove seconds and miliseconds from the date fields...
			string creation_date = Vect[index].db_column_data;
			if(creation_date.size() > 20)
			{
				creation_date.replace(creation_date.size()-9, 7, "");
			}
			cout << "	<!--    creation_date  -->\n"
				
				<< "		<INPUT\n"
				<< "         type=\"hidden\"\n"
				<< "         name=\"db_creation_date\"\n"
				<< "         value=\"" << creation_date << "\">\n"
				
				<< "        <TR>\n"
				<< "          <TD\n"
				<< "           width=\"120\"\n"
				<< "           height=\"25\"\n"
				<< "           align=\"right\">\n"
				<< "            <FONT\n"
				<< "             face=\"Arial, Helvetica, sans-serif\" size=\"2\"> Creation Date:</FONT>\n"
				<< "          </TD>\n"
				<< "          <TD\n"
				<< "           width=\"335\"\n"
				<< "           height=\"25\"\n"
				<< "           align=\"left\"><B>" << creation_date << "</B>\n"
				<< "          </TD>\n"
				<< "        </TR>\n"
				<< endl;
			
			break;
		}
	case 9 :
		{
			// remove seconds and miliseconds from the date fields...
			string last_login = Vect[index].db_column_data;
			if(last_login.size() > 20)
			{
				last_login.replace(last_login.size()-9, 7, "");
			}
			cout << "	<!--    last_login  -->\n"
				
				<< "		<INPUT\n"
				<< "         type=\"hidden\"\n"
				<< "         name=\"db_last_login\"\n"
				<< "         value=\"" << last_login << "\">\n"
				
				<< "        <TR>\n"
				<< "          <TD\n"
				<< "           width=\"120\"\n"
				<< "           height=\"25\"\n"
				<< "           align=\"right\">\n"
				<< "            <FONT\n"
				<< "             face=\"Arial, Helvetica, sans-serif\" size=\"2\"> Last Login:</FONT>\n"
				<< "          </TD>\n"
				<< "          <TD\n"
				<< "           width=\"335\"\n"
				<< "           height=\"25\"\n"
				<< "           align=\"left\"><B>" << last_login << "</B>\n"
				<< "          </TD>\n"
				<< "        </TR>\n"
				<< endl;
			
			break;
		}
	default:
		cout << "	<!--    Unknown Column Name  " << Vect[index].db_column_name << " -->" 
			<< endl;
		break;
	}
	
}
