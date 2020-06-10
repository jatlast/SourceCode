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

#include "DB_Msg_Err_Handlers.h"


using std::string;
using std::vector;
using std::ostream;
using std::cout;
using std::endl;

namespace db_table_base_namespace
{

const int MAXLEN = 64;

class DB_Table_Base
{
	
protected:
	
	class DB_Table_Info
	{
	public:
		// Member Variables
		string db_column_name;
		char * db_column_data;
		string web_form_name;
		string web_form_data;
		string web_form_hidden_data;
		int row_number;
		int vartype;
		int length;

		// default Constructor
		DB_Table_Info();

		// initialization constructor
		DB_Table_Info(
			const string & column_name
			, const char * column_data
			, const string & form_name
			, const string & form_data
			, const string & form_hidden_data
			, const int & c_number
			, const int & v
			, const int & l
			);
		
		// copy constructor
		DB_Table_Info(const DB_Table_Info & copy);

		
		~DB_Table_Info();
	};
	
	public:
		
		virtual void
			Print_Current_And_Change( const string & name ) = 0;
		
		void
			Print_Current(const DB_Table_Info & dbti_vect );
		
		bool
			Get_Info_From_DB( const string & stored_proc_buff, vector<DB_Table_Info> & dbti_vect);
		
		void
			Get_Form_Info_From_Cgi( cgicc::Cgicc & cgi, vector<DB_Table_Info> & dbti_vect);
		
		friend ostream &
			operator<<(ostream & out, const DB_Table_Info & dbti)
		{
			out << "db_column_name = \""<< dbti.db_column_name										<< "\"" << endl;
			out << "db_column_data = \""<< (!dbti.db_column_data ? "ERROR" : dbti.db_column_data)	<< "\"" << endl;
			out << "web_form_name = \""	<< dbti.web_form_name										<< "\"" << endl;
			out << "web_form_data = \""	<< dbti.web_form_data										<< "\"" << endl;
			out << "web_form_hidden_data = \""	<< dbti.web_form_hidden_data						<< "\"" << endl;
			out << "row_number = \""	<< dbti.row_number											<< "\"" << endl;
			out << "vartype = \""		<< dbti.vartype												<< "\"" << endl;
			out << "length = \""		<< dbti.length												<< "\"" << endl;
			
			return out;
		}
		
};




/*
 *	The actual funcitons for the embeded DB_Table_Base::DB_Table_Info class...
 */

// DB_Table_Info embeded class of DB_Table_Base default constructor...
DB_Table_Base::DB_Table_Info::DB_Table_Info()
{
	db_column_name = "";
	db_column_data = new char[MAXLEN];
	db_column_data[0] = '\0';
	web_form_name = "";
	web_form_data = "";
	web_form_hidden_data = "";
	row_number = 0;
	vartype = 0;
	length = 0;
}

// DB_Table_Info embeded class of DB_Table_Base initialization constructor
DB_Table_Base::DB_Table_Info::DB_Table_Info(
											const string & column_name
											, const char * column_data
											, const string & form_name
											, const string & form_data
											, const string & form_hidden_data
											, const int & c_number
											, const int & v
											, const int & l
											)
{
	db_column_name = column_name;
	if(column_data)
	{
		db_column_data = new char[MAXLEN];
		strcpy(db_column_data, column_data);
	}
	else
	{
		db_column_data = new char[MAXLEN];
		db_column_data[0] = '\0';
	}
	web_form_name = form_name;
	web_form_data = form_data;
	web_form_hidden_data = form_hidden_data;
	row_number = c_number;
	vartype = v;
	length = l;
}


// DB_Table_Info embeded class of DB_Table_Base copy constructor
DB_Table_Base::DB_Table_Info::DB_Table_Info(const DB_Table_Info & copy)
{
	db_column_name = copy.db_column_name;
	if(copy.db_column_data)
	{
		db_column_data = new char[MAXLEN];
		strcpy(db_column_data, copy.db_column_data);
	}
	else
	{
		db_column_data = new char[64];
		db_column_data[0] = '\0';
	}
	web_form_name = copy.web_form_name;
	web_form_data = copy.web_form_data;
	web_form_hidden_data = copy.web_form_hidden_data;
	row_number = copy.row_number;
	vartype = copy.vartype;
	length = copy.length;
}


// DB_Table_Info embeded class of DB_Table_Base Destructor
DB_Table_Base::DB_Table_Info::~DB_Table_Info()
{
	//cout << "----------------Within ~DB_Table_Info()" << endl;
	db_column_name = "";
	delete db_column_data;
	web_form_name = "";
	web_form_data = "";
	web_form_hidden_data = "";
	row_number = 0;
	vartype = 0;
	length = 0;
	//cout << "----------------Done with ~DB_Table_Info()" << endl;
}
/*
 *	...END The actual funcitons for the embeded DB_Table_Base::DB_Table_Info class...
 */



/*
 *	Non Member Non Friend Helper Functions...
 */

// Prints the current name and value of the data retrieved from the Database
// used when displaying the user's current info alongside the cangeable info.
void
DB_Table_Base::Print_Current(const DB_Table_Info & dbti )
{
	cout << "        <!--    current " << dbti.db_column_name << "  -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"120\"" << endl;
	cout << "           height=\"25\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\"> " << endl;
	cout << "		Current " << dbti.web_form_name << ":" << endl;
	cout << "	    </FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"335\"" << endl;
	cout << "           height=\"25\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "		<B>" << dbti.db_column_data << " </B>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>        " << endl;	
}

void
DB_Table_Base::Get_Form_Info_From_Cgi( cgicc::Cgicc & cgi, vector<DB_Table_Info> & dbti_vect)
{
	string db_string;
	for(int i=0; i<dbti_vect.size(); i++)
	{
		db_string = "db_" + (dbti_vect[i].db_column_name);
		cgicc::form_iterator temp = cgi.getElement(db_string);
		//cout << "<!-- db looking for = \"" << db_string << "\" -->" << endl;
		if( temp != cgi.getElements().end() )
		{
			if ( temp->isEmpty() )
			{
				dbti_vect[i].web_form_hidden_data = "Empty";
			}
			else
			{
				dbti_vect[i].web_form_hidden_data = temp->getValue();
			}
			//	cout << "<!-- db Found = \"" << dbti_vect[i].web_form_hidden_data << "\" -->" << endl;
			
		}
		cgicc::form_iterator db_temp = cgi.getElement(dbti_vect[i].db_column_name);
		//cout << "<!-- looking for = \"" << login_info.Vect[i].db_column_name << "\" -->" << endl;
		if( db_temp != cgi.getElements().end() )
		{
			if ( db_temp->isEmpty() )
			{
				dbti_vect[i].web_form_data = "Empty";
			}
			else
			{
				dbti_vect[i].web_form_data = db_temp->getValue();
			}
			//			cout << "<!-- Found = \"" << dbti_vect[i].web_form_data << "\" -->" << endl;
		}
		if(dbti_vect[i].web_form_data.empty() || dbti_vect[i].web_form_data == "Empty" || dbti_vect[i].web_form_data == "-1")
			dbti_vect[i].web_form_data = dbti_vect[i].web_form_hidden_data;
		cout << "<!-- Found = \"" << dbti_vect[i].web_form_data << "\" -->" << endl;
	}
				
				
}


//bool RawSybase() 
bool
DB_Table_Base::Get_Info_From_DB( const string & stored_proc_buff, vector<DB_Table_Info> & dbti_vect )
{ 
	Global_DBSuccess = true;
	//cout << "Start RawSybase()" << endl;
	   bool rc = false;
	   
	   const string DatabaseName	= "HOMER";
	   const string UserName		= "sa";
	   const string Password		= "citrix";
	   const string ApplicationName = "RawSybase";
	   
	   DBPROCESS    *dbproc;     /* The connection with */
	   /* SQL Server */ 
	   LOGINREC     *login;      /* The login information */
	   RETCODE      return_code;
	   
	   /* Initialize DB-Library */ 
	   if (dbinit() == FAIL) 
	   {
		   //exit(ERREXIT);
		   rc = false;
		   cout << "dbinit failed." << endl;
		   return rc;
	   }
	   /*  
	   ** Install user-supplied error-handling and message- 
	   ** handling routines.
	   */ 
	   dberrhandle(err_handler); 
	   dbmsghandle(msg_handler);
	   
	   /* Get a LOGINREC */ 
	   login = dblogin(); 
	   
	   /*
	   *  save the proper information in the login record...
	   */	   
	   DBSETLUSER(login, (char *)UserName.c_str()); 
	   DBSETLPWD (login, (char *)Password.c_str()); 
	   DBSETLAPP (login, (char *)ApplicationName.c_str()); 
	   
	   //cout << "pre dbopen" << endl;
	   /* Get a DBPROCESS structure for communication */
	   /* with SQL Server. */ 
	   dbproc = dbopen(login, (char *)DatabaseName.c_str()); 
	   //cout << "post dbopen" << endl;
	   
	   /* 
	   ** Retrieve some columns from the "authors" table 
	   ** in the "pubs2" database. 
	   */ 
	   //cout << "strored procedure: " << stored_proc_buff << endl;
	   /* First, put the command into the command buffer. */ 
	   dbcmd( dbproc, const_cast<char *>(stored_proc_buff.c_str()) ); 
	   
	   //cout << "pre dbsqlexec" << endl;
	   /* 
	   ** Send the command to SQL Server and start execution
	   */ 
	   dbsqlexec(dbproc);
	   //cout << "post dbsqlexec" << endl;
	   if(Global_DBSuccess)
	   {
		   /* Process the command */ 
		   while ((return_code = dbresults(dbproc)) != NO_MORE_RESULTS) 
		   { 
			   if (return_code == SUCCEED) 
			   { 
				   //cout << "within return_code == SUCCEED" << endl;
				   //rc = true;
				   /* Bind results to program variables. */ 
				   for(int i=0; i<dbti_vect.size(); i++)
				   {
					   dbbind( dbproc, dbti_vect[i].row_number,  dbti_vect[i].vartype, dbti_vect[i].length, (BYTE *)( dbti_vect[i].db_column_data) );
				   }
				   //cout << "after return_code == SUCCEED" << endl;
				   /* Retrieve and print the result rows. */ 
				   while (dbnextrow(dbproc) != NO_MORE_ROWS) 
				   { 
					   rc = true;
				   } 
			   } 
		   }
	   }
	   //cout << "post while dbresults..." << endl;
	   
	   /* Close the connection to SQL Server */ 
	   dbexit(); 
	   if(!Global_DBSuccess)
	   {
		   return Global_DBSuccess;
	   }
	   else
	   {
		   return rc;
	   }
} 

// Non Member Non Friend Inportant Function
// Used to update the info in the DB
bool
Update_Info_In_DB( const string & stored_proc_buff )
{ 
	Global_DBSuccess = true;
	   //cout << "Start RawSybase()" << endl;
	   bool rc = true;
	   
	   const string DatabaseName	= "HOMER";
	   const string UserName		= "sa";
	   const string Password		= "citrix";
	   const string ApplicationName = "RawSybase";
	   
	   DBPROCESS    *dbproc;     /* The connection with */
	   /* SQL Server */ 
	   LOGINREC     *login;      /* The login information */
	   RETCODE      return_code;
	   
	   /* Initialize DB-Library */ 
	   if (dbinit() == FAIL) 
	   {
		   //exit(ERREXIT);
		   rc = false;
		   cout << "dbinit failed." << endl;
		   return rc;
	   }
	   /*  
	   ** Install user-supplied error-handling and message- 
	   ** handling routines.
	   */ 
	   dberrhandle(err_handler); 
	   dbmsghandle(msg_handler);
	   
	   /* Get a LOGINREC */ 
	   login = dblogin(); 
	   
	   /*
	   *  save the proper information in the login record...
	   */	   
	   DBSETLUSER(login, (char *)UserName.c_str()); 
	   DBSETLPWD (login, (char *)Password.c_str()); 
	   DBSETLAPP (login, (char *)ApplicationName.c_str()); 
	   
	   //cout << "pre dbopen" << endl;
	   /* Get a DBPROCESS structure for communication */
	   /* with SQL Server. */ 
	   dbproc = dbopen(login, (char *)DatabaseName.c_str()); 
	   //cout << "post dbopen" << endl;
	   
	   /* 
	   ** Retrieve some columns from the "authors" table 
	   ** in the "pubs2" database. 
	   */ 
	   //cout << "strored procedure: " << stored_proc_buff << endl;
	   /* First, put the command into the command buffer. */ 
	   dbcmd( dbproc, const_cast<char *>(stored_proc_buff.c_str()) ); 
	   
	   //cout << "pre dbsqlexec" << endl;
	   /* 
	   ** Send the command to SQL Server and start execution
	   */ 
	   dbsqlexec(dbproc);
	   //cout << "post dbsqlexec" << endl;
	   if(Global_DBSuccess)
	   {
		   /* Process the command */ 
		   while ((return_code = dbresults(dbproc)) != NO_MORE_RESULTS) 
		   { 
			   if (return_code == SUCCEED) 
			   { 
				   //cout << "within return_code == SUCCEED" << endl;
				   //rc = true;
				   /* Bind results to program variables. */ 
				   //for(int i=0; i<dbti_vect.size(); i++)
				   //{
				   // dbbind( dbproc, dbti_vect[i].row_number,  dbti_vect[i].vartype, dbti_vect[i].length, (BYTE *)( dbti_vect[i].db_column_data) );
				   //}
				   //cout << "after return_code == SUCCEED" << endl;
				   /* Retrieve and print the result rows. */ 
				   while (dbnextrow(dbproc) != NO_MORE_ROWS) 
				   { 
					   rc = true;
				   } 
			   } 
		   }
	   }
	   //cout << "post while dbresults..." << endl;
	   
	   /* Close the connection to SQL Server */ 
	   dbexit(); 
	   if(!Global_DBSuccess)
	   {
		   return Global_DBSuccess;
	   }
	   else
	   {
		   return rc;
	   }
} 

/*
void
DB_Table_Base::Print_Current_And_Change(const DB_Table_Info & dbti, const string & name )
{
int column_number = dbti.Get_RowNumber_From_ColumnName( name );

  switch (column_number)
  {
  
	cout << "	<!--    user_name  -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"120\"" << endl;
	cout << "           height=\"25\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\"> *User Name:</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"335\"" << endl;
	cout << "           height=\"25\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <!--  webbot bot=\"Validation\" S-Display-Name=\"Select a User Name\"" << endl;
	cout << "                                         B-Value-Required=\"TRUE\" --><!--webbot" << endl;
	cout << "                              bot=\"Validation\" S-Display-Name=\"User Name\"" << endl;
	cout << "                              B-Value-Required=\"TRUE\" --><INPUT" << endl;
	cout << "             type=\"text\"" << endl;
	cout << "             name=\"user_name\"" << endl;
	cout << "             size=\"20\"> <FONT" << endl;
	cout << "             size=\"2\"" << endl;
	cout << "             color=\"#FF0000\">Others will see this name</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "" << endl;
	cout << "        <!--    password  -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"120\"" << endl;
	cout << "           height=\"25\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <P" << endl;
	cout << "             style=\"line-height: 100%\">" << endl;
	cout << "               <FONT" << endl;
	cout << "               size=\"2\">*Password: 4-8 digits</FONT>" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"335\"" << endl;
	cout << "           height=\"25\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <P" << endl;
	cout << "             style=\"line-height: 100%\">" << endl;
	cout << "               <!--  webbot bot=\"Validation\" S-Display-Name=\"Choose  password\"" << endl;
	cout << "                                              B-Value-Required=\"TRUE\" I-Minimum-Length=\"4\" I-Maximum-Length=\"8\" --><!--webbot" << endl;
	cout << "                                   bot=\"Validation\" S-Display-Name=\"Password\"" << endl;
	cout << "                                   B-Value-Required=\"TRUE\" I-Minimum-Length=\"4\"" << endl;
	cout << "                                   I-Maximum-Length=\"8\" --><INPUT" << endl;
	cout << "               type=\"password\"" << endl;
	cout << "               name=\"password\"" << endl;
	cout << "               size=\"20\"" << endl;
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
	cout << "             style=\"line-height: 100%\">" << endl;
	cout << "               <!--  webbot bot=\"Validation\" S-Display-Name=\"Verify password\"" << endl;
	cout << "                                              B-Value-Required=\"TRUE\" I-Minimum-Length=\"4\" I-Maximum-Length=\"8\" --><!--webbot" << endl;
	cout << "                                   bot=\"Validation\" S-Display-Name=\"Password Verification\"" << endl;
	cout << "                                   B-Value-Required=\"TRUE\" I-Minimum-Length=\"4\"" << endl;
	cout << "                                   I-Maximum-Length=\"8\" --><INPUT" << endl;
	cout << "               type=\"password\"" << endl;
	cout << "               name=\"verify_password\"" << endl;
	cout << "               size=\"20\"" << endl;
	cout << "               maxlength=\"8\"><FONT" << endl;
	cout << "               size=\"2\"" << endl;
	cout << "               color=\"#FF0000\"> Compare password inputs</FONT>" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "" << endl;
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
	cout << "           align=\"left\">" << endl;
	cout << "            <!--  webbot bot=\"Validation\" S-Display-Name=\"Choose a password hint\"" << endl;
	cout << "                                          B-Value-Required=\"TRUE\" --><!--webbot" << endl;
	cout << "                              bot=\"Validation\" S-Display-Name=\"Mother's Maiden Name\"" << endl;
	cout << "                              B-Value-Required=\"TRUE\" --><INPUT" << endl;
	cout << "             name=\"password_hint\"" << endl;
	cout << "             size=\"20\"> <FONT" << endl;
	cout << "             color=\"#FF0000\"" << endl;
	cout << "             size=\"2\">To get your password</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "" << endl;
	cout << "" << endl;
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
	cout << "             style=\"line-height: 100%\">" << endl;
	cout << "               <!--  webbot bot=\"Validation\"" << endl;
	cout << "                                              S-Display-Name=\"Email\" B-Value-Required=\"TRUE\" --><!--webbot" << endl;
	cout << "                                  bot=\"Validation\" S-Display-Name=\"Email Address\"" << endl;
	cout << "                                  B-Value-Required=\"TRUE\" --><INPUT" << endl;
	cout << "               name=\"email\"" << endl;
	cout << "               size=\"20\"> <FONT" << endl;
	cout << "               color=\"#FF0000\"" << endl;
	cout << "               size=\"2\">Will not appear in profile</FONT>" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "        <!--    Sex   -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"120\"" << endl;
	cout << "           height=\"25\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\">Sex</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"335\"" << endl;
	cout << "           height=\"25\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <!--webbot bot=\"Validation\" S-Display-Name=\"Sex\"" << endl;
	cout << "                              B-Value-Required=\"TRUE\" B-Disallow-First-Item=\"TRUE\" --><SELECT" << endl;
	cout << "             size=\"1\"" << endl;
	cout << "             name=\"sex\">" << endl;
	cout << "              <OPTION Selected" << endl;
	cout << "               value=\"-1\">" << endl;
	cout << "                Male" << endl;
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
	cout << "" << endl;
	cout << "	<!-- age -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <P" << endl;
	cout << "             style=\"line-height: 100%\">" << endl;
	cout << "              <FONT" << endl;
	cout << "               size=\"2\">&#160;&#160;&#160;&#160;&#160;&#160;&#160; &#160;&#160;&#160;&#160;&#160; *Your Age:</FONT>" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <P" << endl;
	cout << "             style=\"line-height: 100%\">" << endl;
	cout << "               <!--webbot bot=\"Validation\" S-Display-Name=\"Your Age\" S-Data-Type=\"Number\"" << endl;
	cout << "                  S-Number-Separators=\"x.\" B-Value-Required=\"TRUE\"" << endl;
	cout << "                  S-Validation-Constraint=\"Greater than or equal to\" S-Validation-Value=\"18\"" << endl;
	cout << "                  --> <INPUT" << endl;
	cout << "               type=\"text\"" << endl;
	cout << "               name=\"age\"" << endl;
	cout << "               size=\"5\">" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "	<!-- marital_status -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <P" << endl;
	cout << "             style=\"line-height: 100%\">" << endl;
	cout << "              <FONT" << endl;
	cout << "               size=\"2\">&#160;&#160;&#160;&#160;&#160; Marital status:</FONT>" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <P" << endl;
	cout << "             style=\"line-height: 100%\">" << endl;
	cout << "               <SELECT" << endl;
	cout << "               size=\"1\"" << endl;
	cout << "               name=\"marital_status\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"0\">" << endl;
	cout << "                  Prefer not to say" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"1\">" << endl;
	cout << "                  Single" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"2\">" << endl;
	cout << "                  Single with children" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"3\">" << endl;
	cout << "                  Married" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"4\">" << endl;
	cout << "                  Divorced" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"5\">" << endl;
	cout << "                  Divorced w/Children" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"6\">" << endl;
	cout << "                  Widowed" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"7\">" << endl;
	cout << "                  Widowed w/Chidren" << endl;
	cout << "                </OPTION>" << endl;
	cout << "              </SELECT>" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "	<!-- profession  -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <P" << endl;
	cout << "             style=\"line-height: 100%\">" << endl;
	cout << "              <FONT" << endl;
	cout << "               size=\"2\">Profession:</FONT>" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <P" << endl;
	cout << "             style=\"line-height: 100%\">" << endl;
	cout << "              <SELECT" << endl;
	cout << "               size=\"1\"" << endl;
	cout << "               name=\"profession\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"0\">" << endl;
	cout << "                  Please choose one" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"1\">" << endl;
	cout << "                  Accounting/Finance" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"2\">" << endl;
	cout << "                  Advertising/Media" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"3\">" << endl;
	cout << "                  Advertising/Public Relations" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"4\">" << endl;
	cout << "                  Advertising" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"5\">" << endl;
	cout << "                  Airline - Aerospace" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"6\">" << endl;
	cout << "                  Apparel - Textile" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"7\">" << endl;
	cout << "                  Architecture" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"8\">" << endl;
	cout << "                  Art - Photography - Journalism" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"9\">" << endl;
	cout << "                  Arts/Entertainment/Publishing" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"10\">" << endl;
	cout << "                  Automotive - Motor Vehicles - Parts" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"11\">" << endl;
	cout << "                  Banking - Financial Services" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"12\">" << endl;
	cout << "                  Bio-Pharmaceutical" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"13\">" << endl;
	cout << "                  Biotechnology" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"14\">" << endl;
	cout << "                  Building Materials" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"15\">" << endl;
	cout << "                  Carpentry - Contruction" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"16\">" << endl;
	cout << "                  Charitable - Not for Profit" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"17\">" << endl;
	cout << "                  Clerical/Administrative" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"18\">" << endl;
	cout << "                  Clerical/Service Worker" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"19\">" << endl;
	cout << "                  Composer/Producer/Tech" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"20\">" << endl;
	cout << "                  Computer Hardware" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"21\">" << endl;
	cout << "                  Computer Software" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"22\">" << endl;
	cout << "                  Construction/Real Estate/Facilities" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"23\">" << endl;
	cout << "                  Consultant" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"24\">" << endl;
	cout << "                  Consulting" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"25\">" << endl;
	cout << "                  Doctor/Medical Prof" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"26\">" << endl;
	cout << "                  Education - College" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"27\">" << endl;
	cout << "                  Education/Training" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"28\">" << endl;
	cout << "                  Employment - Recruiting" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"29\">" << endl;
	cout << "                  Energy - Utilities - Gas - Electric" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"30\">" << endl;
	cout << "                  Engineering/Architecture" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"31\">" << endl;
	cout << "                  Entertainment - Radio - TV - Media" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"32\">" << endl;
	cout << "                  Finance/Accounting" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"33\">" << endl;
	cout << "                  Food Services" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"34\">" << endl;
	cout << "                  Government - Civil Service" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"35\">" << endl;
	cout << "                  Graphic Artist/Designer" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"36\">" << endl;
	cout << "                  Health - Medical - Home Services" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"37\">" << endl;
	cout << "                  Health Care" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"38\">" << endl;
	cout << "                  Home Business" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"39\">" << endl;
	cout << "                  Home Maker" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"40\">" << endl;
	cout << "                  Hospitality" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"41\">" << endl;
	cout << "                  Human Resources" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"42\">" << endl;
	cout << "                  HVAC" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"43\">" << endl;
	cout << "                  Industrial" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"44\">" << endl;
	cout << "                  Insurance" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"45\">" << endl;
	cout << "                  Internet" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"46\">" << endl;
	cout << "                  K-12 Faculty/Staff" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"47\">" << endl;
	cout << "                  Law Enforcement - Military" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"48\">" << endl;
	cout << "                  Lawyer/Paralegal/Assistant" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"49\">" << endl;
	cout << "                  Legal" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"50\">" << endl;
	cout << "                  Manufacturing/Operations" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"51\">" << endl;
	cout << "                  Manufacturing" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"52\">" << endl;
	cout << "                  Marketing" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"53\">" << endl;
	cout << "                  Merchandising" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"54\">" << endl;
	cout << "                  Middle Management" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"55\">" << endl;
	cout << "                  MIS/Programming" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"56\">" << endl;
	cout << "                  Mortgage" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"57\">" << endl;
	cout << "                  New Media/Internet" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"58\">" << endl;
	cout << "                  Office Equipment" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"59\">" << endl;
	cout << "                  Office Manager/Admin" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"60\">" << endl;
	cout << "                  Oil Refining - Petroleum" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"61\">" << endl;
	cout << "                  Pharmaceutical" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"62\">" << endl;
	cout << "                  Political" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"63\">" << endl;
	cout << "                  Prefer not to say" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"64\">" << endl;
	cout << "                  Printing - Publishing" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"65\">" << endl;
	cout << "                  Professional/Technical" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"66\">" << endl;
	cout << "                  Public Relations - Fund Raising" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"67\">" << endl;
	cout << "                  Public Sector" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"68\">" << endl;
	cout << "                  R&amp;D Engineering" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"69\">" << endl;
	cout << "                  Real Estate - Property Mgt" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"70\">" << endl;
	cout << "                  Recreation" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"71\">" << endl;
	cout << "                  Retail" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"72\">" << endl;
	cout << "                  Retail Products" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"73\">" << endl;
	cout << "                  Retired" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"74\">" << endl;
	cout << "                  Sales" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"75\">" << endl;
	cout << "                  Sales/Marketing" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"76\">" << endl;
	cout << "                  Scientist/Researcher" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"77\">" << endl;
	cout << "                  Semiconductor - Electronics" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"78\">" << endl;
	cout << "                  Technical Management" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"79\">" << endl;
	cout << "                  Technology" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"80\">" << endl;
	cout << "                  Telecommunications" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"81\">" << endl;
	cout << "                  Telecommunications" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"82\">" << endl;
	cout << "                  Tourism" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"83\">" << endl;
	cout << "                  Tradesman" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"84\">" << endl;
	cout << "                  Training" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"85\">" << endl;
	cout << "                  Transportation - Railroad" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"86\">" << endl;
	cout << "                  Transportation/Logistics" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"87\">" << endl;
	cout << "                  University Staff" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"88\">" << endl;
	cout << "                  University Student" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"89\">" << endl;
	cout << "                  Upper Management/Executive" << endl;
	cout << "                </OPTION>" << endl;
	cout << "              </SELECT>" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "	<!-- education -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\">Education:</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <SELECT" << endl;
	cout << "             size=\"1\"" << endl;
	cout << "             name=\"education\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               selected" << endl;
	cout << "               value=\"0\">" << endl;
	cout << "                Prefer not to say" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"1\">" << endl;
	cout << "                Still a student" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"2\">" << endl;
	cout << "                High School" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"3\">" << endl;
	cout << "                Some College" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"4\">" << endl;
	cout << "                College Degree" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"5\">" << endl;
	cout << "                Graduate Degree" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"6\">" << endl;
	cout << "                Post Graduate" << endl;
	cout << "              </OPTION>" << endl;
	cout << "            </SELECT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\">Religion:</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "<!-- religion  --> " << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <SELECT" << endl;
	cout << "             size=\"1\"" << endl;
	cout << "             name=\"religion\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"0\">" << endl;
	cout << "                Prefer not to say" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"1\">" << endl;
	cout << "                Islam" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"2\">" << endl;
	cout << "                Christian" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"3\">" << endl;
	cout << "                Catholic" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"4\">" << endl;
	cout << "                Jewish" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"5\">" << endl;
	cout << "                Zoroastrian" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"6\">" << endl;
	cout << "                Bahai" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"7\">" << endl;
	cout << "                Other" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"8\">" << endl;
	cout << "                Not religious" << endl;
	cout << "              </OPTION>" << endl;
	cout << "            </SELECT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "<!-- height -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\">Height:</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <SELECT" << endl;
	cout << "             size=\"1\"" << endl;
	cout << "             name=\"height\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"0\">" << endl;
	cout << "                Prefer not to say" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"1\">" << endl;
	cout << "                4' 01\"(1.24m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"2\">" << endl;
	cout << "                4' 02\" (1.27m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"3\">" << endl;
	cout << "                4' 03\"(1.30m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"4\">" << endl;
	cout << "                4'04\" (1.32m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"5\">" << endl;
	cout << "                4' 05\" (1.35m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"6\">" << endl;
	cout << "                4' 06\" (1.37m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"7\">" << endl;
	cout << "                4' 07\" (1.40m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"8\">" << endl;
	cout << "                4' 08\" (1.42m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"9\">" << endl;
	cout << "                4' 09\" (1.45m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"10\">" << endl;
	cout << "                4' 10\" (1.47m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"11\">" << endl;
	cout << "                4' 11\" (1.50m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"12\">" << endl;
	cout << "                5' 00\" (1.52m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"13\">" << endl;
	cout << "                5' 01\" (1.55m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"14\">" << endl;
	cout << "                5' 02\" (1.57m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"15\">" << endl;
	cout << "                5' 03\" (1.60m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"16\">" << endl;
	cout << "                5' 04\" (1.63m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"17\">" << endl;
	cout << "                5' 05\"(1.65m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"18\">" << endl;
	cout << "                5' 06\" (1.68m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"19\">" << endl;
	cout << "                5' 07\" (1.70m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"20\">" << endl;
	cout << "                5'08\" (1.73m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"21\">" << endl;
	cout << "                5' 09\" (1.75m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"22\">" << endl;
	cout << "                5' 10\" (1.78m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"23\">" << endl;
	cout << "                5' 11\" (1.80m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"24\">" << endl;
	cout << "                6' 00\" (1.83m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"25\">" << endl;
	cout << "                6' 01\"(1.85m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"26\">" << endl;
	cout << "                6' 02\" (1.88m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"27\">" << endl;
	cout << "                6' 03\" (1.90m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"28\">" << endl;
	cout << "                6'04\" (1.93m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"29\">" << endl;
	cout << "                6' 05\" (1.96m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"30\">" << endl;
	cout << "                6' 06\" (1.98m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"31\">" << endl;
	cout << "                6' 07\" (2.01m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"32\">" << endl;
	cout << "                6' 08\" (2.03m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"33\">" << endl;
	cout << "                6' 09\"(2.06m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"34\">" << endl;
	cout << "                6' 10\" (2.08m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"35\">" << endl;
	cout << "                6' 11\" (2.11m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"36\">" << endl;
	cout << "                7'0\" (2.13m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"37\">" << endl;
	cout << "                7' 01\" (2.16m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"38\">" << endl;
	cout << "                7' 02\" (2.18m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"39\">" << endl;
	cout << "                7' 03\" (2.21m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"40\">" << endl;
	cout << "                7' 04\" (2.24m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"41\">" << endl;
	cout << "                7' 05\"(2.26m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"42\">" << endl;
	cout << "                7' 06\" (2.29m)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "            </SELECT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "" << endl;
	cout << "<!-- weight -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\">Weight:</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <SELECT" << endl;
	cout << "             size=\"1\"" << endl;
	cout << "             name=\"weight\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"0\">" << endl;
	cout << "                Prefer not to say" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"1\">" << endl;
	cout << "                85 lbs. 39kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"2\">" << endl;
	cout << "                90 lbs. (41kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"3\">" << endl;
	cout << "                95 lbs. (43kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"4\">" << endl;
	cout << "                100 lbs.(45kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"5\">" << endl;
	cout << "                105 lbs. (48kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"6\">" << endl;
	cout << "                110 lbs. (50kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"7\">" << endl;
	cout << "                115 lbs. (52kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"8\">" << endl;
	cout << "                120 lbs. (54kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"9\">" << endl;
	cout << "                125 lbs. (57kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"10\">" << endl;
	cout << "                130 lbs. (59kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"11\">" << endl;
	cout << "                135 lbs. (61kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"12\">" << endl;
	cout << "                140 lbs. (64kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"13\">" << endl;
	cout << "                145 lbs. (66kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"14\">" << endl;
	cout << "                150 lbs. (68kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"15\">" << endl;
	cout << "                155 lbs. (70kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"16\">" << endl;
	cout << "                160 lbs. (73kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"17\">" << endl;
	cout << "                165 lbs. (75kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"18\">" << endl;
	cout << "                170 lbs. (77kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"19\">" << endl;
	cout << "                175 lbs. (79kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"20\">" << endl;
	cout << "                180 lbs. (82kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"21\">" << endl;
	cout << "                185 lbs. (84kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"22\">" << endl;
	cout << "                190 lbs. (86kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"23\">" << endl;
	cout << "                195 lbs. (88kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"24\">" << endl;
	cout << "                200 lbs. (91kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"25\">" << endl;
	cout << "                205 lbs. (93kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"26\">" << endl;
	cout << "                210 lbs. (95kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"27\">" << endl;
	cout << "                215 lbs. (98kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"28\">" << endl;
	cout << "                220 lbs. (100kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"29\">" << endl;
	cout << "                225 lbs. (102kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"30\">" << endl;
	cout << "                230 lbs. (104kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"31\">" << endl;
	cout << "                235 lbs. (107kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"32\">" << endl;
	cout << "                240 lbs. (109kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"33\">" << endl;
	cout << "                245 lbs. (111kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"34\">" << endl;
	cout << "                250 lbs. (113kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"35\">" << endl;
	cout << "                255 lbs. (116kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"36\">" << endl;
	cout << "                260 lbs. (118kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"37\">" << endl;
	cout << "                265 lbs. (120kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"38\">" << endl;
	cout << "                270 lbs. (122kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"39\">" << endl;
	cout << "                275 lbs. (125kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"40\">" << endl;
	cout << "                280 lbs. (127kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"41\">" << endl;
	cout << "                285 lbs. (129kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"42\">" << endl;
	cout << "                290 lbs. (132kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"43\">" << endl;
	cout << "                295 lbs. (134kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"44\">" << endl;
	cout << "                300 lbs. (136kg)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"45\">" << endl;
	cout << "                300+ lbs. (136kg+)" << endl;
	cout << "              </OPTION>" << endl;
	cout << "            </SELECT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "<!-- eyes -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\">Eyes:</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <SELECT" << endl;
	cout << "             size=\"1\"" << endl;
	cout << "             name=\"eyes\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"0\">" << endl;
	cout << "                Prefer not to say" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"1\">" << endl;
	cout << "                Brown" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"2\">" << endl;
	cout << "                Black" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"3\">" << endl;
	cout << "                Blue" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"4\">" << endl;
	cout << "                Green" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"5\">" << endl;
	cout << "                Hazel" << endl;
	cout << "              </OPTION>" << endl;
	cout << "            </SELECT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "<!-- hair -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\">Hair:</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <SELECT" << endl;
	cout << "             size=\"1\"" << endl;
	cout << "             name=\"hair\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"0\">" << endl;
	cout << "                Prefer not to say" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"1\">" << endl;
	cout << "                Black" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"2\">" << endl;
	cout << "                Brown" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"3\">" << endl;
	cout << "                Red" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"4\">" << endl;
	cout << "                Blonde" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"5\">" << endl;
	cout << "                Balding" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"6\">" << endl;
	cout << "                Other" << endl;
	cout << "              </OPTION>" << endl;
	cout << "            </SELECT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "<!-- min_age_desired -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\">Seeking ages from:</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <!--webbot bot=\"Validation\" S-Data-Type=\"Number\"" << endl;
	cout << "                    S-Number-Separators=\"x,\"" << endl;
	cout << "                    S-Validation-Constraint=\"Greater than or equal to\"" << endl;
	cout << "                    S-Validation-Value=\"18\" S-Validation-Constraint=\"Less than or equal to\"" << endl;
	cout << "                    S-Validation-Value=\"100\" --><INPUT" << endl;
	cout << "             type=\"text\"" << endl;
	cout << "             name=\"min_age_desired\"" << endl;
	cout << "             size=\"3\"> " << endl;
	cout << "<!-- max_age_desired -->" << endl;
	cout << "		To: <!--webbot" << endl;
	cout << "                    bot=\"Validation\" S-Data-Type=\"Number\" S-Number-Separators=\"x.\"" << endl;
	cout << "                    S-Validation-Constraint=\"Greater than or equal to\"" << endl;
	cout << "                    S-Validation-Value=\"18\" S-Validation-Constraint=\"Less than or equal to\"" << endl;
	cout << "                    S-Validation-Value=\"100\" --> <INPUT" << endl;
	cout << "             type=\"text\"" << endl;
	cout << "             name=\"max_age_desired\"" << endl;
	cout << "             size=\"3\">" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "" << endl;
	cout << "<!-- relationship  -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\">Relationship type:</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"24\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <SELECT" << endl;
	cout << "             size=\"5\"" << endl;
	cout << "             name=\"relationship\"" << endl;
	cout << "             multiple>" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"0\">" << endl;
	cout << "                Prefer not to say" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"1\">" << endl;
	cout << "                Any" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"2\">" << endl;
	cout << "                Hang Out" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"3\">" << endl;
	cout << "                Short-term" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"4\">" << endl;
	cout << "                Long-term" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"5\">" << endl;
	cout << "                Talk/E-mail" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"6\">" << endl;
	cout << "                Photo Exchange" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"7\">" << endl;
	cout << "                Marriage" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"8\">" << endl;
	cout << "                Other" << endl;
	cout << "              </OPTION>" << endl;
	cout << "            </SELECT><FONT" << endl;
	cout << "             size=\"2\">You can choose several</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "<!-- cook -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\">Do you like to cook?</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <SELECT" << endl;
	cout << "             size=\"1\"" << endl;
	cout << "             name=\"cook\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"0\">" << endl;
	cout << "                Prefer not to say" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"1\">" << endl;
	cout << "                Yes" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"2\">" << endl;
	cout << "                No" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"3\">" << endl;
	cout << "                We'll See!" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"4\">" << endl;
	cout << "                Will Never Cook" << endl;
	cout << "              </OPTION>" << endl;
	cout << "            </SELECT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "<!-- smoke -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\">Do you smoke?</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <SELECT" << endl;
	cout << "             size=\"1\"" << endl;
	cout << "             name=\"smoke\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"0\">" << endl;
	cout << "                Prefer not to say" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"1\">" << endl;
	cout << "                Yes" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"2\">" << endl;
	cout << "                No" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"3\">" << endl;
	cout << "                Sometimes" << endl;
	cout << "              </OPTION>" << endl;
	cout << "            </SELECT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "<!-- drink -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"right\">" << endl;
	cout << "            <FONT" << endl;
	cout << "             size=\"2\">Do you drink?</FONT>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <SELECT" << endl;
	cout << "             size=\"1\"" << endl;
	cout << "             name=\"drink\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"0\">" << endl;
	cout << "                Prefer not to say" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"1\">" << endl;
	cout << "                Yes" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"2\">" << endl;
	cout << "                No" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"3\">" << endl;
	cout << "                Often" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"4\">" << endl;
	cout << "                Sometimes" << endl;
	cout << "              </OPTION>" << endl;
	cout << "            </SELECT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "<!-- party -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\">" << endl;
	cout << "            <P" << endl;
	cout << "             align=\"right\">" << endl;
	cout << "              <FONT" << endl;
	cout << "               size=\"2\">How much do you like to party?</FONT>" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\"" << endl;
	cout << "           valign=\"top\">" << endl;
	cout << "            <SELECT" << endl;
	cout << "             size=\"1\"" << endl;
	cout << "             name=\"party\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"0\">" << endl;
	cout << "                Prefer not to say" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"1\">" << endl;
	cout << "                What does the party mean?" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"2\">" << endl;
	cout << "                Only on special occations" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"3\">" << endl;
	cout << "                On the weekends" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"4\">" << endl;
	cout << "                Every chance I get" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"5\">" << endl;
	cout << "                I party so hard I wake up in different time zones" << endl;
	cout << "              </OPTION>" << endl;
	cout << "            </SELECT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "" << endl;
	cout << "<!-- political -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\">" << endl;
	cout << "            <P" << endl;
	cout << "             align=\"right\">" << endl;
	cout << "              <FONT" << endl;
	cout << "               size=\"2\">What are your political views?&#160;</FONT>" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           valign=\"top\">" << endl;
	cout << "            <SELECT" << endl;
	cout << "             size=\"1\"" << endl;
	cout << "             name=\"political\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"0\">" << endl;
	cout << "                Prefer not to say" << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"1\">" << endl;
	cout << "                I wish I was born pink." << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"2\">" << endl;
	cout << "                Liberal." << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"3\">" << endl;
	cout << "                Moderate Liberal." << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"4\">" << endl;
	cout << "                Moderate Conservative." << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"5\">" << endl;
	cout << "                Conservative." << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"6\">" << endl;
	cout << "                Extreme Conservative." << endl;
	cout << "              </OPTION>" << endl;
	cout << "              <OPTION" << endl;
	cout << "               value=\"7\">" << endl;
	cout << "                If I were any more conservative I would't use electricity." << endl;
	cout << "              </OPTION>" << endl;
	cout << "            </SELECT>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>" << endl;
	cout << "" << endl;
	cout << "<!-- housing_status -->" << endl;
	cout << "        <TR>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"181\"" << endl;
	cout << "           height=\"22\"" << endl;
	cout << "           align=\"left\">" << endl;
	cout << "            <P" << endl;
	cout << "             style=\"line-height: 100%\"" << endl;
	cout << "             align=\"right\">" << endl;
	cout << "              <FONT" << endl;
	cout << "               size=\"2\">What are your living arrangements?</FONT>" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "          <TD" << endl;
	cout << "           width=\"371\"" << endl;
	cout << "           height=\"22\">" << endl;
	cout << "            <P" << endl;
	cout << "             style=\"line-height: 100%\">" << endl;
	cout << "              <SELECT" << endl;
	cout << "               size=\"1\"" << endl;
	cout << "               name=\"housing_status\">" << endl;
	cout << "                <OPTION SELECTED" << endl;
	cout << "                 value=\"-1\">" << endl;
	cout << "                   Married" << endl;
	cout << "              </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"0\">" << endl;
	cout << "                  Prefer not to say" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"1\">" << endl;
	cout << "                  Live alone" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"2\">" << endl;
	cout << "                  Live with room mates" << endl;
	cout << "                </OPTION>" << endl;
	cout << "                <OPTION" << endl;
	cout << "                 value=\"3\">" << endl;
	cout << "                  Live with parents" << endl;
	cout << "                </OPTION>" << endl;
	cout << "              </SELECT>" << endl;
	cout << "            </P>" << endl;
	cout << "          </TD>" << endl;
	cout << "        </TR>	" << endl;
	}
	}
	
*/
}

#endif// DB_TABLE_BASE_H

