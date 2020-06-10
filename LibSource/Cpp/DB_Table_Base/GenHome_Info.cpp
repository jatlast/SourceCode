#include "GenHome_Info.h"
#include "DB_Table_Base.h"


using std::cout;
using std::endl;

using db_table_base_namespace::DB_Table_Base;

GenHome_Info::GenHome_Info(const string & get_sql, const string & update_sql)
{
	//										db_column_name	, db_column_data,   db_column_actual, web_form_name		, web_form_data, web_form_hidden_data	, row_number, vartype		, length
	DB_Table_Base::DB_Table_Info column1("user_name"		,	""			,		""			, "User Name"		,	""		   ,			""			,		1	, NTBSTRINGBIND	,	  USER_NAME);
	DB_Table_Base::DB_Table_Info column2("membership_type"	,	""			,		""			, ""				,	""		   ,			""			,		2	, NTBSTRINGBIND	,	  MEMBERSHIP_TYPE);
	DB_Table_Base::DB_Table_Info column3("password"			,	""			,		""			, "Password"		,	""		   ,			""			,		3	, NTBSTRINGBIND	,	  PASSWORD);
	DB_Table_Base::DB_Table_Info column4("sent_to"			,	""			,		""			, "Send To:"		,	""		   ,			""			,		4	, NTBSTRINGBIND	,	  SENT_TO);
	DB_Table_Base::DB_Table_Info column5("sent_from"		,	""			,		""			, "Sent From:"		,	""		   ,			""			,		5	, NTBSTRINGBIND	,	  SENT_FROM);
	DB_Table_Base::DB_Table_Info column6("message_text"		,	""			,		""			, "Message Body:"	,	""		   ,			""			,		6	, NTBSTRINGBIND	,	  MESSAGE_TEXT);
	DB_Table_Base::DB_Table_Info column7("when_sent"		,	""			,		""			, "Time Sent:"		,	""		   ,			""			,		7	, NTBSTRINGBIND	,	  WHEN_SENT);
	DB_Table_Base::DB_Table_Info column8("when_read"		,	""			,		""			, "Time Read"		,	""		   ,			""			,		8	, NTBSTRINGBIND	,	  WHEN_READ);
	DB_Table_Base::DB_Table_Info column9("deleted"			,	""			,		""			, ""				,	""		   ,			""			,		9	, NTBSTRINGBIND	,	  SENDER_DELETED);
		
	DB_Table_Base::Vect.push_back(column1);
	DB_Table_Base::Vect.push_back(column2);
	DB_Table_Base::Vect.push_back(column3);
	DB_Table_Base::Vect.push_back(column4);
	DB_Table_Base::Vect.push_back(column5);
	DB_Table_Base::Vect.push_back(column6);
	DB_Table_Base::Vect.push_back(column7);
	DB_Table_Base::Vect.push_back(column8);
	DB_Table_Base::Vect.push_back(column9);
	
	DB_Table_Base::get_info_sql = get_sql;
	DB_Table_Base::update_info_sql = update_sql;

	//cout << "Within GenHome_Info(string, string) -------------" << endl;	
}


void
GenHome_Info::Print_Current_And_Change( const string & name )
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
			<< "             size=\"2\"> *User Name: </FONT>\n"
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
			<< "               size=\"2\">*Password: 4-8 digits:</FONT>\n"
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
			<< "               size=\"2\">*Verify Password:</FONT>\n"
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
			<< "             size=\"2\">*Mother's Maiden Name:</FONT>\n"
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
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"120\"\n"
			<< "           height=\"37\"\n"
			<< "           align=\"right\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\">\n"
			<< "               <FONT\n"
			<< "               size=\"2\">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; Email:</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"335\"\n"
			<< "           height=\"37\"\n"
			<< "           align=\"left\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\"><INPUT\n"
			<< "               name=\"email\"\n"
			<< "             value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"20\"> <FONT\n"
			<< "               color=\"#FF0000\"\n"
			<< "               size=\"2\">Will not appear in profile</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "        </TR>\n"
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
			<< "             size=\"2\">Sex:</FONT>\n"
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
		cout << "	<!--    creation_date  -->\n"
			
			<< "		<INPUT\n"
			<< "         type=\"hidden\"\n"
			<< "         name=\"db_creation_date\"\n"
			<< "         value=\"" << Vect[index].db_column_data << "\">\n"

			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"120\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             size=\"2\"> Creation Date:</FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"335\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"left\"><B>" << Vect[index].db_column_data << "</B>\n"
			<< "          </TD>\n"
			<< "        </TR>\n"
			<< endl;
			
		break;
	case 9 :
		cout << "	<!--    last_login  -->\n"

			<< "		<INPUT\n"
			<< "         type=\"hidden\"\n"
			<< "         name=\"db_last_login\"\n"
			<< "         value=\"" << Vect[index].db_column_data << "\">\n"

			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"120\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             size=\"2\"> Last Login:</FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"335\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"left\"><B>" << Vect[index].db_column_data << "</B>\n"
			<< "          </TD>\n"
			<< "        </TR>\n"
			<< endl;
			
		break;
	default:
		cout << "	<!--    Unknown Column Name  " << Vect[index].db_column_name << " -->" 
			<< endl;
		break;
	}
	
}

