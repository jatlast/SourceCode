#include <vector>
#include <string>

#include <iostream>

#include "AddJavaScript.h"
#include "DB_Table_Base/Login_Info.h"

using std::cout;
using std::endl;

void main()
{
	Login_Info li("", "");
	
//	for(int i=0; i<li.Vect.size(); i++)
//		cout << li.Vect[i] << endl;
	
	AddJavaScript js(li.Vect);
	
	js.ToggleFlag("email");
	cout << js.faf_vect << endl;
	
	js.InsertJavaScript();
}