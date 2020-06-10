#ifndef READMAIL_INFO
#define READMAIL_INFO


#include <vector>
#include <string>
#include <iostream>

#include "DB_Table_Base.h"

class ReadMail_Info : public db_table_base_namespace::DB_Table_Base
{
public:
	
	ReadMail_Info(const string & get_info_sql, const string & update_info_sql);
	
	~ReadMail_Info()
	{
		//cout << "----------Within ~ReadMail_Info()" << endl;	
	};
	
	virtual void
		Print_Current_And_Change( const string & name );		 
	
private:
	// prevent the use of default ctor, copy ctor, & assignment 
	ReadMail_Info();
	ReadMail_Info(const ReadMail_Info & mi);
	ReadMail_Info &
		operator=(const ReadMail_Info & rhs);
	
};



#endif // READMAIL_INFO
