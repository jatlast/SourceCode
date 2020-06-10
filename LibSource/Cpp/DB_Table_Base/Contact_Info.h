#ifndef CONTACT_INFO
#define CONTACT_INFO


#include <vector>
#include <string>
#include <iostream>

#include "DB_Table_Base.h"

class Contact_Info : public db_table_base_namespace::DB_Table_Base
{
public:
	
	Contact_Info(const string & get_info_sql, const string & update_info_sql);	

	~Contact_Info()
	{
		//cout << "----------Within ~Contact_Info()" << endl;	
	};

	virtual void
		Print_Current_And_Change( const string & name );

private:
	Contact_Info();
	Contact_Info(const Contact_Info & ci);
	Contact_Info &
		operator=(const Contact_Info & rhs);

};



#endif // CONTACT_INFO
