// Using Visual C++ version 4.x and later to compile a C++ program with the /Zi option generates the following warning: 
// warning C4786: 'identifier' : identifier was truncated to '255' characters in the debug information 
// See http://support.microsoft.com/support/kb/articles/Q122/5/39.ASP

// Since the above states that these warning can be ignored
// Try and Disable Warning C4786... 
#pragma warning ( disable : 4786 )

// Compiler Warning (level 1) C4251
// 'identifier' : class 'type' needs to have dll-interface to be used by clients of class 'type2'
// The specified base class was not declared with the __declspec(dllexport) keyword.
// A base class or structure must be declared with the __declspec(dllexport) keyword if a function in a derived class is to be exported.

// Since the program seems to work properly 
// Try and disable warning C4251
#pragma warning ( disable : 4251 )

#include "Billing_Info.h"

using std::cout;
using std::endl;
using std::flush;

Billing_Info::Billing_Info(const string & get_info_sql, const string & update_info_sql)
{
	DB_Table_Base::get_info_sql    = get_info_sql;
	DB_Table_Base::update_info_sql = update_info_sql;
	//										db_column_name		, db_column_data,   db_column_actual, web_form_name			, web_form_data, web_form_hidden_data, row_number	, vartype	, length
	DB_Table_Base::DB_Table_Info column1("user_name"			,	""			,		""			, "User Name"			,	""		   ,			""		,		1		, NTBSTRINGBIND	,	 USER_NAME);
	DB_Table_Base::DB_Table_Info column2("card_type"			,	""			,		""			, "Card Type"			,	""		   ,			""		,		2		, NTBSTRINGBIND	,	 CARD_TYPE);
	DB_Table_Base::DB_Table_Info column3("name_on_card"			,	""			,		""			, "Name on Card"		,	""		   ,			""		,		3		, NTBSTRINGBIND	,	 NAME_ON_CARD);
	DB_Table_Base::DB_Table_Info column4("account_number"		,	""			,		""			, "Account Number"		,	""		   ,			""		,		4		, NTBSTRINGBIND	,	 ACCOUNT_NUMBER);
	DB_Table_Base::DB_Table_Info column5("expiration_month"		,	""			,		""			, "Month"				,	""		   ,			""		,		5		, NTBSTRINGBIND	,	 EXPIRATION_MONTH);
	DB_Table_Base::DB_Table_Info column6("expiration_year"		,	""			,		""			, "Year"				,	""		   ,			""		,		6		, NTBSTRINGBIND	,	 EXPIRATION_YEAR);
	DB_Table_Base::DB_Table_Info column7("cvv2_code"			,	""			,		""			, "CVV2 Code"			,	""		   ,			""		,		7		, NTBSTRINGBIND	,	 CVV2_CODE);
	DB_Table_Base::DB_Table_Info column8("bank_ABA_code"		,	""			,		""			, "Bank ABA Code"		,	""		   ,			""		,		8		, NTBSTRINGBIND	,	 BANK_ABA_CODE);
	DB_Table_Base::DB_Table_Info column9("bank_account_number"	,	""			,		""			, "Bank Account Number"	,	""		   ,			""		,		9		, NTBSTRINGBIND	,	 BANK_ACCOUNT_NUMBER);
	
	Vect.push_back(column1);
	Vect.push_back(column2);
	Vect.push_back(column3);
	Vect.push_back(column4);
	Vect.push_back(column5);
	Vect.push_back(column6);
	Vect.push_back(column7);
	Vect.push_back(column8);
	Vect.push_back(column9);
}


void
Billing_Info::Print_Current_And_Change( const string & name )
{
	int column_number = Get_RowNumber_From_ColumnName( name );
	
	int index = column_number - 1;
	
	switch (column_number)
	{
	case 1 :
		Print_Current(Vect[index]);
		
		cout << "	<!--  user_name -->\n"
			
			<< "		<INPUT\n"
			<< "         type=\"hidden\"\n"
			<< "         name=\"db_user_name\"\n"
			<< "         value=\"" << Vect[index].db_column_actual << "\">\n"
			<< endl << flush;
		
		break;
		
	case 2 :
		Print_Current(Vect[index]);
		cout << "	<!--  card_type -->\n"
			
			<< "                        <TR>\n"
			<< "                            <TD height=\"30\" width=\"27%\">\n"
			<< "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Card Type :</FONT></STRONG>\n"
			<< "                            </TD>\n"
			<< "                            <TD height=\"30\" width=\"73%\">\n"
			<< "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> <SELECT name=\"card_type\">\n"
			<< "								<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">\n"
			<< "                                " << Vect[index].db_column_data << "\n"
			<< "								</OPTION>\n"			
			<< "                                <OPTION value=\"4\">\n"
			<< "                                  Visa\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION value=\"5\">\n"
			<< "                                  Master Card\n"
			<< "                                </OPTION>\n"
			<< "                              </SELECT></FONT>\n"
			<< "                            </TD>\n"
			<< "                          </TR>\n"
			<< endl << flush;
		break;
	case 3 :
		Print_Current(Vect[index]);
		
		cout << "	<!--  name_on_card -->\n"
			
			<< "                          <TR>\n"
			<< "                            <TD height=\"30\" width=\"27%\">\n"
			<< "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Cardholder's Name:</FONT></STRONG>\n"
			<< "                            </TD>\n"
			<< "                            <TD height=\"30\" valign=\"top\">\n"
			<< "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><INPUT type=\"text\" name=\"name_on_card\" value=\"" << Vect[index].db_column_data << "\" size=\"25\" maxlength=\"64\">as appears on card</FONT>\n"
			<< "                            </TD>\n"
			<< "                          </TR>\n"
			<< endl << flush;
		break;
	case 4 :
		Print_Current(Vect[index]);
		
		cout << "	<!--  account_number -->\n"
			
			<< "                          <TR>\n"
			<< "                            <TD height=\"30\" width=\"27%\">\n"
			<< "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Card Account Number:</FONT></STRONG>\n"
			<< "                            </TD>\n"
			<< "                            <TD height=\"30\" width=\"73%\">\n"
			<< "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> <INPUT type=\"text\" name=\"account_number\" value=\"" << Vect[index].db_column_data << "\" size=\"20\" maxlength=\"16\"></FONT>\n"
			<< "                            </TD>\n"
			<< "                          </TR>\n"
			<< endl << flush;
		break;
	case 5 :
		cout << "	<!--  expiration_month -->\n"
			
			<< "                          <TR>\n"
			<< "                            <TD height=\"30\" width=\"27%\">\n"
			<< "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Expiration Date :</FONT></STRONG>\n"
			<< "                            </TD>\n"
			<< "                            <TD height=\"30\" width=\"73%\">\n"
			<< "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> <SELECT name=\"expiration_month\">\n"
			<< "								<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">\n"
			<< "                                " << Vect[index].db_column_data << "\n"
			<< "								</OPTION>\n"			
			<< "                                <OPTION>\n"
			<< "                                  01\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  02\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  03\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  04\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  05\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  06\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  07\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  08\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  09\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  10\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  11\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  12\n"
			<< "                                </OPTION>\n"
			<< "                              </SELECT>\n"
			<< endl << flush;
		break;
	case 6 :
		cout << "<!--  expiration_year -->\n"
			
			<< "							  <SELECT name=\"expiration_year\">\n"
			<< "								<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">\n"
			<< "                                " << Vect[index].db_column_data << "\n"
			<< "								</OPTION>\n"			
			<< "                                <OPTION>\n"
			<< "                                  2001\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  2002\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  2003\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  2004\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  2005\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  2006\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  2007\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  2008\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  2009\n"
			<< "                                </OPTION>\n"
			<< "                                <OPTION>\n"
			<< "                                  2010\n"
			<< "                                </OPTION>\n"
			<< "                              </SELECT></FONT>\n"
			<< "                            </TD>\n"
			<< "                          </TR>\n"
			<< endl << flush;
		break;
	case 7 :
		Print_Current(Vect[index]);
		
		cout << "	<!--  cvv2_code -->\n"
			
			<< "                          <TR>\n"
			<< "                            <TD height=\"30\" width=\"27%\">\n"
			<< "                              <STRONG><A href=\"javascript:newWindowGeneric('../WhatIsCVV2.html')\" title=\"What is CVV2?\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Verification Value (CVV2):</A></FONT></STRONG>\n"
			<< "                            </TD>\n"
			<< "                            <TD height=\"30\" width=\"73%\">\n"
			<< "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> <INPUT type=\"text\" name=\"cvv2_code\" value=\"" << Vect[index].db_column_data << "\" size=\"4\" maxlength=\"4\"></FONT><A href=\"javascript:newWindowGeneric('../WhatIsCVV2.html')\" title=\"What is CVV2?\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"-1\"> Help...</A></FONT>\n"
			<< "                            </TD>\n"
			<< "                          <TR>\n"
			<< endl << flush;
		break;
	case 8 :
		cout << "	<!--  eCheck Processing Info -->\n" << endl;

		Print_Current(Vect[index]);
		
		cout << "	<!--  bank_ABA_code -->\n"
			<< "                          <TR>\n"
			<< "                            <TD height=\"30\" width=\"27%\">\n"
			<< "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Bank ABA Code:</FONT></STRONG>\n"
			<< "                            </TD>\n"
			<< "                            <TD height=\"30\" width=\"73%\">\n"
			<< "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> <INPUT type=\"text\" name=\"bank_ABA_code\" value=\"" << Vect[index].db_column_data << "\" size=\"20\" maxlength=\"16\"></FONT>\n"
			<< "                            </TD>\n"
			<< "                          </TR>\n"
			<< endl << flush;
		break;
	case 9 :
		Print_Current(Vect[index]);
		
		cout << "	<!--  bank_account_number -->\n"
			
			<< "                          <TR>\n"
			<< "                            <TD height=\"30\" width=\"27%\">\n"
			<< "                              <STRONG><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\">Bank Account Number:</FONT></STRONG>\n"
			<< "                            </TD>\n"
			<< "                            <TD height=\"30\" width=\"73%\">\n"
			<< "                              <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"> <INPUT type=\"text\" name=\"bank_account_number\" value=\"" << Vect[index].db_column_data << "\" size=\"20\" maxlength=\"16\"></FONT>\n"
			<< "                            </TD>\n"
			<< "                          </TR>\n"
			<< endl << flush;
		break;
	default:
		cout << "	<!--    Unknown Column Name  " << Vect[index].db_column_name << " -->" << endl << flush;
		
		break;
	}
}
