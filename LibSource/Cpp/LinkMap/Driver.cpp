
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
/*
*	Standard ANSI C++ Headers...
*/
#include <iostream>	// defines the standard input and output functions
/*
*	User Defined headers...
*/
#include "LinkMap/LinkMap.h" // associative map class
#include "ConnectionsFunctions/ConnectionsFormLayout.h"
/*
*	Namespace directives that are necessary if the ANCII Standard library headers are used...
*/
using std::cout;
using std::endl;
using std::flush;
using std::string;

void main()
{
	/*
	*	instantiate the class that defines the form layouts for the page...
	*/
	CConnectionsFormLayout cfl;	

	cout << "Content-Type: text/html\n\n" << flush;
	
	string LinkMapPath = cfl.GetLinkMapPath();

	cout << "<HTML>" << endl;

	// Old Constructor...
	//LinkMap Map(LinkMapPath);

	// New Constructor...
	LinkMap Map(LinkMapPath, "www.LatinLoveMatch.com");
	
	cout << "<HEAD>" << endl;
	cout << "<TITLE></TITLE>" << endl;
	cout << "</HEAD>" << endl;
	cout << "<BODY BGCOLOR=\"#FFFFFF\" TEXT=\"#000000\" LINK=\"#0000FF\" VLINK=\"#800080\" ALINK=\"#FF0000\">" << endl;
	
	Map.PrintMap();
	//cout << Map.PrintValue( "ROOT" ) << endl;
	
	cout << "</BODY>" << endl;
	cout << "</HTML>" << endl;
	
}




