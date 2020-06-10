#ifndef PERSONAL_INFO
#define PERSONAL_INFO


#include <vector>
#include <string>

#include <iostream>

#include "DB_Table_Base.h"

class Personal_Info : public db_table_base_namespace::DB_Table_Base
{
public:
	
	Personal_Info(const string & get_info_sql, const string & update_info_sql);	

	~Personal_Info()
	{
	//	cout << "----------Within ~Personal_Info()" << endl;	
	};

	virtual void
		Print_Current_And_Change( const string & name );

private:
	Personal_Info();
	Personal_Info(const Personal_Info & ci);
	Personal_Info &
		operator=(const Personal_Info & rhs);

};



#endif // PERSONAL_INFO
