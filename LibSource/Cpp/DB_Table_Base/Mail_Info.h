#ifndef MAIL_INFO
#define MAIL_INFO


#include <vector>
#include <string>
#include <iostream>

#include "DB_Table_Base.h"

class Mail_Info : public db_table_base_namespace::DB_Table_Base
{
public:
	
	Mail_Info(const string & get_info_sql, const string & update_info_sql);
	
	~Mail_Info()
	{
		//cout << "----------Within ~Mail_Info()" << endl;	
	};
	
	virtual void
		Print_Current_And_Change( const string & name );		 
	
private:
	// prevent the use of default ctor, copy ctor, & assignment 
	Mail_Info();
	Mail_Info(const Mail_Info & mi);
	Mail_Info &
		operator=(const Mail_Info & rhs);
	
};



#endif // MAIL_INFO
