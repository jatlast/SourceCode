#ifndef ADDJAVASCRIPT_H
#define ADDJAVASCRIPT_H

#include <vector>
#include <string>

#include <iostream>

#include "DB_Table_Base/DB_Table_Base.h"

using std::ostream;
using std::vector;
using std::string;
using std::ostream;
using std::cout;
using std::endl;

//using db_table_base_namespace::DB_Table_Base;

class AddJavaScript
{
protected:
	struct FieldAndFlag
	{
	public:
		// constructor
		FieldAndFlag(const string & Field, bool Flag)
		{
			field = Field;
			flag  = Flag;
		}
		// copy constructor
		FieldAndFlag(const FieldAndFlag & faf)
		{
			field = faf.field;
			flag  = faf.flag;
		}
		// overloaded operator=
		FieldAndFlag &
			operator=(const FieldAndFlag & rhs)
		{
			if(this != &rhs)
			{
				field = rhs.field;
				flag  = rhs.flag;
			}
			return *this;
		}
		
		// member variables
		string field;
		bool flag;
		
	private:
		FieldAndFlag();
	};	
	public:
		vector<FieldAndFlag> faf_vect;
		
		AddJavaScript(const vector<db_table_base_namespace::DB_Table_Base::DB_Table_Info> & DBTI_Vect);
		
		void 
			ToggleFlag(const string & Field);

		void
			InsertJavaScript();
		

		void
			InsertJavaScriptFile(const string & Path, const string & File);

//		friend ostream &
//			operator<< (ostream & out, const vector<FieldAndFlag> & FAF_Vector);
		
	private:
		// not to be implemented
		AddJavaScript();
		AddJavaScript(const AddJavaScript & ajs);
		AddJavaScript &
			operator=(const AddJavaScript & rhs);
};


#endif ADDJAVASCRIPT_H