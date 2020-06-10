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

#include <string>	// defines the standard string class

#include "SendMailBlat/SendMailBlat.h"
#include "CommentMacro.h" // contains the contains the comment macro def of "dout"

/*
*	Namespace directives that are necessary if the ANCII Standard library headers are used...
*/

int SendMailBlat(LinkMap & Map
				 , const string& To
				 , const string& Subject
				 , const string& From
				 , const string& Bcc
				 , const string& Body
				 , const string& SMTPServer
				 )
{
	int system_return = 0;
	
	// Build email to send...
	const string BlatExe 		= Map.PrintValue("BLAT_PATH") + "/EXE/blat.exe "; // !!!! Extra space at the end is required
	const string BlatLog 		= Map.PrintValue("BLAT_PATH") + "/LOG/blat.log "; // !!!! Extra space at the end is required
//	const string File			= "D:/Required/EXE/RequiredBlankBlatFile.txt";  
	const string File			= "-";  // "-" can be used for console input in place of a file
	
	string Command = BlatExe 
		+ File						//  file with the message body ('-' for console input, end with ^Z)
		+ " -to "		+ To 
		+ " -subject "	+ Subject 
		+ " -f "		+ From 
		//+ " -bcc "		+ Bcc
		//+ " -org "	+ Org
		+ " -body "		+ Body
		//+ " -r "					// Request return receipt
		+ " -q "					// Suppresses ALL output
#if _DEBUG
		+ " -debug "				// Echoes server communications to screen (disables '-q')
#endif
		+ " -noh2 "					// Prevent X-Mailer header entirely
		+ " -server "	+ SMTPServer
		//+ " -html "				// Send an HTML message
		//+ " -try "				// <n times> How many time blat should try to send. from '1' to 'INFINITE'
		//+ " -attach "				// <file> Attach binary file to message (may be repeated)
		//+ " -attacht "			// <file> Attach text file to message (may be repeated)
		+ " -log "		+ BlatLog	// Log everything but usage to <filename>
		;
	
	dout << "<!-- SendMailBlat Command: \"" << Command		 << "\" -->\n";
	dout << "<!-- SendMailBlat Return:  \"" << system_return << "\" -->\n";
	system_return = system(Command.c_str()); // execute system call
	
	return system_return;
}


int SendMailBlat(LinkMap & Map
				 , const string& To
				 , const string& Subject
				 , const string& From
				 , const string& Bcc	// Cannot use when sending a real file as first parameter  (File)
				 , const string& Body
				 , const string& Full_Path_To_HTML_File
				 , const string& SMTPServer
				 )
{
	int system_return = 0;
	
	// Build email to send...
	const string BlatExe 		= Map.PrintValue("BLAT_PATH") + "/EXE/blat.exe "; // !!!! Extra space at the end is required
	const string BlatLog 		= Map.PrintValue("BLAT_PATH") + "/LOG/blat.log "; // !!!! Extra space at the end is required
	const string File			= Full_Path_To_HTML_File;  // "-" can be used for console input in place of a file
	
	string Command = BlatExe 
		+ File									//  file with the message body ('-' for console input, end with ^Z)
		+ " -to "		+ To 
		+ " -subject "	+ Subject 
		+ " -f "		+ From 
//		+ " -bcc "		+ Bcc
//		+ " -org "		+ Org
//		+ " -body "		+ Body
//		+ " -r "								// Request return receipt
		+ " -q "								// Suppresses ALL output
#if _DEBUG
		+ " -debug "							// Echoes server communications to screen (disables '-q')
#endif
		+ " -noh2 "								// Prevent X-Mailer header entirely
		+ " -server "	+ SMTPServer
		+ " -html "								// Send an HTML message
//		+ " -try "							// <n times> How many time blat should try to send. from '1' to 'INFINITE'
//		+ " -attach "							// <file> Attach binary file to message (may be repeated)
//		+ " -attacht "	+ Full_Path_To_HTML_File// <file> Attach text file to message (may be repeated)
		+ " -log "		+ BlatLog				// Log everything but usage to <filename>
		;
	
	dout << "<!-- SendMailBlat Command: \"" << Command		 << "\" -->\n";
	dout << "<!-- SendMailBlat Return:  \"" << system_return << "\" -->\n";
	system_return = system(Command.c_str()); // execute system call
	
	return system_return;
}

