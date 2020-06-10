#ifndef SENDMAILBLAT_H
#define SENDMAILBLAT_H

#include <string>
#include "LinkMap/LinkMap.h" // associative map class

using std::string;


int SendMailBlat(LinkMap & Map
				 , const string& To
				 , const string& Subject
				 , const string& From
				 , const string& Bcc
				 , const string& Body
				 , const string& SMTPServer
				 );

int SendMailBlat(LinkMap & Map
				 , const string& To
				 , const string& Subject
				 , const string& From
				 , const string& Bcc
				 , const string& Body
				 , const string& Full_Path_To_HTML_File
				 , const string& SMTPServer
				 );

#endif //SENDMAILBLAT_H
