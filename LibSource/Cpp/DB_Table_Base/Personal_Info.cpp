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

#include "Personal_Info.h"

using std::cout;
using std::endl;
using std::flush;

Personal_Info::Personal_Info(const string & get_info_sql, const string & update_info_sql)
{
	DB_Table_Base::get_info_sql    = get_info_sql;
	DB_Table_Base::update_info_sql = update_info_sql;
	//										db_column_name		, db_column_data,   db_column_actual, web_form_name			, web_form_data, web_form_hidden_data		, row_number	, vartype		,	length
	DB_Table_Base::DB_Table_Info column1 ("user_name"			,	""			,		""			, "User Name"			,	""		   ,			""				,		1 		, NTBSTRINGBIND	,	USER_NAME);
	DB_Table_Base::DB_Table_Info column2 ("sex_preference"		,	""			,		""			, "Sexual Preference"	,	""		   ,			""				,		2 		, NTBSTRINGBIND	,	SEX_PREFERENCE);
	DB_Table_Base::DB_Table_Info column3 ("age"					,	""			,		""			, "Age"					,	""		   ,			""				,		3 		, NTBSTRINGBIND	,	AGE);
	DB_Table_Base::DB_Table_Info column4 ("marital_status"		,	""			,		""			, "Marital Status"		,	""		   ,			""				,		4 		, NTBSTRINGBIND	,	MARITAL_STATUS);
	DB_Table_Base::DB_Table_Info column5 ("profession"			,	""			,		""			, "Profession"			,	""		   ,			""				,		5 		, NTBSTRINGBIND	,	PROFESSION);
	DB_Table_Base::DB_Table_Info column6 ("income"				,	""			,		""			, "Income"				,	""		   ,			""				,		6 		, NTBSTRINGBIND	,	INCOME);
	DB_Table_Base::DB_Table_Info column7 ("education"			,	""			,		""			, "Educatioin"			,	""		   ,			""				,		7  		, NTBSTRINGBIND	,	EDUCATION);
	DB_Table_Base::DB_Table_Info column8 ("religion"			,	""			,		""			, "Religion"			,	""		   ,			""				,		8 		, NTBSTRINGBIND	,	RELIGION);
	DB_Table_Base::DB_Table_Info column9 ("height"				,	""			,		""			, "Height"				,	""		   ,			""				,		9 		, NTBSTRINGBIND	,	HEIGHT);
	DB_Table_Base::DB_Table_Info column10("weight"				,	""			,		""			, "Weight"				,	""		   ,			""				,		10		, NTBSTRINGBIND	,	WEIGHT);
	DB_Table_Base::DB_Table_Info column11("eyes"				,	""			,		""			, "Eyes"				,	""		   ,			""				,		11		, NTBSTRINGBIND	,	EYES);
	DB_Table_Base::DB_Table_Info column12("hair"				,	""			,		""			, "Hair"				,	""		   ,			""				,		12		, NTBSTRINGBIND	,	HAIR);
	DB_Table_Base::DB_Table_Info column13("min_age_desired"		,	""			,		""			, "Min Age Desired"		,	""		   ,			""				,		13		, NTBSTRINGBIND	,	MIN_AGE_DESIRED);
	DB_Table_Base::DB_Table_Info column14("max_age_desired"		,	""			,		""			, "Max Age Desired"		,	""		   ,			""				,		14		, NTBSTRINGBIND	,	MAX_AGE_DESIRED);
	DB_Table_Base::DB_Table_Info column15("cook"				,	""			,		""			, "Cook"				,	""		   ,			""				,		15		, NTBSTRINGBIND	,	COOK);
	DB_Table_Base::DB_Table_Info column16("smoke"				,	""			,		""			, "Smoke"				,	""		   ,			""				,		16		, NTBSTRINGBIND	,	SMOKE);
	DB_Table_Base::DB_Table_Info column17("drink"				,	""			,		""			, "Drink"				,	""		   ,			""				,		17		, NTBSTRINGBIND	,	DRINK);
	DB_Table_Base::DB_Table_Info column18("party"				,	""			,		""			, "Party"				,	""		   ,			""				,		18		, NTBSTRINGBIND	,	PARTY);
	DB_Table_Base::DB_Table_Info column19("political"			,	""			,		""			, "Political"			,	""		   ,			""				,		19		, NTBSTRINGBIND	,	POLITICAL);
	DB_Table_Base::DB_Table_Info column20("housing_status"		,	""			,		""			, "Housing"				,	""		   ,			""				,		20		, NTBSTRINGBIND	,	HOUSING_STATUS);
	DB_Table_Base::DB_Table_Info column21("prefer_not_to_say"	,	""			,		""			, "Prefer not to say"	,	"0"		   ,			"relationship"	,		21		, NTBSTRINGBIND	,	PREFER_NOT_TO_SAY);
	DB_Table_Base::DB_Table_Info column22("any_relationship"	,	""			,		""			, "Any Relationship"	,	"0"		   ,			"relationship"	,		22		, NTBSTRINGBIND	,	ANY_RELATIONSHIP);
	DB_Table_Base::DB_Table_Info column23("hang_out"			,	""			,		""			, "Hang Out"			,	"0"		   ,			"relationship"	,		23		, NTBSTRINGBIND	,	HANG_OUT);
	DB_Table_Base::DB_Table_Info column24("short_term"			,	""			,		""			, "Short Term"			,	"0"		   ,			"relationship"	,		24		, NTBSTRINGBIND	,	SHORT_TERM);
	DB_Table_Base::DB_Table_Info column25("long_term"			,	""			,		""			, "Long Term"			,	"0"		   ,			"relationship"	,		25		, NTBSTRINGBIND	,	LONG_TERM);
	DB_Table_Base::DB_Table_Info column26("talk_email"			,	""			,		""			, "Talk / Email"		,	"0"		   ,			"relationship"	,		26		, NTBSTRINGBIND	,	TALK_EMAIL);
	DB_Table_Base::DB_Table_Info column27("photo_exchange"		,	""			,		""			, "Photo Exchange"		,	"0"		   ,			"relationship"	,		27		, NTBSTRINGBIND	,	PHOTO_EXCHANGE);
	DB_Table_Base::DB_Table_Info column28("marriage"			,	""			,		""			, "Marriage"			,	"0"		   ,			"relationship"	,		28		, NTBSTRINGBIND	,	MARRIAGE);
	DB_Table_Base::DB_Table_Info column29("other"				,	""			,		""			, "Other"				,	"0"		   ,			"relationship"	,		29		, NTBSTRINGBIND	,	OTHER);
	
	
	Vect.push_back(column1 );
	Vect.push_back(column2 );
	Vect.push_back(column3 );
	Vect.push_back(column4 );
	Vect.push_back(column5 );
	Vect.push_back(column6 );
	Vect.push_back(column7 );
	Vect.push_back(column8 );
	Vect.push_back(column9 );
	Vect.push_back(column10);
	Vect.push_back(column11);
	Vect.push_back(column12);
	Vect.push_back(column13);
	Vect.push_back(column14);
	Vect.push_back(column15);
	Vect.push_back(column16);
	Vect.push_back(column17);
	Vect.push_back(column18);
	Vect.push_back(column19);
	Vect.push_back(column20);
	Vect.push_back(column21);
	Vect.push_back(column22);
	Vect.push_back(column23);
	Vect.push_back(column24);
	Vect.push_back(column25);
	Vect.push_back(column26);
	Vect.push_back(column27);
	Vect.push_back(column28);
	Vect.push_back(column29);

	DB_Table_Base::DB_Table_Base_Error_Text = "Personal_Info Constructor";	
}
void
Personal_Info::Print_Current_And_Change( const string & name )
{
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
		
		cout << "<!-- sex_preference -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\">\n"
			<< "<P style=\"line-height: 100%\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">&nbsp;&nbsp; Sexual Preference:</FONT></P>\n"
			<< "</TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\">\n"
			<< "<P style=\"line-height: 100%\"> <SELECT size=\"1\" name=\"sex_preference\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"1\">Straight</OPTION>\n"
			<< "<OPTION value=\"2\">Bi-Curious</OPTION>\n"
			<< "<OPTION value=\"3\">Bi</OPTION>\n"
			<< "<OPTION value=\"4\">Gay/Lesbian</OPTION>\n"
			<< "</SELECT></P>\n"
			<< "</TD>\n"
			<< "</TR>\n"
			<< endl << flush;		
		break;
	case 3 :
		Print_Current(Vect[index]);
		cout << "<!--  age -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\">\n"
			<< "<P style=\"line-height: 100%\"> <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT color=\"Red\"><STRONG>*</STRONG></FONT>Your Age:</FONT></P>\n"
			<< "</TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\">\n"
			<< "<SELECT size=\"1\" name=\"age\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"18\">18</OPTION>\n"
			<< "<OPTION value=\"19\">19</OPTION>\n"
			<< "<OPTION value=\"20\">20</OPTION>\n"
			<< "<OPTION value=\"21\">21</OPTION>\n"
			<< "<OPTION value=\"22\">22</OPTION>\n"
			<< "<OPTION value=\"23\">23</OPTION>\n"
			<< "<OPTION value=\"24\">24</OPTION>\n"
			<< "<OPTION value=\"25\">25</OPTION>\n"
			<< "<OPTION value=\"26\">26</OPTION>\n"
			<< "<OPTION value=\"27\">27</OPTION>\n"
			<< "<OPTION value=\"28\">28</OPTION>\n"
			<< "<OPTION value=\"29\">29</OPTION>\n"
			<< "<OPTION value=\"30\">30</OPTION>\n"
			<< "<OPTION value=\"31\">31</OPTION>\n"
			<< "<OPTION value=\"32\">32</OPTION>\n"
			<< "<OPTION value=\"33\">33</OPTION>\n"
			<< "<OPTION value=\"34\">34</OPTION>\n"
			<< "<OPTION value=\"35\">35</OPTION>\n"
			<< "<OPTION value=\"36\">36</OPTION>\n"
			<< "<OPTION value=\"37\">37</OPTION>\n"
			<< "<OPTION value=\"38\">38</OPTION>\n"
			<< "<OPTION value=\"39\">39</OPTION>\n"
			<< "<OPTION value=\"40\">40</OPTION>\n"
			<< "<OPTION value=\"41\">41</OPTION>\n"
			<< "<OPTION value=\"42\">42</OPTION>\n"
			<< "<OPTION value=\"43\">43</OPTION>\n"
			<< "<OPTION value=\"44\">44</OPTION>\n"
			<< "<OPTION value=\"45\">45</OPTION>\n"
			<< "<OPTION value=\"46\">46</OPTION>\n"
			<< "<OPTION value=\"47\">47</OPTION>\n"
			<< "<OPTION value=\"48\">48</OPTION>\n"
			<< "<OPTION value=\"49\">49</OPTION>\n"
			<< "<OPTION value=\"50\">50</OPTION>\n"
			<< "<OPTION value=\"51\">51</OPTION>\n"
			<< "<OPTION value=\"52\">52</OPTION>\n"
			<< "<OPTION value=\"53\">53</OPTION>\n"
			<< "<OPTION value=\"54\">54</OPTION>\n"
			<< "<OPTION value=\"55\">55</OPTION>\n"
			<< "<OPTION value=\"56\">56</OPTION>\n"
			<< "<OPTION value=\"57\">57</OPTION>\n"
			<< "<OPTION value=\"58\">58</OPTION>\n"
			<< "<OPTION value=\"59\">59</OPTION>\n"
			<< "<OPTION value=\"60\">60</OPTION>\n"
			<< "<OPTION value=\"61\">61</OPTION>\n"
			<< "<OPTION value=\"62\">62</OPTION>\n"
			<< "<OPTION value=\"63\">63</OPTION>\n"
			<< "<OPTION value=\"64\">64</OPTION>\n"
			<< "<OPTION value=\"65\">65</OPTION>\n"
			<< "<OPTION value=\"66\">66</OPTION>\n"
			<< "<OPTION value=\"67\">67</OPTION>\n"
			<< "<OPTION value=\"68\">68</OPTION>\n"
			<< "<OPTION value=\"69\">69</OPTION>\n"
			<< "<OPTION value=\"70\">70</OPTION>\n"
			<< "<OPTION value=\"71\">71</OPTION>\n"
			<< "<OPTION value=\"72\">72</OPTION>\n"
			<< "<OPTION value=\"73\">73</OPTION>\n"
			<< "<OPTION value=\"74\">74</OPTION>\n"
			<< "<OPTION value=\"75\">75</OPTION>\n"
			<< "<OPTION value=\"76\">76</OPTION>\n"
			<< "<OPTION value=\"77\">77</OPTION>\n"
			<< "<OPTION value=\"78\">78</OPTION>\n"
			<< "<OPTION value=\"79\">79</OPTION>\n"
			<< "<OPTION value=\"80\">80</OPTION>\n"
			<< "<OPTION value=\"81\">81</OPTION>\n"
			<< "<OPTION value=\"82\">82</OPTION>\n"
			<< "<OPTION value=\"83\">83</OPTION>\n"
			<< "<OPTION value=\"84\">84</OPTION>\n"
			<< "<OPTION value=\"85\">85</OPTION>\n"
			<< "<OPTION value=\"86\">86</OPTION>\n"
			<< "<OPTION value=\"87\">87</OPTION>\n"
			<< "<OPTION value=\"88\">88</OPTION>\n"
			<< "<OPTION value=\"89\">89</OPTION>\n"
			<< "<OPTION value=\"90\">90</OPTION>\n"
			<< "<OPTION value=\"91\">91</OPTION>\n"
			<< "<OPTION value=\"92\">92</OPTION>\n"
			<< "<OPTION value=\"93\">93</OPTION>\n"
			<< "<OPTION value=\"94\">94</OPTION>\n"
			<< "<OPTION value=\"95\">95</OPTION>\n"
			<< "<OPTION value=\"96\">96</OPTION>\n"
			<< "<OPTION value=\"97\">97</OPTION>\n"
			<< "<OPTION value=\"98\">98</OPTION>\n"
			<< "<OPTION value=\"99\">99</OPTION>\n"
			<< "</SELECT>\n"
			<< "</TD>\n"
			<< "</TR>\n"
			<< endl << flush;
			break;
	case 4 :
		Print_Current(Vect[index]);
					
		cout << "<!--  marital_status -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\">\n"
			<< "<P style=\"line-height: 100%\"> <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Marital status:</FONT></P>\n"
			<< "</TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\">\n"
			<< "<P style=\"line-height: 100%\"> <SELECT size=\"1\" name=\"marital_status\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">Single</OPTION>\n"
			<< "<OPTION value=\"2\">Single with children</OPTION>\n"
			<< "<OPTION value=\"3\">Married</OPTION>\n"
			<< "<OPTION value=\"4\">Divorced</OPTION>\n"
			<< "<OPTION value=\"5\">Divorced w/Children</OPTION>\n"
			<< "<OPTION value=\"6\">Widowed</OPTION>\n"
			<< "<OPTION value=\"7\">Widowed w/Chidren</OPTION>\n"
			<< "</SELECT></P>\n"
			<< "</TD>\n"
			<< "</TR>\n"
			<< endl << flush;
		break;
	case 5 :
		Print_Current(Vect[index]);		
		cout << "<!--  profession -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\">\n"
			<< "<P style=\"line-height: 100%\"> <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Profession:</FONT></P>\n"
			<< "</TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\">\n"
			<< "<P style=\"line-height: 100%\"> <SELECT size=\"1\" name=\"profession\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Please choose one</OPTION>\n"
			<< "<OPTION value=\"1\">Accounting/Finance</OPTION>\n"
			<< "<OPTION value=\"2\">Advertising/Media</OPTION>\n"
			<< "<OPTION value=\"3\">Advertising/Public Relations</OPTION>\n"
			<< "<OPTION value=\"4\">Advertising</OPTION>\n"
			<< "<OPTION value=\"5\">Airline - Aerospace</OPTION>\n"
			<< "<OPTION value=\"6\">Apparel - Textile</OPTION>\n"
			<< "<OPTION value=\"7\">Architecture</OPTION>\n"
			<< "<OPTION value=\"8\">Art - Photography - Journalism</OPTION>\n"
			<< "<OPTION value=\"9\">Arts/Entertainment/Publishing</OPTION>\n"
			<< "<OPTION value=\"10\">Automotive - Motor Vehicles - Parts</OPTION>\n"
			<< "<OPTION value=\"11\">Banking - Financial Services</OPTION>\n"
			<< "<OPTION value=\"12\">Bio-Pharmaceutical</OPTION>\n"
			<< "<OPTION value=\"13\">Biotechnology</OPTION>\n"
			<< "<OPTION value=\"14\">Building Materials</OPTION>\n"
			<< "<OPTION value=\"15\">Carpentry - Contruction</OPTION>\n"
			<< "<OPTION value=\"16\">Charitable - Not for Profit</OPTION>\n"
			<< "<OPTION value=\"17\">Clerical/Administrative</OPTION>\n"
			<< "<OPTION value=\"18\">Clerical/Service Worker</OPTION>\n"
			<< "<OPTION value=\"19\">Composer/Producer/Tech</OPTION>\n"
			<< "<OPTION value=\"20\">Computer Hardware</OPTION>\n"
			<< "<OPTION value=\"21\">Computer Software</OPTION>\n"
			<< "<OPTION value=\"22\">Construction/Real Estate/Facilities</OPTION>\n"
			<< "<OPTION value=\"23\">Consultant</OPTION>\n"
			<< "<OPTION value=\"24\">Consulting</OPTION>\n"
			<< "<OPTION value=\"25\">Doctor/Medical Prof</OPTION>\n"
			<< "<OPTION value=\"26\">Education - College</OPTION>\n"
			<< "<OPTION value=\"27\">Education/Training</OPTION>\n"
			<< "<OPTION value=\"28\">Employment - Recruiting</OPTION>\n"
			<< "<OPTION value=\"29\">Energy - Utilities - Gas - Electric</OPTION>\n"
			<< "<OPTION value=\"30\">Engineering/Architecture</OPTION>\n"
			<< "<OPTION value=\"31\">Entertainment - Radio - TV - Media</OPTION>\n"
			<< "<OPTION value=\"32\">Finance/Accounting</OPTION>\n"
			<< "<OPTION value=\"33\">Food Services</OPTION>\n"
			<< "<OPTION value=\"34\">Government - Civil Service</OPTION>\n"
			<< "<OPTION value=\"35\">Graphic Artist/Designer</OPTION>\n"
			<< "<OPTION value=\"36\">Health - Medical - Home Services</OPTION>\n"
			<< "<OPTION value=\"37\">Health Care</OPTION>\n"
			<< "<OPTION value=\"38\">Home Business</OPTION>\n"
			<< "<OPTION value=\"39\">Home Maker</OPTION>\n"
			<< "<OPTION value=\"40\">Hospitality</OPTION>\n"
			<< "<OPTION value=\"41\">Human Resources</OPTION>\n"
			<< "<OPTION value=\"42\">HVAC</OPTION>\n"
			<< "<OPTION value=\"43\">Industrial</OPTION>\n"
			<< "<OPTION value=\"44\">Insurance</OPTION>\n"
			<< "<OPTION value=\"45\">Internet</OPTION>\n"
			<< "<OPTION value=\"46\">K-12 Faculty/Staff</OPTION>\n"
			<< "<OPTION value=\"47\">Law Enforcement - Military</OPTION>\n"
			<< "<OPTION value=\"48\">Lawyer/Paralegal/Assistant</OPTION>\n"
			<< "<OPTION value=\"49\">Legal</OPTION>\n"
			<< "<OPTION value=\"50\">Manufacturing/Operations</OPTION>\n"
			<< "<OPTION value=\"51\">Manufacturing</OPTION>\n"
			<< "<OPTION value=\"52\">Marketing</OPTION>\n"
			<< "<OPTION value=\"53\">Merchandising</OPTION>\n"
			<< "<OPTION value=\"54\">Middle Management</OPTION>\n"
			<< "<OPTION value=\"55\">MIS/Programming</OPTION>\n"
			<< "<OPTION value=\"56\">Mortgage</OPTION>\n"
			<< "<OPTION value=\"57\">New Media/Internet</OPTION>\n"
			<< "<OPTION value=\"58\">Office Equipment</OPTION>\n"
			<< "<OPTION value=\"59\">Office Manager/Admin</OPTION>\n"
			<< "<OPTION value=\"60\">Oil Refining - Petroleum</OPTION>\n"
			<< "<OPTION value=\"61\">Pharmaceutical</OPTION>\n"
			<< "<OPTION value=\"62\">Political</OPTION>\n"
			<< "<OPTION value=\"63\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"64\">Printing - Publishing</OPTION>\n"
			<< "<OPTION value=\"65\">Professional/Technical</OPTION>\n"
			<< "<OPTION value=\"66\">Public Relations - Fund Raising</OPTION>\n"
			<< "<OPTION value=\"67\">Public Sector</OPTION>\n"
			<< "<OPTION value=\"68\">R&amp;D Engineering</OPTION>\n"
			<< "<OPTION value=\"69\">Real Estate - Property Mgt</OPTION>\n"
			<< "<OPTION value=\"70\">Recreation</OPTION>\n"
			<< "<OPTION value=\"71\">Retail</OPTION>\n"
			<< "<OPTION value=\"72\">Retail Products</OPTION>\n"
			<< "<OPTION value=\"73\">Retired</OPTION>\n"
			<< "<OPTION value=\"74\">Sales</OPTION>\n"
			<< "<OPTION value=\"75\">Sales/Marketing</OPTION>\n"
			<< "<OPTION value=\"76\">Scientist/Researcher</OPTION>\n"
			<< "<OPTION value=\"77\">Semiconductor - Electronics</OPTION>\n"
			<< "<OPTION value=\"78\">Technical Management</OPTION>\n"
			<< "<OPTION value=\"79\">Technology</OPTION>\n"
			<< "<OPTION value=\"80\">Telecommunications</OPTION>\n"
// Dublicate...
//			<< "<OPTION value=\"81\">Telecommunications</OPTION>\n"
			<< "<OPTION value=\"82\">Tourism</OPTION>\n"
			<< "<OPTION value=\"83\">Tradesman</OPTION>\n"
			<< "<OPTION value=\"84\">Training</OPTION>\n"
			<< "<OPTION value=\"85\">Transportation - Railroad</OPTION>\n"
			<< "<OPTION value=\"86\">Transportation/Logistics</OPTION>\n"
			<< "<OPTION value=\"87\">University Staff</OPTION>\n"
			<< "<OPTION value=\"88\">University Student</OPTION>\n"
			<< "<OPTION value=\"89\">Upper Management/Executive</OPTION>\n"
			<< "</SELECT></P>\n"
			<< "</TD>\n"
			<< "</TR>\n"
			<< endl << flush;
			break;
	case 6 :
		Print_Current(Vect[index]);

		cout << "<!--  income -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Income:</FONT></TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\"><SELECT size=\"1\" name=\"income\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">Less Than $24,999</OPTION>\n"
			<< "<OPTION value=\"2\">$25,000 to $34,999</OPTION>\n"
			<< "<OPTION value=\"3\">$35,000 to $49,999</OPTION>\n"
			<< "<OPTION value=\"4\">$50,000 to $74,999</OPTION>\n"
			<< "<OPTION value=\"5\">$75,000 to $99,999</OPTION>\n"
			<< "<OPTION value=\"6\">$100,000 to $149,999</OPTION>\n"
			<< "<OPTION value=\"7\">$150,000+</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			
			<< endl << flush;
		break;
	case 7 :
		Print_Current(Vect[index]);
		
		cout << "<!--  education -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Education:</FONT></TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\"><SELECT size=\"1\" name=\"education\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">Still a student</OPTION>\n"
			<< "<OPTION value=\"2\">High School</OPTION>\n"
			<< "<OPTION value=\"3\">Some College</OPTION>\n"
			<< "<OPTION value=\"4\">College Degree</OPTION>\n"
			<< "<OPTION value=\"5\">Graduate Degree</OPTION>\n"
			<< "<OPTION value=\"6\">Post Graduate</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			
			<< endl << flush;
		break;
	case 8 :
		Print_Current(Vect[index]);
		
		cout << "<!--  religion -->\n"
			
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Religion:</FONT></TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\"><SELECT size=\"1\" name=\"religion\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"10\">Agnostic</OPTION>\n"
			<< "<OPTION value=\"6\">Bahai</OPTION>\n"
			<< "<OPTION value=\"9\">Buddhist</OPTION>\n"
			<< "<OPTION value=\"19\">Cao Dai</OPTION>\n"
			<< "<OPTION value=\"2\">Christian</OPTION>\n"
			<< "<OPTION value=\"3\">Christian / Catholic</OPTION>\n"
			<< "<OPTION value=\"11\">Christian / Mormon</OPTION>\n"
			<< "<OPTION value=\"12\">Christian / Protestant</OPTION>\n"
			<< "<OPTION value=\"13\">Hindu</OPTION>\n"
			<< "<OPTION value=\"1\">Islam</OPTION>\n"
			<< "<OPTION value=\"17\">Jain</OPTION>\n"
			<< "<OPTION value=\"4\">Jewish</OPTION>\n"
			<< "<OPTION value=\"16\">Juche</OPTION>\n"
			<< "<OPTION value=\"21\">Neo-Pagan</OPTION>\n"
			<< "<OPTION value=\"8\">Not religious</OPTION>\n"
			<< "<OPTION value=\"7\">Other</OPTION>\n"
			<< "<OPTION value=\"24\">Rastafarian</OPTION>\n"
			<< "<OPTION value=\"23\">Scientology</OPTION>\n"
			<< "<OPTION value=\"18\">Shinto</OPTION>\n"
			<< "<OPTION value=\"15\">Sikhs</OPTION>\n"
			<< "<OPTION value=\"14\">Sprirtual but not religous</OPTION>\n"
			<< "<OPTION value=\"20\">Tenrikyo</OPTION>\n"
			<< "<OPTION value=\"22\">Unitarian</OPTION>\n"
			<< "<OPTION value=\"5\">Zoroastrian</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
		break;
	case 9 :
		Print_Current(Vect[index]);
		
		cout << "<!--  height -->\n"
			
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Height:</FONT></TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\"><SELECT size=\"1\" name=\"height\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">4' 01\"(1.24m)</OPTION>\n"
			<< "<OPTION value=\"2\">4' 02\" (1.27m)</OPTION>\n"
			<< "<OPTION value=\"3\">4' 03\"(1.30m)</OPTION>\n"
			<< "<OPTION value=\"4\">4'04\" (1.32m)</OPTION>\n"
			<< "<OPTION value=\"5\">4' 05\" (1.35m)</OPTION>\n"
			<< "<OPTION value=\"6\">4' 06\" (1.37m)</OPTION>\n"
			<< "<OPTION value=\"7\">4' 07\" (1.40m)</OPTION>\n"
			<< "<OPTION value=\"8\">4' 08\" (1.42m)</OPTION>\n"
			<< "<OPTION value=\"9\">4' 09\" (1.45m)</OPTION>\n"
			<< "<OPTION value=\"10\">4' 10\" (1.47m)</OPTION>\n"
			<< "<OPTION value=\"11\">4' 11\" (1.50m)</OPTION>\n"
			<< "<OPTION value=\"12\">5' 00\" (1.52m)</OPTION>\n"
			<< "<OPTION value=\"13\">5' 01\" (1.55m)</OPTION>\n"
			<< "<OPTION value=\"14\">5' 02\" (1.57m)</OPTION>\n"
			<< "<OPTION value=\"15\">5' 03\" (1.60m)</OPTION>\n"
			<< "<OPTION value=\"16\">5' 04\" (1.63m)</OPTION>\n"
			<< "<OPTION value=\"17\">5' 05\"(1.65m)</OPTION>\n"
			<< "<OPTION value=\"18\">5' 06\" (1.68m)</OPTION>\n"
			<< "<OPTION value=\"19\">5' 07\" (1.70m)</OPTION>\n"
			<< "<OPTION value=\"20\">5'08\" (1.73m)</OPTION>\n"
			<< "<OPTION value=\"21\">5' 09\" (1.75m)</OPTION>\n"
			<< "<OPTION value=\"22\">5' 10\" (1.78m)</OPTION>\n"
			<< "<OPTION value=\"23\">5' 11\" (1.80m)</OPTION>\n"
			<< "<OPTION value=\"24\">6' 00\" (1.83m)</OPTION>\n"
			<< "<OPTION value=\"25\">6' 01\"(1.85m)</OPTION>\n"
			<< "<OPTION value=\"26\">6' 02\" (1.88m)</OPTION>\n"
			<< "<OPTION value=\"27\">6' 03\" (1.90m)</OPTION>\n"
			<< "<OPTION value=\"28\">6'04\" (1.93m)</OPTION>\n"
			<< "<OPTION value=\"29\">6' 05\" (1.96m)</OPTION>\n"
			<< "<OPTION value=\"30\">6' 06\" (1.98m)</OPTION>\n"
			<< "<OPTION value=\"31\">6' 07\" (2.01m)</OPTION>\n"
			<< "<OPTION value=\"32\">6' 08\" (2.03m)</OPTION>\n"
			<< "<OPTION value=\"33\">6' 09\"(2.06m)</OPTION>\n"
			<< "<OPTION value=\"34\">6' 10\" (2.08m)</OPTION>\n"
			<< "<OPTION value=\"35\">6' 11\" (2.11m)</OPTION>\n"
			<< "<OPTION value=\"36\">7'0\" (2.13m)</OPTION>\n"
			<< "<OPTION value=\"37\">7' 01\" (2.16m)</OPTION>\n"
			<< "<OPTION value=\"38\">7' 02\" (2.18m)</OPTION>\n"
			<< "<OPTION value=\"39\">7' 03\" (2.21m)</OPTION>\n"
			<< "<OPTION value=\"40\">7' 04\" (2.24m)</OPTION>\n"
			<< "<OPTION value=\"41\">7' 05\"(2.26m)</OPTION>\n"
			<< "<OPTION value=\"42\">7' 06\" (2.29m)</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
			break;
	case 10 :
		Print_Current(Vect[index]);
		
		cout << "	<!--  weight -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Weight:</FONT></TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\"><SELECT size=\"1\" name=\"weight\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">85 lbs. 39kg)</OPTION>\n"
			<< "<OPTION value=\"2\">90 lbs. (41kg)</OPTION>\n"
			<< "<OPTION value=\"3\">95 lbs. (43kg)</OPTION>\n"
			<< "<OPTION value=\"4\">100 lbs.(45kg)</OPTION>\n"
			<< "<OPTION value=\"5\">105 lbs. (48kg)</OPTION>\n"
			<< "<OPTION value=\"6\">110 lbs. (50kg)</OPTION>\n"
			<< "<OPTION value=\"7\">115 lbs. (52kg)</OPTION>\n"
			<< "<OPTION value=\"8\">120 lbs. (54kg)</OPTION>\n"
			<< "<OPTION value=\"9\">125 lbs. (57kg)</OPTION>\n"
			<< "<OPTION value=\"10\">130 lbs. (59kg)</OPTION>\n"
			<< "<OPTION value=\"11\">135 lbs. (61kg)</OPTION>\n"
			<< "<OPTION value=\"12\">140 lbs. (64kg)</OPTION>\n"
			<< "<OPTION value=\"13\">145 lbs. (66kg)</OPTION>\n"
			<< "<OPTION value=\"14\">150 lbs. (68kg)</OPTION>\n"
			<< "<OPTION value=\"15\">155 lbs. (70kg)</OPTION>\n"
			<< "<OPTION value=\"16\">160 lbs. (73kg)</OPTION>\n"
			<< "<OPTION value=\"17\">165 lbs. (75kg)</OPTION>\n"
			<< "<OPTION value=\"18\">170 lbs. (77kg)</OPTION>\n"
			<< "<OPTION value=\"19\">175 lbs. (79kg)</OPTION>\n"
			<< "<OPTION value=\"20\">180 lbs. (82kg)</OPTION>\n"
			<< "<OPTION value=\"21\">185 lbs. (84kg)</OPTION>\n"
			<< "<OPTION value=\"22\">190 lbs. (86kg)</OPTION>\n"
			<< "<OPTION value=\"23\">195 lbs. (88kg)</OPTION>\n"
			<< "<OPTION value=\"24\">200 lbs. (91kg)</OPTION>\n"
			<< "<OPTION value=\"25\">205 lbs. (93kg)</OPTION>\n"
			<< "<OPTION value=\"26\">210 lbs. (95kg)</OPTION>\n"
			<< "<OPTION value=\"27\">215 lbs. (98kg)</OPTION>\n"
			<< "<OPTION value=\"28\">220 lbs. (100kg)</OPTION>\n"
			<< "<OPTION value=\"29\">225 lbs. (102kg)</OPTION>\n"
			<< "<OPTION value=\"30\">230 lbs. (104kg)</OPTION>\n"
			<< "<OPTION value=\"31\">235 lbs. (107kg)</OPTION>\n"
			<< "<OPTION value=\"32\">240 lbs. (109kg)</OPTION>\n"
			<< "<OPTION value=\"33\">245 lbs. (111kg)</OPTION>\n"
			<< "<OPTION value=\"34\">250 lbs. (113kg)</OPTION>\n"
			<< "<OPTION value=\"35\">255 lbs. (116kg)</OPTION>\n"
			<< "<OPTION value=\"36\">260 lbs. (118kg)</OPTION>\n"
			<< "<OPTION value=\"37\">265 lbs. (120kg)</OPTION>\n"
			<< "<OPTION value=\"38\">270 lbs. (122kg)</OPTION>\n"
			<< "<OPTION value=\"39\">275 lbs. (125kg)</OPTION>\n"
			<< "<OPTION value=\"40\">280 lbs. (127kg)</OPTION>\n"
			<< "<OPTION value=\"41\">285 lbs. (129kg)</OPTION>\n"
			<< "<OPTION value=\"42\">290 lbs. (132kg)</OPTION>\n"
			<< "<OPTION value=\"43\">295 lbs. (134kg)</OPTION>\n"
			<< "<OPTION value=\"44\">300 lbs. (136kg)</OPTION>\n"
			<< "<OPTION value=\"45\">300+ lbs. (136kg+)</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
			break;
	case 11 :
		Print_Current(Vect[index]);
		
		cout << "<!--  eyes -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Eyes:</FONT></TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\"><SELECT size=\"1\" name=\"eyes\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">Brown</OPTION>\n"
			<< "<OPTION value=\"2\">Black</OPTION>\n"
			<< "<OPTION value=\"3\">Blue</OPTION>\n"
			<< "<OPTION value=\"4\">Green</OPTION>\n"
			<< "<OPTION value=\"5\">Hazel</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
		break;
	case 12 :
		Print_Current(Vect[index]);
		
		cout << "<!--  hair -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Hair:</FONT></TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\"><SELECT size=\"1\" name=\"hair\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">Black</OPTION>\n"
			<< "<OPTION value=\"2\">Brown</OPTION>\n"
			<< "<OPTION value=\"3\">Red</OPTION>\n"
			<< "<OPTION value=\"4\">Blonde</OPTION>\n"
			<< "<OPTION value=\"5\">Balding</OPTION>\n"
			<< "<OPTION value=\"6\">Other</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
		break;
	case 13 :
		cout << "<!--  min_age_desired -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Seeking ages from:</FONT></TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\"><SELECT size=\"1\" name=\"min_age_desired\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"18\">18</OPTION>\n"
			<< "<OPTION value=\"19\">19</OPTION>\n"
			<< "<OPTION value=\"20\">20</OPTION>\n"
			<< "<OPTION value=\"21\">21</OPTION>\n"
			<< "<OPTION value=\"22\">22</OPTION>\n"
			<< "<OPTION value=\"23\">23</OPTION>\n"
			<< "<OPTION value=\"24\">24</OPTION>\n"
			<< "<OPTION value=\"25\">25</OPTION>\n"
			<< "<OPTION value=\"26\">26</OPTION>\n"
			<< "<OPTION value=\"27\">27</OPTION>\n"
			<< "<OPTION value=\"28\">28</OPTION>\n"
			<< "<OPTION value=\"29\">29</OPTION>\n"
			<< "<OPTION value=\"30\">30</OPTION>\n"
			<< "<OPTION value=\"31\">31</OPTION>\n"
			<< "<OPTION value=\"32\">32</OPTION>\n"
			<< "<OPTION value=\"33\">33</OPTION>\n"
			<< "<OPTION value=\"34\">34</OPTION>\n"
			<< "<OPTION value=\"35\">35</OPTION>\n"
			<< "<OPTION value=\"36\">36</OPTION>\n"
			<< "<OPTION value=\"37\">37</OPTION>\n"
			<< "<OPTION value=\"38\">38</OPTION>\n"
			<< "<OPTION value=\"39\">39</OPTION>\n"
			<< "<OPTION value=\"40\">40</OPTION>\n"
			<< "<OPTION value=\"41\">41</OPTION>\n"
			<< "<OPTION value=\"42\">42</OPTION>\n"
			<< "<OPTION value=\"43\">43</OPTION>\n"
			<< "<OPTION value=\"44\">44</OPTION>\n"
			<< "<OPTION value=\"45\">45</OPTION>\n"
			<< "<OPTION value=\"46\">46</OPTION>\n"
			<< "<OPTION value=\"47\">47</OPTION>\n"
			<< "<OPTION value=\"48\">48</OPTION>\n"
			<< "<OPTION value=\"49\">49</OPTION>\n"
			<< "<OPTION value=\"50\">50</OPTION>\n"
			<< "<OPTION value=\"51\">51</OPTION>\n"
			<< "<OPTION value=\"52\">52</OPTION>\n"
			<< "<OPTION value=\"53\">53</OPTION>\n"
			<< "<OPTION value=\"54\">54</OPTION>\n"
			<< "<OPTION value=\"55\">55</OPTION>\n"
			<< "<OPTION value=\"56\">56</OPTION>\n"
			<< "<OPTION value=\"57\">57</OPTION>\n"
			<< "<OPTION value=\"58\">58</OPTION>\n"
			<< "<OPTION value=\"59\">59</OPTION>\n"
			<< "<OPTION value=\"60\">60</OPTION>\n"
			<< "<OPTION value=\"61\">61</OPTION>\n"
			<< "<OPTION value=\"62\">62</OPTION>\n"
			<< "<OPTION value=\"63\">63</OPTION>\n"
			<< "<OPTION value=\"64\">64</OPTION>\n"
			<< "<OPTION value=\"65\">65</OPTION>\n"
			<< "<OPTION value=\"66\">66</OPTION>\n"
			<< "<OPTION value=\"67\">67</OPTION>\n"
			<< "<OPTION value=\"68\">68</OPTION>\n"
			<< "<OPTION value=\"69\">69</OPTION>\n"
			<< "<OPTION value=\"70\">70</OPTION>\n"
			<< "<OPTION value=\"71\">71</OPTION>\n"
			<< "<OPTION value=\"72\">72</OPTION>\n"
			<< "<OPTION value=\"73\">73</OPTION>\n"
			<< "<OPTION value=\"74\">74</OPTION>\n"
			<< "<OPTION value=\"75\">75</OPTION>\n"
			<< "<OPTION value=\"76\">76</OPTION>\n"
			<< "<OPTION value=\"77\">77</OPTION>\n"
			<< "<OPTION value=\"78\">78</OPTION>\n"
			<< "<OPTION value=\"79\">79</OPTION>\n"
			<< "<OPTION value=\"80\">80</OPTION>\n"
			<< "<OPTION value=\"81\">81</OPTION>\n"
			<< "<OPTION value=\"82\">82</OPTION>\n"
			<< "<OPTION value=\"83\">83</OPTION>\n"
			<< "<OPTION value=\"84\">84</OPTION>\n"
			<< "<OPTION value=\"85\">85</OPTION>\n"
			<< "<OPTION value=\"86\">86</OPTION>\n"
			<< "<OPTION value=\"87\">87</OPTION>\n"
			<< "<OPTION value=\"88\">88</OPTION>\n"
			<< "<OPTION value=\"89\">89</OPTION>\n"
			<< "<OPTION value=\"90\">90</OPTION>\n"
			<< "<OPTION value=\"91\">91</OPTION>\n"
			<< "<OPTION value=\"92\">92</OPTION>\n"
			<< "<OPTION value=\"93\">93</OPTION>\n"
			<< "<OPTION value=\"94\">94</OPTION>\n"
			<< "<OPTION value=\"95\">95</OPTION>\n"
			<< "<OPTION value=\"96\">96</OPTION>\n"
			<< "<OPTION value=\"97\">97</OPTION>\n"
			<< "<OPTION value=\"98\">98</OPTION>\n"
			<< "<OPTION value=\"99\">99</OPTION>\n"
			<< "</SELECT> &nbsp;&nbsp;<FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">To</FONT>&nbsp;&nbsp;\n"
			<< endl << flush;
		break;
	case 14 :
		cout << "	<!--  max_age_desired -->\n"
			<< "<SELECT size=\"1\" name=\"max_age_desired\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"18\">18</OPTION>\n"
			<< "<OPTION value=\"19\">19</OPTION>\n"
			<< "<OPTION value=\"20\">20</OPTION>\n"
			<< "<OPTION value=\"21\">21</OPTION>\n"
			<< "<OPTION value=\"22\">22</OPTION>\n"
			<< "<OPTION value=\"23\">23</OPTION>\n"
			<< "<OPTION value=\"24\">24</OPTION>\n"
			<< "<OPTION value=\"25\">25</OPTION>\n"
			<< "<OPTION value=\"26\">26</OPTION>\n"
			<< "<OPTION value=\"27\">27</OPTION>\n"
			<< "<OPTION value=\"28\">28</OPTION>\n"
			<< "<OPTION value=\"29\">29</OPTION>\n"
			<< "<OPTION value=\"30\">30</OPTION>\n"
			<< "<OPTION value=\"31\">31</OPTION>\n"
			<< "<OPTION value=\"32\">32</OPTION>\n"
			<< "<OPTION value=\"33\">33</OPTION>\n"
			<< "<OPTION value=\"34\">34</OPTION>\n"
			<< "<OPTION value=\"35\">35</OPTION>\n"
			<< "<OPTION value=\"36\">36</OPTION>\n"
			<< "<OPTION value=\"37\">37</OPTION>\n"
			<< "<OPTION value=\"38\">38</OPTION>\n"
			<< "<OPTION value=\"39\">39</OPTION>\n"
			<< "<OPTION value=\"40\">40</OPTION>\n"
			<< "<OPTION value=\"41\">41</OPTION>\n"
			<< "<OPTION value=\"42\">42</OPTION>\n"
			<< "<OPTION value=\"43\">43</OPTION>\n"
			<< "<OPTION value=\"44\">44</OPTION>\n"
			<< "<OPTION value=\"45\">45</OPTION>\n"
			<< "<OPTION value=\"46\">46</OPTION>\n"
			<< "<OPTION value=\"47\">47</OPTION>\n"
			<< "<OPTION value=\"48\">48</OPTION>\n"
			<< "<OPTION value=\"49\">49</OPTION>\n"
			<< "<OPTION value=\"50\">50</OPTION>\n"
			<< "<OPTION value=\"51\">51</OPTION>\n"
			<< "<OPTION value=\"52\">52</OPTION>\n"
			<< "<OPTION value=\"53\">53</OPTION>\n"
			<< "<OPTION value=\"54\">54</OPTION>\n"
			<< "<OPTION value=\"55\">55</OPTION>\n"
			<< "<OPTION value=\"56\">56</OPTION>\n"
			<< "<OPTION value=\"57\">57</OPTION>\n"
			<< "<OPTION value=\"58\">58</OPTION>\n"
			<< "<OPTION value=\"59\">59</OPTION>\n"
			<< "<OPTION value=\"60\">60</OPTION>\n"
			<< "<OPTION value=\"61\">61</OPTION>\n"
			<< "<OPTION value=\"62\">62</OPTION>\n"
			<< "<OPTION value=\"63\">63</OPTION>\n"
			<< "<OPTION value=\"64\">64</OPTION>\n"
			<< "<OPTION value=\"65\">65</OPTION>\n"
			<< "<OPTION value=\"66\">66</OPTION>\n"
			<< "<OPTION value=\"67\">67</OPTION>\n"
			<< "<OPTION value=\"68\">68</OPTION>\n"
			<< "<OPTION value=\"69\">69</OPTION>\n"
			<< "<OPTION value=\"70\">70</OPTION>\n"
			<< "<OPTION value=\"71\">71</OPTION>\n"
			<< "<OPTION value=\"72\">72</OPTION>\n"
			<< "<OPTION value=\"73\">73</OPTION>\n"
			<< "<OPTION value=\"74\">74</OPTION>\n"
			<< "<OPTION value=\"75\">75</OPTION>\n"
			<< "<OPTION value=\"76\">76</OPTION>\n"
			<< "<OPTION value=\"77\">77</OPTION>\n"
			<< "<OPTION value=\"78\">78</OPTION>\n"
			<< "<OPTION value=\"79\">79</OPTION>\n"
			<< "<OPTION value=\"80\">80</OPTION>\n"
			<< "<OPTION value=\"81\">81</OPTION>\n"
			<< "<OPTION value=\"82\">82</OPTION>\n"
			<< "<OPTION value=\"83\">83</OPTION>\n"
			<< "<OPTION value=\"84\">84</OPTION>\n"
			<< "<OPTION value=\"85\">85</OPTION>\n"
			<< "<OPTION value=\"86\">86</OPTION>\n"
			<< "<OPTION value=\"87\">87</OPTION>\n"
			<< "<OPTION value=\"88\">88</OPTION>\n"
			<< "<OPTION value=\"89\">89</OPTION>\n"
			<< "<OPTION value=\"90\">90</OPTION>\n"
			<< "<OPTION value=\"91\">91</OPTION>\n"
			<< "<OPTION value=\"92\">92</OPTION>\n"
			<< "<OPTION value=\"93\">93</OPTION>\n"
			<< "<OPTION value=\"94\">94</OPTION>\n"
			<< "<OPTION value=\"95\">95</OPTION>\n"
			<< "<OPTION value=\"96\">96</OPTION>\n"
			<< "<OPTION value=\"97\">97</OPTION>\n"
			<< "<OPTION value=\"98\">98</OPTION>\n"
			<< "<OPTION value=\"99\">99</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< endl << flush;
		break;		
	case 15 :
		Print_Current(Vect[index]);
		
		cout << "<!--  cook -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Do you like to cook?</FONT></TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\"><SELECT size=\"1\" name=\"cook\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">Yes</OPTION>\n"
			<< "<OPTION value=\"2\">No</OPTION>\n"
			<< "<OPTION value=\"3\">We'll See!</OPTION>\n"
			<< "<OPTION value=\"4\">Will Never Cook</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			
			<< endl << flush;
		break;
	case 16 :
		Print_Current(Vect[index]);
		
		cout << "<!--  smoke -->\n"
			
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Do you smoke?</FONT></TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\"><SELECT size=\"1\" name=\"smoke\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">Yes</OPTION>\n"
			<< "<OPTION value=\"2\">No</OPTION>\n"
			<< "<OPTION value=\"3\">Sometimes</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
		break;
	case 17 :
		Print_Current(Vect[index]);
		
		cout << "<!--  drink -->\n"
			
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Do you drink?</FONT></TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\"><SELECT size=\"1\" name=\"drink\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">Yes</OPTION>\n"
			<< "<OPTION value=\"2\">No</OPTION>\n"
			<< "<OPTION value=\"3\">Often</OPTION>\n"
			<< "<OPTION value=\"4\">Sometimes</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
		break;
	case 18 :
		Print_Current(Vect[index]);
		
		cout << "<!--  party -->\n"
			
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\">\n"
			<< "<P align=\"right\"> <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">How much do you like to party?</FONT></P>\n"
			<< "</TD>\n"
			<< "<TD width=\"371\" height=\"22\" align=\"left\" valign=\"top\"><SELECT size=\"1\" name=\"party\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">What does the party mean?</OPTION>\n"
			<< "<OPTION value=\"2\">Only on special occasions</OPTION>\n"
			<< "<OPTION value=\"3\">On the weekends</OPTION>\n"
			<< "<OPTION value=\"4\">Every chance I get</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
		break;
	case 19 :
		Print_Current(Vect[index]);
		
		cout << "<!--  political -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\">\n"
			<< "<P align=\"right\"> <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">What are your political views?&nbsp;</FONT></P>\n"
			<< "</TD>\n"
			<< "<TD width=\"371\" height=\"22\" valign=\"top\"><SELECT size=\"1\" name=\"political\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">I wish I was born pink.</OPTION>\n"
			<< "<OPTION value=\"2\">Liberal.</OPTION>\n"
			<< "<OPTION value=\"3\">Moderate Liberal.</OPTION>\n"
			<< "<OPTION value=\"4\">Moderate Conservative.</OPTION>\n"
			<< "<OPTION value=\"5\">Conservative.</OPTION>\n"
			<< "<OPTION value=\"6\">Extreme Conservative.</OPTION>\n"
			<< "<OPTION value=\"7\">If I were any more conservative I would't use electricity.</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
		break;
	case 20 :
		Print_Current(Vect[index]);
		
		cout << "<!--  housing_status -->\n"
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"left\">\n"
			<< "<P style=\"line-height: 100%\" align=\"right\"> <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">What are your living arrangements?</FONT></P>\n"
			<< "</TD>\n"
			<< "<TD width=\"371\" height=\"22\">\n"
			<< "<P style=\"line-height: 100%\"> <SELECT size=\"1\" name=\"housing_status\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">Live alone</OPTION>\n"
			<< "<OPTION value=\"2\">Live with room mates</OPTION>\n"
			<< "<OPTION value=\"3\">Live with parents</OPTION>\n"
			<< "</SELECT></P>\n"
			<< "</TD>\n"
			<< "</TR>\n"
			<< endl << flush;
		
		break;
	case 21 :
		cout << "<!--  relationship -->\n"
			
			<< "<TR>\n"
			<< "<TD width=\"181\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Relationship type:</FONT></TD>\n"
			<< "<TD width=\"371\" height=\"24\" align=\"left\"><SELECT size=\"5\" name=\"relationship\" multiple>\n"
			
			<< endl << flush;
		if ( ! strcmp(Vect[index].db_column_actual, "1") )
		{
			cout << "<OPTION SELECTED value=\"" << (index - ITEMS_BEFORE_RELATIONSHIP) << "\">" << Vect[index].web_form_name << "</OPTION>\n" << endl << flush;
		}
		else
		{
			cout << "<OPTION value=\"" << (index - ITEMS_BEFORE_RELATIONSHIP) << "\">" << Vect[index].web_form_name << "</OPTION>\n" << endl << flush;
		}
		break;
	case 22 : case 23 : case 24 : case 25 : case 26 : case 27 : case 28 :
		if ( ! strcmp(Vect[index].db_column_actual, "1") )
		{
			cout << "<OPTION SELECTED value=\"" << (index - ITEMS_BEFORE_RELATIONSHIP) << "\">" << Vect[index].web_form_name << "</OPTION>\n" << endl << flush;
		}
		else
		{
			cout << "<OPTION value=\"" << (index - ITEMS_BEFORE_RELATIONSHIP) << "\">" << Vect[index].web_form_name << "</OPTION>\n" << endl << flush;
		}
		break;
	case 29 :
		if ( ! strcmp(Vect[index].db_column_actual, "1") )
		{
			cout << "<OPTION SELECTED value=\"" << (index - ITEMS_BEFORE_RELATIONSHIP) << "\">" << Vect[index].web_form_name << "</OPTION>\n" << endl << flush;
		}
		else
		{
			cout << "<OPTION value=\"" << (index - ITEMS_BEFORE_RELATIONSHIP) << "\">" << Vect[index].web_form_name << "</OPTION>\n" << endl << flush;
		}
		
		
		cout << "</SELECT><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">You can choose several</FONT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
		break;
		
	default:
		cout << "	<!--    Unknown Column Name  " << Vect[index].db_column_name << " -->" << endl << flush;
		break;
	}
}
