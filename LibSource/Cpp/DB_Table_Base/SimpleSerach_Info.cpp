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

#include "SimpleSearch_Info.h"

using std::cout;
using std::endl;
using std::flush;

SimpleSearch_Info::SimpleSearch_Info(const string & get_info_sql, const string & update_info_sql)
{
	DB_Table_Base::get_info_sql    = get_info_sql;
	DB_Table_Base::update_info_sql = update_info_sql;
	
	//										db_column_name	, db_column_data,   db_column_actual, web_form_name		, web_form_data, web_form_hidden_data, row_number	, vartype		, length
	DB_Table_Base::DB_Table_Info column1 ("picture_only"	,	""			,		""			, "Search"			,	""		   ,			""		,		1 		, NTBSTRINGBIND	,	  1);
	DB_Table_Base::DB_Table_Info column2 ("i_am"			,	""			,		""			, "I Am"			,	""		   ,			""		,		2		, NTBSTRINGBIND	,	  1);
	DB_Table_Base::DB_Table_Info column3 ("seeking"			,	""			,		""			, "Seeking"			,	""		   ,			""		,		3		, NTBSTRINGBIND	,	  1);
	DB_Table_Base::DB_Table_Info column4 ("city"			,	""			,		""			, "City"			,	""		   ,			""		,		4		, NTBSTRINGBIND	,	 CITY);
	DB_Table_Base::DB_Table_Info column5 ("state"			,	""			,		""			, "State"			,	""		   ,			""		,		5		, NTBSTRINGBIND	,	  STATE);
	DB_Table_Base::DB_Table_Info column6 ("country"			,	""			,		""			, "Country"			,	""		   ,			""		,		6		, NTBSTRINGBIND	,	  COUNTRY);
	DB_Table_Base::DB_Table_Info column7 ("min_age_desired"	,	""			,		""			, "Min Age Desired"	,	""		   ,			""		,		7		, NTBSTRINGBIND	,	  MIN_AGE_DESIRED);
	DB_Table_Base::DB_Table_Info column8 ("max_age_desired"	,	""			,		""			, "Max Age Desired"	,	""		   ,			""		,		8		, NTBSTRINGBIND	,	  MAX_AGE_DESIRED);
	DB_Table_Base::DB_Table_Info column9 ("search_limit"	,	""			,		""			, "Limit"			,	""		   ,			""		,		9		, NTBSTRINGBIND	,	  2);
	DB_Table_Base::DB_Table_Info column10("sort_order"		,	""			,		""			, "Sort"			,	""		   ,			""		,		10		, NTBSTRINGBIND	,	  1);
	DB_Table_Base::DB_Table_Info column11("index"			,	""			,		""			, "Index"			,	""		   ,			""		,		11		, NTBSTRINGBIND	,	  4);
	
	Vect.push_back(column1);
	Vect.push_back(column2);
	Vect.push_back(column3);
	Vect.push_back(column4);
	Vect.push_back(column5);
	Vect.push_back(column6);
	Vect.push_back(column7);
	Vect.push_back(column8);
	Vect.push_back(column9);
	Vect.push_back(column10);
	Vect.push_back(column11);

	DB_Table_Base::DB_Table_Base_Error_Text = "SimpleSearch_Info Constructor";	
}

void
SimpleSearch_Info::Print_Current_And_Change( const string & name )
{
	/*
	int column_number = Get_RowNumber_From_ColumnName( name );
	
	int index = column_number - 1;
	
	switch (column_number)
	{
	case 1 :
		Print_Current(Vect[index]);
		
		cout << "	<!--  user_name -->\n"
			
			<< "		<INPUT\n"
			<< "         type=\"hidden\"\n"
			<< "         name=\"db_user_name\"\n"
			<< "         value=\"" << Vect[index].db_column_actual << "\">\n"
			<< endl << flush;
		
		break;
		
	case 2 :
		Print_Current(Vect[index]);
		cout << "	<!--  first_name -->\n"
			
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"113\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"right\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\">\n"
			<< "              <FONT\n"
			<< "               size=\"2\">&#160;&#160;&#160;&#160; *First name:</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"329\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"left\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\">\n"
			<< "		<INPUT\n"
			<< "               type=\"text\"\n"
			<< "               name=\"first_name\"\n"
			<< "               value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"20\">"
			<< "				<FONT\n"
			<< "               color=\"#FF0000\"\n"
			<< "               size=\"2\">Will not appear in profile</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "        </TR>" 
			<< endl << flush;
		break;
	case 3 :
		Print_Current(Vect[index]);
		
		cout << "	<!--  last_name -->\n"
			
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"113\"\n"
			<< "           height=\"21\"\n"
			<< "           align=\"right\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\">\n"
			<< "              <FONT\n"
			<< "               size=\"2\">&#160;&#160;&#160;&#160;&#160;&#160; Last name:</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"329\"\n"
			<< "           height=\"21\"\n"
			<< "           align=\"left\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\">\n"
			<< "               <INPUT\n"
			<< "               type=\"text\"\n"
			<< "               name=\"last_name\"\n"
			<< "               value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"20\">"
			<< "				<FONT\n"
			<< "               color=\"#FF0000\"\n"
			<< "               size=\"2\">Will not appear in profile</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "        </TR>" << endl << flush;
		break;
	case 4 :
		Print_Current(Vect[index]);
		
		cout << "	<!--  street_address -->\n"
			
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"113\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             size=\"2\">Street Address</FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"329\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"left\">\n"
			<< "            <INPUT\n"
			<< "             type=\"text\"\n"
			<< "             name=\"street_address\"\n"
			<< "               value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"20\">"
			<< "				<FONT\n"
			<< "             color=\"#FF0000\"\n"
			<< "             size=\"2\">Will not appear in profile</FONT>\n"
			<< "          </TD>\n"
			<< "        </TR>" << endl << flush;
		break;
	case 5 :
		Print_Current(Vect[index]);
		cout << "	<!--  city -->\n"
			
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"113\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             size=\"2\">*City</FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"329\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"left\">\n"
			<< "		<INPUT\n"
			<< "             type=\"text\"\n"
			<< "             name=\"city\"\n"
			<< "             value=\"" << Vect[index].db_column_data << "\"\n"
			<< "             size=\"20\">\n"
			<< "          </TD>\n"
			<< "        </TR>" << endl << flush;
		break;
	case 6 :
		Print_Current(Vect[index]);
		cout << "<!--  state -->\n"
			
			<< "<TR>\n"
			<< "<TD width=\"113\" height=\"22\" align=\"right\"><FONT size=\"2\">*State&nbsp;</FONT></TD>\n"
			<< "<TD width=\"329\" height=\"22\" align=\"left\"><SELECT name=\"state\" size=\"1\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Please Choose a State</OPTION>\n"
			<< "<OPTION value=\"1\">Alabama</OPTION>\n"
			<< "<OPTION value=\"2\">Alaska</OPTION>\n"
			<< "<OPTION value=\"3\">Arizona</OPTION>\n"
			<< "<OPTION value=\"4\">Arkansas</OPTION>\n"
			<< "<OPTION value=\"5\">California - Bay Area</OPTION>\n"
			<< "<OPTION value=\"6\">California - L.A. Area</OPTION>\n"
			<< "<OPTION value=\"7\">California - San Diego</OPTION>\n"
			<< "<OPTION value=\"8\">California - All other areas</OPTION>\n"
			<< "<OPTION value=\"9\">Colorado</OPTION>\n"
			<< "<OPTION value=\"10\">Connecticut</OPTION>\n"
			<< "<OPTION value=\"11\">Delaware</OPTION>\n"
			<< "<OPTION value=\"12\">District of Columbia</OPTION>\n"
			<< "<OPTION value=\"13\">Florida</OPTION>\n"
			<< "<OPTION value=\"14\">Georgia</OPTION>\n"
			<< "<OPTION value=\"16\">Hawaii</OPTION>\n"
			<< "<OPTION value=\"17\">Idaho</OPTION>\n"
			<< "<OPTION value=\"18\">Illinois</OPTION>\n"
			<< "<OPTION value=\"19\">Indiana</OPTION>\n"
			<< "<OPTION value=\"20\">Iowa</OPTION>\n"
			<< "<OPTION value=\"21\">Kansas</OPTION>\n"
			<< "<OPTION value=\"22\">Kentucky</OPTION>\n"
			<< "<OPTION value=\"23\">Louisiana</OPTION>\n"
			<< "<OPTION value=\"24\">Maine</OPTION>\n"
			<< "<OPTION value=\"25\">Maryland</OPTION>\n"
			<< "<OPTION value=\"26\">Massachusetts</OPTION>\n"
			<< "<OPTION value=\"27\">Michigan</OPTION>\n"
			<< "<OPTION value=\"28\">Minnesota</OPTION>\n"
			<< "<OPTION value=\"29\">Mississippi</OPTION>\n"
			<< "<OPTION value=\"30\">Missouri</OPTION>\n"
			<< "<OPTION value=\"31\">Montana</OPTION>\n"
			<< "<OPTION value=\"32\">Nebraska</OPTION>\n"
			<< "<OPTION value=\"33\">Nevada</OPTION>\n"
			<< "<OPTION value=\"34\">New Hampshire</OPTION>\n"
			<< "<OPTION value=\"35\">New Jersey</OPTION>\n"
			<< "<OPTION value=\"36\">New Mexico</OPTION>\n"
			<< "<OPTION value=\"37\">New York</OPTION>\n"
			<< "<OPTION value=\"38\">New Yok City</OPTION>\n"
			<< "<OPTION value=\"39\">North Carolina</OPTION>\n"
			<< "<OPTION value=\"40\">North Dakota</OPTION>\n"
			<< "<OPTION value=\"41\">Ohio</OPTION>\n"
			<< "<OPTION value=\"42\">Oklahoma</OPTION>\n"
			<< "<OPTION value=\"43\">Oregon</OPTION>\n"
			<< "<OPTION value=\"44\">Pennsylvania</OPTION>\n"
			<< "<OPTION value=\"45\">Puerto Rico</OPTION>\n"
			<< "<OPTION value=\"46\">Rhode Island</OPTION>\n"
			<< "<OPTION value=\"47\">South Carolina</OPTION>\n"
			<< "<OPTION value=\"48\">South Dakota</OPTION>\n"
			<< "<OPTION value=\"49\">Tennessee</OPTION>\n"
			<< "<OPTION value=\"50\">Texas - Austin</OPTION>\n"
			<< "<OPTION value=\"51\">Texas - Dallas</OPTION>\n"
			<< "<OPTION value=\"52\">Texas - Houston</OPTION>\n"
			<< "<OPTION value=\"53\">Texas - All other cities</OPTION>\n"
			<< "<OPTION value=\"54\">Utah</OPTION>\n"
			<< "<OPTION value=\"55\">Vermont</OPTION>\n"
			<< "<OPTION value=\"56\">Virginia</OPTION>\n"
			<< "<OPTION value=\"57\">Washington</OPTION>\n"
			<< "<OPTION value=\"58\">West Virginia</OPTION>\n"
			<< "<OPTION value=\"59\">Wisconsin</OPTION>\n"
			<< "<OPTION value=\"60\">Wyoming</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
		break;
	case 7 :
		Print_Current(Vect[index]);
		cout << "<!--  country -->\n"
			
			<< "<TR>\n"
			<< "<TD width=\"113\" height=\"22\" align=\"right\"><FONT size=\"2\">*Country</FONT></TD>\n"
			<< "<TD width=\"329\" height=\"22\" align=\"left\"><SELECT name=\"country\" size=\"1\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">USA</OPTION>\n"
			<< "<OPTION value=\"2\">Africa</OPTION>\n"
			<< "<OPTION value=\"3\">Asia and Pacific - Australia</OPTION>\n"
			<< "<OPTION value=\"4\">Asia and Pacific - India</OPTION>\n"
			<< "<OPTION value=\"5\">Asia and Pacific - Japan</OPTION>\n"
			<< "<OPTION value=\"6\">Asia and Pacific - New Zealand</OPTION>\n"
			<< "<OPTION value=\"7\">Asia and Pacific - Other</OPTION>\n"
			<< "<OPTION value=\"8\">Canada - Alberta</OPTION>\n"
			<< "<OPTION value=\"9\">Canada - British Columbia</OPTION>\n"
			<< "<OPTION value=\"10\">Canada - Manitoba</OPTION>\n"
			<< "<OPTION value=\"11\">Canada - New Brunswick</OPTION>\n"
			<< "<OPTION value=\"12\">Canada - Newfoundland</OPTION>\n"
			<< "<OPTION value=\"13\">Canada - Northwest Territories</OPTION>\n"
			<< "<OPTION value=\"14\">Canada - Nova Scotia</OPTION>\n"
			<< "<OPTION value=\"15\">Canada - Ontario</OPTION>\n"
			<< "<OPTION value=\"16\">Canada - Prince Edward Island</OPTION>\n"
			<< "<OPTION value=\"17\">Canada - Quebec</OPTION>\n"
			<< "<OPTION value=\"18\">Canada - Saskatchewan</OPTION>\n"
			<< "<OPTION value=\"19\">Canada - Yukon</OPTION>\n"
			<< "<OPTION value=\"20\">Europe - Eastern Europe</OPTION>\n"
			<< "<OPTION value=\"21\">Europe - France</OPTION>\n"
			<< "<OPTION value=\"22\">Europe - Germany</OPTION>\n"
			<< "<OPTION value=\"23\">Europe - Ireland</OPTION>\n"
			<< "<OPTION value=\"24\">Europe - Italy</OPTION>\n"
			<< "<OPTION value=\"25\">Europe - Netherlands</OPTION>\n"
			<< "<OPTION value=\"26\">Europe - Scandinavia</OPTION>\n"
			<< "<OPTION value=\"27\">Europe - Other</OPTION>\n"
			<< "<OPTION value=\"28\">Guam</OPTION>\n"
			<< "<OPTION value=\"29\">UK - Channel Islands</OPTION>\n"
			<< "<OPTION value=\"30\">UK - England - London</OPTION>\n"
			<< "<OPTION value=\"31\">UK - England - Mid</OPTION>\n"
			<< "<OPTION value=\"32\">UK - England - North</OPTION>\n"
			<< "<OPTION value=\"33\">UK - England - Southeast</OPTION>\n"
			<< "<OPTION value=\"34\">UK - England - Southwest</OPTION>\n"
			<< "<OPTION value=\"35\">UK - Isle of Man</OPTION>\n"
			<< "<OPTION value=\"36\">UK - Northern Ireland</OPTION>\n"
			<< "<OPTION value=\"37\">UK - Scotland</OPTION>\n"
			<< "<OPTION value=\"38\">UK - Wales</OPTION>\n"
			<< "<OPTION value=\"39\">Latin America</OPTION>\n"
			<< "<OPTION value=\"40\">Middle East</OPTION>\n"
			<< "<OPTION value=\"41\">Puerto Rico</OPTION>\n"
			<< "<OPTION value=\"42\">Other Area</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
			break;
	case 8 :
		Print_Current(Vect[index]);
		cout << "	<!--  zip -->\n"
			
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"113\"\n"
			<< "           height=\"22\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             size=\"2\">*Zip/Postal Code</FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"329\"\n"
			<< "           height=\"22\"\n"
			<< "           align=\"left\">\n"
			<< "            <INPUT\n"
			<< "             type=\"text\"\n"
			<< "             name=\"zip\"\n"
			<< "               value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"20\">"
			<< "				<FONT\n"
			<< "             color=\"#FF0000\"\n"
			<< "             size=\"2\">Will not appear in profile</FONT>\n"
			<< "          </TD>\n"
			<< "        </TR>" << endl << flush;
		break;
	case 9 :
		Print_Current(Vect[index]);
		cout << "	<!--  city -->\n"
			
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"113\"\n"
			<< "           height=\"22\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             size=\"2\">Telephone</FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"329\"\n"
			<< "           height=\"22\"\n"
			<< "           align=\"left\">\n"
			<< "            <INPUT\n"
			<< "             type=\"text\"\n"
			<< "             name=\"telephone\"\n"
			<< "               value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"20\">"
			<< "				<FONT\n"
			<< "             color=\"#FF0000\"\n"
			<< "             size=\"2\">Will not appear in profile</FONT>\n"
			<< "          </TD>\n"
			<< "        </TR>" << endl << flush;
		
		break;
	default:
		cout << "	<!--    Unknown Column Name  " << Vect[index].db_column_name << " -->" << endl << flush;
		
		break;
	}
	*/
}









