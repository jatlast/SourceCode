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

#include "About_Info.h"


About_Info::About_Info(const string & get_info_sql, const string & update_info_sql)
{
	DB_Table_Base::get_info_sql    = get_info_sql;
	DB_Table_Base::update_info_sql = update_info_sql;
	//										db_column_name	, db_column_data,   db_column_actual, web_form_name		, web_form_data, web_form_hidden_data, row_number	, vartype		,	length
	DB_Table_Base::DB_Table_Info column1("user_name"		,	""			,		""			, "User Name"		,	""		   ,			""		,		1		, NTBSTRINGBIND	,	USER_NAME);
	DB_Table_Base::DB_Table_Info column2("screen_quote"		,	""			,		""			, "Screen Quote"	,	""		   ,			""		,		2		, NTBSTRINGBIND	,	SCREEN_QUOTE);
	DB_Table_Base::DB_Table_Info column3("about_yourself"	,	""			,		""			, "About Yourself"	,	""		   ,			""		,		3		, NTBSTRINGBIND	,	ABOUT_YOURSELF);
	DB_Table_Base::DB_Table_Info column4("questionable"		,	""			,		""			, ""				,	""		   ,			""		,		4		, NTBSTRINGBIND	,	QUESTIONABLE);
	
	Vect.push_back(column1);
	Vect.push_back(column2);
	Vect.push_back(column3);
	Vect.push_back(column4);

	DB_Table_Base::DB_Table_Base_Error_Text = "About_Info Constructor";
}


void
About_Info::Print_Current_And_Change( const string & name )
{
	int column_number = Get_RowNumber_From_ColumnName( name );
	
	int index = column_number - 1;
	
	switch (column_number)
	{
	case 1 :
		cout << "	<!--  user_name -->\n"
			
			<< "		<INPUT\n"
			<< "         type=\"hidden\"\n"
			<< "         name=\"db_user_name\"\n"
			<< "         value=\"" << Vect[index].db_column_data << "\">\n"
			<< endl;
		break;
		
	case 2 :
		Print_Current(Vect[index]);
		cout << "	<!--  screen_quote -->\n"
			
			<< "	<tr> \n"
			<< "      <td\n"
			<< "           width=\"182\"\n"
			<< "           height=\"13\"\n"
			<< "           align=\"right\" nowrap> \n"
			<< "        <p\n"
			<< "             align=\"left\"> <font face=\"Arial, Helvetica, sans-serif\" size=\"2\">Screen Quote:</font></p>\n"
			<< "      </td>\n"
			<< "      <td\n"
			<< "           width=\"372\"\n"
			<< "           height=\"13\"\n"
			<< "           align=\"left\"> \n"
			<< "        <input\n"
			<< "               type=\"text\"\n"
			<< "               name=\"screen_quote\"\n"
			<< "               value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"70\">\n"
			<< "      </td>\n"
			<< "    </tr>\n"
			
			<< endl;
		break;

	case 3 :
		Print_Current(Vect[index]);
		
		cout << "	<!--  about_yourself -->\n"
			
			<< "    <tr> \n"
			<< "      <td\n"
			<< "           height=\"29\"\n"
			<< "           align=\"left\" width=\"182\"\n"
			<< "           valign=\"top\" nowrap> \n"
			<< "        <p align=\"left\"></p>\n"
			<< "        <p align=\"left\"><font size=\"2\" face=\"Arial, Helvetica, sans-serif\">Now Tell Us About Yourself:</font></p>\n"
			<< "        <p align=\"left\"></p>\n"
			<< "      </td>\n"
			<< "      <td\n"
			<< "           height=\"29\"\n"
			<< "           align=\"left\" width=\"372\"\n"
			<< "           valign=\"bottom\"> \n"
			<< "        <p><font face=\"Arial, Helvetica, sans-serif\">\n"
			<< "          <textarea\n"
			<< "         rows=\"20\"\n"
			<< "         name=\"about_yourself\"\n"
			<< "         cols=\"60\">"<< Vect[index].db_column_data << "</textarea>\n"
			<< "          </font></p>\n"
			<< "      </td>\n"
			<< "    </tr>\n"
			<< endl;
		
		break;
	case 4 :
		cout << "	<!--  questionable -->\n"
			
			<< "		<INPUT\n"
			<< "         type=\"hidden\"\n"
			<< "         name=\"db_questionable\"\n"
			<< "         value=\"" << Vect[index].db_column_data << "\">\n"
			<< endl;
		break;
	default:
		cout << "	<!--    Unknown Column Name  " << Vect[index].db_column_name << " -->" << endl;
		
		break;
	}
}


