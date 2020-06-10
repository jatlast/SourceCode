#ifndef ADVANCEDSEARCH_INFO
#define ADVANCEDSEARCH_INFO


#include <vector>
#include <string>
#include <iostream>

#include "DB_Table_Base.h"

class AdvancedSearch_Info : public db_table_base_namespace::DB_Table_Base
{
public:
	
	AdvancedSearch_Info(const string & get_info_sql, const string & update_info_sql);	

	~AdvancedSearch_Info()
	{
		//cout << "----------Within ~AdvancedSearch_Info()" << endl;	
	};

	virtual void
		Print_Current_And_Change( const string & name );

private:
	AdvancedSearch_Info();
	AdvancedSearch_Info(const AdvancedSearch_Info & ci);
	AdvancedSearch_Info &
		operator=(const AdvancedSearch_Info & rhs);

};



#endif // ADVANCEDSEARCH_INFO
