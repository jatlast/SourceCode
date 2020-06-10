#ifndef CONNECTIONS_TEMPLATES_H
#define CONNECTIONS_TEMPLATES_H

#include "cgicc/Cgicc.h"
#include "DB_Table_Base/DB_Table_Base.h"

//extern class db_table_base_namespace::DB_Table_Base;
using namespace cgicc;
using db_table_base_namespace::DB_Table_Base;

// used with both SimpleSearch and AdvancedSearch
bool
Search_Template(class DB_Table_Base *& Base_Ptr, const string & Program_Name);
// creates an info table in the database
bool
Create_Template(class DB_Table_Base *& Base_Ptr, const string & Program_Name);
// updates an info table in the database
bool
Update_Template(class DB_Table_Base *& Base_Ptr, const string & Program_Name);

bool
SingleProfile_Template(class DB_Table_Base *& Base_Ptr, const string & Program_Name);

bool
Get_Cookie_Name_Password(const Cgicc& cgi, string& cookie_name, string& cookie_password);

bool
Get_Single_Cookie_By_Name(const Cgicc& cgi, const string cookie_name, string& cookie_value);

string
Escape_Quotation_Marks(const string & string_to_replace);

#endif //CONNECTIONS_TEMPLATES_H