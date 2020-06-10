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

#include "Profile_Info.h"
#include "DB_Table_Base.h"


using std::cout;
using std::endl;

using db_table_base_namespace::DB_Table_Base;

Profile_Info::Profile_Info(const string & get_sql, const string & update_sql)
{
	//										db_column_name	, db_column_data,   db_column_actual, web_form_name		, web_form_data, web_form_hidden_data	, row_number, vartype		, length
	DB_Table_Base::DB_Table_Info column1 ("email"			,	""			,		""			, ""				,	""		   ,			""			,	1		, NTBSTRINGBIND	,	EMAIL);
	DB_Table_Base::DB_Table_Info column2 ("user_name"		,	""			,		""			, ""				,	""		   ,			""			,	2		, NTBSTRINGBIND	,	USER_NAME);
	DB_Table_Base::DB_Table_Info column3 ("age"				,	""			,		""			, "Age:"			,	""		   ,			""			,	3		, NTBSTRINGBIND	,	AGE);
	DB_Table_Base::DB_Table_Info column4 ("sex"				,	""			,		""			, "Gender:"			,	""		   ,			""			,	4		, NTBSTRINGBIND	,	SEX);
	DB_Table_Base::DB_Table_Info column5 ("height"			,	""			,		""			, "Height:"			,	""		   ,			""			,	5		, NTBSTRINGBIND	,	HEIGHT);
	DB_Table_Base::DB_Table_Info column6 ("weight"			,	""			,		""			, "Weight:"			,	""		   ,			""			,	6		, NTBSTRINGBIND	,	WEIGHT);
	DB_Table_Base::DB_Table_Info column7 ("hair"			,	""			,		""			, "Hair Color:"		,	""		   ,			""			,	7		, NTBSTRINGBIND	,	HAIR);
	DB_Table_Base::DB_Table_Info column8 ("eyes"			,	""			,		""			, "Eye Color:"		,	""		   ,			""			,	8		, NTBSTRINGBIND	,	EYES);
	DB_Table_Base::DB_Table_Info column9 ("city"			,	""			,		""			, "City"			,	""		   ,			""			,	9		, NTBSTRINGBIND	,	CITY);
	DB_Table_Base::DB_Table_Info column10("state"			,	""			,		""			, "State"			,	""		   ,			""			,	10		, NTBSTRINGBIND	,	STATE);
	DB_Table_Base::DB_Table_Info column11("country"			,	""			,		""			, "Countyry"		,	""		   ,			""			,	11		, NTBSTRINGBIND	,	COUNTRY);
	DB_Table_Base::DB_Table_Info column12("photo_1"			,	""			,		""			, "Picture"			,	""		   ,			""			,	12		, NTBSTRINGBIND	,	PHOTO_1);
		
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
	
	DB_Table_Base::get_info_sql = get_sql;
	DB_Table_Base::update_info_sql = update_sql;

	DB_Table_Base::DB_Table_Base_Error_Text = "Profile_Info Constructor";

	//cout << "Within Profile_Info(string, string) -------------" << endl;	
}

void
Profile_Info::Print_Current_And_Change( const string & name )
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
	case 9 :
		Print_Current(Vect[index]);
			
		break;
	case 10 :
		Print_Current(Vect[index]);
			
		break;
	case 11 :
		Print_Current(Vect[index]);
			
		break;
	case 12 :
		Print_Current(Vect[index]);
			
		break;
	default:
		cout << "	<!--    Unknown Column Name  " << Vect[index].db_column_name << " -->" 
			<< endl;
		break;
	}
	
}

