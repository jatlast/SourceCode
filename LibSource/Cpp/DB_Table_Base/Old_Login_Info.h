#ifndef LOGIN_INFO
#define LOGIN_INFO


#include <vector>
#include <string>

#include <iostream>

#include "DB_Table_Base.h"

class Login_Info : public db_table_base_namespace::DB_Table_Base
{
public:
	vector<DB_Table_Base::DB_Table_Info> Vect;
	
	
	Login_Info(const string & sql_statement);	
	
	bool
		Get_Info_From_DB();
	
	bool
		Login_Info::Update_Info_In_DB();
	
	void
		Set_Sql(const string & sql_statement);
	
	const string &
		Get_Sql(); 
	
	const string
		Get_FormData_From_ColumnName(const string & name);
	
	const char *
		Get_DBData_From_ColumnName(const string & name);
	
	const int
		Get_RowNumber_From_ColumnName(const string & name);
	
	void
		Print_Current_And_Change( const string & name );
	
private:
	string sql;
};


Login_Info::Login_Info(const string & sql_statement) : sql(sql_statement)
{
	//										db_column_name	, db_column_data, web_form_name			, web_form_data, web_form_hidden_data, row_number	, vartype	, length
	DB_Table_Base::DB_Table_Info column1("user_id"			,	""			, ""					,	""		   ,	""				,		1	, NTBSTRINGBIND	,	16);
	DB_Table_Base::DB_Table_Info column2("user_name"		,	""			, "User Name"			,	""		   ,	""				,		2	, NTBSTRINGBIND	,	32);
	DB_Table_Base::DB_Table_Info column3("membership_type"	,	""			, ""					,	""		   ,	""				,		3	, NTBSTRINGBIND	,	32);
	DB_Table_Base::DB_Table_Info column4("password"			,	""			, "Password"			,	""		   ,	""				,		4	, NTBSTRINGBIND	,	16);
	DB_Table_Base::DB_Table_Info column5("password_hint"	,	""			, "Hint"				,	""		   ,	""				,		5	, NTBSTRINGBIND	,	64);
	DB_Table_Base::DB_Table_Info column6("email"			,	""			, "Mother's Maiden Name",	""		   ,	""				,		6	, NTBSTRINGBIND	,	64);
	DB_Table_Base::DB_Table_Info column7("sex"				,	""			, "Sex"					,	""		   ,	""				,		7	, NTBSTRINGBIND	,	 4);
	DB_Table_Base::DB_Table_Info column8("creation_date"	,	""			, "Creatioin Date"		,	""		   ,	""				,		8	, NTBSTRINGBIND	,	32);
	DB_Table_Base::DB_Table_Info column9("last_login"		,	""			, "Last Login"			,	""		   ,	""				,		9	, NTBSTRINGBIND	,	32);
	
	Vect.push_back(column1);
	Vect.push_back(column2);
	Vect.push_back(column3);
	Vect.push_back(column4);
	Vect.push_back(column5);
	Vect.push_back(column6);
	Vect.push_back(column7);
	Vect.push_back(column8);
	Vect.push_back(column9);
}

bool
Login_Info::Get_Info_From_DB()
{
	return (DB_Table_Base::Get_Info_From_DB(sql, Vect));
}

bool
Login_Info::Update_Info_In_DB()
{
//	return (DB_Table_Base::Update_Info_In_DB(sql));
	return (db_table_base_namespace::Update_Info_In_DB(sql));
}

void
Login_Info::Set_Sql(const string & sql_statement)
{
	sql = sql_statement;
}

const string &
Login_Info::Get_Sql()
{
	return sql;
}

const string
Login_Info::Get_FormData_From_ColumnName(const string & name)
{
	for(int i=0; i<Vect.size(); i++)
	{
		if ( Vect[i].db_column_name == name)
		{
			//cout << "Within Get... \"" << Vect[i].web_form_data << "\"" << endl; 
			return Vect[i].web_form_data;
		}
	}
	return "form_name not found";
}		

const char *
Login_Info::Get_DBData_From_ColumnName(const string & name)
{
	for(int i=0; i<Vect.size(); i++)
	{
		if ( Vect[i].db_column_name == name)
		{
			//cout << "Within Get... \"" << Vect[i].db_column_data << "\"" << endl; 
			return Vect[i].db_column_data;
		}
	}
	return "column_name not found";
}		

const int
Login_Info::Get_RowNumber_From_ColumnName(const string & name)
{
	for(int i=0; i<Vect.size(); i++)
	{
		if ( Vect[i].db_column_name == name)
		{
			//cout << "Within Get... \"" << Vect[i].web_form_data << "\"" << endl; 
			return Vect[i].row_number;
		}
	}
	return -1;
}		

void
Login_Info::Print_Current_And_Change( const string & name )
{
	int column_number = Get_RowNumber_From_ColumnName( name );
	
	int index = column_number - 1;
	
	switch (column_number)
	{
	case 1 :
		cout << "	<!--    user_id  " << Vect[index].db_column_data << " -->" << endl;
		
		cout << "		<INPUT" << endl;
		cout << "         type=\"hidden\"" << endl;
		cout << "         name=\"db_user_id\"" << endl;
		cout << "         value=\"" << Vect[index].db_column_data << "\">" << endl;
		
		cout << "" << endl;
		break;
	case 2 : 
		Print_Current(Vect[index]);
		cout << "	<!--  user_name -->" << endl;
		cout << "        <TR>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"120\"" << endl;
		cout << "           height=\"25\"" << endl;
		cout << "           align=\"right\">" << endl;
		cout << "            <FONT" << endl;
		cout << "             size=\"2\"> *User Name: </FONT>" << endl;
		cout << "          </TD>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"335\"" << endl;
		cout << "           height=\"25\"" << endl;
		cout << "           align=\"left\">" << endl;
		cout << "             <INPUT" << endl;
		cout << "             type=\"text\"" << endl;
		cout << "             name=\"user_name\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\"" << endl;
		cout << "             size=\"20\"> <FONT" << endl;
		cout << "             size=\"2\"" << endl;
		cout << "             color=\"#FF0000\">Others will see this name</FONT>" << endl;
		cout << "          </TD>" << endl;
		cout << "        </TR>" << endl;
		
		cout << "				<INPUT" << endl;
		cout << "             type=\"hidden\"" << endl;
		cout << "             name=\"db_user_name\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\">" << endl;
		
		cout << "" << endl;
		break;
	case 3 :
		cout << "	<!--    membership_type  " << Vect[index].db_column_data << " -->" << endl;
		
		cout << "				<INPUT" << endl;
		cout << "             type=\"hidden\"" << endl;
		cout << "             name=\"db_membership_type\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\">" << endl;
		
		cout << "" << endl;
		break;
	case 4 :
		Print_Current(Vect[index]);
		cout << "        <!--    password  -->" << endl;
		cout << "        <TR>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"120\"" << endl;
		cout << "           height=\"25\"" << endl;
		cout << "           align=\"right\">" << endl;
		cout << "            <P" << endl;
		cout << "             style=\"line-height: 100%\">" << endl;
		cout << "               <FONT" << endl;
		cout << "               size=\"2\">*Password: 4-8 digits:</FONT>" << endl;
		cout << "            </P>" << endl;
		cout << "          </TD>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"335\"" << endl;
		cout << "           height=\"25\"" << endl;
		cout << "           align=\"left\">" << endl;
		cout << "            <P" << endl;
		cout << "             style=\"line-height: 100%\"><INPUT" << endl;
		cout << "               type=\"password\"" << endl;
		cout << "               name=\"password\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\"" << endl;
		cout << "               maxlength=\"8\"><FONT" << endl;
		cout << "               size=\"2\"" << endl;
		cout << "               color=\"#FF0000\"> Store for future use</FONT>" << endl;
		cout << "            </P>" << endl;
		cout << "          </TD>" << endl;
		cout << "        </TR>" << endl;
		cout << "" << endl;
		cout << "        <!--    verify_password   -->" << endl;
		cout << "        <TR>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"120\"" << endl;
		cout << "           height=\"25\"" << endl;
		cout << "           align=\"right\">" << endl;
		cout << "            <P" << endl;
		cout << "             style=\"line-height: 100%\">" << endl;
		cout << "               <FONT" << endl;
		cout << "               size=\"2\">*Verify Password:</FONT>" << endl;
		cout << "            </P>" << endl;
		cout << "          </TD>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"335\"" << endl;
		cout << "           height=\"25\"" << endl;
		cout << "           align=\"left\">" << endl;
		cout << "            <P" << endl;
		cout << "             style=\"line-height: 100%\"><INPUT" << endl;
		cout << "               type=\"password\"" << endl;
		cout << "               name=\"verify_password\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\"" << endl;
		cout << "               size=\"20\"" << endl;
		cout << "               maxlength=\"8\"><FONT" << endl;
		cout << "               size=\"2\"" << endl;
		cout << "               color=\"#FF0000\"> Compare password inputs</FONT>" << endl;
		cout << "            </P>" << endl;
		cout << "          </TD>" << endl;
		cout << "        </TR>" << endl;
		
		cout << "				<INPUT" << endl;
		cout << "             type=\"hidden\"" << endl;
		cout << "             name=\"db_password\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\">" << endl;
		
		cout << "" << endl;
		break;
	case 5 :
		cout << "        <!--    password_hint -->" << endl;
		cout << "        <TR>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"120\"" << endl;
		cout << "           height=\"22\"" << endl;
		cout << "           align=\"right\">" << endl;
		cout << "            <FONT" << endl;
		cout << "             size=\"2\">*Mother's Maiden Name:</FONT>" << endl;
		cout << "          </TD>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"335\"" << endl;
		cout << "           height=\"22\"" << endl;
		cout << "           align=\"left\"><INPUT" << endl;
		cout << "             name=\"password_hint\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\"" << endl;
		cout << "             size=\"20\"> <FONT" << endl;
		cout << "             color=\"#FF0000\"" << endl;
		cout << "             size=\"2\">To get your password</FONT>" << endl;
		cout << "          </TD>" << endl;
		cout << "        </TR>" << endl;
		
		cout << "				<INPUT" << endl;
		cout << "             type=\"hidden\"" << endl;
		cout << "             name=\"db_password_hint\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\">" << endl;
		
		cout << "" << endl;
		break;
	case 6 :
		Print_Current(Vect[index]);
		cout << "        <!--  email -->" << endl;
		cout << "        <TR>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"120\"" << endl;
		cout << "           height=\"37\"" << endl;
		cout << "           align=\"right\">" << endl;
		cout << "            <P" << endl;
		cout << "             style=\"line-height: 100%\">" << endl;
		cout << "               <FONT" << endl;
		cout << "               size=\"2\">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; Email:</FONT>" << endl;
		cout << "            </P>" << endl;
		cout << "          </TD>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"335\"" << endl;
		cout << "           height=\"37\"" << endl;
		cout << "           align=\"left\">" << endl;
		cout << "            <P" << endl;
		cout << "             style=\"line-height: 100%\"><INPUT" << endl;
		cout << "               name=\"email\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\"" << endl;
		cout << "               size=\"20\"> <FONT" << endl;
		cout << "               color=\"#FF0000\"" << endl;
		cout << "               size=\"2\">Will not appear in profile</FONT>" << endl;
		cout << "            </P>" << endl;
		cout << "          </TD>" << endl;
		cout << "        </TR>" << endl;
		
		cout << "				<INPUT" << endl;
		cout << "             type=\"hidden\"" << endl;
		cout << "             name=\"db_email\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\">" << endl;
		
		break;
	case 7 :
		Print_Current(Vect[index]);
		cout << "        <!--    Sex   -->" << endl;
		cout << "        <TR>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"120\"" << endl;
		cout << "           height=\"25\"" << endl;
		cout << "           align=\"right\">" << endl;
		cout << "            <FONT" << endl;
		cout << "             size=\"2\">Sex:</FONT>" << endl;
		cout << "          </TD>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"335\"" << endl;
		cout << "           height=\"25\"" << endl;
		cout << "           align=\"left\"><SELECT" << endl;
		cout << "             size=\"1\"" << endl;
		cout << "             name=\"sex\">" << endl;
		cout << "              <OPTION Selected" << endl;
		cout << "               value=\"-1\">" << endl;
		if(! strcmp(Vect[index].db_column_data, "0") )
			cout << "Male" << endl;
		else
			cout << "Female" << endl;
		cout << "              </OPTION>" << endl;
		cout << "              <OPTION>" << endl;
		cout << "                Please select" << endl;
		cout << "              </OPTION>" << endl;
		cout << "              <OPTION" << endl;
		cout << "               value=\"0\">" << endl;
		cout << "                Male" << endl;
		cout << "              </OPTION>" << endl;
		cout << "              <OPTION" << endl;
		cout << "               value=\"1\">" << endl;
		cout << "                Female" << endl;
		cout << "              </OPTION>" << endl;
		cout << "            </SELECT>" << endl;
		cout << "          </TD>" << endl;
		cout << "        </TR>" << endl;
		
		cout << "				<INPUT" << endl;
		cout << "             type=\"hidden\"" << endl;
		cout << "             name=\"db_sex\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\">" << endl;
		
		
		cout << "" << endl;
		break;
	case 8 :
		cout << "	<!--    creation_date  -->" << endl;
		cout << "        <TR>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"120\"" << endl;
		cout << "           height=\"25\"" << endl;
		cout << "           align=\"right\">" << endl;
		cout << "            <FONT" << endl;
		cout << "             size=\"2\"> Creation Date:</FONT>" << endl;
		cout << "          </TD>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"335\"" << endl;
		cout << "           height=\"25\"" << endl;
		cout << "           align=\"left\"><B>" << Vect[index].db_column_data << "</B>" << endl;
		cout << "          </TD>" << endl;
		cout << "        </TR>" << endl;
		
		cout << "				<INPUT" << endl;
		cout << "             type=\"hidden\"" << endl;
		cout << "             name=\"db_creation_date\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\">" << endl;
		
		cout << "" << endl;
		break;
	case 9 :
		cout << "	<!--    last_login  -->" << endl;
		cout << "        <TR>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"120\"" << endl;
		cout << "           height=\"25\"" << endl;
		cout << "           align=\"right\">" << endl;
		cout << "            <FONT" << endl;
		cout << "             size=\"2\"> Last Login:</FONT>" << endl;
		cout << "          </TD>" << endl;
		cout << "          <TD" << endl;
		cout << "           width=\"335\"" << endl;
		cout << "           height=\"25\"" << endl;
		cout << "           align=\"left\"><B>" << Vect[index].db_column_data << "</B>" << endl;
		cout << "          </TD>" << endl;
		cout << "        </TR>" << endl;
		
		cout << "				<INPUT" << endl;
		cout << "             type=\"hidden\"" << endl;
		cout << "             name=\"db_last_login\"" << endl;
		cout << "             value=\"" << Vect[index].db_column_data << "\">" << endl;
		
		cout << "" << endl;
		break;
	default:
		cout << "	<!--    Unknown Column Name  " << Vect[index].db_column_name << " -->" << endl;
		cout << "" << endl;
		break;
	}
}

#endif LOGIN_INFO
