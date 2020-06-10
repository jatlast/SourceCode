#ifndef ABOUT_INFO
#define ABOUT_INFO


#include <vector>
#include <string>

#include <iostream>

#include "DB_Table_Base.h"

class About_Info : public db_table_base_namespace::DB_Table_Base
{
public:
	
	About_Info(const string & get_info_sql, const string & update_info_sql);	

	~About_Info()
	{
		//cout << "----------Within ~About_Info()" << endl;	
	};

	virtual void
		Print_Current_And_Change( const string & name );

private:
	About_Info();
	About_Info(const About_Info & ci);
	About_Info &
		operator=(const About_Info & rhs);

};

#endif // ABOUT_INFO
