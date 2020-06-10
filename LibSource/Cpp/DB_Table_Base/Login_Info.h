#ifndef LOGIN_INFO
#define LOGIN_INFO


#include <vector>
#include <string>
#include <iostream>

#include "DB_Table_Base.h"

class Login_Info : public db_table_base_namespace::DB_Table_Base
{
public:
	
	Login_Info(const string & get_info_sql, const string & update_info_sql);
	
	Login_Info(const string & update_info_sql);// used with UpdateLoginIndex.exe
	
	~Login_Info()
	{
		//cout << "----------Within ~Login_Info()" << endl;	
	};
	
	virtual void
		Print_Current_And_Change( const string & name );		 
	
private:
	// prevent the use of default ctor, copy ctor, & assignment 
	Login_Info();
	Login_Info(const Login_Info & li);
	Login_Info &
		operator=(const Login_Info & rhs);
	
};



#endif // LOGIN_INFO
