#ifndef BILLING_INFO
#define BILLING_INFO


#include <vector>
#include <string>
#include <iostream>

#include "DB_Table_Base.h"

class Billing_Info : public db_table_base_namespace::DB_Table_Base
{
public:
	
	Billing_Info(const string & get_info_sql, const string & update_info_sql);	

	~Billing_Info()
	{
		//cout << "----------Within ~Billing_Info()" << endl;	
	};

	virtual void
		Print_Current_And_Change( const string & name );

private:
	Billing_Info();
	Billing_Info(const Billing_Info & ci);
	Billing_Info &
		operator=(const Billing_Info & rhs);

};



#endif // BILLING_INFO
