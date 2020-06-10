#ifndef PROFILE_INFO
#define PROFILE_INFO


#include <vector>
#include <string>
#include <iostream>

#include "DB_Table_Base.h"

class Profile_Info : public db_table_base_namespace::DB_Table_Base
{
public:
	
	Profile_Info(const string & get_info_sql, const string & update_info_sql);
	
	~Profile_Info()
	{
		//cout << "----------Within ~Profile_Info()" << endl;	
	};
	
	virtual void
		Print_Current_And_Change( const string & name );		 
	
private:
	// prevent the use of default ctor, copy ctor, & assignment 
	Profile_Info();
	Profile_Info(const Profile_Info & mi);
	Profile_Info &
		operator=(const Profile_Info & rhs);
	
};



#endif // PROFILE_INFO
