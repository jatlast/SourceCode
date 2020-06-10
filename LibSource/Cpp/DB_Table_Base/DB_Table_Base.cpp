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

#include <vector>
#include <algorithm>
#include <cctype>

#include "DB_Table_Base/DB_Table_Base.h"	
#include "DB_Msg_Err_Handlers.h"
#include "CommentMacro.h" // contains the comment macro def of "dout"

using db_table_base_namespace::DB_Table_Base;

using std::cout;
using std::endl;
using std::flush;
using std::vector; // needed for retrieving multiple selection relationship data

extern LinkMap LM;

//	The actual funcitons for the DB_Table_Info class...

// initialization constructor
DB_Table_Base::DB_Table_Info::DB_Table_Info(
											const string & column_name
											, const char * const column_data
											, const char * const column_actual
											, const string & form_name
											, const string & form_data
											, const string & form_hidden_data
											, const int c_number
											, const int v
											, const int l
											)
{
	db_column_name		= column_name;
	if(column_data)
	{
		db_column_data	= new char[MAXLEN];
		strcpy(db_column_data, column_data);
	}
	else
	{
		db_column_data	= new char[MAXLEN];
		memset(db_column_data, '\0', MAXLEN);
		//		db_column_data[0] = '\0';
	}
	if(column_actual)
	{
		db_column_actual= new char[MAXLEN];
		strcpy(db_column_actual, column_actual);
	}
	else
	{
		db_column_actual= new char[MAXLEN];
		memset(db_column_actual, '\0', MAXLEN);
		//		db_column_data[0] = '\0';
	}
	web_form_name		= form_name;
	web_form_data		= form_data;
	web_form_hidden_data= form_hidden_data;
	row_number			= c_number;
	vartype				= v;
	length				= l;
	//dout << "-----------DB_Table_Info(params...)" << endl;
}// initialization constructor


// copy constructor
DB_Table_Base::DB_Table_Info::DB_Table_Info(const DB_Table_Info & copy)
{
	db_column_name		= copy.db_column_name;
	if(copy.db_column_data)
	{
		db_column_data	= new char[MAXLEN];
		strcpy(db_column_data, copy.db_column_data);
	}
	else
	{
		db_column_data	= new char[MAXLEN];
		memset(db_column_data, '\0', MAXLEN);
		//		db_column_data[0] = '\0';
	}
	if(copy.db_column_actual)
	{
		db_column_actual= new char[MAXLEN];
		strcpy(db_column_actual, copy.db_column_actual);
	}
	else
	{
		db_column_data	= new char[MAXLEN];
		memset(db_column_data, '\0', MAXLEN);
		//		db_column_data[0] = '\0';
	}
	web_form_name			= copy.web_form_name;
	web_form_data			= copy.web_form_data;
	web_form_hidden_data	= copy.web_form_hidden_data;
	row_number				= copy.row_number;
	vartype					= copy.vartype;
	length					= copy.length;
	//dout << "-----------DB_Table_Info() copy" << endl;
}// copy constructor



// operator= overload
DB_Table_Base::DB_Table_Info & 
DB_Table_Base::DB_Table_Info::operator=(const DB_Table_Base::DB_Table_Info & rhs)
{
	//dout << "Within operator=" << endl;
	if(this != &rhs)
	{
		db_column_name = rhs.db_column_name;
		delete [] db_column_data;	// delete the old char * 
		if(rhs.db_column_data)
		{
			db_column_data = new char[MAXLEN];
			strcpy(db_column_data, rhs.db_column_data);
		}
		else
		{
			db_column_data = new char[MAXLEN];
			memset(db_column_data, '\0', MAXLEN);
			//		db_column_data[0] = '\0';
		}
		delete [] db_column_actual;	// delete the old char * 
		if(rhs.db_column_actual)
		{
			db_column_actual = new char[MAXLEN];
			strcpy(db_column_actual, rhs.db_column_actual);
		}
		else
		{
			db_column_actual = new char[MAXLEN];
			memset(db_column_actual, '\0', MAXLEN);
			//		db_column_data[0] = '\0';
		}
		web_form_name		= rhs.web_form_name;
		web_form_data		= rhs.web_form_data;
		web_form_hidden_data= rhs.web_form_hidden_data;
		row_number			= rhs.row_number;
		vartype				= rhs.vartype;
		length				= rhs.length;
	}
	//dout << "-----------DB_Table_Info() assignment" << endl;
	return *this;
}// operator= overload


// DB_Table_Info embeded class of DB_Table_Base Destructor
DB_Table_Base::DB_Table_Info::~DB_Table_Info()
{
	//dout << "----------------Within ~DB_Table_Info()" << endl;
	delete [] db_column_data;
	delete [] db_column_actual;
}// DB_Table_Info embeded class of DB_Table_Base Destructor


//	...END The actual funcitons for the DB_Table_Info class...


DB_Table_Base::~DB_Table_Base()
{
	//	dout << "----------------Within ~DB_Table_Base()" << endl;
}// Destructor


bool
DB_Table_Base::Initialize_DbProc(LinkMap & Map)
{
	bool rc = false;
				
	const string DatabaseName	= Map.PrintValue( "DBNAME" );
	const string UserName		= Map.PrintValue( "DBUSER" );
	const string Password		= Map.PrintValue( "DBPWD" );
	const string ApplicationName = "Initialize_DbProc";
	
	LOGINREC     *login;      // The login information
				
	// Initialize DB-Library
	if (dbinit() == FAIL) 
	{
		rc = false;
		dout << "<!-- dbinit failed. -->" << endl;
		return rc;
	}
	// Install user-supplied error-handling and message-handling routines.
	dberrhandle(err_handler); 
	dbmsghandle(msg_handler);
	
	// Get a LOGINREC
	login = dblogin(); 
	
	//  save the proper information in the login record...	   
	DBSETLUSER(login, (char *)UserName.c_str()); 
	DBSETLPWD (login, (char *)Password.c_str()); 
	DBSETLAPP (login, (char *)ApplicationName.c_str()); 
	
	// Get a DBPROCESS structure for communication with SQL Server.
	// No need to check for errors when calling dbopen() 
	// because my error_handler will be called in that case...
	this->DbProc = dbopen(login, (char *)DatabaseName.c_str()); 
	
	if(this->DbProc)
	{
		dout << "<!-- DbProc Initialized -->" << endl;
		return 1;
	}
	else
	{
		dout << "<!-- DbProc Failed to Initialize -->" << endl;
		return 0;
	}
}// end Initialize_DbProc()

void
DB_Table_Base::Set_Update_Info_Sql(const string & sql_statement)
{
	update_info_sql +=  " " + sql_statement;
}// Set_Update_Info_Sql

void
DB_Table_Base::Set_Get_Info_Sql(const string & sql_statement)
{
	get_info_sql += " " + sql_statement;
}// Set_Get_Info_Sql

const string &
DB_Table_Base::Get_Update_Info_Sql()
{
	return update_info_sql;
}// Get_Update_Info_Sql

const string &
DB_Table_Base::Get_Get_Info_Sql()
{
	return get_info_sql;
}// Get_Get_Info_Sql


// Prints the current name and value of the data retrieved from the Database
// used when displaying the user's current info alongside the cangeable info.
void
DB_Table_Base::Print_Current(const DB_Table_Info & dbti_vect)
{
	cout << "        <!--    current " << dbti_vect.db_column_name << "  -->\n"
		<< "        <TR>\n"
		<< "          <TD\n"
		<< "           width=\"120\"\n"
		<< "           height=\"25\"\n"
		<< "           align=\"right\">\n"
		<< "            <FONT\n"
		<< "             face=\"Arial, Helvetica, sans-serif\" size=\"2\"> \n"
		<< "		Current " << dbti_vect.web_form_name << ":\n"
		<< "	    </FONT>\n"
		<< "          </TD>\n"
		<< "          <TD\n"
		<< "           width=\"335\"\n"
		<< "           height=\"25\"\n"
		<< "           align=\"left\">\n"
		<< "		<B>" << dbti_vect.db_column_data << " </B>\n"
		<< "          </TD>\n"
		<< "        </TR>        " << endl;	
}// Print_Current

void
DB_Table_Base::Get_Form_Info_From_Cgi( cgicc::Cgicc & cgi )
{
	string db_string("");
	cgicc::form_iterator form_itr = 0;
	
	vector<cgicc::FormEntry> relationship;// contains the relationship multiple selections
	bool found_item = false;// true if there are selections in the relationship menu
	
	if ( Get_FormData_From_ColumnName("any_relationship") != "form_name not found")
	{
		found_item = cgi.getElement("relationship", relationship);
		dout << "<!-- relationship found -->" << endl;
	}
	
	for(unsigned int i=0; i<Vect.size(); i++)
	{
		db_string = "db_" + (Vect[i].db_column_name);
		form_itr = cgi.getElement(db_string);
		dout << "<!-- db looking for = \"" << db_string << "\" i = \"" << i << "\" -->" << endl;
		if( form_itr != cgi.getElements().end() )
		{
			if ( form_itr->isEmpty() )
			{
				Vect[i].web_form_hidden_data = "Empty";
			}
			else
			{// for some reason if += is NOT used the pointer is copied instead of the string ????????
				Vect[i].web_form_hidden_data += form_itr->getValue();		
			}
				dout << "<!-- db Found = \"" << Vect[i].web_form_hidden_data << "\" -->" << endl;
		}
		
		form_itr = cgi.getElement(Vect[i].db_column_name);
		dout << "<!-- db looking for = \"" << db_string << "\" -->" << endl;
		if( form_itr != cgi.getElements().end() )
		{
			if ( form_itr->isEmpty() )
			{
				Vect[i].web_form_data = "Empty";
			}
			else
			{
				// for some reason if += is NOT used the pointer is copied instead of the string ????????
				Vect[i].web_form_data += form_itr->getValue();
			}
		}
		if(Vect[i].web_form_data.empty() || Vect[i].web_form_data == "Empty")
		{
			Vect[i].web_form_data = Vect[i].web_form_hidden_data;
		}
		
		dout << "<!-- Pre relationship web_form_hidden_data = \"" << Vect[i].web_form_hidden_data << "\" -->" << endl;
		if ( Vect[i].web_form_hidden_data == "relationship" )// all relationship vector members should enter the for loop
		{
			//dout << "<!-- Within relationship form_name = \"" << Vect[i].web_form_name << "\" -->" << endl;
			if ( found_item ) // if the form contains the relationship multiple selection menu
			{
				//dout << "<!-- found_item = true -->" << endl;
				for(unsigned int j=0; j<relationship.size(); j++)
				{
					//dout << "<!-- i-... = \"" << (i-ITEMS_BEFORE_RELATIONSHIP) << "\" -->" << endl;
					if(relationship[j].getIntegerValue() == i-ITEMS_BEFORE_RELATIONSHIP)
					{
						Vect[i].web_form_data = "1";
						dout << "<!-- form_data = \"" << Vect[i].web_form_data << "\" -->" << endl;
						break;
					}
				}
			} // endl if relationship
		}// end if item_found
		dout << "<!-- Found = \"" << Vect[i].web_form_data << "\" -->" << endl;
	}// end for loop
}// Get_Form_Info_From_Cgi

bool
DB_Table_Base::Get_Info_From_DB(LinkMap & Map)
{
	Global_DBSuccess = true;
	//dout << "Start RawSybase()" << endl;
	bool rc = this->Initialize_DbProc(Map);
	
	dout << "<!-- Initialize_DbProc returned (" << rc << ") -->\n" << flush;

/*
	if(rc == 0)
	{
		DB_Table_Base_Error_Number = -1;
		DB_Table_Base_Error_Text = "Database Error.  Contact <FONT color=\"red\">" + Map.PrintValue( "EMAIL" ) + "</FONT> for assistence with this problem.\n\n<!-- ########### Check DB username and password. ########### -->\n\n";
		return false;
	}
*/

	// First, put the command into the command buffer.
	dbcmd( DbProc, const_cast<char *>(get_info_sql.c_str()) ); 
	
	// Send the command to SQL Server and start execution 
	dbsqlexec(DbProc);

	// Set DB_Table_Base class internal varaibles
	DB_Table_Base_Error_Number = dbretstatus ( DbProc );
	dout << "<!-- DB_Table_Base_Error_Number = (" << DB_Table_Base_Error_Number << ") -->\n";
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";
	
	if(Global_DBSuccess)
	{
		// Process the command
		// Get the actual data that is contained in the table itself
		if(dbresults(DbProc)) 
		{ 
			// Bind results to program variables.
			for(unsigned int i=0; i<Vect.size(); i++)
			{
				dbbind( DbProc
					, Vect[i].row_number
					, Vect[i].vartype
					, Vect[i].length
					, (BYTE *)( Vect[i].db_column_actual) 
					);
			}
			while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			{ 
				rc = true;
			} 
		}
		// Get the textual data via an SQL join
		if(dbresults(DbProc)) 
		{ 
			// Bind results to program variables.
			for(unsigned int i=0; i<Vect.size(); i++)
			{
				dbbind( DbProc
					, Vect[i].row_number
					, Vect[i].vartype
					, Vect[i].length
					, (BYTE *)( Vect[i].db_column_data) 
					);
			}
			while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			{ 
				rc = true;
			} 
		}
	}
	
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";

	// Close the connection to SQL Server
	dbexit(); 
	if(!Global_DBSuccess)
	{
		return Global_DBSuccess;
	}
	else
	{
		return rc;
	}
} // Get_Info_From_DB 


// Used to update the info in the DB
bool
DB_Table_Base::Update_Info_In_DB(LinkMap & Map)
{
	Global_DBSuccess = true;
	//dout << "Start RawSybase()" << endl;
	bool rc = true;
	
	this->Initialize_DbProc(Map);
	
	dout << "<!-- Initialize_DbProc returned (" << rc << ") -->\n" << flush;
/*
	if(rc == 0)
	{
		DB_Table_Base_Error_Number = -1;
		DB_Table_Base_Error_Text = "Database Error.  Contact <FONT color=\"red\">" + Map.PrintValue( "EMAIL" ) + "</FONT> for assistence with this problem.\n\n<!-- ########### Check DB username and password. ########### -->\n\n";
		return false;
	}
*/

	// First, put the command into the command buffer.
	dbcmd( DbProc, const_cast<char *>(update_info_sql.c_str()) ); 
	
	// Send the command to SQL Server and start execution
	dbsqlexec(DbProc);

	// Set DB_Table_Base class internal varaibles
	DB_Table_Base_Error_Number = dbretstatus ( DbProc );
	dout << "<!-- DB_Table_Base_Error_Number = (" << DB_Table_Base_Error_Number << ") -->\n";
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";
	
	if(Global_DBSuccess)
	{
		RETCODE return_code;
		// Process the command
		while ((return_code = dbresults(DbProc)) != NO_MORE_RESULTS) 
		{ 
			if (return_code == SUCCEED) 
			{ 
				// Retrieve and print the result rows.
				while (dbnextrow(DbProc) != NO_MORE_ROWS) 
				{ 
					rc = true;
				} 
			} 
		}
	}
	
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";
	// Close the connection to SQL Server
	dbexit(); 
	if(!Global_DBSuccess)
	{
		return Global_DBSuccess;
	}
	else
	{
		return rc;
	}
} // Update_Info_In_DB 

// Used to search the DB (SingleProfile.exe)
bool
DB_Table_Base::SingleSearch_The_DB(LinkMap & Map, const string & program_name, const string & PhotoNumber)
{
	CConnectionsFormLayout cfl;
	Global_DBSuccess = true;
	
	char row_count			[ROW_COUNT			];
	char search_unique_id	[SEARCH_UNIQUE_ID	];
	
	char user_id			[USER_ID			];
	char user_name			[USER_NAME			];
	char membership_type	[MEMBERSHIP_TYPE	];
	char sex				[SEX				];
	char creation_date		[CREATION_DATE		];
	char last_login			[LAST_LOGIN			];
	char city				[CITY				];
	char state				[STATE				];
	char country			[COUNTRY			];
	char sex_preference		[SEX_PREFERENCE		];
	char age				[AGE				];
	char marital_status		[MARITAL_STATUS		];
	char profession			[PROFESSION			];
	char income				[INCOME				];
	char education			[EDUCATION			];
	char religion			[RELIGION			];
	char height				[HEIGHT				];
	char weight				[WEIGHT				];
	char eyes				[EYES				];
	char hair				[HAIR				];
	char min_age_desired	[MIN_AGE_DESIRED	];
	char max_age_desired	[MAX_AGE_DESIRED	];
	char cook				[COOK				];
	char smoke				[SMOKE				];
	char drink				[DRINK				];
	char party				[PARTY				];
	char political			[POLITICAL			];
	char housing_status		[HOUSING_STATUS		];
	
	char prefer_not_to_say	[PREFER_NOT_TO_SAY	];
	char any_relationship	[ANY_RELATIONSHIP	];
	char hang_out			[HANG_OUT			];
	char short_term			[SHORT_TERM			];
	char long_term			[LONG_TERM			];
	char talk_email			[TALK_EMAIL			];
	char photo_exchange		[PHOTO_EXCHANGE		];
	char marriage			[MARRIAGE			];
	char other				[OTHER				];
	
	char screen_quote		[SCREEN_QUOTE		];
	char about_yourself		[ABOUT_YOURSELF		];
	
	char photo_1			[PHOTO_1			];
	char photo_2			[PHOTO_2			];
	char photo_3			[PHOTO_3			];
	char photo_4			[PHOTO_4			];
	char photo_5			[PHOTO_5			];
	
	
	memset(row_count		, ROW_COUNT			, NULL);
	memset(search_unique_id	, SEARCH_UNIQUE_ID	, NULL);
	
	memset(user_id			, USER_ID			, NULL);
	memset(user_name		, USER_NAME			, NULL);
	memset(membership_type	, MEMBERSHIP_TYPE	, NULL);
	memset(sex				, SEX				, NULL);
	memset(creation_date	, CREATION_DATE		, NULL);
	memset(last_login		, LAST_LOGIN		, NULL);
	memset(city				, CITY				, NULL);
	memset(state			, STATE				, NULL);
	memset(country			, COUNTRY			, NULL);
	memset(sex_preference	, SEX_PREFERENCE	, NULL);
	memset(age				, AGE				, NULL);
	memset(marital_status	, MARITAL_STATUS	, NULL);
	memset(profession		, PROFESSION		, NULL);
	memset(income			, INCOME			, NULL);
	memset(education		, EDUCATION			, NULL);
	memset(religion			, RELIGION			, NULL);
	memset(height			, HEIGHT			, NULL);
	memset(weight			, WEIGHT			, NULL);
	memset(eyes             , EYES				, NULL);
	memset(hair             , HAIR				, NULL);
	memset(min_age_desired  , MIN_AGE_DESIRED	, NULL);
	memset(max_age_desired	, MAX_AGE_DESIRED	, NULL);
	memset(cook				, COOK				, NULL);
	memset(smoke			, SMOKE				, NULL);
	memset(drink			, DRINK				, NULL);
	memset(party			, PARTY				, NULL);
	memset(political		, POLITICAL			, NULL);
	memset(housing_status	, HOUSING_STATUS	, NULL);
	
	memset(prefer_not_to_say, PREFER_NOT_TO_SAY	, NULL);
	memset(any_relationship	, ANY_RELATIONSHIP	, NULL);
	memset(hang_out			, HANG_OUT			, NULL);
	memset(short_term		, SHORT_TERM		, NULL);
	memset(long_term		, LONG_TERM			, NULL);
	memset(talk_email		, TALK_EMAIL		, NULL);
	memset(photo_exchange	, PHOTO_EXCHANGE	, NULL);
	memset(marriage			, MARRIAGE			, NULL);
	memset(other			, OTHER				, NULL);
	
	memset(screen_quote		, SCREEN_QUOTE		, NULL);
	memset(about_yourself	, ABOUT_YOURSELF	, NULL);
	
	memset(photo_1			, PHOTO_1			, NULL);
	memset(photo_2			, PHOTO_2			, NULL);
	memset(photo_3			, PHOTO_3			, NULL);
	memset(photo_4			, PHOTO_4			, NULL);
	memset(photo_5			, PHOTO_5			, NULL);
	
	bool rc = this->Initialize_DbProc(Map);
	
	dout << "<!-- Initialize_DbProc returned (" << rc << ") -->\n" << flush;
/*
	if(rc == 0)
	{
		DB_Table_Base_Error_Number = -1;
		DB_Table_Base_Error_Text = "Database Error.  Contact <FONT color=\"red\">" + Map.PrintValue( "EMAIL" ) + "</FONT> for assistence with this problem.\n\n<!-- ########### Check DB username and password. ########### -->\n\n";
		return false;
	}
*/

	// First, put the command into the command buffer.
	dbcmd( DbProc, const_cast<char *>(update_info_sql.c_str()) ); 
	
	// Send the command to SQL Server and start execution
	dbsqlexec(DbProc);

	// Set DB_Table_Base class internal varaibles
	DB_Table_Base_Error_Number = dbretstatus ( DbProc );
	dout << "<!-- DB_Table_Base_Error_Number = (" << DB_Table_Base_Error_Number << ") -->\n";
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";
	
	if(Global_DBSuccess)
	{
		// Process the command
		// Get the actual data that is contained in the table itself
		if(dbresults(DbProc)) 
		{
			::dbbind( DbProc, 1,  NTBSTRINGBIND, USER_ID			, (BYTE *)( user_id				) );
			::dbbind( DbProc, 2,  NTBSTRINGBIND, USER_NAME			, (BYTE *)( user_name			) );
			::dbbind( DbProc, 3,  NTBSTRINGBIND, MEMBERSHIP_TYPE	, (BYTE *)( membership_type		) );
			::dbbind( DbProc, 4,  NTBSTRINGBIND, SEX				, (BYTE *)( sex					) );
			::dbbind( DbProc, 5,  NTBSTRINGBIND, CREATION_DATE		, (BYTE *)( creation_date		) );
			::dbbind( DbProc, 6,  NTBSTRINGBIND, LAST_LOGIN			, (BYTE *)( last_login			) );
			::dbbind( DbProc, 7,  NTBSTRINGBIND, CITY				, (BYTE *)( city				) );
			::dbbind( DbProc, 8,  NTBSTRINGBIND, STATE				, (BYTE *)( state				) );
			::dbbind( DbProc, 9,  NTBSTRINGBIND, COUNTRY			, (BYTE *)( country				) );
			::dbbind( DbProc, 10, NTBSTRINGBIND, SEX_PREFERENCE		, (BYTE *)( sex_preference		) );
			::dbbind( DbProc, 11, NTBSTRINGBIND, AGE				, (BYTE *)( age					) );
			::dbbind( DbProc, 12, NTBSTRINGBIND, MARITAL_STATUS		, (BYTE *)( marital_status		) );
			::dbbind( DbProc, 13, NTBSTRINGBIND, PROFESSION			, (BYTE *)( profession			) );
			::dbbind( DbProc, 14, NTBSTRINGBIND, INCOME				, (BYTE *)( income				) );
			::dbbind( DbProc, 15, NTBSTRINGBIND, EDUCATION			, (BYTE *)( education			) );
			::dbbind( DbProc, 16, NTBSTRINGBIND, RELIGION			, (BYTE *)( religion			) );
			::dbbind( DbProc, 17, NTBSTRINGBIND, HEIGHT				, (BYTE *)( height				) );
			::dbbind( DbProc, 18, NTBSTRINGBIND, WEIGHT				, (BYTE *)( weight				) );
			::dbbind( DbProc, 19, NTBSTRINGBIND, EYES				, (BYTE *)( eyes				) );
			::dbbind( DbProc, 20, NTBSTRINGBIND, HAIR				, (BYTE *)( hair				) );
			::dbbind( DbProc, 21, NTBSTRINGBIND, MIN_AGE_DESIRED	, (BYTE *)( min_age_desired		) );
			::dbbind( DbProc, 22, NTBSTRINGBIND, MAX_AGE_DESIRED	, (BYTE *)( max_age_desired		) );
			::dbbind( DbProc, 23, NTBSTRINGBIND, COOK				, (BYTE *)( cook				) );
			::dbbind( DbProc, 24, NTBSTRINGBIND, SMOKE				, (BYTE *)( smoke				) );
			::dbbind( DbProc, 25, NTBSTRINGBIND, DRINK				, (BYTE *)( drink				) );
			::dbbind( DbProc, 26, NTBSTRINGBIND, PARTY				, (BYTE *)( party				) );
			::dbbind( DbProc, 27, NTBSTRINGBIND, POLITICAL			, (BYTE *)( political			) );
			::dbbind( DbProc, 28, NTBSTRINGBIND, HOUSING_STATUS		, (BYTE *)( housing_status		) );
			
			::dbbind( DbProc, 29, NTBSTRINGBIND, PREFER_NOT_TO_SAY	, (BYTE *)( &prefer_not_to_say	) );
			::dbbind( DbProc, 30, NTBSTRINGBIND, ANY_RELATIONSHIP	, (BYTE *)( &any_relationship	) );
			::dbbind( DbProc, 31, NTBSTRINGBIND, HANG_OUT			, (BYTE *)( &hang_out			) );
			::dbbind( DbProc, 32, NTBSTRINGBIND, SHORT_TERM			, (BYTE *)( &short_term			) );
			::dbbind( DbProc, 33, NTBSTRINGBIND, LONG_TERM			, (BYTE *)( &long_term			) );
			::dbbind( DbProc, 34, NTBSTRINGBIND, TALK_EMAIL			, (BYTE *)( &talk_email			) );
			::dbbind( DbProc, 35, NTBSTRINGBIND, PHOTO_EXCHANGE		, (BYTE *)( &photo_exchange		) );
			::dbbind( DbProc, 36, NTBSTRINGBIND, MARRIAGE			, (BYTE *)( &marriage			) );
			::dbbind( DbProc, 37, NTBSTRINGBIND, OTHER				, (BYTE *)( &other				) );
			
			::dbbind( DbProc, 38, NTBSTRINGBIND, SCREEN_QUOTE		, (BYTE *)( screen_quote		) );
			::dbbind( DbProc, 39, NTBSTRINGBIND, ABOUT_YOURSELF		, (BYTE *)( about_yourself		) );
			
			::dbbind( DbProc, 40, NTBSTRINGBIND, PHOTO_1			, (BYTE *)( photo_1				) );
			::dbbind( DbProc, 41, NTBSTRINGBIND, PHOTO_2			, (BYTE *)( photo_2				) );
			::dbbind( DbProc, 42, NTBSTRINGBIND, PHOTO_3			, (BYTE *)( photo_3				) );
			::dbbind( DbProc, 43, NTBSTRINGBIND, PHOTO_4			, (BYTE *)( photo_4				) );
			::dbbind( DbProc, 44, NTBSTRINGBIND, PHOTO_5			, (BYTE *)( photo_5				) );
			::dbbind( DbProc, 45, NTBSTRINGBIND, SEARCH_UNIQUE_ID	, (BYTE *)( search_unique_id	) );
			


			// To return an error when no profile is found 
			//    ( maybe it is hidden in the db i.e. about_info.questionable = 0 )
			// Set the return code to false if it is true
			// So it can be set to true if it makes it into the wihle loop
			if(rc)
				rc = false;
			// begin the result set with some return info...
			while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			{ 
				// Get the HTML Top along with the Text Ad Delivery Code...
				cfl.Html_Begin(Map, 1, SINGLE_PROFILE, search_unique_id);
				// reset the return code to true to indicate a user was found...
				rc = true;
				// remove seconds and miliseconds from the date fields...
				string creation_date_string = creation_date;
				if(creation_date_string.size() > 20)
				{
					creation_date_string.replace(creation_date_string.size()-9, 7, "");
				}
				if (program_name == "SingleProfile.exe")
				{
					cout << "<TABLE border=\"0\" cellpadding=\"0\" width=\"470\" cellspacing=\"0\">\n"
						
						<< "        <TR>\n"
						<< "          <TD colspan=\"2\" height=\"25\"><font color=\"#000000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">Meet</font> \n"
						<< "            <font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\"><STRONG>" << user_name << "</STRONG> \n"
						<< "            <font color=\"#000000\">who has been a member Since: " << creation_date_string << "</font></font></TD>\n"
						<< "		</TR>\n"
						<< "\n"


						<< "<TR>\n"
						<< "<TD width=\"200\" height=\"20\">&nbsp;</TD>\n"
						<< "<TD width=\"266\" height=\"20\">&nbsp;</TD>\n"
						<< "</TR>\n"
						<< "\n"
						<< "<TR>\n"
						<< "<TD width=\"200\" height=\"20\">&nbsp;</TD>\n"
						<< "<TD width=\"266\" height=\"20\">&nbsp;</TD>\n"
						<< "</TR>\n"
						<< "\n"
						<< "<TR>\n"
						<< "<TD align=\"left\" valign=\"top\" width=\"200\" height=\"488\">\n"
						<< "<DIV align=\"left\">\n"
						<< "<TABLE border=\"0\" width=\"200\" cellspacing=\"0\" align=\"left\">\n"
						<< "<TR>\n"
						<< "  <TD valign=\"top\" align=\"left\">\n"
						<< "    <CENTER>\n"
						<< "      <FONT size=\"2\">\n";
					
					
					// display the right picture...
					if(PhotoNumber == "1")
					{
						if(!strcmp(photo_1, "Nothing") || strlen(photo_1) < 1)
						{
							cout << "       <IMG ALT=\"Picture not available.\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_LARGE" ) << "\" width=\"180\" height=\"180\" border=\"0\">\n";
						}
						else	
						{
							cout << "       <A HREF=\"javascript:newWindow('" << Map.PrintValue( "PICTURES" ) << "/" << photo_1 << "')\">\n"
								<< "        <IMG ALT=\"View image 1 full size.\" src=\"" << Map.PrintValue( "PICTURES" ) << "/180x180_" << photo_1 << "\" width=\"180\" height=\"180\" border=\"0\">\n"
								<< "       </A>\n";
						}
					}
					else if(PhotoNumber == "2")
					{
						if(!strcmp(photo_2, "Nothing") || strlen(photo_2) < 1)
						{
							cout << "       <IMG ALT=\"Picture not available.\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_LARGE" ) << "\" width=\"180\" height=\"180\" border=\"0\">\n";
						}
						else	
						{
							cout << "       <A HREF=\"javascript:newWindow('" << Map.PrintValue( "PICTURES" ) << "/" << photo_2 << "')\">\n"
								<< "        <IMG ALT=\"View image 2 full size.\" src=\"" << Map.PrintValue( "PICTURES" ) << "/180x180_" << photo_2 << "\" width=\"180\" height=\"180\" border=\"0\">\n"
								<< "       </A>\n";
						}
					}
					else if(PhotoNumber == "3")
					{
						if(!strcmp(photo_3, "Nothing") || strlen(photo_3) < 1)
						{
							cout << "       <IMG ALT=\"Picture not available.\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_LARGE" ) << "\" width=\"180\" height=\"180\" border=\"0\">\n";
						}
						else	
						{
							cout << "       <A HREF=\"javascript:newWindow('" << Map.PrintValue( "PICTURES" ) << "/" << photo_3 << "')\">\n"
								<< "        <IMG ALT=\"View image 3 full size.\" src=\"" << Map.PrintValue( "PICTURES" ) << "/180x180_" << photo_3 << "\" width=\"180\" height=\"180\" border=\"0\">\n"
								<< "       </A>\n";
						}
					}
					else if(PhotoNumber == "4")
					{
						if(!strcmp(photo_4, "Nothing") || strlen(photo_4) < 1)
						{
							cout << "       <IMG ALT=\"Picture not available.\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_LARGE" ) << "\" width=\"180\" height=\"180\" border=\"0\">\n";
						}
						else	
						{
							cout << "       <A HREF=\"javascript:newWindow('" << Map.PrintValue( "PICTURES" ) << "/" << photo_4 << "')\">\n"
								<< "        <IMG ALT=\"View image 4 full size.\" src=\"" << Map.PrintValue( "PICTURES" ) << "/180x180_" << photo_4 << "\" width=\"180\" height=\"180\" border=\"0\">\n"
								<< "       </A>\n";
						}
					}
					else if(PhotoNumber == "5")
					{
						if(!strcmp(photo_5, "Nothing") || strlen(photo_5) < 1)
						{
							cout << "       <IMG ALT=\"Picture not available.\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_LARGE" ) << "\" width=\"180\" height=\"180\" border=\"0\">\n";
						}
						else	
						{
							cout << "       <A HREF=\"javascript:newWindow('" << Map.PrintValue( "PICTURES" ) << "/" << photo_5 << "')\">\n"
								<< "        <IMG ALT=\"View image 5 full size.\" src=\"" << Map.PrintValue( "PICTURES" ) << "/180x180_" << photo_5 << "\" width=\"180\" height=\"180\" border=\"0\">\n"
								<< "       </A>\n";
						}
					}
					cout << "     </FONT>\n"
						<< "    </CENTER>\n"
						<< "  </TD>\n"
						<< "</TR>\n"
						<< "\n"
						<< "<TR align=\"center\" valign=\"top\"> \n"
						<< "  <TD height=\"98\"> \n"
						<< "    <table width=\"87%\" border=\"0\" cellspacing=\"3\" cellpadding=\"3\">\n"
						<< "      <tr> \n";
					if(strcmp(photo_1, "Nothing") && strlen(photo_1) > 0)
						cout << "        <td width=\"40\" height=\"5\" align=\"left\" valign=\"top\"><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "&amp;picture_number=1\"><IMG ALT=\"View this photo of "  << user_name << ".\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60x60_" << photo_1 << "\" width=\"40\" height=\"40\" border=\"0\"></td>\n";
					if(strcmp(photo_2, "Nothing") && strlen(photo_2) > 0)
						cout << "        <td width=\"40\" height=\"5\" align=\"left\" valign=\"top\"><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "&amp;picture_number=2\"><IMG ALT=\"View this photo of "  << user_name << ".\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60x60_" << photo_2 << "\" width=\"40\" height=\"40\" border=\"0\"></td>\n";
					if(strcmp(photo_3, "Nothing") && strlen(photo_3) > 0)
						cout << "        <td width=\"40\" height=\"5\" align=\"left\" valign=\"top\"><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "&amp;picture_number=3\"><IMG ALT=\"View this photo of "  << user_name << ".\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60x60_" << photo_3 << "\" width=\"40\" height=\"40\" border=\"0\"></td>\n";
					cout << "      </tr>\n"
						<< "      <tr> \n";
					if(strcmp(photo_4, "Nothing") && strlen(photo_4) > 0)
						cout << "        <td width=\"40\" height=\"5\" align=\"left\" valign=\"top\"><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "&amp;picture_number=4\"><IMG ALT=\"View this photo of "  << user_name << ".\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60x60_" << photo_4 << "\" width=\"40\" height=\"40\" border=\"0\"></td>\n";
					if(strcmp(photo_5, "Nothing") && strlen(photo_5) > 0)
						cout << "        <td width=\"40\" height=\"5\" align=\"left\" valign=\"top\"><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "&amp;picture_number=5\"><IMG ALT=\"View this photo of "  << user_name << ".\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60x60_" << photo_5 << "\" width=\"40\" height=\"40\" border=\"0\"></td>\n";
					cout << "      </tr>\n"
						<< "    </table>\n"
						<< "	<TABLE width=\"180\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\">\n"
						<< "	  <TR>\n"
						<< "	    <TD>\n"
						<< "			<A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenSendMail.exe?user_name=" << user_name << "\"><IMG ALT=\"Send "  << user_name 
						<< " email.\" align=\"right\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LARGE_EMAILSYMBOL" ) << "\"></A>\n"
						<< "	    </TD>\n"
						<< "	  </TR>\n"
						<< "	  <TR>\n"
						<< "	    <TD>\n"
						<< "			<A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SendWink.exe?winked_at=" << user_name << "\"><IMG ALT=\"Let "  << user_name 
						<< " know you are interested by sending a free wink.\" align=\"right\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LARGE_WINKSYMBOL" ) << "\"></A>\n"
						<< "	    </TD>\n"
						<< "	  </TR>\n"
						<< "	  <TR>\n"
						<< "	    <TD>\n"
						<< "			<A href=\"" << Map.PrintValue( "CGIBIN" ) << "/UpdateBookMarks.exe?book_mark=" << user_name << "&add_remove=add\"><IMG ALT=\"Bookmark "  << user_name 
						<< ".\" align=\"right\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LARGE_BOOKMARKSYMBOL" ) << "\"></A>\n"
						<< "	    </TD>\n"
						<< "	  </TR>\n"
						<< "	</TABLE>\n"
						<< "  </TD>\n"
						<< "</TR>\n"
						<< "<TR>\n"
						<< "  <TD>&nbsp;</TD>\n"
						<< "</TR>\n"
						
						<< "<SCRIPT LANGUAGE=JAVASCRIPT TYPE=\"TEXT/JAVASCRIPT\">\n"
						<< "<!-- \n"
						<< "function newWindow(picName) \n"
						<< "{\n"
						<< "	var myWindow = window.open(picName, 'PicViewer', 'toolbar=no,location=no,scrollbars=yes,resizable=yes,width=500,height=700')\n"
						<< "	myWindow.focus()\n"
						<< "}\n"
						<< "// -->\n"
						<< "</SCRIPT>\n"
						<< "</TABLE>\n"
						<< "\n"
						<< "</DIV>\n"
						<< "</TD>\n"
						
						<< "<TD align=\"right\" valign=\"top\" width=\"266\" height=\"488\">\n"
						<< "<DIV align=\"left\">\n"
						<< "<TABLE border=\"0\" cellpadding=\"4\" width=\"100%\" cellspacing=\"0\" align=\"left\">\n"
						
						<< "<tr> \n"
						<< "  <td colspan=\"2\" valign=\"top\"> \n"
						<< "    <p align=\"left\"><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << screen_quote << "</font></p>\n"
						<< "  </td>\n"
						<< "</tr>\n"
						<< "<tr> </tr>\n"
						<< "<tr> </tr>\n"
						<< "<tr> \n"
						<< "  <td align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">Sex:</font></td>\n"
						<< "  <td align=\"Left\" width=\"50%\" nowrap> \n"
						<< "    <div align=\"left\"><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << sex << "</font></div>\n"
						<< "  </td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">Age:</font></td>\n"
						<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << age << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">City:</font></td>\n"
						<< "  <td align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << city << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">State:</font></td>\n"
						<< "  <td align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << state << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td  align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">Country:</font></td>\n"
						<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << country << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td  align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">Profession:</font></td>\n"
						<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << profession << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td  align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">Income:</font></td>\n"
						<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << income << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td  align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">Education:</font></td>\n"
						<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << education << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td  align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">Religion:</font></td>\n"
						<< "  <td align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << religion << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">Height:</font></td>\n"
						<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << height << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td  align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">Weight:</font></td>\n"
						<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << weight << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td  align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">Eyes:</font></td>\n"
						<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << eyes << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td  align=\"Right\" width=\"50%\" nowrap><font size=\"2\" color=\"#800000\" face=\"Arial, Helvetica, sans-serif\">Hair:</font></td>\n"
						<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << hair << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td  align=\"Right\" width=\"50%\" nowrap><font size=\"2\" color=\"#800000\" face=\"Arial, Helvetica, sans-serif\">Seeking Ages:</font></td>\n"
						<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << min_age_desired << " to " << max_age_desired << "</font></td>\n"
						<< "</tr>\n"
						<< "<tr> \n"
						<< "  <td  align=\"Right\" width=\"50%\" nowrap height=\"21\"><font size=\"2\" color=\"#800000\" face=\"Arial, Helvetica, sans-serif\">Relationship:</font></td>\n"
						<< "  <td  align=\"Left\" width=\"50%\" nowrap height=\"21\"><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">";
						
						if( !strcmp(prefer_not_to_say, "1") )
							cout << "Prefer Not To Say<BR>" ;
						if( !strcmp(any_relationship, "1") )
							cout << "Any Relationship<BR>" ;
						if( !strcmp(hang_out, "1") )
							cout << "Hang Out<BR>" ;
						if( !strcmp(short_term, "1") )
							cout << "Short Term<BR>" ;
						if( !strcmp(long_term, "1") )
							cout << "Long Term<BR>" ;
						if( !strcmp(talk_email, "1") )
							cout << "Talk/Email<BR>" ;
						if( !strcmp(photo_exchange, "1") )
							cout << "Photo Exchange<BR>" ;
						if( !strcmp(marriage, "1") )
							cout << "Marriage<BR>" ;
						if( !strcmp(other, "1") )
							cout << "Other" ;
						cout << "</FONT></TD>\n"
							
							<< "</tr>\n"
							<< "<tr> \n"
							<< "  <td  align=\"Right\" width=\"50%\" nowrap><font size=\"2\" color=\"#800000\" face=\"Arial, Helvetica, sans-serif\">Do I like to cook?</font></td>\n"
							<< "  <td align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << cook << "</font></td>\n"
							<< "</tr>\n"
							<< "<tr> \n"
							<< "  <td align=\"Right\" width=\"50%\" nowrap><font size=\"2\" color=\"#800000\" face=\"Arial, Helvetica, sans-serif\">Do I smoke?</font></td>\n"
							<< "  <td align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << smoke << "</font></td>\n"
							<< "</tr>\n"
							<< "<tr> \n"
							<< "  <td  align=\"Right\" width=\"50%\" nowrap><font size=\"2\" color=\"#800000\" face=\"Arial, Helvetica, sans-serif\">Do I drink?</font></td>\n"
							<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << drink << "</font></td>\n"
							<< "</tr>\n"
							<< "<tr> \n"
							<< "  <td align=\"Right\" width=\"50%\" nowrap><font color=\"#800000\" size=\"2\" face=\"Arial, Helvetica, sans-serif\">How much do I party?</font></td>\n"
							<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << party << "</font></td>\n"
							<< "</tr>\n"
							<< "<tr> \n"
							<< "  <td  align=\"Right\" width=\"50%\" nowrap><font size=\"2\" color=\"#800000\" face=\"Arial, Helvetica, sans-serif\">Political Views:</font></td>\n"
							<< "  <td align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << political << "</font></td>\n"
							<< "</tr>\n"
							<< "<tr> \n"
							<< "  <td align=\"Right\" width=\"50%\" nowrap><font size=\"2\" color=\"#800000\" face=\"Arial, Helvetica, sans-serif\">Living Arrangements:</font></td>\n"
							<< "  <td  align=\"Left\" width=\"50%\" nowrap><font size=\"2\" color=\"#000000\" face=\"Arial, Helvetica, sans-serif\">" << housing_status << "</font></td>\n"
							<< "</tr>\n"
							
							
							<< "\n"
							<< "<TR>\n"
							<< "<TD bgcolor=\"" << Map.PrintValue("HTML_BODY_BGCOLOR") << "\" align=\"Right\" width=\"135\" valign=\"top\">&nbsp;</TD>\n"
							<< "<TD bgcolor=\"" << Map.PrintValue("HTML_BODY_BGCOLOR") << "\" align=\"Left\" width=\"111\" valign=\"top\">&nbsp;</TD>\n"
							<< "</TR>\n"
							<< "\n"
							<< "<TR>\n"
							<< "<TD colspan=\"2\" align=\"CENTER\" valign=\"top\" width=\"248\"></TD>\n"
							<< "</TR>\n"
							<< "\n"
							<< "<TR>\n"
							<< "<TD colspan=\"2\" valign=\"top\" align=\"Center\" width=\"248\"></TD>\n"
							<< "</TR>\n"
							<< "</TABLE>\n"
							<< "</DIV>\n"
							<< "</TD>\n"
							<< "</TR>\n"
							<< "\n"
							
							<< "<TR>\n"
							<< "  <TD colspan=\"2\" cellpadding=\"4\" valign=\"TOP\" width=\"468\" height=\"40\" align=\"left\"><FONT size=\"2\"> \n"
							<< "    <font face=\"Arial, Helvetica, sans-serif\">" << Replace_Returns_With_Breaks(about_yourself) << "</font></FONT> \n"
							<< "  </TD>\n"
							<< "</TR>\n"
/*
							<< "<TR>\n"
							<< "  <TD align=\"right\" valign=\"top\" width=\"40\">\n"
							<< "    <DIV align=\"right\">\n"
							<< "      <FONT color=\"#666666\" face=\"Arial, Hevetica\" size=\"-2\">contact&nbsp;" << user_name << "</FONT>\n"
							<< "       <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenSendMail.exe?user_name=" << user_name << "\"><IMG ALT=\"Send "  << user_name 
							<< " email.\" align=\"right\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "EMAILSYMBOL" ) << "\"></A>\n"
							<< "    </DIV>\n"
							<< "  </TD>\n"
							<< "  <TD align=\"right\" valign=\"top\" width=\"40\">\n"
							<< "    <DIV align=\"right\">\n"
							<< "      <FONT color=\"#666666\" face=\"Arial, Hevetica\" size=\"-2\">Bookmark&nbsp;" << user_name << "</FONT>\n"
							<< "       <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/UpdateBookMarks.exe?book_mark=" << user_name << "&add_remove=add\"><IMG ALT=\"Bookmark "  << user_name 
							<< ".\" align=\"right\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "BOOKMARKSYMBOL" ) << "\"></A>\n"
							<< "    </DIV>\n"
							<< " </TD>\n"
							<< "</TR>\n"
*/
							<< "</TABLE>\n"
							<< "</DIV>\n"
							<< "\n"
							<< "<P>&nbsp;</P>\n"
							<< flush;
				}
				else
				{
					cout << "ERROR:	This should never happen.  " << program_name << " is the name of the calling program\n";
				}
				
			}// end while (dbnextrow(DbProc) != NO_MORE_ROWS)
			
		}// end if(dbresults(DbProc)) 
		
	}// end if(Global_DBSuccess)
	else
	{
		// Get the HTML Top along with the Text Ad Delivery Code...
		cfl.Html_Begin(Map, 1, SINGLE_PROFILE, "0");
	}

	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";

	// Close the connection to SQL Server
	dbexit(); 
	if(!Global_DBSuccess)
	{
		return Global_DBSuccess;
	}
	else
	{
		return rc;
	}
} // SingleSearch_The_DB 

bool
DB_Table_Base::GenHome_The_DB(LinkMap & Map)
{
	CConnectionsFormLayout cfl;
	Global_DBSuccess = true;
	
	char user_name					[USER_NAME				];
	char membership_type			[MEMBERSHIP_TYPE		];
	char membership_type_name		[MEMBERSHIP_TYPE_NAME	];
	char photo_submitted			[PHOTO_SUBMITTED		];
	char email_verification_code	[EMAIL_VERIFICATION_CODE];
	char is_email_verified			[IS_EMAIL_VERIFIED		];
	char affiliate_action_status	[AFFILIATE_ACTION_STATUS];
	char affiliate_tracking_id		[AFFILIATE_TRACKING_ID	];
	char questionable				[QUESTIONABLE			];
	char promo_days_remaining		[8						];
	char is_membership_active		[IS_MEMBERSHIP_ACTIVE	];
	char premium_days_remaining		[8						];
	char search_unique_id			[SEARCH_UNIQUE_ID		];
	
	
	char mail_id					[MAIL_ID				];
	char sent_to					[SENT_TO				];
	char sent_from					[SENT_FROM				];
	char subject					[SUBJECT				];
	char message_text				[MESSAGE_TEXT			];
	char when_sent					[WHEN_SENT				];
	char when_read					[WHEN_READ				];
	char sender_deleted				[SENDER_DELETED			];
	char receiver_deleted			[RECEIVER_DELETED		];
	
	memset(user_name					, USER_NAME					, NULL);
	memset(membership_type				, MEMBERSHIP_TYPE			, NULL);
	memset(membership_type_name			, MEMBERSHIP_TYPE_NAME		, NULL);
	memset(photo_submitted				, PHOTO_SUBMITTED			, NULL);
	memset(email_verification_code		, EMAIL_VERIFICATION_CODE	, NULL);
	memset(is_email_verified			, IS_EMAIL_VERIFIED			, NULL);
	memset(affiliate_action_status		, AFFILIATE_ACTION_STATUS	, NULL);
	memset(affiliate_tracking_id		, AFFILIATE_TRACKING_ID		, NULL);
	memset(questionable					, QUESTIONABLE				, NULL);
	memset(promo_days_remaining			, 8							, NULL);
	memset(is_membership_active			, IS_MEMBERSHIP_ACTIVE		, NULL);
	memset(premium_days_remaining		, 8							, NULL);
	memset(search_unique_id				, SEARCH_UNIQUE_ID			, NULL);

	memset(mail_id						, MAIL_ID					, NULL);
	memset(sent_to						, SENT_TO					, NULL);
	memset(sent_from					, SENT_FROM					, NULL);
	memset(subject						, SUBJECT					, NULL);
	memset(message_text					, MESSAGE_TEXT				, NULL);
	memset(when_sent					, WHEN_SENT					, NULL);
	memset(when_read					, WHEN_READ					, NULL);
	memset(sender_deleted				, SENDER_DELETED			, NULL);
	memset(receiver_deleted				, RECEIVER_DELETED			, NULL);
	
	// define a string to hold the desired value of the user's profile.
	string HideUnhide("");

	bool rc = this->Initialize_DbProc(Map);
	
	dout << "<!-- Initialize_DbProc returned (" << rc << ") -->\n" << flush;
/*
	if(rc == 0)
	{
		DB_Table_Base_Error_Number = -1;
		DB_Table_Base_Error_Text = "Database Error.  Contact <FONT color=\"red\">" + Map.PrintValue( "EMAIL" ) + "</FONT> for assistence with this problem.\n\n<!-- ########### Check DB username and password. ########### -->\n\n";
		return false;
	}
*/

	// First, put the command into the command buffer.
	dbcmd( DbProc, const_cast<char *>(update_info_sql.c_str()) ); 

	// Send the command to SQL Server and start execution
	dbsqlexec(DbProc);

	// Set DB_Table_Base class internal varaibles
	DB_Table_Base_Error_Number = dbretstatus ( DbProc );
	dout << "<!-- DB_Table_Base_Error_Number = (" << DB_Table_Base_Error_Number << ") -->\n";
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";
	
	if(Global_DBSuccess)
	{
		// Process the command
		// Get the actual data that is contained in the table itself
		
		int count_unread = 0;
		int count_receiver_deleted = 0;
		
		if(dbresults(DbProc)) 
		{
			::dbbind( DbProc,  1,  NTBSTRINGBIND, USER_NAME						, (BYTE *)( user_name					) );
			::dbbind( DbProc,  2,  NTBSTRINGBIND, MEMBERSHIP_TYPE				, (BYTE *)( membership_type				) );
			::dbbind( DbProc,  3,  NTBSTRINGBIND, MEMBERSHIP_TYPE_NAME			, (BYTE *)( membership_type_name		) );
			::dbbind( DbProc,  4,  NTBSTRINGBIND, PHOTO_SUBMITTED				, (BYTE *)( photo_submitted				) );
			::dbbind( DbProc,  5,  NTBSTRINGBIND, EMAIL_VERIFICATION_CODE		, (BYTE *)( email_verification_code		) );
			::dbbind( DbProc,  6,  NTBSTRINGBIND, IS_EMAIL_VERIFIED				, (BYTE *)( is_email_verified			) );
			::dbbind( DbProc,  7,  NTBSTRINGBIND, AFFILIATE_TRACKING_ID			, (BYTE *)( affiliate_tracking_id		) );
			::dbbind( DbProc,  8,  NTBSTRINGBIND, AFFILIATE_ACTION_STATUS		, (BYTE *)( affiliate_action_status		) );
			::dbbind( DbProc,  9,  NTBSTRINGBIND, QUESTIONABLE					, (BYTE *)( questionable				) );
			::dbbind( DbProc, 10,  NTBSTRINGBIND, 8								, (BYTE *)( promo_days_remaining		) );
			::dbbind( DbProc, 11,  NTBSTRINGBIND, IS_MEMBERSHIP_ACTIVE			, (BYTE *)( is_membership_active		) );
			::dbbind( DbProc, 12,  NTBSTRINGBIND, 8								, (BYTE *)( premium_days_remaining		) );
			::dbbind( DbProc, 13,  NTBSTRINGBIND, SEARCH_UNIQUE_ID				, (BYTE *)( search_unique_id			) );
			
			// begin the result set with some return info...
			while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			{ 
				rc = true;
			} 
		}
		// Get the HTML Top along with the Text Ad Delivery Code...
		cfl.Html_Begin(Map, 1, GEN_HOME, search_unique_id);

		if(dbresults(DbProc)) 
		{
			::dbbind( DbProc, 1,  NTBSTRINGBIND, MAIL_ID			, (BYTE *)( mail_id			) );
			::dbbind( DbProc, 2,  NTBSTRINGBIND, SENT_TO			, (BYTE *)( sent_to			) );
			::dbbind( DbProc, 3,  NTBSTRINGBIND, SENT_FROM			, (BYTE *)( sent_from		) );
			::dbbind( DbProc, 4,  NTBSTRINGBIND, SUBJECT			, (BYTE *)( subject			) );
			::dbbind( DbProc, 5,  NTBSTRINGBIND, MESSAGE_TEXT		, (BYTE *)( message_text	) );
			::dbbind( DbProc, 6,  NTBSTRINGBIND, WHEN_SENT			, (BYTE *)( when_sent		) );
			::dbbind( DbProc, 7,  NTBSTRINGBIND, WHEN_READ			, (BYTE *)( when_read		) );
			::dbbind( DbProc, 8,  NTBSTRINGBIND, SENDER_DELETED		, (BYTE *)( sender_deleted	) );
			::dbbind( DbProc, 9,  NTBSTRINGBIND, RECEIVER_DELETED	, (BYTE *)( receiver_deleted) );
			
			// begin the result set with some return info...
			while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			{ 
				//dout << "strlen(" << strlen(when_read) << ")\n" ;
				if( !strcmp(receiver_deleted, "0") )
				{
					if(strlen(when_read) < 2)
					{
						count_unread++;
					}
				}
				else
				{
					count_receiver_deleted++;
				}
				
			} 
		}
		if( !strcmp(questionable, "0") )
		{
			HideUnhide = "Hide";
			dout << "\n<!-- Hide questionable = (" << questionable << ") -->\n";
			dout << "\n<!--		   HideUnhide = (" << HideUnhide << ") -->\n";
		}
		else
		{
			HideUnhide = "Unhide";
			dout << "\n<!-- Unhide questionable = (" << questionable << ") -->\n";
			dout << "\n<!--			 HideUnhide = (" << HideUnhide << ") -->\n";
		}
		cout << "          <TABLE border=\"0\" cellspacing=\"3\" cellpadding=\"3\" width=\"100%\">\n"
			<< "            <TR>\n"
			<< "              <TD height=\"40\" width=\"180\" align=\"left\" valign=\"middle\">\n"
			<< "                <DIV align=\"left\">\n"
			<< "                  <FONT color=\"#000000\"><STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"3\">Welcome </FONT></STRONG></FONT> <FONT face=\"Arial, Helvetica, sans-serif\" size=\"3\"><STRONG> " << user_name << "</STRONG></FONT>\n"
			<< "                </DIV>\n"
			<< "              </TD>\n"
			<< "              <TD height=\"40\" colspan=\"2\" align=\"left\" valign=\"middle\">\n"
			<< "                <DIV align=\"left\">\n";
		// show the become member link only if the user is NOT a membership_type 1 or 2
		if( !( !strcmp(membership_type, "1") || !strcmp(membership_type, "2") ) && !strcmp(is_email_verified, "1") )
		{
			cout << "                  <A href=\"" << Map.PrintValue( "ROOT" ) << "/PaymentOptions.html\"><IMG alt=\"Become a member now.\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "BECOME_PREMIUM_MEMBER" ) << "\" border=\"0\"></A>\n";
		}
		
		cout << "                </DIV>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD height=\"130\" width=\"180\" valign=\"top\">\n"
			<< "                <TABLE width=\"100%\" border=\"2\" cellspacing=\"0\" cellpadding=\"0\" bordercolor=\"#CCCCCC\">\n"
			<< "                  <TR valign=\"top\">\n"
			<< "                    <TD height=\"235\">\n"
			<< "                      <TABLE border=\"0\" width=\"100%\" cellspacing=\"3\" cellpadding=\"3\">\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><STRONG><FONT color=\"#000000\"><U><FONT size=\"3\">Search...</FONT></U></FONT></STRONG></FONT>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "ROOT" ) << "/SimpleSearch.html\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Simple Search</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "ROOT" ) << "/AdvancedSearch.html\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Advanced Search</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><STRONG><FONT color=\"#000000\"><U><FONT size=\"3\">Hide/Unhide...</FONT></U></FONT></STRONG></FONT>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n";
		
		// show the update billing info link only if the user IS a membership_type 1 or 2
		if( HideUnhide == "Unhide" )
		{
			cout << "                        <TR>\n"
				<< "                        <TR>\n"
				<< "                          <TD NOWRAP>\n"
				<< "                            <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"red\"><STRONG>Profile Is Hidden!!</STRONG></FONT>\n"
				<< "                          </TD>\n"
				<< "                        </TR>\n";
		}
		cout << "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/HideUnhideProfile.exe\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">" << HideUnhide << " my profile...</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n";
		
		// show the update billing info link only if the user IS a membership_type 1 or 2
		if( !strcmp(membership_type, "1") || !strcmp(membership_type, "2") )
		{
			cout << "                        <TR>\n"
				<< "                          <TD NOWRAP height=\"30\">\n"
				<< "                            <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><STRONG><FONT color=\"#000000\"><U><FONT size=\"3\">Credit Card Info...</FONT></U></FONT></STRONG></FONT>\n"
				<< "                          </TD>\n"
				<< "                        </TR>\n"
				<< "                        <TR>\n"
				<< "                          <TD NOWRAP height=\"30\">\n"
				<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/UpdateBilling.exe\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Update Card Info...</FONT></A>\n"
				<< "                          </TD>\n"
				<< "                        </TR>\n";
		}
		
		cout << "                      </TABLE>\n"
			<< "                    </TD>\n"
			<< "                  </TR>\n"
			<< "                </TABLE>\n"
			<< "              </TD>\n"
			<< "              <TD height=\"130\" width=\"150\" valign=\"top\">\n"
			<< "                <TABLE width=\"100%\" border=\"2\" cellspacing=\"0\" cellpadding=\"0\" bordercolor=\"#CCCCCC\">\n"
			<< "                  <TR valign=\"top\">\n"
			<< "                    <TD height=\"236\">\n"
			<< "                      <TABLE border=\"0\" width=\"100%\" cellspacing=\"3\" cellpadding=\"3\">\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT color=\"#000000\"><U><FONT size=\"3\">View Mail...</FONT></U></FONT></STRONG></FONT>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenInbox.exe\">";
		// Display the unread messages count...
		if (count_unread > 0)
		{
			cout << "<FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">Inbox</FONT></A>&nbsp;(&nbsp;<FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\" color=\"red\">" << count_unread << "</FONT>&nbsp;)&nbsp;</FONT>\n";
		}
		else
		{
			cout << "<FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">Inbox</FONT></A> \n";
		}
		
		cout << "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenOutbox.exe\"><FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">Outbox</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
/*
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                          &nbsp;</TD>\n"
			<< "                        </TR>\n"
*/
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT color=\"#000000\"><U><FONT size=\"3\">View BookMarks...</FONT></U></FONT></STRONG></FONT>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenBookMarks.exe\"><FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">BookMarks</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
/*
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                          &nbsp;</TD>\n"
			<< "                        </TR>\n"
*/
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT color=\"#000000\"><U><FONT size=\"3\">View Winks...</FONT></U></FONT></STRONG></FONT>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/ViewWinks.exe\"><FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">Winks</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                      </TABLE>\n"
			<< "                    </TD>\n"
			<< "                  </TR>\n"
			<< "                </TABLE>\n"
			<< "              </TD>\n"
			<< "              <TD height=\"130\" width=\"164\" valign=\"top\">\n"
			<< "                <TABLE width=\"100%\" border=\"2\" cellspacing=\"0\" cellpadding=\"0\" bordercolor=\"#CCCCCC\">\n"
			<< "                  <TR>\n"
			<< "                    <TD height=\"236\">\n"
			<< "                      <TABLE border=\"0\" width=\"100%\" cellspacing=\"3\" cellpadding=\"3\">\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <FONT color=\"#000000\" face=\"Arial, Helvetica, sans-serif\" size=\"2\"><STRONG><U><FONT size=\"3\">Update Profile...</FONT></U></STRONG></FONT>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/ManageEmailVerification.cgi\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Update/Verify Email</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/UpdateLogin.exe\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Update Login Info</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/UpdateContact.exe\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Update Contact Info</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/UpdatePersonal.exe\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Update Personal Info</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/UpdateAbout.exe\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Update Screen Quote</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenPicUpload.exe\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Manage Your Pictures</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                        <TR>\n"
			<< "                          <TD NOWRAP height=\"30\">\n"
			<< "                            <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">View Your Profile</FONT></A>\n"
			<< "                          </TD>\n"
			<< "                        </TR>\n"
			<< "                      </TABLE>\n"
			<< "                    </TD>\n"
			<< "                  </TR>\n"
			<< "                </TABLE>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD height=\"69\" colspan=\"3\">\n"
			<< "                <TABLE width=\"349\" border=\"0\" cellspacing=\"3\" cellpadding=\"3\">\n"
			<< "                  <TR>\n"
			<< "                    <TD NOWRAP>\n"
			<< "                      <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\"><STRONG>My Membership Type:</STRONG><FONT color=\"#FF0033\"> " << membership_type_name << " </FONT></FONT><BR>\n";

		// display premium_days_remaining if applicable...
		if( strcmp(premium_days_remaining, "") )
			cout << "                     <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\"><FONT color=\"#9933FF\">Only " << premium_days_remaining << " days remaining in your \"" << membership_type_name << "\" membership!</FONT></FONT><BR>\n";
		// display promo_days_remaining if applicable...
		else if( strcmp(promo_days_remaining, "") )
			cout << "                     <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\"><FONT color=\"#9933FF\">Only " << promo_days_remaining << " days remaining in your \"" << membership_type_name << "\" membership!</FONT></FONT><BR>\n";
		else
		{
			cout << "                     <!-- premium_days_remaining = (" << premium_days_remaining << ") -->\n";
			cout << "                     <!-- promo_days_remaining   = (" << promo_days_remaining << ") -->\n";
		}
		// Paying Members & Formally Paying Members...
		// show the current membership_type only if the user IS a membership_type 1 or 2
//		if( ( !strcmp(membership_type, "1") || !strcmp(membership_type, "2") ) && !strcmp(premium_days_remaining, ""))
		if( strcmp(membership_type, "0") && !strcmp(premium_days_remaining, "") )
		{
			cout << "                     <A href=\"" << Map.PrintValue( "ROOT" ) << "/CancelMembership.html\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"-2\"><FONT color=\"#3F4958\">Cancel " << membership_type_name << " Membership...</FONT></FONT></A><BR>\n";
		}
		else
		{
			cout << "                     <!-- membership_type = (" << membership_type << ") -->\n";
		}

		cout << "                    </TD>\n";
		
		// NON-Paying Members...
		// show the become member link only if the user is NOT a membership_type 1 or 2 and email has been verified
//		if( !( !strcmp(membership_type, "1") || !strcmp(membership_type, "2") ) && !strcmp(is_email_verified, "1") )
		if( !strcmp(membership_type, "0") && !strcmp(is_email_verified, "1") )
		{
			cout << "                    <TD align=\"left\">\n"
				<< "                      <A href=\"" << Map.PrintValue( "ROOT" ) << "/PaymentOptions.html\"><FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "BECOME_MEMBER_GIF" ) << "\" border=\"0\"></FONT></A>\n"
				<< "                    </TD>\n";
		}
		else if( strcmp(premium_days_remaining, "") && !strcmp(is_email_verified, "1") )
		{
			cout << "                    <TD align=\"left\">\n"
				<< "                      <A href=\"" << Map.PrintValue( "ROOT" ) << "/PaymentOptions.html\"><FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\"><IMG src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "BECOME_MEMBER_GIF" ) << "\" border=\"0\"></FONT></A>\n"
				<< "                    </TD>\n";
		}
		cout << "                  </TR>\n"
			<< "                  <TR>\n"
			<< "                    <TD NOWRAP>\n"
			<< "                        <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"2\">My Photo Status:</FONT></STRONG> \n";
		if( !strcmp(photo_submitted, "0") )
		{
			cout << "					<FONT size=\"2\"><FONT color=\"#FF0033\">Photo Not Posted </FONT><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenPicUpload.exe\">Update my Photo</A></FONT>\n";
		}
		else
		{
			cout << "					<FONT size=\"2\"><FONT color=\"#FF0033\">Photo Posted</FONT></FONT>\n";
		}
		
		cout << "                    </TD>\n"
			<< "                  </TR>\n"
			<< "                  <TR>\n"
			<< "                    <TD NOWRAP>\n"
			<< "                        <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG><FONT size=\"2\">My Email Status:</FONT></STRONG> \n";
		if( !strcmp(is_email_verified, "0") )
		{
			cout << "					<FONT size=\"2\"><FONT color=\"#FF0033\">Not Verified </FONT><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/ManageEmailVerification.cgi\">Change/Verify My Email Address</A></FONT><BR>\n";
			cout << "                   <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\"><FONT color=\"#9933FF\">To access all the features of " << Map.PrintValue( "WHICH_CONNECTIONS" ) << " you must first verify your email address.</FONT></FONT>\n";
		}
		else
		{
			cout << "					<FONT size=\"2\"><FONT color=\"#FF0033\">Verified</FONT></FONT>\n";
		}
		
		cout << "                    </TD>\n"
			<< "                  </TR>\n"
			<< "                </TABLE>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "          </TABLE>\n"
			<< endl << flush;
		
		rc = true;
	}
	else
	{
		// Get the HTML Top along with the Text Ad Delivery Code...
		cfl.Html_Begin(Map, 1, GEN_HOME, "0");
	}
	
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";

	// Close the connection to SQL Server
	dbexit(); 
	if(!Global_DBSuccess)
	{
		return Global_DBSuccess;
	}
	else
	{
		return rc;
	}
} // GenHome_The_DB

bool
DB_Table_Base::GenPicUpload_The_DB(LinkMap & Map)
{ 
	CConnectionsFormLayout cfl;
	Global_DBSuccess = true;
	
	char user_name			[USER_NAME			];
	char photo_1			[PHOTO_1			];
	char photo_2			[PHOTO_2			];
	char photo_3			[PHOTO_3			];
	char photo_4			[PHOTO_4			];
	char photo_5			[PHOTO_5			];
	char search_unique_id	[SEARCH_UNIQUE_ID	];
	
	
	memset(user_name		, USER_NAME			, NULL);
	memset(photo_1			, PHOTO_1			, NULL);
	memset(photo_2			, PHOTO_2			, NULL);
	memset(photo_3			, PHOTO_3			, NULL);
	memset(photo_4			, PHOTO_4			, NULL);
	memset(photo_5			, PHOTO_5			, NULL);
	memset(search_unique_id	, SEARCH_UNIQUE_ID	, NULL);
	
	bool rc = this->Initialize_DbProc(Map);
	
	dout << "<!-- Initialize_DbProc returned (" << rc << ") -->\n" << flush;
/*
	if(rc == 0)
	{
		DB_Table_Base_Error_Number = -1;
		DB_Table_Base_Error_Text = "Database Error.  Contact <FONT color=\"red\">" + Map.PrintValue( "EMAIL" ) + "</FONT> for assistence with this problem.\n\n<!-- ########### Check DB username and password. ########### -->\n\n";
		return false;
	}
*/

	// First, put the command into the command buffer.
	dbcmd( DbProc, const_cast<char *>(update_info_sql.c_str()) ); 
	
	//dout << "pre dbsqlexec" << endl;
	// Send the command to SQL Server and start execution
	dbsqlexec(DbProc);

	// Set DB_Table_Base class internal varaibles
	DB_Table_Base_Error_Number = dbretstatus ( DbProc );
	dout << "<!-- DB_Table_Base_Error_Number = (" << DB_Table_Base_Error_Number << ") -->\n";
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";
	
	//dout << "post dbsqlexec" << endl;
	if(Global_DBSuccess)
	{
		// Process the command
		// Get the actual data that is contained in the table itself
		
		if(dbresults(DbProc)) 
		{
			::dbbind( DbProc, 1,  NTBSTRINGBIND, USER_NAME			, (BYTE *)( user_name		) );
			::dbbind( DbProc, 2,  NTBSTRINGBIND, PHOTO_1			, (BYTE *)( photo_1			) );
			::dbbind( DbProc, 3,  NTBSTRINGBIND, PHOTO_2			, (BYTE *)( photo_2			) );
			::dbbind( DbProc, 4,  NTBSTRINGBIND, PHOTO_3			, (BYTE *)( photo_3			) );
			::dbbind( DbProc, 5,  NTBSTRINGBIND, PHOTO_4			, (BYTE *)( photo_4			) );
			::dbbind( DbProc, 6,  NTBSTRINGBIND, PHOTO_5			, (BYTE *)( photo_5			) );
			::dbbind( DbProc, 7,  NTBSTRINGBIND, SEARCH_UNIQUE_ID	, (BYTE *)( search_unique_id) );
			
			// begin the result set with some return info...
			while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			{ 
				//dout << "strlen(" << strlen(when_read) << ")\n" ;
			} 
			// Get the HTML Top along with the Text Ad Delivery Code...
			cfl.Html_Begin(Map, 1, GEN_PIC_UPLOAD, search_unique_id);
		}
		cout << "          <TABLE width=\"100%\" border=\"0\" cellspacing=\"3\" cellpadding=\"3\">\n"
			<< "            <TR>\n"
			<< "              <TD>\n"
			<< "                <IMG ALT=\"Manage Photos.\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/section_names_manage_photos.gif\">\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD>\n"
			<< "                <IMG ALT=\"Pleas post a photo.\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "UPLOADPIC" ) << "\">\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD>\n"
			<< "                <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><STRONG>Instructions for uploading pictures-</STRONG></FONT>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD>\n"
			<< "                <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">1) Click the \"Browse...\" button to select a .gif or .jpeg image file that you put on your computer.</FONT>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD>\n"
			<< "                <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">2) Choose the file that you would like by clicking on it. The file should become highlighted.</FONT>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD>\n"
			<< "                <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">3) Click on the \"Open\" button. You will see the name of the photo you selected in the \"Picture Name\" field.</FONT>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD>\n"
			<< "                <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">4) Choose where you would like the photo to appear on your profile by pulling down the \"Replace\" list and &nbsp; choose either \"Main Photo, Photo #2, Photo #3, Photo #4, Photo #5.\"</FONT>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD>\n"
			<< "                <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">5) Click on the \"Replace Photo\" button to upload the file.</FONT>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD>\n"
			<< "                <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">6) You will receive a confirmation that should say \"Your picture has ben added to your profile.\"</FONT>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD>\n"
			<< "                <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">7) Press the back button and reload the page to see how your photo looks.</FONT>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "          </TABLE>\n"
			<< "          <TABLE width=\"100%\" border=\"0\" cellspacing=\"3\" cellpadding=\"3\">\n"
			<< "            <TR>\n"
			<< "              <TD height=\"2\">\n"
			<< "                <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\">Please try to keep your photos small (no more than 220 pixels or 3 inches wide) Note: We remove any images which are <STRONG>not</STRONG> photos of people.</FONT>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD height=\"14\">\n"
			<< "                &nbsp;\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD>\n"
			<< "                <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">If you are not able to upload your photos in electronic format, please send your photo along with your user name and a check for $15 payable to :</FONT>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "            <TR>\n"
			<< "              <TD>\n"
			<< "                <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">" << Map.PrintValue( "WHICH_CONNECTIONS" ) << ".com\n"
			<< "                <BR>\n"
			<< "                 116 Willow Ave., Suite 4\n"
			<< "                <BR>\n"
			<< "                 Hoboken, NJ 07030</FONT>\n"
			<< "              </TD>\n"
			<< "            </TR>\n"
			<< "          </TABLE>\n"
			<< "          <P>\n"
			<< "             <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">If you need your photo back, please include a self-addressed-stamped-envelope.</FONT>\n"
			<< "          </P>\n"
			
			
			<< "                 \n"
			<< "           <FORM enctype=\"multipart/form-data\" method=\"POST\" action=\"" << Map.PrintValue( "CGIBIN" ) << "/UploadPicture.cgi\">\n"
			<< "            <TABLE align=\"center\">\n"
			<< "              <TR>\n";
		
		if(!strcmp(photo_1, "Nothing") || strlen(photo_1) < 1)
			cout << "			<TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "				<IMG ALT=\"Picture of person 1 not available\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_SMALL" ) << "\" width=\"60\" height=\"60\">\n</TD>\n";
		else
			cout << "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  <IMG ALT=\"Picture of person 1\" border=\"0\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60x60_" << photo_1 << "\" width=\"60\" height=\"60\">\n"
			<< "				<INPUT type=\"hidden\" name=\"photo_1\" value=\"" << photo_1 << "\">\n</TD>\n";
		if(!strcmp(photo_2, "Nothing") || strlen(photo_2) < 1)
			cout << "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  <IMG ALT=\"Picture of person 2 not available\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_SMALL" ) << "\" width=\"60\" height=\"60\">\n</TD>\n";
		else
			cout << "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  <IMG ALT=\"Picture of person 2\" border=\"0\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60x60_" << photo_2 << "\" width=\"60\" height=\"60\">\n"
			<< "				<INPUT type=\"hidden\" name=\"photo_2\" value=\"" << photo_2 << "\">\n</TD>\n";
		if(!strcmp(photo_3, "Nothing") || strlen(photo_3) < 1)
			cout << "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  <IMG ALT=\"Picture of person 3 not available\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_SMALL" ) << "\" width=\"60\" height=\"60\">\n</TD>\n";
		else
			cout << "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  <IMG ALT=\"Picture of person 3\" border=\"0\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60x60_" << photo_3 << "\" width=\"60\" height=\"60\">\n"
			<< "				<INPUT type=\"hidden\" name=\"photo_3\" value=\"" << photo_3 << "\">\n</TD>\n";
		if(!strcmp(photo_4, "Nothing") || strlen(photo_4) < 1)
			cout << "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  <IMG ALT=\"Picture of person 4 not available\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_SMALL" ) << "\" width=\"60\" height=\"60\">\n</TD>\n";
		else
			cout << "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  <IMG ALT=\"Picture of person 4\" border=\"0\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60x60_" << photo_4 << "\" width=\"60\" height=\"60\">\n"
			<< "				<INPUT type=\"hidden\" name=\"photo_4\" value=\"" << photo_4 << "\">\n</TD>\n";
		if(!strcmp(photo_5, "Nothing") || strlen(photo_5) < 1)
			cout << "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  <IMG ALT=\"Picture of person 5 not available\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_SMALL" ) << "\" width=\"60\" height=\"60\">\n</TD>\n";
		else
			cout << "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  <IMG ALT=\"Picture of person 5\" border=\"0\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60x60_" << photo_5 << "\" width=\"60\" height=\"60\">\n"
			<< "				<INPUT type=\"hidden\" name=\"photo_5\" value=\"" << photo_5 << "\">\n</TD>\n";
		
		cout << "              </TR>\n"
			<< "\n"
			<< "              <TR>\n"
			<< "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  Main\n"
			<< "                </TD>\n"
			<< "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  #2\n"
			<< "                </TD>\n"
			<< "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  #3\n"
			<< "                </TD>\n"
			<< "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  #4\n"
			<< "                </TD>\n"
			<< "                <TD align=\"center\" valign=\"middle\" width=\"60\">\n"
			<< "                  #5\n"
			<< "                </TD>\n"
			<< "              </TR>\n"
			<< "            </TABLE>\n"
			<< "                 \n"
			//			<< "                <FORM enctype=\"multipart/form-data\" method=\"POST\" action=\"" << Map.PrintValue( "CGIBIN" ) << "/UploadPicture.cgi\">\n"
			<< "            <TABLE border=\"1\">\n"
			<< "              <TR>\n"
			<< "                <TD colspan=\"2\" align=\"center\">\n"
			<< "                  <FONT size=\"4\"><STRONG>Replace A Picture</STRONG></FONT>\n"
			<< "                </TD>\n"
			<< "                <TD colspan=\"2\" align=\"center\">\n"
			<< "                  <FONT size=\"4\"><STRONG>Delete A Picture</STRONG></FONT>\n"
			<< "                </TD>\n"
			<< "              </TR>\n"
			<< "              <TR>\n"
			<< "                <TD>\n"
			<< "                </TD>\n"
			<< "              </TR>\n"
			<< "              <TR>\n"
			<< "                <TD align=\"right\">\n"
			<< "                  <FONT size=\"2\"><STRONG>Picture Name:</STRONG></FONT>\n"
			<< "                </TD>\n"
			<< "                <TD>\n"
			<< "                  <INPUT type=\"file\" name=\"picture\" accept=\"image/*\">\n"
			<< "                </TD>\n"
			<< "                <TD colspan=\"2\" align=\"center\">\n"
			<< "                </TD>\n"
			<< "              </TR>\n"
			<< "              <TR>\n"
			<< "                <TD align=\"right\">\n"
			<< "                  <FONT size=\"2\"><STRONG>Replace:</STRONG></FONT>\n"
			<< "                </TD>\n"
			<< "                <TD>\n"
			<< "                  <SELECT name=\"upload_picture_number\">\n"
			<< "                    <OPTION value=\"1\">\n"
			<< "                      Main Photo\n"
			<< "                    </OPTION>\n"
			<< "                    <OPTION value=\"2\">\n"
			<< "                      Photo #2\n"
			<< "                    </OPTION>\n"
			<< "                    <OPTION value=\"3\">\n"
			<< "                      Photo #3\n"
			<< "                    </OPTION>\n"
			<< "                    <OPTION value=\"4\">\n"
			<< "                      Photo #4\n"
			<< "                    </OPTION>\n"
			<< "                    <OPTION value=\"5\">\n"
			<< "                      Photo #5\n"
			<< "                    </OPTION>\n"
			<< "                  </SELECT>\n"
			<< "                </TD>\n"
			<< "                <TD align=\"right\">\n"
			<< "                  <FONT size=\"2\"><STRONG>Delete:</STRONG></FONT>\n"
			<< "                </TD>\n"
			<< "                <TD>\n"
			<< "                  <SELECT name=\"delete_picture_number\">\n"
			<< "                    <OPTION value=\"1\">\n"
			<< "                      Main Photo\n"
			<< "                    </OPTION>\n"
			<< "                    <OPTION value=\"2\">\n"
			<< "                      Photo #2\n"
			<< "                    </OPTION>\n"
			<< "                    <OPTION value=\"3\">\n"
			<< "                      Photo #3\n"
			<< "                    </OPTION>\n"
			<< "                    <OPTION value=\"4\">\n"
			<< "                      Photo #4\n"
			<< "                    </OPTION>\n"
			<< "                    <OPTION value=\"5\">\n"
			<< "                      Photo #5\n"
			<< "                    </OPTION>\n"
			<< "                  </SELECT>\n"
			<< "                </TD>\n"
			<< "              </TR>\n"
			<< "              <TR>\n"
			<< "                <TD colspan=\"2\" align=\"center\">\n"
			<< "                  <INPUT type=\"submit\" value=\"Replace Photo\" name=\"submit\" onClick=\"return uploadCheck()\">\n"
			<< "                </TD>\n"
			<< "                <TD colspan=\"2\" align=\"center\">\n"
			<< "                  <INPUT type=\"submit\" value=\"Delete Photo\" name=\"submit\">\n"
			<< "                </TD>\n"
			<< "              </TR>\n"
			<< "              <TR>\n"
			<< "                <TD align=\"left\" width=\"543\" valign=\"middle\" height=\"65\" colspan=\"2\">\n"
			<< "                  <FONT size=\"2\" color=\"#FF0000\" face=\"Arial, Helvetica, sans-serif\">Submitting this form with file attachments may take longer than usual depending on the size of the file(s) you attached.&nbsp; Your browser may appear to be hung for several minutes.&nbsp; This is normal.&nbsp;&nbsp; Please be patient and press the submit button only once.&nbsp; Once the file(s) finish uploading, you will be taken to a confirmation screen.</FONT>\n"
			<< "                </TD>\n"
			<< "                <TD align=\"left\" width=\"543\" valign=\"middle\" height=\"65\" colspan=\"2\">\n"
			<< "                  <FONT size=\"2\" color=\"#FF33CC\" face=\"Arial, Helvetica, sans-serif\">Deleting pictures is an immediate and irreversable act. Please be sure you select the correct photo name from the drop down menue.</FONT>\n"
			<< "                </TD>\n"
			<< "              </TR>\n"
			<< "            </TABLE>\n"
			<< "           <SCRIPT type=\"text/javascript\" language=\"javascript\">\n"
			<< "           <!--\n"
			<< "           function uploadCheck()\n"
			<< "           {\n"
			<< "           // ----- picture\n"
			<< "             if (document.forms[0].picture.value == \"\")\n"
			<< "             {\n"
			<< "               alert(\"Please enter a value for the \\\"Picture Name\\\" field under the \\\"Replace A Picture\\\" header.\");\n"
			<< "               document.forms[0].picture.focus();\n"
			<< "               return (false);\n"
			<< "             }\n"
			<< "           }\n"
			<< "           // -->\n"
			<< "           </SCRIPT>\n"
			<< "          </FORM>\n"
			<< flush;
			rc = true;
	}// end if(Global_DBSuccess)
	
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";

	// Close the connection to SQL Server
	dbexit();
	
	if(!Global_DBSuccess)
	{
		return Global_DBSuccess;
	}
	else
	{
		return rc;
	}
} // GenPicUpload_The_DB 

bool
DB_Table_Base::GenMailbox_The_DB(LinkMap & Map, const string & program_name, const int index, const int limit)
{
	CConnectionsFormLayout cfl;
	Global_DBSuccess = true;
	
	int BOX_TYPE = 0;
	if(program_name == "GenInbox.exe")
	{
		BOX_TYPE = GEN_INBOX;
	}
	else if(program_name == "GenOutbox.exe")
	{
		BOX_TYPE = GEN_OUTBOX;
	}

	char row_count			[ROW_COUNT			];
	char search_unique_id	[SEARCH_UNIQUE_ID	];
	char user_name			[USER_NAME			];
	char membership_type	[MEMBERSHIP_TYPE	];
	char mail_id			[MAIL_ID			];
	char sent_to			[SENT_TO			];
	char sent_from			[SENT_FROM			];
	char subject			[SUBJECT			];
	char message_text		[MESSAGE_TEXT		];
	char when_sent			[WHEN_SENT			];
	char when_read			[WHEN_READ			];
	char sender_deleted		[SENDER_DELETED		];
	char receiver_deleted	[RECEIVER_DELETED	];
	char photo_1			[PHOTO_1			];
	
	memset(row_count		, ROW_COUNT			, NULL);
	memset(search_unique_id	, SEARCH_UNIQUE_ID	, NULL);
	memset(user_name		, USER_NAME			, NULL);
	memset(membership_type	, MEMBERSHIP_TYPE	, NULL);
	memset(mail_id			, MAIL_ID			, NULL);
	memset(sent_to			, SENT_TO			, NULL);
	memset(sent_from		, SENT_FROM			, NULL);
	memset(subject			, SUBJECT			, NULL);
	memset(message_text		, MESSAGE_TEXT		, NULL);
	memset(when_sent		, WHEN_SENT			, NULL);
	memset(when_read		, WHEN_READ			, NULL);
	memset(sender_deleted	, SENDER_DELETED	, NULL);
	memset(receiver_deleted	, RECEIVER_DELETED	, NULL);
	memset(photo_1			, PHOTO_1			, NULL);
	
	
	bool rc = this->Initialize_DbProc(Map);
	
	dout << "<!-- Initialize_DbProc returned (" << rc << ") -->\n" << flush;
/*
	if(rc == 0)
	{
		DB_Table_Base_Error_Number = -1;
		DB_Table_Base_Error_Text = "Database Error.  Contact <FONT color=\"red\">" + Map.PrintValue( "EMAIL" ) + "</FONT> for assistence with this problem.\n\n<!-- ########### Check DB username and password. ########### -->\n\n";
		return false;
	}
*/

	// First, put the command into the command buffer.
	dbcmd( DbProc, const_cast<char *>(update_info_sql.c_str()) ); 
	
	// Send the command to SQL Server and start execution
	dbsqlexec(DbProc);

	// Set DB_Table_Base class internal varaibles
	DB_Table_Base_Error_Number = dbretstatus ( DbProc );
	dout << "<!-- DB_Table_Base_Error_Number = (" << DB_Table_Base_Error_Number << ") -->\n";
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";
	
	if(Global_DBSuccess)
	{
		// Process the command
		// Get the actual data that is contained in the table itself
		
		// get row_count...
		if(dbresults(DbProc)) 
		{
			::dbbind( DbProc, 1, NTBSTRINGBIND,	ROW_COUNT		, (BYTE *)( row_count ) );
			::dbbind( DbProc, 2, NTBSTRINGBIND,	SEARCH_UNIQUE_ID, (BYTE *)( search_unique_id ) );
			while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			{ 
				rc = true;
			} 
		}	
		// Get the HTML Top along with the Text Ad Delivery Code...
		cfl.Html_Begin(Map, 1, BOX_TYPE, search_unique_id);

		// get actual data...
		if(dbresults(DbProc)) 
		{
			::dbbind( DbProc,  1,  NTBSTRINGBIND, USER_NAME			, (BYTE *)( user_name		) );
			::dbbind( DbProc,  2,  NTBSTRINGBIND, MEMBERSHIP_TYPE	, (BYTE *)( membership_type	) );
			::dbbind( DbProc,  3,  NTBSTRINGBIND, MAIL_ID			, (BYTE *)( mail_id			) );
			::dbbind( DbProc,  4,  NTBSTRINGBIND, SENT_TO			, (BYTE *)( sent_to			) );
			::dbbind( DbProc,  5,  NTBSTRINGBIND, SENT_FROM			, (BYTE *)( sent_from		) );
			::dbbind( DbProc,  6,  NTBSTRINGBIND, SUBJECT			, (BYTE *)( subject			) );
			::dbbind( DbProc,  7,  NTBSTRINGBIND, MESSAGE_TEXT		, (BYTE *)( message_text	) );
			::dbbind( DbProc,  8,  NTBSTRINGBIND, WHEN_SENT			, (BYTE *)( when_sent		) );
			::dbbind( DbProc,  9,  NTBSTRINGBIND, WHEN_READ			, (BYTE *)( when_read		) );
			::dbbind( DbProc, 10,  NTBSTRINGBIND, SENDER_DELETED	, (BYTE *)( sender_deleted	) );
			::dbbind( DbProc, 11,  NTBSTRINGBIND, RECEIVER_DELETED	, (BYTE *)( receiver_deleted) );
			::dbbind( DbProc, 12,  NTBSTRINGBIND, PHOTO_1			, (BYTE *)( photo_1			) );
			
			// begin the result set with some return info...
			
	
		cout << "            <TABLE width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"3\">\n";
			if(program_name == "GenInbox.exe")
				cout << "              <TR bgcolor=" << Map.PrintValue( "INBOX_COLOR_2" ) << ">\n";
			else if (program_name == "GenOutbox.exe")
				cout << "              <TR bgcolor=" << Map.PrintValue( "OUTBOX_COLOR_2" ) << ">\n";
			
			cout << "          <TD width=\"25\">&nbsp;</FONT></TD>\n"
				<< "          <TD width=\"197\"><font face=\"Arial, Helvetica, sans-serif\" color=\"#990033\" size=\"4\"><strong>";
			// Current Mailbox...
			if(program_name == "GenInbox.exe")
				cout << "Inbox";
			else if (program_name == "GenOutbox.exe")
				cout << "Outbox";
			cout << "</strong></font></TD>\n"
				<< "          <TD width=\"125\">&nbsp;</TD>\n"
				<< "          <TD width=\"132\">&nbsp;</TD>\n"
				<< "          <TD width=\"60\">&nbsp;</TD>\n"
				<< "          <TD width=\"48\">&nbsp;</TD>\n"
				<< "        </TR>\n";
				if(program_name == "GenInbox.exe")
				cout << "              <TR bgcolor=" << Map.PrintValue( "INBOX_COLOR_1" ) << ">\n";
			else if (program_name == "GenOutbox.exe")
				cout << "              <TR bgcolor=" << Map.PrintValue( "OUTBOX_COLOR_1" ) << ">\n";
			
			cout << "          <TD width=\"25\">&nbsp;</TD>\n"
				<< "          <TD width=\"197\"> <FONT face=\"Arial, Helvetica, sans-serif\" color=\"#000066\" size=\"2\"><STRONG><FONT color=\"#663399\">Messages</FONT></STRONG></FONT> \n"
				<< "          </TD>\n"
				<< "          <TD width=\"125\">&nbsp;</TD>\n"
				<< "          <TD width=\"132\">&nbsp;</TD>\n"
				<< "          <TD width=\"60\">&nbsp;</TD>\n"
				<< "          <TD width=\"48\">&nbsp;</TD>\n"
				<< "        </TR>\n";
			if(program_name == "GenInbox.exe")
				cout << "              <TR bgcolor=" << Map.PrintValue( "INBOX_COLOR_2" ) << ">\n";
			else if (program_name == "GenOutbox.exe")
				cout << "              <TR bgcolor=" << Map.PrintValue( "OUTBOX_COLOR_2" ) << ">\n";
			
			cout << "                <TD width=\"25\">\n"
				<< "                  <FONT face=\"Arial, Helvetica, sans-serif\" color=\"#663399\" size=\"-2\"><STRONG>New</STRONG></FONT>\n"
				<< "                </TD>\n"
				<< "                <TD width=\"197\">\n";
			
			// From...
			if(program_name == "GenInbox.exe")
				cout << "                  <FONT face=\"Arial, Helvetica, sans-serif\" color=\"#663399\" size=\"-2\"><STRONG>From</STRONG></FONT>\n";
			// To...
			else if (program_name == "GenOutbox.exe")
				cout << "                  <FONT face=\"Arial, Helvetica, sans-serif\" color=\"#663399\" size=\"-2\"><STRONG>To</STRONG></FONT>\n";
			
			cout << "                </TD>\n"
				<< "                <TD width=\"125\">\n"
				<< "                  <FONT face=\"Arial, Helvetica, sans-serif\" color=\"#663399\" size=\"-2\"><STRONG>Subject</STRONG></FONT>\n"
				<< "                </TD>\n"
				<< "                <TD width=\"132\">\n";
			// Received...
			if(program_name == "GenInbox.exe")
				cout << "                  <FONT face=\"Arial, Helvetica, sans-serif\" color=\"#663399\" size=\"-2\"><STRONG>Received</STRONG></FONT>\n";
			// Sent / Read...
			else if (program_name == "GenOutbox.exe")
				cout << "                  <FONT face=\"Arial, Helvetica, sans-serif\" color=\"#663399\" size=\"-2\"><STRONG>Sent / Read</STRONG></FONT>\n";
			cout << "                </TD>\n"
				<< "                <TD width=\"60\">\n"
				<< "                  <FONT face=\"Arial, Helvetica, sans-serif\" color=\"#663399\" size=\"-2\"><STRONG>Profile</STRONG></FONT>\n"
				<< "                </TD>\n"
				<< "                <TD width=\"48\">\n"
				<< "                  <FONT face=\"Arial, Helvetica, sans-serif\" color=\"#663399\" size=\"-2\"><STRONG>Delete</STRONG></FONT>\n"
				<< "                </TD>\n"
				<< "              </TR>\n" << flush;
			
			
			int count_unread = 0;
			int count = 1; // Total message count variable
			int bg_count = 0; // bg Color alternation variable
			while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			{ 
				if( (count >= index) && count < (limit + index) )
				{
					// convert the "subject" character array to a std::string ...
					string subject_string = subject;
					if(subject_string.size() > SUBJECT_LENGTH_CUT_OFF)
					{
						subject_string = subject_string.substr(0, SUBJECT_LENGTH_CUT_OFF) + "...";
					}
					else if(subject_string.size() < 1)
					{
						subject_string = "No Subject";
					}
					
					
					// remove seconds and miliseconds from the date fields...
					string when_sent_string = when_sent;
					if(when_sent_string.size() > 20)
					{
						when_sent_string.replace(when_sent_string.size()-9, 7, "");
					}
					
					string when_read_string = when_read;
					if(when_read_string.size() > 20)
					{
						when_read_string.replace(when_read_string.size()-9, 7, "");
					}
					else
					{
						when_read_string = " Unread";
					}
					
					// Inbox Alternate background color...
					if(program_name == "GenInbox.exe")
					{
						if ( (bg_count % 2) == 0)
						{
							cout << "              <TR bgcolor=" << Map.PrintValue( "INBOX_COLOR_1" ) << ">\n";
							bg_count++;
						}
						else
						{
							cout << "              <TR bgcolor=" << Map.PrintValue( "INBOX_COLOR_2" ) << ">\n";
							bg_count++;
						}
					}
					// Inbox Alternate background color...
					else
					{
						if ( (bg_count % 2) == 0)
						{
							cout << "              <TR bgcolor=" << Map.PrintValue( "OUTBOX_COLOR_1" ) << ">\n";
							bg_count++;
						}
						else
						{
							cout << "              <TR bgcolor=" << Map.PrintValue( "OUTBOX_COLOR_2" ) << ">\n";
							bg_count++;
						}
					}
					
					// Read/Unread Image...
					if(strlen(when_read) > 1)
					{
						cout << "<!-- Read -->\n"
							<< "                <TD width=\"25\">\n"
							<< "                  <DIV align=\"center\">\n"
							<< "                    <IMG ALT=\"Empty Space\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "SPACESYMBOL" ) << "\" width=\"10\" height=\"8\">\n"
							<< "                  </DIV>\n"
							<< "                </TD>\n";
					}
					else
					{
						cout << "<!-- Unread -->\n"
							<< "                <TD width=\"25\">\n"
							<< "                  <DIV align=\"center\">\n"
							<< "                    <IMG ALT=\"Unread Message Indicator\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "UNREADSYMBOL" ) << "\" width=\"10\" height=\"8\">\n"
							<< "                  </DIV>\n"
							<< "                </TD>\n";
						count_unread++;
					}
					
					
					cout << "<!-- Sender -->\n"
						<< "                <TD width=\"197\">\n"
						<< "                  <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\"><STRONG>";
					// sent_from...
					if(program_name == "GenInbox.exe")
						cout << sent_from;
					// sent_to...
					else if (program_name == "GenOutbox.exe")
						cout << sent_to;
					
					cout << "</STRONG></FONT>\n"
						<< "                </TD>\n"
						<< "<!-- href to received mail -->\n"
						<< "                <TD width=\"125\">\n"
						
						<< "                  <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\"><STRONG><A href=\"" << Map.PrintValue( "CGIBIN" ) << "/ReadMail.exe?mail_id=" << mail_id << "&amp;the_caller=" << program_name << "\"><font color=\"#000000\">" << subject_string << "</font></A></STRONG></FONT>\n"
						<< "                </TD>\n"
						<< "<!-- Date message was sent -->\n"
						<< "                <TD width=\"132\">\n"
						<< "                  <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\"><STRONG>" << when_sent_string << "</STRONG></FONT>\n";
					// when_read...
					if (program_name == "GenOutbox.exe")
					{
						cout << "<!-- Date message was read -->\n"
							<< "                  <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\" color=\"red\"><STRONG>"<< when_read_string << "</STRONG></FONT>\n";
					}
					
					cout << "                </TD>\n"
						<< "<!-- Sender's Photo and href to sender's profile -->\n"
						<< "                <TD width=\"60\">\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=";
					// Sender was sent_from...
					if(program_name == "GenInbox.exe")
						cout << sent_from;
					// Sender was sent_to...
					else if (program_name == "GenOutbox.exe")
						cout << sent_to;
					
					// Sender's photo if submitted...
					if(!strcmp(photo_1, "Nothing") || strlen(photo_1) < 1)
					{
						// Sender has no photo...
						cout << "\"><IMG ALT=\"Picture of person 1 not available\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_SMALL" ) << "\" height=\"60\" width=\"60\" border=\"0\"></A>\n";
					}
					else
					{
						// Sender has photo...
						cout << "\"><FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\"><IMG ALT=\"Picture of person 1\" src=\"" << Map.PrintValue( "PICTURES" ) << "/" << photo_1 << "\" height=\"60\" width=\"60\" border=\"0\"></FONT></A>\n";
					}
					cout << "                </TD>\n"
						<< "<!-- Delete Mail -->\n"
						<< "                <TD width=\"48\">\n"
						<< "                  <DIV align=\"center\">\n";
					
					// Delete from Inbox...
					if(program_name == "GenInbox.exe")
					{
						cout << "                    <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/DeleteMail.exe?mail_id=" << mail_id << "&amp;caller=GenInbox.exe\">";
					}
					else
					{
						// Delete from Outbox...
						cout << "                    <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/DeleteMail.exe?mail_id=" << mail_id << "&amp;caller=GenOutbox.exe\">";
					}
					cout << "<IMG ALT=\"Delete mail message...\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "DELETSYMBOL" ) << "\" border=\"0\"></A>"
						<< "                  </DIV>\n"
						<< "                </TD>\n"
						
						<< "              </TR>\n"
						
						<< "<!-- when read = (" << when_read << ") -->\n"
						
						<< flush;
					
				} // end if count...
				count ++;
				
			}// end While
			
			// determin which navigation arrows to show...
			bool show_first_previous = false;
			bool show_next_last		 = false;
			if( index > 1  )
			{
				show_first_previous = true;
			}
			if( atoi(row_count) >= (index+limit) )
			{
				show_next_last		= true;
			}
			cout << "	</TABLE>\n"
				<< "      <table width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"3\">\n"
				<< "        <tr> \n"
				<< "          <td height=\"20\" width=\"207\">&nbsp;</td>\n";
			
			// First/Previous Arrows...
			if( show_first_previous )
			{
				cout << "<!-- First Result Set -->\n"
					<< "          <td height=\"20\" width=\"90\">"
					<< "        <A href=" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?index=" << 1 << "\">\n"
					<< "		<IMG ALT=\"Display First\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "FIRSTARROW" ) << "\" border=\"0\"></A></TD>&nbsp;\n"
					<< "<!-- Previous Result Set -->\n"
					<< "          <td height=\"20\" width=\"90\">"
					<< "		<A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?index=" << ( (index - limit > 0) ? index-limit : 1 ) << "\">\n"
					<< "		<IMG ALT=\"Display Previous\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "PREVIOUSARROW" ) << "\" border=\"0\"></A></TD>\n"
					<< endl << flush;
			}
			else
			{
				// add filler column...
				cout << "          <td height=\"20\" width=\"90\">&nbsp;</TD>";
				cout << "          <td height=\"20\" width=\"90\">&nbsp;</TD>";
				dout << "<!-- index     = (" << index << ") -->\n";
				dout << "<!-- limit     = (" << limit << ") -->\n";
				dout << "<!-- row_count = (" << row_count << ") -->\n" << flush;
			}
			
			// Next/Last Arrows...
			if( show_next_last )
			{
				cout << "<!-- Next Result Set -->\n"
					<< "          <td height=\"20\" width=\"90\">"
					<< "		<A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?index=" << index + limit << "\">\n"
					<< "		<IMG ALT=\"Display Next\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NEXTARROW" ) << "\" border=\"0\"></TD>&nbsp;\n"
					<< "<!-- Last Result Set -->\n"
					<< "          <td height=\"20\" width=\"90\">"
					<< "		<A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?index=" << atoi(row_count) - limit+1 << "\">\n"
					<< "		<IMG ALT=\"Display Last\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LASTARROW" ) << "\" border=\"0\"></TD></A>\n"
					<< endl << flush;
			}
			else
			{
				// add filler column...
				cout << "          <td height=\"20\" width=\"90\">&nbsp;</TD>";
				cout << "          <td height=\"20\" width=\"90\">&nbsp;</TD>";
				dout << "<!-- index     = (" << index << ") -->\n";
				dout << "<!-- limit     = (" << limit << ") -->\n";
				dout << "<!-- row_count = (" << row_count << ") -->\n" << flush;
			}
			
			// fill in the excess table space if the arrows are not printed...
			if (!show_first_previous && !show_next_last)
			{
				cout << "          <td height=\"20\" width=\"90\">&nbsp;</TD>";
				cout << "          <td height=\"20\" width=\"90\">&nbsp;</TD>";
				cout << "          <td height=\"20\" width=\"90\">&nbsp;</TD>";
				cout << "          <td height=\"20\" width=\"90\">&nbsp;</TD>";
			}
			
			// Display the count of the page...
			cout << "        </tr>\n"
				<< "        <tr> \n"
				<< "          <td colspan=\"3\" align=\"left\" height=\"21\"><font face=\"Arial, Helvetica, sans-serif\" color=#000000 size=2><strong>(" << atoi(row_count) << ") total messages</strong></font></td>\n"
				<< "          <td colspan=\"2\" align=\"right\" height=\"21\">"
				<< "<font face=\"Arial, Helvetica, sans-serif\" size=2><NOBR><strong>"
				// Results...
				<< "Results " << index 
				// Through...
				<< " Through " << ( (index + limit) > atoi(row_count) ? atoi(row_count) : (index+limit-1) ) 
				// Of...
				<< " of " << atoi(row_count) 
				<< "</strong></NOBR></font></td>\n";
			
			// Close table for navigation arrows...
			cout << "        </tr>\n"
				<< "      </table>\n"
				<< flush;			
		}
	}
	else
	{
		// Get the HTML Top along with the Text Ad Delivery Code...
		cfl.Html_Begin(Map, 0, BOX_TYPE, "0");
	}

	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";

	// Close the connection to SQL Server
	dbexit(); 
	if(!Global_DBSuccess)
	{
		return Global_DBSuccess;
	}
	else
	{
		return rc;
	}
} // GenMailbox_The_DB 



// Used to generate the send mail page the DB (SingleProfile.exe)
bool
DB_Table_Base::GenSendMail_The_DB(LinkMap & Map, const string & program_name)
{
	CConnectionsFormLayout cfl;
	Global_DBSuccess = true;
	
	char user_name			[USER_NAME			];
	char screen_quote		[SCREEN_QUOTE		];
	char about_yourself		[ABOUT_YOURSELF		];
	char photo_1			[PHOTO_1			];
	char photo_2			[PHOTO_2			];
	char photo_3			[PHOTO_3			];
	char photo_4			[PHOTO_4			];
	char photo_5			[PHOTO_5			];
	char search_unique_id	[SEARCH_UNIQUE_ID	];
	
	
	memset(user_name		, USER_NAME			, NULL);
	memset(screen_quote		, SCREEN_QUOTE		, NULL);
	memset(about_yourself	, ABOUT_YOURSELF	, NULL);
	memset(photo_1			, PHOTO_1			, NULL);
	memset(photo_2			, PHOTO_2			, NULL);
	memset(photo_3			, PHOTO_3			, NULL);
	memset(photo_4			, PHOTO_4			, NULL);
	memset(photo_5			, PHOTO_5			, NULL);
	memset(search_unique_id	, SEARCH_UNIQUE_ID	, NULL);
	
	bool rc = this->Initialize_DbProc(Map);
	
	// First, put the command into the command buffer...
	dout << "<!-- Initialize_DbProc returned (" << rc << ") -->\n" << flush;
/*
	if(rc == 0)
	{
		DB_Table_Base_Error_Number = -1;
		DB_Table_Base_Error_Text = "Database Error.  Contact <FONT color=\"red\">" + Map.PrintValue( "EMAIL" ) + "</FONT> for assistence with this problem.\n\n<!-- ########### Check DB username and password. ########### -->\n\n";
		return false;
	}
*/

	dbcmd( DbProc, const_cast<char *>(update_info_sql.c_str()) ); 
	
	//dout << "pre dbsqlexec" << endl;
	// Send the command to SQL Server and start execution
	dbsqlexec(DbProc);

	// Set DB_Table_Base class internal varaibles
	DB_Table_Base_Error_Number = dbretstatus ( DbProc );
	dout << "<!-- DB_Table_Base_Error_Number = (" << DB_Table_Base_Error_Number << ") -->\n";
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";
	
	//dout << "post dbsqlexec" << endl;
	if(Global_DBSuccess)
	{
		// Process the command
		// Get the actual data that is contained in the table itself
		if(dbresults(DbProc)) 
		{
			::dbbind( DbProc, 2,  NTBSTRINGBIND, USER_NAME			, (BYTE *)( user_name		) );
			::dbbind( DbProc, 37, NTBSTRINGBIND, SCREEN_QUOTE		, (BYTE *)( screen_quote	) );
			::dbbind( DbProc, 38, NTBSTRINGBIND, ABOUT_YOURSELF		, (BYTE *)( about_yourself	) );
			::dbbind( DbProc, 39, NTBSTRINGBIND, PHOTO_1			, (BYTE *)( photo_1			) );
			::dbbind( DbProc, 40, NTBSTRINGBIND, PHOTO_2			, (BYTE *)( photo_2			) );
			::dbbind( DbProc, 41, NTBSTRINGBIND, PHOTO_3			, (BYTE *)( photo_3			) );
			::dbbind( DbProc, 42, NTBSTRINGBIND, PHOTO_4			, (BYTE *)( photo_4			) );
			::dbbind( DbProc, 43, NTBSTRINGBIND, PHOTO_5			, (BYTE *)( photo_5			) );
			::dbbind( DbProc, 44, NTBSTRINGBIND, SEARCH_UNIQUE_ID	, (BYTE *)( search_unique_id) );
			
			// begin the result set with some return info...
			while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			{
				// Get the HTML Top along with the Text Ad Delivery Code...
				cfl.Html_Begin(Map, 1, GEN_SEND_MAIL, search_unique_id);

				cout << "          <DIV align=\"center\">\n"
					<< "            <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"5\">Send A Message To:</FONT></STRONG>\n"
					<< "          </DIV>\n"
					<< "            <TABLE width=\"550\" align=\"center\" border=\"0\">\n"
					<< "              <TR>\n"
					<< "                <TD valign=\"TOP\">\n"
					<< "                  <FORM action=\"SendMail.cgi\" method=\"post\">\n"
					<< "                    <TABLE width=\"590\" align=\"center\" border=\"0\" cellpadding=\"4\" cellspacing=\"0\">\n"
					<< "                      <TR>\n"
					<< "                        <TD align=\"center\" style=\"border:medium none\">\n"
					<< "                          <BR>\n";
				
				if( strcmp(photo_1, "Nothing") )
				{
					cout << "                           <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "\"><IMG ALT=\"Take another look at " << user_name << "'s detailed profile.\" src=\"" << Map.PrintValue( "PICTURES" ) << "/180x180_" << user_name << "_1.jpg\" width=\"180\" height=\"180\" border=\"0\"></A>\n";
				}
				else if( strcmp(photo_2, "Nothing") )
				{
					cout << "                           <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "\"><IMG ALT=\"Take another look at " << user_name << "'s detailed profile.\" src=\"" << Map.PrintValue( "PICTURES" ) << "/180x180_" << user_name << "_2.jpg\" width=\"180\" height=\"180\" border=\"0\"></A>\n";
				}
				else if( strcmp(photo_3, "Nothing") )
				{
					cout << "                           <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "\"><IMG ALT=\"Take another look at " << user_name << "'s detailed profile.\" src=\"" << Map.PrintValue( "PICTURES" ) << "/180x180_" << user_name << "_3.jpg\" width=\"180\" height=\"180\" border=\"0\"></A>\n";
				}
				else if( strcmp(photo_4, "Nothing") )
				{
					cout << "                           <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "\"><IMG ALT=\"Take another look at " << user_name << "'s detailed profile.\" src=\"" << Map.PrintValue( "PICTURES" ) << "/180x180_" << user_name << "_4.jpg\" width=\"180\" height=\"180\" border=\"0\"></A>\n";
				}
				else if( strcmp(photo_5, "Nothing") )
				{
					cout << "                           <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "\"><IMG ALT=\"Take another look at " << user_name << "'s detailed profile.\" src=\"" << Map.PrintValue( "PICTURES" ) << "/180x180_" << user_name << "_5.jpg\" width=\"180\" height=\"180\" border=\"0\"></A>\n";
				}
				else
				{
					cout << "                           <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name << "\"><IMG ALT=\"Take another look at " << user_name << "'s detailed profile.\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_LARGE" ) << "\" width=\"180\" height=\"180\" border=\"0\"></A>\n";
				}
				
				cout << "                          <BR>\n"
					<< "                          <STRONG>" << user_name << "</STRONG>\n"
					<< "                        </TD>\n"
					<< "                      </TR>\n"
					<< "                      <TR>\n"
					<< "                        <TD align=\"left\">\n"
					<< "                          <FONT face=\"Arial, Helvetica, Sans Serif\" size=\"-1\">\n" 
					<< "                          \n"
					<< "                            <B>" << Replace_Returns_With_Breaks(about_yourself) << "</B>\n"
					<< "						  </FONT>\n"
					<< "                        </TD>\n"
					<< "                        <TD align=\"left\" width=\"2\" valign=\"top\" rowspan=\"18\">&nbsp;\n"
					<< "                          <BR><BR>\n"
					<< "                        </TD>\n"
					<< "                      </TR>\n"
					<< "                      <TR>\n"
					<< "                        <TD align=\"center\" colspan=\"2\" style=\"border:medium none\">\n"
					<< "                          <P>\n"
					<< "                             <FONT face=\"Arial, Helvetica, Sans Serif\" size=\"3\"><STRONG>Enter Subject:</STRONG></FONT>\n"
					<< "                            <BR>\n"
					<< "                            <INPUT type=\"text\" maxlength=\"128\" size=\"65\" name=\"subject\">\n"
					<< "                            <BR>\n"
					<< "                            <BR>\n"
					<< "                          </P>\n"
					<< "                        </TD>\n"
					<< "                      </TR>\n"
					<< "                      <TR>\n"
					<< "                        <TD align=\"center\" colspan=\"2\" style=\"border:medium none\">\n"
					<< "                          <P>\n"
					<< "                             <FONT face=\"Arial, Helvetica, Sans Serif\" size=\"3\"><STRONG>Enter Mail Message:</STRONG></FONT>\n"
					<< "                            <BR>\n"
					<< "                            <TEXTAREA rows=\"20\" cols=\"65\" name=\"message_text\"></TEXTAREA>\n"
					<< "                            <BR>\n"
					<< "                            <BR>\n"
					<< "                          </P>\n"
					<< "                        </TD>\n"
					<< "                      </TR>\n"
					<< "                      <TR>\n"
					<< "                        <TD align=\"center\" style=\"border:medium none\" colspan=\"2\">\n"
					<< "                          <P>\n"
					<< "                             <FONT size=\"-2\" face=\"Arial, Helvetica, Sans Serif\" color=\"black\"> All email is for internal use only and will <STRONG>NOT<STRONG> be sent from your email address.\n"
					<< "                          </P><STRONG><STRONG>\n"
					<< "                            <FONT face=\"Arial, Helvetica, Sans Serif\" size=\"2\">\n"
					// Send the message to:
					<< "                              <INPUT type=\"hidden\" name=\"sent_to\" value=\"" << user_name << "\">\n"
					<< "                              <INPUT type=\"submit\" value=\"submit\" name=\"submit\"></FONT>\n"
					<< "                          <FONT face=\"Arial, Helvetica, Sans Serif\" size=\"2\"><BR>\n"
					<< "                          </FONT>\n"
					<< "                        </strong></strong></TD>\n"
					<< "                      </TR>\n"
					<< "                      <TR>\n"
					<< "                        <TD align=\"center\" colspan=\"3\">&nbsp;\n"
					<< "                          \n"
					<< "                        </TD>\n"
					<< "                      </TR>\n"
					<< "                    </TABLE>\n"
					<< "                   </FORM\n"
					<< "                  </TD>\n"
					<< "                 </TR>\n"
					<< "                </TABLE>\n"
					<< flush;
			}// end while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			
		}// end if(dbresults(DbProc)) 
		
	}// end if(Global_DBSuccess)
	else
	{
		// Get the HTML Top along with the Text Ad Delivery Code...
		cfl.Html_Begin(Map, 1, GEN_SEND_MAIL, "0");
	}
	
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";

	// Close the connection to SQL Server
	dbexit(); 
	
	if(!Global_DBSuccess)
	{
		return Global_DBSuccess;
	}
	else
	{
		return rc;
	}
}// GenSendMail_The_DB 

// Used for SimpleSearch.exe and AdvancedSearch.exe
bool
DB_Table_Base::Search_The_DB(LinkMap & Map
							, const string & program_name
							, const int index
							, const int limit
							, const bool my_cookie_found
							)
{
	CConnectionsFormLayout cfl;
	Global_DBSuccess = true;

	int SEARCH_TYPE = 0;
	if(program_name == "SimpleSearch.exe")
	{
		SEARCH_TYPE = SIMPLE_SEARCH;
	}
	else if(program_name == "AdvancedSearch.exe")
	{
		SEARCH_TYPE = ADVANCED_SEARCH;
	}
	char row_count			[ROW_COUNT			];
	char search_unique_id	[SEARCH_UNIQUE_ID	];
	char user_name			[USER_NAME			];
	char city				[CITY				];
	char state				[STATE				];
	char country			[COUNTRY			];
	char age				[AGE				];
	char screen_quote		[SCREEN_QUOTE		];
	char about_yourself		[ABOUT_YOURSELF		];
	char photo_1			[PHOTO_1			];
	
	memset(row_count		, ROW_COUNT			, NULL);
	memset(search_unique_id	, SEARCH_UNIQUE_ID	, NULL);
	memset(user_name		, USER_NAME			, NULL);
	memset(city				, CITY				, NULL);
	memset(state			, STATE				, NULL);
	memset(country			, COUNTRY			, NULL);
	memset(age				, AGE				, NULL);
	memset(screen_quote		, SCREEN_QUOTE		, NULL);
	memset(about_yourself	, ABOUT_YOURSELF	, NULL);
	memset(photo_1			, PHOTO_1			, NULL);
	
	bool rc = this->Initialize_DbProc(Map);
	
	dout << "<!-- Initialize_DbProc returned (" << rc << ") -->\n" << flush;
/*
	if(rc == 0)
	{
		DB_Table_Base_Error_Number = -1;
		DB_Table_Base_Error_Text = "Database Error.  Contact <FONT color=\"red\">" + Map.PrintValue( "EMAIL" ) + "</FONT> for assistence with this problem.\n\n<!-- ########### Check DB username and password. ########### -->\n\n";
		return false;
	}
*/

	// First, put the command into the command buffer.
	dbcmd( DbProc, const_cast<char *>(get_info_sql.c_str()) ); 
	
	// Send the command to SQL Server and start execution
	dbsqlexec(DbProc);

	// Set DB_Table_Base class internal varaibles
	DB_Table_Base_Error_Number = dbretstatus ( DbProc );
	dout << "<!-- DB_Table_Base_Error_Number = (" << DB_Table_Base_Error_Number << ") -->\n";
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";
	dout << "<!-- Global_DBSuccess = (" << Global_DBSuccess << ") -->\n";
	

	if(Global_DBSuccess)
	{
		// Process the command
		// Get the actual data that is contained in the table itself
		if(dbresults(DbProc)) 
		{ 
			// Bind results to program variables.
			::dbbind( DbProc, 1,  NTBSTRINGBIND, ROW_COUNT, (BYTE *)( row_count			) );
			::dbbind( DbProc, 2,  NTBSTRINGBIND, 8		  , (BYTE *)( search_unique_id	) );
			while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			{ 
				rc = true;
			} 
		}

		// Get the actual data that is contained in the table itself
		if(dbresults(DbProc)) 
		{
			::dbbind( DbProc, 1,  NTBSTRINGBIND, USER_NAME		, (BYTE *)( user_name		) );
			::dbbind( DbProc, 2,  NTBSTRINGBIND, CITY			, (BYTE *)( city			) );
			::dbbind( DbProc, 3,  NTBSTRINGBIND, STATE			, (BYTE *)( state			) );
			::dbbind( DbProc, 4,  NTBSTRINGBIND, COUNTRY		, (BYTE *)( country			) );
			::dbbind( DbProc, 5,  NTBSTRINGBIND, AGE			, (BYTE *)( age				) );
			::dbbind( DbProc, 6,  NTBSTRINGBIND, SCREEN_QUOTE	, (BYTE *)( screen_quote	) );
			::dbbind( DbProc, 7,  NTBSTRINGBIND, ABOUT_YOURSELF	, (BYTE *)( about_yourself	) );
			::dbbind( DbProc, 8,  NTBSTRINGBIND, PHOTO_1		, (BYTE *)( photo_1			) );
			
			// prepare the url
/*			string url_buf("");
			url_buf += ("&state="		+ Get_FormData_From_ColumnName("state"));
			url_buf += ("&country="		+ Get_FormData_From_ColumnName("country"));
			url_buf += ("&sex_seeking="	+ Get_FormData_From_ColumnName("i_am"));
			url_buf += ("&sex_sought="	+ Get_FormData_From_ColumnName("seeking"));
			url_buf += ("&min_age="		+ Get_FormData_From_ColumnName("min_age_desired"));
			url_buf += ("&max_age="		+ Get_FormData_From_ColumnName("max_age_desired"));
			cfl.Html_Begin(Map, my_cookie_found, SEARCH_TYPE, const_cast<char *>(url_buf.c_str()));
			//cout << "<BR> search_unique_id = (" << search_unique_id << ")<BR>" << endl;
*/
			

			// Get the HTML Top along with the Text Ad Delivery Code...
			cfl.Html_Begin(Map, my_cookie_found, SEARCH_TYPE, search_unique_id);


			// begin the result set with some return info...
			dout << "<!-- index:" << index << " limit:" << limit << "-->" << endl;
			cout << "          <TABLE align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"550\">\n"
				<< "            <TBODY>\n"
				<< "              <TR>\n"
				<< "                <TD align=\"left\">\n"
				<< "                  <FONT face=\"Arial, Hevetica\" size=\"+1\"><STRONG>";
			if(program_name == "SimpleSearch.exe")
			{
				cout << "Simple Search Results";
			}
			else if(program_name == "AdvancedSearch.exe")
			{
				cout << "Advanced Search Results";
			}
			cout << "</STRONG>\n"
				<< "                </TD>\n"
				<< "              </TR>\n"
				<< "              <TR>\n"
				<< "                <TD align=\"left\">\n"
				<< "                </TD>\n"
				<< "              </TR>\n"
				<< "              <TR>\n"
				<< "                <TD align=\"left\">\n"
				<< "                  <FONT face=\"Arial, Hevetica\" size=\"-2\">Your search returned <STRONG>" << row_count << "</STRONG> profiles!\n"
				<< "                  <BR>\n";
			if(atoi(row_count) > 0)
			{
				cout << "                   Results " << index << " Through " << ( (index + limit) > atoi(row_count) ? atoi(row_count) : (index+limit) ) << " are shown below.</FONT>\n";
			}
			cout << "                </TD>\n"
				<< "              </TR>\n"
				<< "            </TBODY>\n"
				<< "          </TABLE>\n";
			if(atoi(row_count) > 0)
			{
				cout << "          <TABLE align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"550\">\n"
					<< "            <TBODY>\n"
					<< "              <TR>\n"
					<< "                <TD colspan=\"2\">\n"
					<< "                  <IMG ALT=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
					<< "                </TD>\n"
					<< "              </TR>\n"
					<< "              <TR>\n"
					<< "                <TD align=\"center\">\n"
					<< endl << flush;
				
				if( index > limit )
				{
					cout << "<!-- First Result Set -->\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
					for(unsigned int i=0; i<Vect.size()-1; i++)
					{
						if (i == 0)
							cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
						else
							cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					}
					cout << "&amp;index="			<< 1
						<< "\"><IMG ALT=\"Display First\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "FIRSTARROW" ) << "\"></A> \n"
						<< "<!-- Previous Result Set -->\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
					for(i=0; i<Vect.size()-1; i++)
					{
						if (i == 0)
							cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
						else
							cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					}
					cout << "&amp;index="			<< index - limit
						<< "\"><IMG ALT=\"Previous\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "PREVIOUSARROW" ) << "\"></A>\n"
						<< endl << flush;
				}
				if( atoi(row_count) > (index+limit) )
				{
					cout << "<!-- Next Result Set -->\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
					
					for(unsigned int i=0; i<Vect.size()-1; i++)
					{
						if (i == 0)
							cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
						else
							cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					}
					cout << "&amp;index="			<< index + limit
						<< "\"><IMG ALT=\"Display Next\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NEXTARROW" ) << "\"></A> \n"
						<< "<!-- Last Result Set -->\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
					for(i=0; i<Vect.size()-1; i++)
					{
						if (i == 0)
							cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
						else
							cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					}
					cout << "&amp;index="			<< atoi(row_count) - limit
						<< "\"><IMG ALT=\"Display Last\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LASTARROW" ) << "\"></A>\n"
						<< endl << flush;
				}
				
				cout << "                </TD>\n"
					<< "              </TR>\n"
					<< "              <TR>\n"
					<< "                <TD colspan=\"2\">\n"
					<< "                  <IMG ALT=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
					<< "                </TD>\n"
					<< "              </TR>\n"
					<< "            </TBODY>\n"
					<< "          </TABLE>\n";
			}// end if row_count > 0
				cout << endl << flush;
			// Clear out results...
			int count = 1;

			while ( dbnextrow(DbProc) != NO_MORE_ROWS )
			{
				if( (count >= index) && (count < (limit + index)) )
				{
					// convert the "screen_quote" character array to a std::string and replace email addresses...
					string screen_quote_str = Replace_Email_With_Links(screen_quote, user_name, Map);
					// check if a link has been added to the "screen_quote_str"...
					string::size_type end_of_link_idx = screen_quote_str.find("</A>");
					if( end_of_link_idx != string::npos) 
					{
						// Only print up to the end of the hot link
						screen_quote_str = screen_quote_str.substr(0, end_of_link_idx+4);
					}
					else if(screen_quote_str.size() > SCREEN_QUOTE_LENGTH_CUT_OFF)
					{
						// Only print the first part of the string
						screen_quote_str = screen_quote_str.substr(0, SCREEN_QUOTE_LENGTH_CUT_OFF) + "...";
					}

					// convert the "about_yourself" character array to a std::string and replace email addresses...
					string about_yourself_str = Replace_Email_With_Links(about_yourself, user_name, Map);
					// check if a link has been added to the "about_yourself_str"...
					end_of_link_idx = about_yourself_str.find("</A>");
					if( end_of_link_idx != string::npos) 
					{
						// Only print the first part of the string
						about_yourself_str = about_yourself_str.substr(0, end_of_link_idx+4);
					}
					else if(about_yourself_str.size() > ABOUT_YOURSELF_LENGTH_CUT_OFF)
					{
						// Only print the first part of the string
						about_yourself_str = about_yourself_str.substr(0, ABOUT_YOURSELF_LENGTH_CUT_OFF) + "...";
					}
					// Begin Repeatable User Profile Table
					cout << "          <!--    START MAIN TABLE   //-->\n"
						<< "          <TABLE align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"550\">\n"
						<< "            <TBODY>\n"
						<< "              <TR>\n"
						<< "                <TD align=\"center\" valign=\"center\" width=\"60\">\n"
						<< "                  <A href=\"" 
						<< Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name;
					
					if(!strcmp(photo_1, "Nothing") || strlen(photo_1) < 1)
						cout << "\"><IMG alt=\"Picture of person 1 not available\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_SMALL" ) << "\" width=\"60\" height=\"60\" border=\"0\">\n";
					else
						cout << "\"><IMG alt=\"Picture of person 1\" border=\"0\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60X60_" << photo_1 << "\" width=\"60\" height=\"60\">\n";
					
					cout << "                 <FONT size=\"-2\" color=\"#3300FF\" face=\"Arial, Helvetica, Sans Serif\">Details...</FONT></A>\n"
						<< "                  </A>\n"
						<< "                </TD>\n"
						<< "                <TD width=\"15\">\n"
						<< "                  <IMG ALT=\"Empty Space\" border=\"0\" height=\"1\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "SPACESYMBOL" ) << "\" width=\"15\">\n"
						<< "                </TD>\n"
						<< "                <TD valign=\"top\" width=\"500\">\n"
						<< "                  <FONT color=\"#666666\" face=\"Arial, Helvetica, Sans Serif\" size=\"2\"><STRONG>" << user_name << "&nbsp;:&nbsp;" << screen_quote_str << "</STRONG></FONT>\n"
						<< "                  <BR>\n"
						<< "                   <FONT color=\"#333399\" face=\"Arial, Helvetica\" size=\"-1\"> FROM:&nbsp;" << city << ",&nbsp;" << state << ",&nbsp;" << country << "&nbsp;&nbsp;AGE:&nbsp;" << age << "\n"
						<< "                  <BR clear=\"all\">\n"
						<< "                   " << about_yourself_str << "</FONT>\n"//, ValidateParagraph(user_fields.about_yourself)
						<< "                </TD>\n"
						<< "                <TD align=\"center\" valign=\"top\" width=\"40\">\n"
						<< "                  <DIV align=\"center\">\n"
						<< "                    <FONT color=\"#666666\" face=\"Arial, Hevetica\" size=\"-2\">Contact</FONT>\n"
						<< "                     <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenSendMail.exe?user_name=" << user_name << "\"><IMG ALT=\"Send " << user_name 
						<< " email.\" align=\"center\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "EMAILSYMBOL" ) << "\"></A>\n"
						<< "                  </DIV>\n"
						<< "                </TD>\n"
						<< "              </TR>\n"
						<< "              <TR>\n"
						<< "                <TD colspan=\"4\">\n"
						<< "                  <IMG ALT=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
						<< "                </TD>\n"
						<< "              </TR>\n"
						<< "            </TBODY>\n"
						<< "          </TABLE>\n"
						<< endl << flush;
				}
				// End Repeatable User Profile Table
				count++ ;
			}
			cout << "          <TABLE align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"550\">\n"
				<< "            <TBODY>\n"
				<< "              <TR>\n"
				<< "                <TD colspan=\"2\">\n"
				<< "                  <IMG ALT=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
				<< "                </TD>\n"
				<< "              </TR>\n"
				<< "              <TR>\n"
				<< "                <TD align=\"center\">\n"
				<< "<!-- Number of rows returned = \"" << count << "\" -->\n"
				<< endl << flush;
			
			if( index > limit )
			{
				cout << "<!-- First Result Set -->\n"
					<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
				for(unsigned int i=0; i<Vect.size()-1; i++)
				{
					if (i == 0)
						cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					else
						cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
				}
				cout << "&amp;index="			<< 1
					<< "\"><IMG ALT=\"Display First\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "FIRSTARROW" ) << "\"></A> \n"
					<< "<!-- Previous Result Set -->\n"
					<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
				for(i=0; i<Vect.size()-1; i++)
				{
					if (i == 0)
						cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					else
						cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
				}
				cout << "&amp;index="			<< index - limit
					<< "\"><IMG ALT=\"Previous\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "PREVIOUSARROW" ) << "\"></A>\n"
					<< endl << flush;
			}
			if( atoi(row_count) > (index+limit) )
			{
				cout << "<!-- Next Result Set -->\n"
					<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
				
				for(unsigned int i=0; i<Vect.size()-1; i++)
				{
					if (i == 0)
						cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					else
						cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
				}
				cout << "&amp;index="			<< index + limit
					<< "\"><IMG ALT=\"Display Next\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NEXTARROW" ) << "\"></A> \n"
					<< "<!-- Last Result Set -->\n"
					<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
				for(i=0; i<Vect.size()-1; i++)
				{
					if (i == 0)
						cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					else
						cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
				}
				cout << "&amp;index="			<< atoi(row_count) - limit
					<< "\"><IMG ALT=\"Display Last\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LASTARROW" ) << "\"></A>\n"
					<< endl << flush;
			}
			
			cout << "                </TD>\n"
				<< "              </TR>\n"
				<< "              <TR>\n"
				<< "                <TD colspan=\"2\">\n"
				<< "                  <IMG alt=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
				<< "                </TD>\n"
				<< "              </TR>\n"
				<< "            </TBODY>\n"
				<< "          </TABLE>\n"			
				<< endl << flush;
		}// end if(dbresults(DbProc)) 
		
	}// end if(Global_DBSuccess)
	else
	{
		// Get the HTML Top along with the Text Ad Delivery Code...
		cfl.Html_Begin(Map, 0, SEARCH_TYPE, "0");
	}
	
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";

	// Close the connection to SQL Server
	dbexit();
	
	if(!Global_DBSuccess)
	{
		return Global_DBSuccess;
	}
	else
	{
		return rc;
	}
} // Search_The_DB 

// Used for GenBookMarks.exe
bool
DB_Table_Base::GenBookMarks_The_DB(LinkMap & Map, const string & program_name, const int index, const int limit)
{
	CConnectionsFormLayout cfl;
	Global_DBSuccess = true;
	
	char row_count			[ROW_COUNT			];
	char search_unique_id	[SEARCH_UNIQUE_ID	];
	char user_name			[USER_NAME			];
	char city				[CITY				];
	char state				[STATE				];
	char country			[COUNTRY			];
	char age				[AGE				];
	char screen_quote		[SCREEN_QUOTE		];
	char about_yourself		[ABOUT_YOURSELF		];
	char photo_1			[PHOTO_1			];
	
	memset(row_count		, ROW_COUNT			, NULL);
	memset(search_unique_id	, SEARCH_UNIQUE_ID	, NULL);
	memset(user_name		, USER_NAME			, NULL);
	memset(city				, CITY				, NULL);
	memset(state			, STATE				, NULL);
	memset(country			, COUNTRY			, NULL);
	memset(age				, AGE				, NULL);
	memset(screen_quote		, SCREEN_QUOTE		, NULL);
	memset(about_yourself	, ABOUT_YOURSELF	, NULL);
	memset(photo_1			, PHOTO_1			, NULL);
	
	bool rc = this->Initialize_DbProc(Map);
	
	dout << "<!-- Initialize_DbProc returned (" << rc << ") -->\n" << flush;
/*
	if(rc == 0)
	{
		DB_Table_Base_Error_Number = -1;
		DB_Table_Base_Error_Text = "Database Error.  Contact <FONT color=\"red\">" + Map.PrintValue( "EMAIL" ) + "</FONT> for assistence with this problem.\n\n<!-- ########### Check DB username and password. ########### -->\n\n";
		return false;
	}
*/

	// First, put the command into the command buffer.
	dout << "<!-- DB SQL:" << update_info_sql << " -->" << endl;
	dbcmd( DbProc, const_cast<char *>(update_info_sql.c_str()) ); 
	
	// Send the command to SQL Server and start execution
	dbsqlexec(DbProc);

	// Set DB_Table_Base class internal varaibles
	DB_Table_Base_Error_Number = dbretstatus ( DbProc );
	dout << "<!-- DB_Table_Base_Error_Number = (" << DB_Table_Base_Error_Number << ") -->\n";
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";
	
	if(Global_DBSuccess)
	{
		// Process the command
		// Get the actual data that is contained in the table itself
		if(dbresults(DbProc)) 
		{ 
			// Bind results to program variables.
			::dbbind( DbProc, 1,  NTBSTRINGBIND, ROW_COUNT			, (BYTE *)( row_count			) );
			::dbbind( DbProc, 2,  NTBSTRINGBIND, SEARCH_UNIQUE_ID	, (BYTE *)( search_unique_id	) );
			while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			{ 
				rc = true;
			} 
		}
		// Get the HTML Top along with the Text Ad Delivery Code...
		cfl.Html_Begin(Map, 1, GEN_BOOKMARKS, search_unique_id);
		// Process the command
		if(dbresults(DbProc)) 
		{
			::dbbind( DbProc, 1,  NTBSTRINGBIND, USER_NAME		, (BYTE *)( user_name		) );
			::dbbind( DbProc, 2,  NTBSTRINGBIND, CITY			, (BYTE *)( city			) );
			::dbbind( DbProc, 3,  NTBSTRINGBIND, STATE			, (BYTE *)( state			) );
			::dbbind( DbProc, 4,  NTBSTRINGBIND, COUNTRY		, (BYTE *)( country			) );
			::dbbind( DbProc, 5,  NTBSTRINGBIND, AGE			, (BYTE *)( age				) );
			::dbbind( DbProc, 6,  NTBSTRINGBIND, SCREEN_QUOTE	, (BYTE *)( screen_quote	) );
			::dbbind( DbProc, 7,  NTBSTRINGBIND, ABOUT_YOURSELF	, (BYTE *)( about_yourself	) );
			::dbbind( DbProc, 8,  NTBSTRINGBIND, PHOTO_1		, (BYTE *)( photo_1			) );
			
			// begin the result set with some return info...
			dout << "<!-- index:" << index << " limit:" << limit << "-->" << endl;
			cout << "          <TABLE align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"550\">\n"
				<< "            <TBODY>\n"
				<< "              <TR>\n"
				<< "                <TD align=\"left\">\n"
				<< "                  <FONT face=\"Arial, Hevetica\" size=\"+1\"><STRONG>Bookmarks</STRONG>\n"
				<< "                </TD>\n"
				<< "              </TR>\n"
				<< "              <TR>\n"
				<< "                <TD align=\"left\">\n"
				<< "                </TD>\n"
				<< "              </TR>\n"
				<< "              <TR>\n"
				<< "                <TD align=\"left\">\n"
				<< "                  <FONT face=\"Arial, Hevetica\" size=\"-2\">You have <STRONG>" << row_count << "</STRONG> profiles bookmarked!\n"
				<< "                  <BR>\n";
			if(atoi(row_count) > 0)
			{
				cout << "                   Bookmarks " << index << " Through " << ( (index + limit) > atoi(row_count) ? atoi(row_count) : (index+limit) ) << " are shown below.</FONT>\n";
			}
			cout << "                </TD>\n"
				<< "              </TR>\n"
				<< "            </TBODY>\n"
				<< "          </TABLE>\n";
			if(atoi(row_count) > 0)
			{
				
				cout << "          <TABLE align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"550\">\n"
					<< "            <TBODY>\n"
					<< "              <TR>\n"
					<< "                <TD colspan=\"2\">\n"
					<< "                  <IMG ALT=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
					<< "                </TD>\n"
					<< "              </TR>\n"
					<< "              <TR>\n"
					<< "                <TD align=\"center\">\n"
					<< endl << flush;
				
				if( index > limit )
				{
					cout << "<!-- First Result Set -->\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
					for(unsigned int i=0; i<Vect.size()-1; i++)
					{
						if (i == 0)
							cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
						else
							cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					}
					cout << "&amp;index="			<< 1
						<< "\"><IMG ALT=\"Display First\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "FIRSTARROW" ) << "\"></A> \n"
						<< "<!-- Previous Result Set -->\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
					for(i=0; i<Vect.size()-1; i++)
					{
						if (i == 0)
							cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
						else
							cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					}
					cout << "&amp;index="			<< index - limit
						<< "\"><IMG ALT=\"Previous\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "PREVIOUSARROW" ) << "\"></A>\n"
						<< endl << flush;
				}
				if( atoi(row_count) > (index+limit) )
				{
					cout << "<!-- Next Result Set -->\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
					
					for(unsigned int i=0; i<Vect.size()-1; i++)
					{
						if (i == 0)
							cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
						else
							cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					}
					cout << "&amp;index="			<< index + limit
						<< "\"><IMG ALT=\"Display Next\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NEXTARROW" ) << "\"></A> \n"
						<< "<!-- Last Result Set -->\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
					for(i=0; i<Vect.size()-1; i++)
					{
						if (i == 0)
							cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
						else
							cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					}
					cout << "&amp;index="			<< atoi(row_count) - limit
						<< "\"><IMG ALT=\"Display Last\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LASTARROW" ) << "\"></A>\n"
						<< endl << flush;
				}
				
				cout << "                </TD>\n"
					<< "              </TR>\n"
					<< "              <TR>\n"
					<< "                <TD colspan=\"2\">\n"
					<< "                  <IMG ALT=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
					<< "                </TD>\n"
					<< "              </TR>\n"
					<< "            </TBODY>\n"
					<< "          </TABLE>\n";
			}
			cout << endl << flush;
			// Clear out results...
			int count = 1;
			while ( dbnextrow(DbProc) != NO_MORE_ROWS )
			{
				if( (count >= index) && (count < (limit + index)) )
				{
					// convert the "about_yourself" character array to a std::string ...
					string about_yourself_str	= about_yourself;
					if(about_yourself_str.size() > ABOUT_YOURSELF_LENGTH_CUT_OFF)
					{
						// Only print the first part of the string
						about_yourself_str = about_yourself_str.substr(0, ABOUT_YOURSELF_LENGTH_CUT_OFF) + "...";
					}
					// convert the "screen_quote" character array to a std::string ...
					string screen_quote_str	= screen_quote;
					if(screen_quote_str.size() > SCREEN_QUOTE_LENGTH_CUT_OFF)
					{
						// Only print the first part of the string
						screen_quote_str = screen_quote_str.substr(0, SCREEN_QUOTE_LENGTH_CUT_OFF) + "...";
					}
					// Begin Repeatable User Profile Table
					cout << "          <!--    START MAIN TABLE   //-->\n"
						<< "          <TABLE align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"550\">\n"
						<< "            <TBODY>\n"
						<< "              <TR>\n"
						<< "                <TD align=\"center\" valign=\"center\" width=\"60\">\n"
						<< "                  <A href=\"" 
						<< Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name;
					
					if(!strcmp(photo_1, "Nothing") || strlen(photo_1) < 1)
						cout << "\"><IMG alt=\"Picture of person 1 not available\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_SMALL" ) << "\" width=\"60\" height=\"60\">\n";
					else
						cout << "\"><IMG alt=\"Picture of person 1\" border=\"0\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60X60_" << photo_1 << "\" width=\"60\" height=\"60\">\n";
					
					cout << "                 <FONT size=\"-2\" color=\"#3300FF\" face=\"Arial, Helvetica, Sans Serif\">Details...</FONT></A>\n"
						<< "                  </A>\n"
						<< "                </TD>\n"
						<< "                <TD width=\"15\">\n"
						<< "                  <IMG ALT=\"Empty Space\" border=\"0\" height=\"1\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "SPACESYMBOL" ) << "\" width=\"15\">\n"
						<< "                </TD>\n"
						<< "                <TD valign=\"top\" width=\"500\">\n"
						<< "                  <FONT color=\"#666666\" face=\"Arial, Helvetica, Sans Serif\" size=\"2\"><STRONG>" << user_name << "&nbsp;:&nbsp;" << screen_quote_str << "</STRONG></FONT>\n"
						<< "                  <BR>\n"
						<< "                   <FONT color=\"#333399\" face=\"Arial, Helvetica\" size=\"-1\"> FROM:&nbsp;" << city << ",&nbsp;" << state << ",&nbsp;" << country << "&nbsp;&nbsp;AGE:&nbsp;" << age << "\n"
						<< "                  <BR clear=\"all\">\n"
						<< "                   " << about_yourself_str << "</FONT>\n"//, ValidateParagraph(user_fields.about_yourself)
						<< "                </TD>\n"
						<< "                <TD align=\"center\" valign=\"top\" width=\"40\">\n"
						<< "                  <DIV align=\"center\">\n"
						<< "                    <FONT color=\"#666666\" face=\"Arial, Hevetica\" size=\"-2\">Contact</FONT>\n"
						<< "                     <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenSendMail.exe?user_name=" << user_name << "\"><IMG ALT=\"Send " << user_name 
						<< " email.\" align=\"center\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "EMAILSYMBOL" ) << "\"></A>\n"
						<< "                    <BR>&nbsp;\n"
						<< "                    <BR>\n"
						<< "                     <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/UpdateBookMarks.exe?book_mark=" << user_name << "&add_remove=Remove\">"
						<< "                      <IMG ALT=\"Remove " << user_name << " from bookmarks folder...\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "DELETSYMBOL" ) << "\" border=\"0\"></A>"
						<< "                  </DIV>\n"
						<< "                </TD>\n"
						<< "              </TR>\n"
						<< "              <TR>\n"
						<< "                <TD colspan=\"4\">\n"
						<< "                  <IMG ALT=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
						<< "                </TD>\n"
						<< "              </TR>\n"
						<< "            </TBODY>\n"
						<< "          </TABLE>\n"
						<< endl << flush;
				}
				// End Repeatable User Profile Table
				count++ ;
			}
			cout << "          <TABLE align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"550\">\n"
				<< "            <TBODY>\n"
				<< "              <TR>\n"
				<< "                <TD colspan=\"2\">\n"
				<< "                  <IMG ALT=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
				<< "                </TD>\n"
				<< "              </TR>\n"
				<< "              <TR>\n"
				<< "                <TD align=\"center\">\n"
				<< "<!-- Number of rows returned = \"" << count << "\" -->\n"
				<< endl << flush;
			
			if( index > limit )
			{
				cout << "<!-- First Result Set -->\n"
					<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
				for(unsigned int i=0; i<Vect.size()-1; i++)
				{
					if (i == 0)
						cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					else
						cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
				}
				cout << "&amp;index="			<< 1
					<< "\"><IMG ALT=\"Display First\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "FIRSTARROW" ) << "\"></A> \n"
					<< "<!-- Previous Result Set -->\n"
					<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
				for(i=0; i<Vect.size()-1; i++)
				{
					if (i == 0)
						cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					else
						cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
				}
				cout << "&amp;index="			<< index - limit
					<< "\"><IMG ALT=\"Previous\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "PREVIOUSARROW" ) << "\"></A>\n"
					<< endl << flush;
			}
			if( atoi(row_count) > (index+limit) )
			{
				cout << "<!-- Next Result Set -->\n"
					<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
				
				for(unsigned int i=0; i<Vect.size()-1; i++)
				{
					if (i == 0)
						cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					else
						cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
				}
				cout << "&amp;index="			<< index + limit
					<< "\"><IMG ALT=\"Display Next\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NEXTARROW" ) << "\"></A> \n"
					<< "<!-- Last Result Set -->\n"
					<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
				for(i=0; i<Vect.size()-1; i++)
				{
					if (i == 0)
						cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					else
						cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
				}
				cout << "&amp;index="			<< atoi(row_count) - limit
					<< "\"><IMG ALT=\"Display Last\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LASTARROW" ) << "\"></A>\n"
					<< endl << flush;
			}
			
			cout << "                </TD>\n"
				<< "              </TR>\n"
				<< "              <TR>\n"
				<< "                <TD colspan=\"2\">\n"
				<< "                  <IMG alt=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
				<< "                </TD>\n"
				<< "              </TR>\n"
				<< "            </TBODY>\n"
				<< "          </TABLE>\n"			
				<< endl << flush;
		}// end if(dbresults(DbProc)) 
		
	}// end if(Global_DBSuccess)
	else
	{
		// Get the HTML Top along with the Text Ad Delivery Code...
		cfl.Html_Begin(Map, 1, GEN_BOOKMARKS, "0");
	}
	
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";

	// Close the connection to SQL Server
	dbexit();
	
	if(!Global_DBSuccess)
	{
		return Global_DBSuccess;
	}
	else
	{
		return rc;
	}
} // GenBookMarks_The_DB 

// Used for ViewWinks.exe
bool
DB_Table_Base::ViewWinks_The_DB(LinkMap & Map, const string & program_name, const int index, const int limit)
{
	CConnectionsFormLayout cfl;
	Global_DBSuccess = true;
	
	char row_count			[ROW_COUNT			];
	char search_unique_id	[SEARCH_UNIQUE_ID	];
	char user_name			[USER_NAME			];
	char city				[CITY				];
	char state				[STATE				];
	char country			[COUNTRY			];
	char age				[AGE				];
	char screen_quote		[SCREEN_QUOTE		];
	char about_yourself		[ABOUT_YOURSELF		];
	char photo_1			[PHOTO_1			];
	
	memset(row_count		, ROW_COUNT			, NULL);
	memset(search_unique_id	, SEARCH_UNIQUE_ID	, NULL);
	memset(user_name		, USER_NAME			, NULL);
	memset(city				, CITY				, NULL);
	memset(state			, STATE				, NULL);
	memset(country			, COUNTRY			, NULL);
	memset(age				, AGE				, NULL);
	memset(screen_quote		, SCREEN_QUOTE		, NULL);
	memset(about_yourself	, ABOUT_YOURSELF	, NULL);
	memset(photo_1			, PHOTO_1			, NULL);
	
	bool rc = this->Initialize_DbProc(Map);
	
	dout << "<!-- Initialize_DbProc returned (" << rc << ") -->\n" << flush;
/*
	if(rc == 0)
	{
		DB_Table_Base_Error_Number = -1;
		DB_Table_Base_Error_Text = "Database Error.  Contact <FONT color=\"red\">" + Map.PrintValue( "EMAIL" ) + "</FONT> for assistence with this problem.\n\n<!-- ########### Check DB username and password. ########### -->\n\n";
		return false;
	}
*/

	// First, put the command into the command buffer.
	dout << "<!-- DB SQL:" << update_info_sql << " -->" << endl;
	dbcmd( DbProc, const_cast<char *>(update_info_sql.c_str()) ); 
	
	// Send the command to SQL Server and start execution
	dbsqlexec(DbProc);

	// Set DB_Table_Base class internal varaibles
	DB_Table_Base_Error_Number = dbretstatus ( DbProc );
	dout << "<!-- DB_Table_Base_Error_Number = (" << DB_Table_Base_Error_Number << ") -->\n";
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";
	
	if(Global_DBSuccess)
	{
		// Process the command
		// Get the actual data that is contained in the table itself
		if(dbresults(DbProc)) 
		{ 
			// Bind results to program variables.
			::dbbind( DbProc, 1,  NTBSTRINGBIND, ROW_COUNT			, (BYTE *)( row_count			) );
			::dbbind( DbProc, 2,  NTBSTRINGBIND, SEARCH_UNIQUE_ID	, (BYTE *)( search_unique_id	) );
			while (dbnextrow(DbProc) != NO_MORE_ROWS) 
			{ 
				rc = true;
			} 
		}
		// Get the HTML Top along with the Text Ad Delivery Code...
		cfl.Html_Begin(Map, 1, VIEW_WINKS, search_unique_id);
		// Process the command
		if(dbresults(DbProc)) 
		{
			::dbbind( DbProc, 1,  NTBSTRINGBIND, USER_NAME		, (BYTE *)( user_name		) );
			::dbbind( DbProc, 2,  NTBSTRINGBIND, CITY			, (BYTE *)( city			) );
			::dbbind( DbProc, 3,  NTBSTRINGBIND, STATE			, (BYTE *)( state			) );
			::dbbind( DbProc, 4,  NTBSTRINGBIND, COUNTRY		, (BYTE *)( country			) );
			::dbbind( DbProc, 5,  NTBSTRINGBIND, AGE			, (BYTE *)( age				) );
			::dbbind( DbProc, 6,  NTBSTRINGBIND, SCREEN_QUOTE	, (BYTE *)( screen_quote	) );
			::dbbind( DbProc, 7,  NTBSTRINGBIND, ABOUT_YOURSELF	, (BYTE *)( about_yourself	) );
			::dbbind( DbProc, 8,  NTBSTRINGBIND, PHOTO_1		, (BYTE *)( photo_1			) );
			
			// begin the result set with some return info...
			dout << "<!-- index:" << index << " limit:" << limit << "-->" << endl;
			cout << "          <TABLE align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"550\">\n"
				<< "            <TBODY>\n"
				<< "              <TR>\n"
				<< "                <TD align=\"left\">\n"
				<< "                  <FONT face=\"Arial, Hevetica\" size=\"+1\"><STRONG>Winks</STRONG>\n"
				<< "                </TD>\n"
				<< "              </TR>\n"
				<< "              <TR>\n"
				<< "                <TD align=\"left\">\n"
				<< "                </TD>\n"
				<< "              </TR>\n"
				<< "              <TR>\n"
				<< "                <TD align=\"left\">\n"
				<< "                  <FONT face=\"Arial, Hevetica\" size=\"-2\">So far <STRONG>" << row_count << "</STRONG> members liked your profile enough to send you a wink. &nbsp;Now that they've made the first move, here's your chance to return the favor. &nbsp;Continue the conversation by sending them a message today!<BR>\n"
				<< "                  <BR>\n";
			if(atoi(row_count) > 0)
			{
				cout << "                   Winks " << index << " Through " << ( (index + limit) > atoi(row_count) ? atoi(row_count) : (index+limit) ) << " are shown below.</FONT>\n";
			}
			cout << "                </TD>\n"
				<< "              </TR>\n"
				<< "            </TBODY>\n"
				<< "          </TABLE>\n";
			if(atoi(row_count) > 0)
			{
				
				cout << "          <TABLE align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"550\">\n"
					<< "            <TBODY>\n"
					<< "              <TR>\n"
					<< "                <TD colspan=\"2\">\n"
					<< "                  <IMG ALT=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
					<< "                </TD>\n"
					<< "              </TR>\n"
					<< "              <TR>\n"
					<< "                <TD align=\"center\">\n"
					<< endl << flush;
				
				if( index > limit )
				{
					cout << "<!-- First Result Set -->\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
					for(unsigned int i=0; i<Vect.size()-1; i++)
					{
						if (i == 0)
							cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
						else
							cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					}
					cout << "&amp;index="			<< 1
						<< "\"><IMG ALT=\"Display First\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "FIRSTARROW" ) << "\"></A> \n"
						<< "<!-- Previous Result Set -->\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
					for(i=0; i<Vect.size()-1; i++)
					{
						if (i == 0)
							cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
						else
							cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					}
					cout << "&amp;index="			<< index - limit
						<< "\"><IMG ALT=\"Previous\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "PREVIOUSARROW" ) << "\"></A>\n"
						<< endl << flush;
				}
				if( atoi(row_count) > (index+limit) )
				{
					cout << "<!-- Next Result Set -->\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
					
					for(unsigned int i=0; i<Vect.size()-1; i++)
					{
						if (i == 0)
							cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
						else
							cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					}
					cout << "&amp;index="			<< index + limit
						<< "\"><IMG ALT=\"Display Next\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NEXTARROW" ) << "\"></A> \n"
						<< "<!-- Last Result Set -->\n"
						<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
					for(i=0; i<Vect.size()-1; i++)
					{
						if (i == 0)
							cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
						else
							cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					}
					cout << "&amp;index="			<< atoi(row_count) - limit
						<< "\"><IMG ALT=\"Display Last\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LASTARROW" ) << "\"></A>\n"
						<< endl << flush;
				}
				
				cout << "                </TD>\n"
					<< "              </TR>\n"
					<< "              <TR>\n"
					<< "                <TD colspan=\"2\">\n"
					<< "                  <IMG ALT=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
					<< "                </TD>\n"
					<< "              </TR>\n"
					<< "            </TBODY>\n"
					<< "          </TABLE>\n";
			}
			cout << endl << flush;
			// Clear out results...
			int count = 1;
			while ( dbnextrow(DbProc) != NO_MORE_ROWS )
			{
				if( (count >= index) && (count < (limit + index)) )
				{
					// convert the "about_yourself" character array to a std::string ...
					string about_yourself_str	= about_yourself;
					if(about_yourself_str.size() > ABOUT_YOURSELF_LENGTH_CUT_OFF)
					{
						// Only print the first part of the string
						about_yourself_str = about_yourself_str.substr(0, ABOUT_YOURSELF_LENGTH_CUT_OFF) + "...";
					}
					// convert the "screen_quote" character array to a std::string ...
					string screen_quote_str	= screen_quote;
					if(screen_quote_str.size() > SCREEN_QUOTE_LENGTH_CUT_OFF)
					{
						// Only print the first part of the string
						screen_quote_str = screen_quote_str.substr(0, SCREEN_QUOTE_LENGTH_CUT_OFF) + "...";
					}
					// Begin Repeatable User Profile Table
					cout << "          <!--    START MAIN TABLE   //-->\n"
						<< "          <TABLE align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"550\">\n"
						<< "            <TBODY>\n"
						<< "              <TR>\n"
						<< "                <TD align=\"center\" valign=\"center\" width=\"60\">\n"
						<< "                  <A href=\"" 
						<< Map.PrintValue( "CGIBIN" ) << "/SingleProfile.exe?user_name=" << user_name;
					
					if(!strcmp(photo_1, "Nothing") || strlen(photo_1) < 1)
						cout << "\"><IMG alt=\"Picture of person 1 not available\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NO_PIC_SMALL" ) << "\" width=\"60\" height=\"60\">\n";
					else
						cout << "\"><IMG alt=\"Picture of person 1\" border=\"0\" src=\"" << Map.PrintValue( "PICTURES" ) << "/60X60_" << photo_1 << "\" width=\"60\" height=\"60\">\n";
					
					cout << "                 <FONT size=\"-2\" color=\"#3300FF\" face=\"Arial, Helvetica, Sans Serif\">Details...</FONT></A>\n"
						<< "                  </A>\n"
						<< "                </TD>\n"
						<< "                <TD width=\"15\">\n"
						<< "                  <IMG ALT=\"Empty Space\" border=\"0\" height=\"1\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "SPACESYMBOL" ) << "\" width=\"15\">\n"
						<< "                </TD>\n"
						<< "                <TD valign=\"top\" width=\"500\">\n"
						<< "                  <FONT color=\"#666666\" face=\"Arial, Helvetica, Sans Serif\" size=\"2\"><STRONG>" << user_name << "&nbsp;:&nbsp;" << screen_quote_str << "</STRONG></FONT>\n"
						<< "                  <BR>\n"
						<< "                   <FONT color=\"#333399\" face=\"Arial, Helvetica\" size=\"-1\"> FROM:&nbsp;" << city << ",&nbsp;" << state << ",&nbsp;" << country << "&nbsp;&nbsp;AGE:&nbsp;" << age << "\n"
						<< "                  <BR clear=\"all\">\n"
						<< "                   " << about_yourself_str << "</FONT>\n"//, ValidateParagraph(user_fields.about_yourself)
						<< "                </TD>\n"
						<< "                <TD align=\"center\" valign=\"top\" width=\"40\">\n"
						<< "                  <DIV align=\"center\">\n"
						<< "                    <FONT color=\"#666666\" face=\"Arial, Hevetica\" size=\"-2\">Contact</FONT>\n"
						<< "                     <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/GenSendMail.exe?user_name=" << user_name << "\"><IMG ALT=\"Send " << user_name 
						<< " email.\" align=\"center\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "EMAILSYMBOL" ) << "\"></A>\n"
						<< "                    <BR>&nbsp;\n"
						<< "                    <BR>\n"
						<< "                     <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/DeleteWink.exe?delete_wink=" << user_name << "\">"
						<< "                      <IMG ALT=\"Remove " << user_name << " from winks folder...\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "DELETSYMBOL" ) << "\" border=\"0\"></A>"
						<< "                  </DIV>\n"
						<< "                </TD>\n"
						<< "              </TR>\n"
						<< "              <TR>\n"
						<< "                <TD colspan=\"4\">\n"
						<< "                  <IMG ALT=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
						<< "                </TD>\n"
						<< "              </TR>\n"
						<< "            </TBODY>\n"
						<< "          </TABLE>\n"
						<< endl << flush;
				}
				// End Repeatable User Profile Table
				count++ ;
			}
			cout << "          <TABLE align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"550\">\n"
				<< "            <TBODY>\n"
				<< "              <TR>\n"
				<< "                <TD colspan=\"2\">\n"
				<< "                  <IMG ALT=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
				<< "                </TD>\n"
				<< "              </TR>\n"
				<< "              <TR>\n"
				<< "                <TD align=\"center\">\n"
				<< "<!-- Number of rows returned = \"" << count << "\" -->\n"
				<< endl << flush;
			
			if( index > limit )
			{
				cout << "<!-- First Result Set -->\n"
					<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
				for(unsigned int i=0; i<Vect.size()-1; i++)
				{
					if (i == 0)
						cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					else
						cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
				}
				cout << "&amp;index="			<< 1
					<< "\"><IMG ALT=\"Display First\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "FIRSTARROW" ) << "\"></A> \n"
					<< "<!-- Previous Result Set -->\n"
					<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
				for(i=0; i<Vect.size()-1; i++)
				{
					if (i == 0)
						cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					else
						cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
				}
				cout << "&amp;index="			<< index - limit
					<< "\"><IMG ALT=\"Previous\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "PREVIOUSARROW" ) << "\"></A>\n"
					<< endl << flush;
			}
			if( atoi(row_count) > (index+limit) )
			{
				cout << "<!-- Next Result Set -->\n"
					<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
				
				for(unsigned int i=0; i<Vect.size()-1; i++)
				{
					if (i == 0)
						cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					else
						cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
				}
				cout << "&amp;index="			<< index + limit
					<< "\"><IMG ALT=\"Display Next\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "NEXTARROW" ) << "\"></A> \n"
					<< "<!-- Last Result Set -->\n"
					<< "                  <A href=\"" << Map.PrintValue( "CGIBIN" ) << "/" << program_name << "?";
				for(i=0; i<Vect.size()-1; i++)
				{
					if (i == 0)
						cout << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
					else
						cout << "&amp;" << Vect[i].db_column_name << "=" << Get_FormData_From_ColumnName(Vect[i].db_column_name);
				}
				cout << "&amp;index="			<< atoi(row_count) - limit
					<< "\"><IMG ALT=\"Display Last\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LASTARROW" ) << "\"></A>\n"
					<< endl << flush;
			}
			
			cout << "                </TD>\n"
				<< "              </TR>\n"
				<< "              <TR>\n"
				<< "                <TD colspan=\"2\">\n"
				<< "                  <IMG alt=\"Seperation Line\" border=\"0\" src=\"" << Map.PrintValue( "IMAGES" ) << "/" << Map.PrintValue( "LINESYMBOL" ) << "\" width=\"549\" height=\"10\">\n"
				<< "                </TD>\n"
				<< "              </TR>\n"
				<< "            </TBODY>\n"
				<< "          </TABLE>\n"			
				<< endl << flush;
		}// end if(dbresults(DbProc)) 
		
	}// end if(Global_DBSuccess)
	else
	{
		// Get the HTML Top along with the Text Ad Delivery Code...
		cfl.Html_Begin(Map, 1, VIEW_WINKS, "0");
	}
	
	DB_Table_Base_Error_Text = DB_Error_Text;
	dout << "<!-- DB_Table_Base_Error_Text = (" << DB_Table_Base_Error_Text << "<!-- ) -->\n";

	// Close the connection to SQL Server
	dbexit();
	
	if(!Global_DBSuccess)
	{
		return Global_DBSuccess;
	}
	else
	{
		return rc;
	}
} // ViewWinks_The_DB 

const string
DB_Table_Base::Get_FormData_From_ColumnName(const string & name)
{
	for(unsigned int i=0; i<Vect.size(); i++)
	{
		if ( Vect[i].db_column_name == name)
		{
			//dout << "Within Get... \"" << Vect[i].Get_web_form_data << "\"" << endl; 
			return Vect[i].web_form_data;
		}
	}
	return "form_name not found";
}// Get_FormData_From_ColumnName		

const char *
DB_Table_Base::Get_DBData_From_ColumnName(const string & name)
{
	for(unsigned int i=0; i<Vect.size(); i++)
	{
		if ( Vect[i].db_column_name == name)
		{
			//dout << "Within Get... \"" << Vect[i].Get_db_column_data << "\"" << endl; 
			return Vect[i].db_column_data;
		}
	}
	return "column_name not found";
}// Get_DBData_From_ColumnName		

const char *
DB_Table_Base::Get_DBActual_From_ColumnName(const string & name)
{
	for(unsigned int i=0; i<Vect.size(); i++)
	{
		if ( Vect[i].db_column_name == name)
		{
			//dout << "Within Get... \"" << Vect[i].Get_db_column_data << "\"" << endl; 
			return Vect[i].db_column_actual;
		}
	}
	return "column_name not found";
}// Get_DBActual_From_ColumnName		

const int
DB_Table_Base::Get_RowNumber_From_ColumnName(const string & name)
{
	for(unsigned int i=0; i<Vect.size(); i++)
	{
		if ( Vect[i].db_column_name == name)
		{
//			dout << "Within Get... \"" << Vect[i].Get_web_form_data << "\"" << endl; 
			return Vect[i].row_number;
		}
	}
	return -1;
}// Get_RowNumber_From_ColumnName		

string
Replace_Returns_With_Breaks(const char * string_with_returns)
{
	// convert the "subject" character array to a std::string ...
	string srtring_with_breaks(strlen(string_with_returns), ' ');  // Create a string with blanks.
	
	int j = 0; // iterate through string_with_breaks...
	for(int i = 0; string_with_returns[i] != NULL; i++)
	{
		if (string_with_returns[i] == '\n' 
			&& string_with_returns[i-1] != '\n'
			&& string_with_returns[i+1] != '\n'
			)
		{
			srtring_with_breaks += "<BR>";
		}
		else
		{
			srtring_with_breaks += string_with_returns[i];
		}
	}
	return srtring_with_breaks;
}


string
Replace_Email_With_Links(const char * charstar_with_email, string UserName, LinkMap & Map)
{
	// convert the "subject" character array to a std::string ...
	string srtring_with_email(charstar_with_email);  // Create a string with blanks.
	string srtring_with_links(strlen(charstar_with_email), ' ');  // Create a string with blanks.
	
	const string delims(" \t\n");
	
	string::size_type atIdx, begIdx, endIdx;
	
	srtring_with_email = " " + srtring_with_email + " ";
	atIdx = srtring_with_email.find("@");
	
	if(atIdx == string::npos)
	{
		srtring_with_links = srtring_with_email;
	}
	else
	{
		while(srtring_with_email.find("@") != string::npos)
		{
			atIdx = srtring_with_email.find("@");
			begIdx = 0;
			for(int i=atIdx-1; i>=0; --i)
			{
				begIdx += 1;
				if(srtring_with_email.substr(i, atIdx-i).find(' ') != string::npos 
					|| srtring_with_email.substr(i, atIdx-i).find('\n') != string::npos
					|| i == 0)
				{
					break;
				}
			}
			begIdx = atIdx - begIdx;
			
			for(i=atIdx; i<=srtring_with_email.size(); ++i)
			{
				endIdx = srtring_with_email.substr(atIdx, i-atIdx).find_first_of(" \n");
				if( endIdx != string::npos || i==srtring_with_email.size() )
				{
					break;
				}
			}
			endIdx = atIdx + endIdx;
			
//			cout << "found \n" << srtring_with_email.substr(begIdx, endIdx-begIdx) << endl;
			string ReplacementString = "<A href=\"" + Map.PrintValue( "CGIBIN" ) + "/SingleProfile.exe?user_name=" + UserName + "\">view " + UserName + "'s email address...</A>";
			//string ReplacementString = " (" + UserName + "'s email) ";
			srtring_with_email.replace(begIdx+1, endIdx-begIdx-1, ReplacementString);
		}
		srtring_with_links = srtring_with_email;
	}
	
	return srtring_with_links;
}

/*
void
bestHighlight(char * myBuff, char * szHSummary, char * thePattern)
{
char *theResult;
char szSummary[5000];
int iScan = 300;
long iTotal = 0;
long iPlace[2000];
long iPos = 0;
long index;
long iFound = 0;
long iStart =0;
long iLen;
long iStartIndex;
long iStopIndex;
long iBestLocation = -1;
long iBest = 0;
int  i,j;
char *theToken;
char *theLast;
char szPattern[2000];

  iScan = m_pINIFileArgs->iNumUnits;
  
	for( index = 0; index < 2000; index++ )
	iPlace[index] = 0;
	strcpy( szPattern, thePattern);
    theToken = strtok_r( szPattern, ";", &theLast);
	if( !theToken || !myBuff )		  
	{
	strcpy( szHSummary, " ");
	return;
	}
	
	  while( theToken )
	  {
	  theResult = myBuff;
	  while( theResult )
	  {
	  // printf("theToken = %s<BR>",theToken);
	  theResult = txtfind( theResult, theToken );
	  if( theResult )
	  {
	  theResult--;
	  // ensure the beginning of a word 
	  if( ( *theResult >= 32 && *theResult <= 47 )
	  //  	|| ( theResult[ iStartSearch ] >= 40 && theResult[ iStartSearch ] <= 47 )
	  || ( *theResult >= 58 && *theResult <= 64 )
	  || ( *theResult == 96 ) )
	  
		{
		
		  theResult++;
		  char * szTemp = theResult;
		  
			int iLenTheToken = strlen( theToken );
			szTemp += iLenTheToken;
			// ensure the end of a word
			if( ( *szTemp >= 32 && *szTemp <= 47 )
			//  	|| ( theResult[ iStartSearch ] >= 40 && theResult[ iStartSearch ] <= 47 )
			|| ( *szTemp >= 58 && *szTemp <= 64 )
			|| ( *szTemp == 96 ) 
			|| ( *(szTemp+1) >= 32 && *(szTemp+1) <= 47 ) )
			
			  {
			  
				index = theResult - myBuff;
				if( index < iScan )
				iPos = 0;
				else
				iPos = index / iScan;
				iPlace[iPos]++;
				if( iPos > iTotal )
				iTotal = iPos;
				iFound++;
				//		printf("index, iPos, iTotal txtfind = %ld %ld %ld %ld %ld   %.20s<BR>",
				//			index,iPos,iTotal, iPlace[iPos],theResult,theResult );
				}
				}
				theResult += strlen( theToken );
				}
				}
				theToken = strtok_r( NULL, ";",&theLast );
				}
				if( iTotal == 0 )
				return;
				// Find String with most hits
				strcpy( szSummary, "");
				for( j=0; j < m_pINIFileArgs->iBestXunits; j++ )
				{
				
				  for( i=0; i<iTotal+1; i++ )
				  {
				  if( iPlace[i] > 0 )
				  {
				  
					if( iPlace[i] > iBest )
					{
					iBest = iPlace[i];
					iBestLocation = i;
					}
					}
					}
					if( iBestLocation == -1 )
					{
					break;
					}
					strcat( szSummary, m_pINIFileArgs->szTextBeginDel );
					iStartIndex = (long)(myBuff + ((( iBestLocation +1) * iScan) - iScan) );
					iStopIndex = (long)( myBuff + ( ( iBestLocation +1) * iScan) );
					
					  //make this place zero for next iBestXunits
					  iPlace[iBestLocation] = 0;
					  //	  iTotal--;
					  iBest=0;
					  iBestLocation = -1;
					  
						
						  // make the beginning and end word a whole word
						  
							char *szPtr = (char *)iStartIndex;
							while( szPtr != myBuff )
							{
							if( ( *szPtr >= 32 && *szPtr <= 38 )
							|| ( *szPtr >= 40 && *szPtr <= 47 )
							|| ( *szPtr >= 58 && *szPtr <= 64 )
							|| ( *szPtr == 96 ) )
							{
							iStartIndex = (long)szPtr;
							break;
							}
							else szPtr--;
							}
							long iLenBuff = strlen( myBuff );
							szPtr = (char *)iStopIndex;
							while( szPtr != myBuff+iLenBuff )
							{
							if( ( *szPtr >= 32 && *szPtr <= 38 )
							|| ( *szPtr >= 40 && *szPtr <= 47 )
							|| ( *szPtr >= 58 && *szPtr <= 64 )
							|| ( *szPtr == 96 ) )
							{
							iStopIndex = (long)szPtr;
							break;
							}
							else szPtr++;
							}
							
							  strncat( szSummary, (char *)iStartIndex, iStopIndex - iStartIndex );
							  strcat( szSummary, m_pINIFileArgs->szTextEndDel );
							  }
							  //	szSummary[ (iStopIndex - iStartIndex) ] = '\0';
							  
								iLen = strlen( szSummary );
								
								  for( i=0; i<iLen; i++ )
								  {
								  if (((unsigned char) szSummary[i]) < 0x20)
								  {
								  szSummary[i] = ' ';
								  }
								  }
								  
									//	printf("iStartIndex , iStopIndex = %ld %ld <BR><BR>...%s...\n",iStartIndex , iStopIndex, szSummary);
									highLightString( szSummary, thePattern, szHSummary );
									}
									
									  void
									  highLightString( char * szSummary , char * szBooleanSummary, char * hSummary)
									  {
									  char *theLast;
									  char *theToken;
									  char *lastPlace;
									  char *theResult;
									  int iBuffSize;
									  int iLen;
									  int iStartSearch;
									  bool bFoundToken;
									  
										
										  char* szboolean = new char [ strlen( szBooleanSummary ) + 1];
										  strcpy( szboolean, szBooleanSummary );
										  
											iBuffSize = strlen( szSummary );
											char* szTempSummary = new char [iBuffSize*4];
											char* szRealSummary = new char [ iBuffSize*4 ];
											char* szTemp = new char [ iBuffSize*4];
											strcpy( szTempSummary, szSummary );
											
											  theToken = strtok_r( szboolean, ";", &theLast);
											  strcpy( szRealSummary, "" );
											  
												while( theToken )
												{
												theResult = szTempSummary;
												lastPlace = szTempSummary;
												bFoundToken = false;
												while( theResult )
												{
												theResult = txtfind( theResult, theToken );
												if( theResult )
												{
												// ensure the beginning of a word 
												if( ( *(theResult-1) >= 32 && *(theResult-1) <= 47 )
												//  	|| ( theResult[ iStartSearch ] >= 40 && theResult[ iStartSearch ] <= 47 )
												|| ( *(theResult-1) >= 58 && *(theResult-1) <= 64 )
												|| ( *(theResult-1) == 96 ) )
												
												  {
												  bFoundToken = true;
												  iLen = strlen( theToken );
												  iStartSearch =  iLen;
												  // search word until character < 0x20 and highlight the string
												  int iTimes = 2;
												  while( iTimes-- )
												  {
												  if( ( theResult[ iStartSearch ] >= 32 && theResult[ iStartSearch ] <= 47 )
												  //  	|| ( theResult[ iStartSearch ] >= 40 && theResult[ iStartSearch ] <= 47 )
												  || ( theResult[ iStartSearch ] >= 58 && theResult[ iStartSearch ] <= 64 )
												  || ( theResult[ iStartSearch ] == 96 )
												  || iStartSearch > iBuffSize )
												  
													{
													strncat( szRealSummary, lastPlace, theResult - lastPlace );				
													strcat(szRealSummary, m_pINIFileArgs->szHtmlBeginHL);                      
													strncat(  szRealSummary , theResult, iStartSearch );
													strcat(szRealSummary, m_pINIFileArgs->szHtmlEndHL);
													lastPlace = &theResult[ iStartSearch  ];
													break;				
													}
													iStartSearch++;
													}
													}
													theResult += iLen;
													}
													}
													if( lastPlace )
													strcpy( szTemp, lastPlace );
													if( bFoundToken )
													{
													strcpy( szTempSummary, szRealSummary );
													strcat( szTempSummary, szTemp );
													}
													strcpy( szRealSummary, "" );
													theToken = strtok_r( NULL, ";",&theLast );
													}
													//   printf("<BR><BR>szTempSummary = %s<BR>",szTempSummary);
													strcpy( hSummary, szTempSummary );
													
													  delete [] szboolean;
													  delete [] szTempSummary;
													  delete [] szRealSummary;
													  delete [] szTemp;
													  }
*/