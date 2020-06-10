#ifndef DB_MSG_ERR_HANDLERS_H
#define DB_MSG_ERR_HANDLERS_H

/*
*	Sybase Open Client header files...
*/
#include <string>

// defining DEBUG_OFF turns off TracingAndTiming...
#define DEBUG_OFF 1
#include "TracingAndTiming/TracingAndTiming.h"

extern "C"
{
#include <sybfront.h> 
#include <sybdb.h> 
#include <syberror.h> 
}

//#include "DB_Table_Base.h"

// These should probably not be global but it was the easiest solution...
bool Global_DBSuccess = true;
// Define globle variable to hold the DB_Error_Text length...
const int DB_ERROR_TEXT	= 128;
// Define globle variable DB_Error_Text to report DB errors...
char DB_Error_Text [DB_ERROR_TEXT] = "\n<!-- No Error Message -->\n";


/**********************************************************************
*
*  error handler for system-level errors reported by the remote SQL
*  Server...
*
**********************************************************************/

extern "C" int CS_PUBLIC DBFAR err_handler( DBPROCESS DBFAR * dbproc
										   , int               severity
										   , int               dberr
										   , int               oserr
										   , char DBFAR      * dberrstr
										   , char DBFAR      * oserrstr
										   )
										   
{
	// Define a TracingAndTiming object...
	Debug MyMain("err_handler",false);
    MyMain.specify("D;ERROR,SUCCESS,GenHome");	// Enable Dbg/Dbx for the specified comma seperated strings
    //MyMain.specify("M;err_handler");				// Enable Timing  for the specified comma seperated strings
	//MyMain.specify("T;err_handler");				// Enable Tracing for the specified comma seperated strings
	MyMain.specify("O;C:/Required/LOG/TracingAndTiming.log");// specify the log file
	
	MyMain.Dbg("ERROR", "Within err_handler");// Print error message to the log
	MyMain.Dbg("ERROR", "dberr: ", dberr );
	MyMain.Dbg("ERROR", "severity: ", severity );
	
	
#ifdef _DEBUG
#ifndef PRINT_JAVA_SCRIPT
	printf("\n<!-- Within err_handler -->\n");
    printf("<!-- dberr %d, severity %d -->\n", dberr, severity);
#endif	// unndef PRINT_JAVA_SCRIPT
#endif	// else _DEBUG
	
	
	Global_DBSuccess = false;

	sprintf(DB_Error_Text, "<!-- Severe Database Error: Contact Tech Support. -->");

	if ((dbproc == NULL) || (DBDEAD(dbproc)))           
		return(INT_EXIT);      
	else       
	{
		MyMain.Dbg("ERROR", "DB-Library error: ", dberrstr );
#ifdef _DEBUG
#ifndef PRINT_JAVA_SCRIPT
		printf("<!-- DB-Library error:\n\t%s -->\n", dberrstr); 
#endif	// unndef PRINT_JAVA_SCRIPT
#endif	// else _DEBUG
	}
	if (oserr != DBNOERR)                
	{
		MyMain.Dbg("ERROR", "Operating-system error: ", oserrstr );
#ifdef _DEBUG
#ifndef PRINT_JAVA_SCRIPT
		printf("<!-- Operating-system error:\n\t%s -->\n", oserrstr);           
#endif	// unndef PRINT_JAVA_SCRIPT
#endif	// else _DEBUG
	}
	
	return(INT_CANCEL);
	
}  /* end SybaseErrHandler() */


   /**********************************************************************
   *
   *  error handler for program-level errors reported by the remote
   *  SQL Server...
   *
**********************************************************************/

extern "C" int CS_PUBLIC DBFAR msg_handler( DBPROCESS DBFAR * dbproc
										   , DBINT             msgno
										   , int               msgstate
										   , int               severity
										   , char      DBFAR * msgtext
										   , char      DBFAR * srvname
										   , char      DBFAR * procname
										   , int               line
										   )
										   
{
	// Define a TracingAndTiming object...
	Debug MyMain("msg_handler",false);
    MyMain.specify("D;ERROR,SUCCESS,GenHome");	// Enable Dbg/Dbx for the specified comma seperated strings
    //MyMain.specify("M;msg_handler");				// Enable Timing  for the specified comma seperated strings
	//MyMain.specify("T;msg_handler");				// Enable Tracing for the specified comma seperated strings
	MyMain.specify("O;C:/Required/LOG/TracingAndTiming.log");// specify the log file
	
// ifdef Example: #if defined (__cplusplus) && !defined (NOT_C_CODE)

#ifdef _DEBUG
#ifndef PRINT_JAVA_SCRIPT
	   printf("\n<!-- Within msg_handler -->\n");
	   
	   //	   if(msgstate == 1)
	   if( !strncmp( msgtext, "ERROR", strlen("ERROR") ) )
	   {
		   Global_DBSuccess = false;
		   printf("<!-- Sybase error should have been set. -->\n");
	   }
	   
	   printf ("<!-- DBDead %d, Msg %ld, Level %d, State %d\n", DBDEAD(dbproc), msgno, severity, msgstate);
	   if (strlen(srvname) > 0)           
	   {
		   printf ("Server '%s', ", srvname);       
	   }
	   if (strlen(procname) > 0)           
	   {
		   printf ("Procedure '%s', ", procname);       
	   }
	   if (line > 0)           
	   {
		   printf ("Line %d", line);       
	   }
	   
	   printf("\nMessage Text: \"%s\" -->\n\n", msgtext); 

#else  
	   //	   if(msgstate == 1)
	   if( !strncmp( msgtext, "ERROR", strlen("ERROR") ) )
	   {
		   Global_DBSuccess = false;
	       printf("document.write(\"Sybase error should have been set.\")\n");
	   }
	   
	   //printf ("document.write(\"\nMessage Text: [%s] -->\n\n\")\n", msgtext);       

#endif	// unndef PRINT_JAVA_SCRIPT
#endif	// else _DEBUG

	   
	   // check for error while creating a new user...
	   if ( !strncmp(msgtext, "user_name is not unique", 23) )
	   {
		   MyMain.Dbg("ERROR", "Within msg_handler DB Message: ", msgtext);
		   // Set global error text variable...
		   sprintf(DB_Error_Text, msgtext);
		   Global_DBSuccess = false;
	   }
	   // check for implicit conversion error...
	   if ( !strncmp(msgtext, "Implicit", 8) )
	   {
		   MyMain.Dbg("ERROR", "Within msg_handler DB Message: ", msgtext);
		   // Set global error text variable...
		   sprintf(DB_Error_Text, msgtext);
		   Global_DBSuccess = false;
	   }
	   // check if membership_type is sufficient for transaction...
	   if ( !strncmp(msgtext, "You must upgrade your membership to use this feature", 52) )
	   {
		   MyMain.Dbg("ERROR", "Within msg_handler DB Message: ", msgtext);
		   // Set global error text variable...
		   sprintf(DB_Error_Text, msgtext);
		   Global_DBSuccess = false;
	   }
	   // check if membership_type is sufficient for transaction...
	   if ( !strncmp(msgtext, "membership_type does not permit mail", 36) )
	   {
		   MyMain.Dbg("ERROR", "Within msg_handler DB Message: ", msgtext);
		   // Set global error text variable...
		   sprintf(DB_Error_Text, msgtext);
		   Global_DBSuccess = false;
	   }
	   // check if the user exists in the DB...
	   if ( !strncmp(msgtext, "user_name does not exist", 24) )
	   {
		   MyMain.Dbg("ERROR", "Within msg_handler DB Message: ", msgtext);
		   // Set global error text variable...
		   sprintf(DB_Error_Text, msgtext);
		   Global_DBSuccess = false;
	   }
	   // check if the user exists in the DB...
	   if ( !strncmp(msgtext, "The user you are trying to view currently has a hidden profile", 62) )
	   {
		   MyMain.Dbg("ERROR", "Within msg_handler DB Message: ", msgtext);
		   // Set global error text variable...
		   sprintf(DB_Error_Text, msgtext);
		   Global_DBSuccess = false;
	   }
	   // check if the user exists in the DB...
	   if ( !strncmp(msgtext, "email address has not been verified", 35) )
	   {
		   MyMain.Dbg("ERROR", "Within msg_handler DB Message: ", msgtext);
		   // Set global error text variable...
		   sprintf(DB_Error_Text, msgtext);
		   Global_DBSuccess = false;
	   }
	   if ( !strncmp(msgtext, "ERROR", 5) )
	   {
		   MyMain.Dbg("ERROR", "Within msg_handler DB Message: ", msgtext);
		   // Set global error text variable...
		   sprintf(DB_Error_Text, msgtext);
		   Global_DBSuccess = false;
	   }
	   
	   
	   return(0); 
	   
}  /* end SybaseMsgHandler() */

#endif // DB_MSG_ERR_HANDLERS_H
