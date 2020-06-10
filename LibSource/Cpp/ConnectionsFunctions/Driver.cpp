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

#include <iostream>

#include "ConnectionsFunctions/ConnectionsFormLayout.h"
#include "LinkMap/LinkMap.h"

using std::cout;
using std::endl;
using std::flush;

void main()
{
	//	instantiate the class that defines the form layouts for the page...
	CConnectionsFormLayout cfl;
	
	// Read the file containg the current URL configurations...
	LinkMap Map( cfl.GetLinkMapPath() );

	cout << "Content-Type: text/html\n\n" << flush;
	
	cfl.Html_Begin(Map, 0, GEN_INBOX);
	cout << "<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><H1>NOT Logged In -- inbox</H1>" << endl;
	cfl.Html_End(Map);

	cfl.Html_Begin(Map, 1, GEN_OUTBOX);
	cout << "<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><H1>NOT Logged In -- outbox</H1>" << endl;
	cfl.Html_End(Map);

	cfl.Html_Begin(Map, 0, GEN_HOME);
	cout << "<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><H1>NOT Logged In -- home</H1>" << endl;
	cfl.Html_End(Map);

	cfl.Html_Begin(Map, 0, SIMPLE_SEARCH);
	cout << "<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><H1>NOT Logged In -- simple</H1>" << endl;
	cfl.Html_End(Map);

	cfl.Html_Begin(Map, 0, ADVANCED_SEARCH);
	cout << "<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><H1>NOT Logged In -- advanced</H1>" << endl;
	cfl.Html_End(Map);


}
