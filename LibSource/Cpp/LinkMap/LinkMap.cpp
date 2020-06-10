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

#include <iostream>	// defines the standard input and output functions
#include <map>		// defines the standard STL Contiainer map and multimap
#include <string>	// defines the standard string class
#include <fstream>	// defines the standard file input and output functions
#include <iomanip>	// defines the standard file input and output manipulation functions
#include <algorithm>// defines the standard algorithm classes including "transform"

#include "LinkMap/LinkMap.h"
#include "CommentMacro.h" // contains the contains the comment macro def of "dout"


/*
*	Namespace directives that are necessary if the ANCII Standard library headers are used...
*/

using std::cout;
using std::endl;
using std::string;
using std::getline;
using std::transform;



LinkMap::LinkMap(const string FileName) : LinkMapPath(FileName)
{
	// open the Local input file
	std::ifstream file( FileName.c_str() );
	
	string Line;        // Create a string of 256 blanks.
	string key  (16u, ' ');         // Create a string of 16 blanks.
	string value(64u, ' ');         // Create a string of 64 blanks.
	// file opened?
	if( file )
	{
		dout << "<!-- Using Local LM -->" << endl;
		while ( getline(file, Line) )
		{	
			
			if( Line.substr(0,1) != "#" && Line.substr(0,1) != " " && Line.substr(0,1) != "\t" && Line.size() > 1)
			{
				key	= Line.substr(0, Line.find_first_of(" \t") );
				Line.erase( 0, key.size() );
				if(Line.find_first_not_of(" \t") != std::string::npos)
				{
					value	= Line.substr( Line.find_first_not_of(" \t") );
					//cout << key << ":" << value << endl;
					StringStringMap.insert( std::make_pair(key, value ) );
				}
			}
			else
			{
				continue;
				//cout << "Line = " << Line << endl;
			}
		}
		// exit because no other LMs need to be loaded...
		return;
	} // No Local LM file...
	else
	{
		// add an error indicator key when the file can not be opened...
		key   = "ERROR";
		value = "1";
		StringStringMap.insert( std::make_pair(key, value ) );
		// add an error message key when the file can not be opened...
		key	  = "ERROR_INFO";
		value = "Could not open " + FileName;
		StringStringMap.insert( std::make_pair(key, value ) );
		// Exit because no LM was found
		return;
		//StringStringMap.insert( std::make_pair("ERROR_VALUE", ("Could not open" + FileName) ) );
	}// end looking for Local LM files...

}

LinkMap::LinkMap(const string FileName, string ServerName) : LinkMapPath(FileName)
{
	// open the Local input file
	std::ifstream file( FileName.c_str() );
	string Specific_LM_Location;
	
	string Line;        // Create a string of 256 blanks.
	string key  (16u, ' ');         // Create a string of 16 blanks.
	string value(64u, ' ');         // Create a string of 64 blanks.
	// file opened?
	if( file )
	{
		dout << "<!-- Using Local LM -->" << endl;
		while ( getline(file, Line) )
		{	
			
			if( Line.substr(0,1) != "#" && Line.substr(0,1) != " " && Line.substr(0,1) != "\t" && Line.size() > 1)
			{
				key	= Line.substr(0, Line.find_first_of(" \t") );
				Line.erase( 0, key.size() );
				if(Line.find_first_not_of(" \t") != std::string::npos)
				{
					value	= Line.substr( Line.find_first_not_of(" \t") );
					//cout << key << ":" << value << endl;
					StringStringMap.insert( std::make_pair(key, value ) );
				}
			}
			else
			{
				continue;
				//cout << "Line = " << Line << endl;
			}
		}
		// exit because no other LMs need to be loaded...
		return;
	} // No Local LM file...
	else
	{
		// open the Shared LinkMap file C:/...
		std::ifstream file( "C:\\Required\\Shared\\LinkMap\\Shared_LinkMap.dat" );
		
		// file opened?
		if( file )
		{
			dout << "<!-- Using Shared_C LM -->" << endl;
			Specific_LM_Location = "C:\\Required\\Shared\\LinkMap\\";
			while ( getline(file, Line) )
			{	
				
				if( Line.substr(0,1) != "#" && Line.substr(0,1) != " " && Line.substr(0,1) != "\t" && Line.size() > 1)
				{
					key	= Line.substr(0, Line.find_first_of(" \t") );
					Line.erase( 0, key.size() );
					if(Line.find_first_not_of(" \t") != std::string::npos)
					{
						value	= Line.substr( Line.find_first_not_of(" \t") );
						//cout << key << ":" << value << endl;
						StringStringMap.insert( std::make_pair(key, value ) );
					}
				}
				else
				{
					continue;
					//cout << "Line = " << Line << endl;
				}
			}
		} // No Shared LM file on C:/...
		else
		{
			// open the Shared LinkMap file D:/...
			std::ifstream file( "D:\\Required\\Shared\\LinkMap\\Shared_LinkMap.dat" );
			
			// file opened?
			if( file )
			{
				Specific_LM_Location = "D:\\Required\\Shared\\LinkMap\\";
				dout << "<!-- Using Shared_D LM -->" << endl;
				while ( getline(file, Line) )
				{	
					
					if( Line.substr(0,1) != "#" && Line.substr(0,1) != " " && Line.substr(0,1) != "\t" && Line.size() > 1)
					{
						key	= Line.substr(0, Line.find_first_of(" \t") );
						Line.erase( 0, key.size() );

						if(Line.find_first_not_of(" \t") != std::string::npos)
						{
							value	= Line.substr( Line.find_first_not_of(" \t") );
							//cout << key << ":" << value << endl;
							StringStringMap.insert( std::make_pair(key, value ) );
						}
					}
					else
					{
						continue;
						//cout << "Line = " << Line << endl;
					}
				}
			} // No Shared LM file on D:/...
			else
			{
				// add an error indicator key when the file can not be opened...
				key   = "ERROR";
				value = "1";
				StringStringMap.insert( std::make_pair(key, value ) );
				// add an error message key when the file can not be opened...
				key	  = "ERROR_INFO";
				value = "Could not open " + FileName;
				StringStringMap.insert( std::make_pair(key, value ) );
				// Exit because no LM was found
				return;
				//StringStringMap.insert( std::make_pair("ERROR_VALUE", ("Could not open" + FileName) ) );
			}// No LinkMap file found...
		}// end LM on D:/...

		// A Shared LM was found so load the Specific LM info...
		transform(ServerName.begin(), ServerName.end(), ServerName.begin(), tolower);
		dout << "<!-- Looking for Key = (" << ServerName << ") -->" << endl;

		Iterator = StringStringMap.find(ServerName);
		if ( Iterator != StringStringMap.end() )
		{
			dout << Iterator->second << endl;
			string Specific_LM = Specific_LM_Location + Iterator->second;
			dout << "<!-- Specific LM = (" << Specific_LM << ") -->" << endl;

			// open the Shared LinkMap file D:/...
			std::ifstream file( Specific_LM.c_str() );
			
			// file opened?
			if( file )
			{
				dout << "<!-- Using Specific " << Iterator->second << " -->" << endl;
				while ( getline(file, Line) )
				{	
					
					if( Line.substr(0,1) != "#" && Line.substr(0,1) != " " && Line.substr(0,1) != "\t" && Line.size() > 1)
					{
						key	= Line.substr(0, Line.find_first_of(" \t") );
						Line.erase( 0, key.size() );
						if(Line.find_first_not_of(" \t") != std::string::npos)
						{
							value	= Line.substr( Line.find_first_not_of(" \t") );
							//cout << key << ":" << value << endl;
							StringStringMap.insert( std::make_pair(key, value ) );
						}
					}
					else
					{
						continue;
						//cout << "Line = " << Line << endl;
					}
				}
			} // No Shared LM file on D:/...
			else
			{
				// add an error indicator key when the file can not be opened...
				key   = "ERROR";
				value = "2";
				StringStringMap.insert( std::make_pair(key, value ) );
				// add an error message key when the file can not be opened...
				key	  = "ERROR_INFO";
				value = "Could not open specific" + Specific_LM;
				StringStringMap.insert( std::make_pair(key, value ) );
				// Exit because no LM was found
				return;
				//StringStringMap.insert( std::make_pair("ERROR_VALUE", ("Could not open" + FileName) ) );
			}// No LinkMap file found...
		}
		else
		{
			dout << "<!-- Could not find key" << endl;;
			//return "Error: Key not found";
		}

	}// end looking for Local LM files...

}

LinkMap::~LinkMap()
{		
	StringStringMap.clear();
}

LinkMap::PrintMap()
{
	cout.setf( std::ios::left, std::ios::adjustfield );
	cout << ' ' << std::setw(10) << "Key        "
		<< "Value" << endl;		
	cout << std::setfill('-') << std::setw(20) << ""
		<< std::setfill(' ') << "\n<BR>" << endl;
	
	for (Iterator = StringStringMap.begin(); Iterator != StringStringMap.end(); ++Iterator)
	{
		cout << "<FONT color=\"blue\">" << std::setw(10) << Iterator->first << " </FONT> <FONT color=\"red\"> "
			<< Iterator->second << "</FONT><BR>" << endl;		
	}
}


const string LinkMap::PrintValue(const string & key)
{
	Iterator = StringStringMap.find(key);
	if ( Iterator != StringStringMap.end() )
	{
		return Iterator->second;
	}
	else
	{
		return "<!-- Could not find key: \"" + key + "\"\n Loking in :\"" + LinkMapPath + "\" -->LM_ERROR";
		//return "Error: Key not found";
	}
}

/*
string key  (16u, ' ');         // Create a string of 16 blanks.
string value(64u, ' ');         // Create a string of 64 blanks.
// file opened?
if( file )
{
while ( file >> key >> value )
{		
cout << key << ":" << value << endl;
StringStringMap.insert( std::make_pair(key, value ) );
}
}
*/