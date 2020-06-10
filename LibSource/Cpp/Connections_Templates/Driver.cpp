

//#include "DB_Table_Base/Login_Info.h"
#include "DB_Table_Base/SimpleSearch_Info.h"
#include "AddJavaScript/AddJavaScript.h"
#include "DB_Table_Base/DB_Table_Base.h"
#include "Connections_Templates/Connections_Templates.h"


void main()
{
	DB_Table_Base * Base_Ptr = new SimpleSearch_Info("simpleSearch", "");

	// Create_Template takes the page name of the next page in the create chain...
	Search_Template(Base_Ptr, "CreateContact.html");

	delete Base_Ptr;
}
