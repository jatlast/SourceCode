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

#include <string>
#include <iostream>

#include "SendMailBlat.h"
#include "ConnectionsFunctions/ConnectionsFormLayout.h"

using std::cout;
using std::endl;
using std::string;


int main()
{
int system_return = 0;

//	instantiate the class that defines the form layouts for the page...
CConnectionsFormLayout cfl;
	
// Read the file containg the current URL configurations...
//LinkMap Map( cfl.GetLinkMapPath() );		
LinkMap Map( "D:/MyData/Personal/Projects/Connections/PersianConnectionsWebDev/cgi-bin/LinkMap.dat" );		

// Build email to send...
const string From	 		= "Admin@PersianConnections.com";
const string To				= "jatlast@hotmail.com";
const string Bcc			= "jatlast@hotmail.com";
const string Subject		= "\"C++ Mail Blat Test.\"";
const string Body	 		= "\"This is a test mail from C++ using Blat\"";
const string HTML_To_Attach	= "\"D:\\MyData\\Personal\\Projects\\Connections\\PersianConnectionsWebDev\\index.html\"";
const string SMTPServer 	= Map.PrintValue("SMTP_HOST");

system_return = SendMailBlat(Map
							, To
							, Subject
							, From
							, ""
							, Body
							, HTML_To_Attach
							, SMTPServer
							);

cout << "system_return = \"" << system_return << "\"" << endl;	

	return system_return;
}