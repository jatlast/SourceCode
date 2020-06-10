#include "Mail_Info.h"
#include "DB_Table_Base.h"


using std::cout;
using std::endl;

using db_table_base_namespace::DB_Table_Base;

Mail_Info::Mail_Info(const string & get_sql, const string & update_sql)
{
	//										db_column_name	, db_column_data,   db_column_actual, web_form_name		, web_form_data, web_form_hidden_data	, row_number, vartype		, length
	DB_Table_Base::DB_Table_Info column1("mail_id"			,	""			,		""			, ""				,	""		   ,			""			,		1	, NTBSTRINGBIND	,	  16);
	DB_Table_Base::DB_Table_Info column2("sent_to"			,	""			,		""			, "Send To:"		,	""		   ,			""			,		2	, NTBSTRINGBIND	,	  32);
	DB_Table_Base::DB_Table_Info column3("sent_from"		,	""			,		""			, "Sent From:"		,	""		   ,			""			,		3	, NTBSTRINGBIND	,	  32);
	DB_Table_Base::DB_Table_Info column4("subject"			,	""			,		""			, "Subject:"		,	""		   ,			""			,		4	, NTBSTRINGBIND	,	  64);
	DB_Table_Base::DB_Table_Info column5("message_text"		,	""			,		""			, "Message Body:"	,	""		   ,			""			,		5	, NTBSTRINGBIND	,	2048);
	DB_Table_Base::DB_Table_Info column6("when_sent"		,	""			,		""			, "Time Sent:"		,	""		   ,			""			,		6	, NTBSTRINGBIND	,	  32);
	DB_Table_Base::DB_Table_Info column7("when_read"		,	""			,		""			, "Time Read"		,	""		   ,			""			,		7	, NTBSTRINGBIND	,	  32);
	DB_Table_Base::DB_Table_Info column8("sender_deleted"	,	""			,		""			, ""				,	""		   ,			""			,		8	, NTBSTRINGBIND	,	   4);
	DB_Table_Base::DB_Table_Info column9("receiver_deleted"	,	""			,		""			, ""				,	""		   ,			""			,		9	, NTBSTRINGBIND	,	   4);
		
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

	//cout << "Within Mail_Info(string, string) -------------" << endl;	
}

void
Mail_Info::Print_Current_And_Change( const string & name )
{
	int column_number = Get_RowNumber_From_ColumnName( name );
	
	int index = column_number - 1;
	
	switch (column_number)
	{
	case 1 :
		Print_Current(Vect[index]);

		break;
	case 2 : 
		Print_Current(Vect[index]);
					
		break;
	case 3 :
		Print_Current(Vect[index]);
			
		break;
	case 4 :
		Print_Current(Vect[index]);
		break;
	case 5 :
		Print_Current(Vect[index]);
		break;
	case 6 :
		Print_Current(Vect[index]);
			
		break;
	case 7 :
		Print_Current(Vect[index]);
			
		break;
	case 8 :
		Print_Current(Vect[index]);
			
		break;
	default:
		cout << "	<!--    Unknown Column Name  " << Vect[index].db_column_name << " -->" 
			<< endl;
		break;
	}
	
}

