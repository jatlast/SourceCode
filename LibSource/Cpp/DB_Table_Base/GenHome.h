#ifndef GENHOME_INFO
#define GENHOME_INFO


#include <vector>
#include <string>
#include <iostream>

#include "DB_Table_Base.h"

class GenHome_Info : public db_table_base_namespace::DB_Table_Base
{
public:
	
	GenHome_Info(const string & get_info_sql, const string & update_info_sql);
	
	~GenHome_Info()
	{
		//cout << "----------Within ~GenHome_Info()" << endl;	
	};
	
	virtual void
		Print_Current_And_Change( const string & name );		 
	
private:
	// prevent the use of default ctor, copy ctor, & assignment 
	GenHome_Info();
	GenHome_Info(const GenHome_Info & mi);
	GenHome_Info &
		operator=(const GenHome_Info & rhs);
	
};



#endif // GENHOME_INFO
