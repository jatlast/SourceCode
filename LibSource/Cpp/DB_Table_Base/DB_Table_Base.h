#ifndef DB_TABLE_BASE_H
#define DB_TABLE_BASE_H

#include <string>
#include <vector>

/*
*	Sybase Open Client header files...
*/
extern "C"
{
#include <sybfront.h> 
#include <sybdb.h> 
#include <syberror.h> 
}


#include "cgicc/Cgicc.h"
#include "ConnectionsFunctions/ConnectionsFormLayout.h"
#include "LinkMap/LinkMap.h" // associative map class

// CONSTANT VALUES...
const int ITEMS_BEFORE_RELATIONSHIP		= 19;
const int SCREEN_QUOTE_LENGTH_CUT_OFF	= 40;
const int ABOUT_YOURSELF_LENGTH_CUT_OFF = 128;
const int SUBJECT_LENGTH_CUT_OFF		= 32;

const int ROW_COUNT			= 8;

const int SEARCH_UNIQUE_ID	= 16;

/////////////////////////////////////////////////////////////
// These constants represent the maximum size of a column
//  for any given row name.  That is, sometimes the row name
//  represents the value in the table itself and other times
//  it represents the value in the lookup table.
// NOTE: Values need to be at least one larger than the
//       value in the DB to hold the string terminator in C++
/////////////////////////////////////////////////////////////

// database key (values used in all tables)
const int USER_NAME			= 32;

// contact_info
const int FIRST_NAME		= 32;
const int LAST_NAME			= 32;
const int STREET_ADDRESS	= 96;
const int CITY				= 32;
const int STATE				= 32;
const int COUNTRY			= 32;
const int ZIP				= 8;
const int TELEPHONE			= 16;

// login_info
const int USER_ID						= 10;
const int MEMBERSHIP_TYPE				= 4;
const int PASSWORD						= 16;
const int PASSWORD_HINT					= 32;
const int EMAIL							= 64;
const int SEX							= 32;
const int CREATION_DATE					= 32;
const int LAST_LOGIN					= 32;
const int PHOTO_SUBMITTED				= 4;
const int DATE_STARTED_PAYING			= 32;
const int EMAIL_VERIFICATION_CODE		= 17;
const int IS_EMAIL_VERIFIED				= 2;
const int AFFILIATE_TRACKING_ID			= 44;
const int AFFILIATE_ACTION_STATUS		= 8;

// personal_info
const int SEX_PREFERENCE	= 32;
const int AGE				= 4;
const int MARITAL_STATUS	= 32;
const int PROFESSION		= 48;
const int INCOME			= 48;
const int EDUCATION			= 32;
const int RELIGION			= 32;
const int HEIGHT			= 32;
const int WEIGHT			= 32;
const int EYES				= 32;
const int HAIR				= 32;
const int MAX_AGE_DESIRED	= 4;
const int MIN_AGE_DESIRED	= 4;
const int COOK				= 32;
const int SMOKE				= 32;
const int DRINK				= 32;
const int PARTY				= 64;
const int POLITICAL			= 64;
const int HOUSING_STATUS	= 32;

// about_info
const int SCREEN_QUOTE		= 1024;
const int ABOUT_YOURSELF	= 1024*3;
const int QUESTIONABLE		= 2;

// billing_info
const int CARD_TYPE					= 16;
const int NAME_ON_CARD				= 64;
const int CVV2_CODE					=  6;
const int ACCOUNT_NUMBER			= 32;
const int EXPIRATION_MONTH			=  4;
const int EXPIRATION_YEAR			=  6;
const int IS_MEMBERSHIP_ACTIVE		=  2;
const int DATE_MEMBERSHIP_EXPIRES	= 32;
const int BANK_ABA_CODE				=  9;
const int BANK_ACCOUNT_NUMBER		= 32;

// pictures
const int PHOTO_1			= 48;
const int PHOTO_2			= 48;
const int PHOTO_3			= 48;
const int PHOTO_4			= 48;
const int PHOTO_5			= 48;

// relationship
const int PREFER_NOT_TO_SAY	= 2;
const int ANY_RELATIONSHIP	= 2;
const int HANG_OUT			= 2;
const int SHORT_TERM		= 2;
const int LONG_TERM			= 2;
const int TALK_EMAIL		= 2;
const int PHOTO_EXCHANGE	= 2;
const int MARRIAGE			= 2;
const int OTHER				= 2;

// MAIL
const int MAIL_ID			= 16;
const int SENT_TO			= 32;
const int SENT_FROM			= 32;
const int SUBJECT			= 128;
const int MESSAGE_TEXT		= 1024*4;
const int WHEN_SENT			= 32;
const int WHEN_READ			= 32;
const int SENDER_DELETED	= 4; // currently stored in DB as integer which is overkill.  Should be 1 or 2 chars
const int RECEIVER_DELETED	= 4; // currently stored in DB as integer which is overkill.  Should be 1 or 2 chars

// membership_cancellation
//		  USER_NAME				already defined under login_info
//		  EMAIL					already defined under login_info
//		  DATE_STARTED_PAYING	already defined under login_info
const int DATE_CANCELLED		= 32;
const int REASON_FOR_LEAVING	= 128;
const int MEMBERSHIP_PRICES		= 16;
const int WEBSITE_DESIGN		= 16;
const int SUGGESTIONS			= 1924*4;

// membership_type
const int MEMBERSHIP_TYPE_ID	= 4;
const int MEMBERSHIP_TYPE_NAME	= 16;
const int DATE_PROMOTION_STARTED= 32;
const int ALLOW_SEARCH_SIMPLE	= 1;
const int ALLOW_SEARCH_ADVANCED	= 1;
const int ALLOW_VIEW_PROFILES	= 1;
const int ALLOW_MAIL_RECEIVE	= 1;
const int ALLOW_MAIL_READ		= 1;
const int ALLOW_MAIL_SEND		= 1;
const int ALLOW_ROMANCE_WIZARD	= 1;
const int ALLOW_CHAT_VIEW		= 1;
const int ALLOW_CHAT_USE		= 1;
const int ALLOW_VIEW_STATS		= 1;

using std::vector;
using std::string;
using std::ostream;
using std::cout;
using std::endl;


namespace db_table_base_namespace
{	
	
	const int MAXLEN = 3000;
	
	class DB_Table_Base
	{
		
	public:
		
		struct DB_Table_Info
		{
		public:
			string db_column_name;
			char * db_column_data;
			char * db_column_actual;
			string web_form_name;
			string web_form_data;
			string web_form_hidden_data;
			int row_number;
			int vartype;
			int length;
			
			// initialization constructor
			DB_Table_Info(
				const string & column_name
				, const char * const column_data
				, const char * const column_actual
				, const string & form_name
				, const string & form_data
				, const string & form_hidden_data
				, const int c_number
				, const int v
				, const int l
				);
			
			// copy constructor
			DB_Table_Info(const DB_Table_Info & copy);
			
			// operator= overload is not intended for use
			DB_Table_Info & 
				operator=(const DB_Table_Info & rhs);
			
			virtual ~DB_Table_Info();
		private:
			// prevent default Constructor
			DB_Table_Info();

			
		};// ...end struct DB_Table_Info
		
		public:
			vector<DB_Table_Info> Vect;
			string get_info_sql;
			string update_info_sql;
			DBPROCESS *DbProc;     // The connection with SQL server

			// Class variable to hold global variable DB_Error_Text from file db_msg_error_handlers.h...
			string DB_Table_Base_Error_Text;

			// Class variable to hold global variable DB_Error_Number from file db_msg_error_handlers.h...
			long DB_Table_Base_Error_Number;

			virtual ~DB_Table_Base();

			bool
				Initialize_DbProc(LinkMap & Map);
			
			void
				Set_Update_Info_Sql(const string & sql_statement);
			
			void
				Set_Get_Info_Sql(const string & sql_statement);
			
			const string &
				Get_Update_Info_Sql();
			
			const string &
				Get_Get_Info_Sql();
			
			virtual void
				Print_Current_And_Change( const string & name ) = 0;
			
			bool
				Get_Info_From_DB(LinkMap & Map);
			
			void
				Get_Form_Info_From_Cgi( cgicc::Cgicc & cgi);
			
			// Used to update the info in the DB
			bool
				Update_Info_In_DB(LinkMap & Map);

			// Used with GenBookMarks.exe
			bool 
				GenBookMarks_The_DB(LinkMap & Map, const string & program_name, const int index, const int limit);

			// Used with ViewWinks.exe
			bool 
				ViewWinks_The_DB(LinkMap & Map, const string & program_name, const int index, const int limit);

			// Used with SendWink.exe
			bool 
				SendWink_The_DB(LinkMap & Map, const string & program_name, const int index, const int limit);

			// Used to search the DB
			//bool
			//	SimpleSearch_The_DB(LinkMap & Map, const string & program_name, const int index, const int limit);

			// Used to search the DB
			//bool
			//	AdvancedSearch_The_DB(LinkMap & Map, const string & program_name, const int index, const int limit);

			// Used to search the DB
			bool 
				Search_The_DB(LinkMap & Map
								, const string & program_name
								, const int index
								, const int limit
								, const bool my_cookie_found
								);

			bool
				SingleSearch_The_DB(LinkMap & Map, const string & program_name, const string & PhotoNumber);

			bool
				GenSendMail_The_DB(LinkMap & Map, const string & program_name);

			bool
				GenHome_The_DB(LinkMap & Map);

			bool
				GenPicUpload_The_DB(LinkMap & Map);

			bool
				GenMailbox_The_DB(LinkMap & Map, const string & program_name, const int index, const int limit);

			void
				Print_Current(const DB_Table_Info & dbti_vect );
			
			const string
				Get_FormData_From_ColumnName(const string & name);
			

			const char *
				Get_DBData_From_ColumnName(const string & name);

			const char *
				Get_DBActual_From_ColumnName(const string & name);
			
			const int
				Get_RowNumber_From_ColumnName(const string & name);
			
			friend ostream &
				operator<<(ostream & out, const DB_Table_Info & dbti)
			{
				out << "within friend of DB_Table_Info" << endl;
				out << "db_column_name = \""<< dbti.db_column_name											<< "\"\n"
					<< "db_column_data = \""<< (!dbti.db_column_data ? "ERROR" : dbti.db_column_data)		<< "\"\n"
					<< "db_column_actual = \""<< (!dbti.db_column_actual ? "ERROR" : dbti.db_column_actual)	<< "\"\n"
					<< "web_form_name = \""	<< dbti.web_form_name											<< "\"\n"
					<< "web_form_data = \""	<< dbti.web_form_data											<< "\"\n"
					<< "web_form_hidden_data = \""	<< dbti.web_form_hidden_data							<< "\"\n"
					<< "row_number = \""	<< dbti.row_number												<< "\"\n"
					<< "vartype = \""		<< dbti.vartype													<< "\"\n"
					<< "length = \""		<< dbti.length													<< "\"" 
					<< endl;
				return out;
			}
			
			// Private Member Variables
			
		private:
			// prevent assignment of DB_Table_Base objects
			DB_Table_Base & 
				operator=(const DB_Table_Base & rhs);

	};// .. end class DB_Table_Base
}// ... end namespace db_table_base_namespace

string
Replace_Returns_With_Breaks(const char * string_with_returns);

string
Replace_Email_With_Links(const char * charstar_with_email, string UserName, LinkMap & Map);

/**********************************************************************
*
*  bestHighlight...
*
**********************************************************************/
void 
bestHighlight( char * myBuff ,char * szHSummary, char * list);

/**********************************************************************
*
*  highLightString...
*
**********************************************************************/
void
highLightString( char * szSummary , char * szBooleanSummary, char * hSummary);

#endif// DB_TABLE_BASE_H

