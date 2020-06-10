#ifndef SIMPLESEARCH_INFO
#define SIMPLESEARCH_INFO


#include <vector>
#include <string>
#include <iostream>

#include "DB_Table_Base.h"

class SimpleSearch_Info : public db_table_base_namespace::DB_Table_Base
{
public:
	
	SimpleSearch_Info(const string & get_info_sql, const string & update_info_sql);	

	~SimpleSearch_Info()
	{
		//cout << "----------Within ~SimpleSearch_Info()" << endl;	
	};

	virtual void
		Print_Current_And_Change( const string & name );

private:
	SimpleSearch_Info();
	SimpleSearch_Info(const SimpleSearch_Info & ci);
	SimpleSearch_Info &
		operator=(const SimpleSearch_Info & rhs);

};



#endif // SIMPLESEARCH_INFO
