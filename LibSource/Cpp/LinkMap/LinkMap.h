#ifndef LINKMAP_H
#define LINKMAP_H

#include <iostream>	// defines the standard input and output functions
#include <map>		// defines the standard STL Contiainer map and multimap
#include <string>	// defines the standard string class
#include <fstream>	// defines the standard file input and output functions
#include <iomanip>	// defines the standard file input and output manipulation functions

/*
 *	Namespace directives that are necessary if the ANCII Standard library headers are used...
 */

using std::cout;
using std::endl;
using std::string;

/*
 *	Type definition to prevent from having to type so much crap...
 */
typedef std::map<string,string> SSM;


/*
 *	Begin class definition for LinkMap class...
 */
class LinkMap
{
public:
	
	// Old LM consturctor...
	LinkMap(const string FileName);
	// New LM consturctor with Website Server name passed in...
	LinkMap(const string FileName, string ServerName);
	~LinkMap();
	PrintMap();
	const string
		PrintValue(const string & key);


private:
	string LinkMapPath;
	SSM StringStringMap;
	SSM::iterator Iterator;

	// not to be implemented
	LinkMap();
	LinkMap(const LinkMap & lm);
	LinkMap &
		operator=(const LinkMap & rhs);


};	// end LinkMap class

#endif // LINKMAP_H