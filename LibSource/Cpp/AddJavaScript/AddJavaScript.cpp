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

#include "AddJavaScript.h"


using std::flush;

extern class LinkMap LM;

AddJavaScript::AddJavaScript(const vector<db_table_base_namespace::DB_Table_Base::DB_Table_Info> & DBTI_Vect)
{
	// login_info Table
	// user_id is a member but is not set by user
	FieldAndFlag user_name			("user_name"		, false);
	FieldAndFlag membership_type	("membership_type"	, false);
	FieldAndFlag password			("password"			, false);
	FieldAndFlag password_hint		("password_hint"	, false);
	FieldAndFlag email				("email"			, false);
	FieldAndFlag sex				("sex"				, false);
	// creation_date is a member but is not set by user
	// last_login is a member but is not set by user
	
	// contact_info Table
	// user_name already in login_info
	FieldAndFlag first_name			("first_name"		, false);
	FieldAndFlag last_name			("last_name"		, false);
	FieldAndFlag street_address		("street_address"	, false);
	FieldAndFlag city				("city"				, false);
	FieldAndFlag state				("state"			, false);
	FieldAndFlag country			("country"			, false);
	FieldAndFlag zip				("zip"				, false);
	FieldAndFlag telephone			("telephone"		, false);
	
	// personal_info Table
	// user_name already in login_info
	FieldAndFlag sex_preference		("sex_preference"	, false);
	FieldAndFlag age				("age"				, false);
	FieldAndFlag marital_status		("marital_status"	, false);
	FieldAndFlag profession			("profession"		, false);
	FieldAndFlag education			("education"		, false);
	FieldAndFlag income				("income"			, false);
	FieldAndFlag religion			("religion"			, false);
	FieldAndFlag height				("height"			, false);
	FieldAndFlag weight				("weight"			, false);
	FieldAndFlag eyes				("eyes"				, false);
	FieldAndFlag hair				("hair"				, false);
	FieldAndFlag min_age_desired	("min_age_desired"	, false);
	FieldAndFlag max_age_desired	("max_age_desired"	, false);
	FieldAndFlag cook				("cook"				, false);
	FieldAndFlag smoke				("smoke"			, false);
	FieldAndFlag drink				("drink"			, false);
	FieldAndFlag party				("party"			, false);
	FieldAndFlag political			("political"		, false);
	FieldAndFlag housing			("housing"			, false);
	
	// relationship Table
	FieldAndFlag relationship		("relationship"		, false);
	
	// about_info
	//bool user_name already in login_info 
	FieldAndFlag screen_quote		("screen_quote"		, false);
	FieldAndFlag about_yourself		("about_yourself"	, false);
	// questionable field is a member but is not set by user		
	
	// billing_ingo Table
	//			 user_name						is a member but is not set by user
//	FieldAndFlag card_type			("card_type"		, false);
//	FieldAndFlag name_on_card		("name_on_card"		, false);
//	FieldAndFlag account_number		("account_number"	, false);
//	FieldAndFlag expiration_month	("expiration_month"	, false);
//	FieldAndFlag expiration_year	("expiration_year"	, false);
	//			 is_member_active				is a member but is not set by user
	//			 date_membership_expires		is a member but is not set by user

	// Cookies to be set
	FieldAndFlag user_name_cookie	("user_name_cookie"	, false);
	FieldAndFlag password_cookie	("password_cookie"	, false);
	
	// login_info Table
	// user_id is a member but is not set by user
	faf_vect.push_back( user_name		);
	// membership_type is a member but is not set by user
	faf_vect.push_back( password		);
	faf_vect.push_back( password_hint	);
	faf_vect.push_back( email			);
	faf_vect.push_back( sex				);
	// creation_date is a member but is not set by user
	// last_login is a member but is not set by user
	
	// contact_info Table
	// user_name already in login_info
	faf_vect.push_back( first_name		);
	faf_vect.push_back( last_name		);
	faf_vect.push_back( street_address	);
	faf_vect.push_back( city			);
	faf_vect.push_back( state			);
	faf_vect.push_back( country			);
	faf_vect.push_back( zip				);
	faf_vect.push_back( telephone		);
	
	// personal_info Table
	// user_name already in login_info
	faf_vect.push_back( sex_preference	);
	faf_vect.push_back( age				);
	faf_vect.push_back( marital_status	);
	faf_vect.push_back( profession		);
	faf_vect.push_back( income			);
	faf_vect.push_back( education		);
	faf_vect.push_back( religion		);
	faf_vect.push_back( height			);
	faf_vect.push_back( weight			);
	faf_vect.push_back( eyes			);
	faf_vect.push_back( hair			);
	faf_vect.push_back( min_age_desired	);
	faf_vect.push_back( max_age_desired );
	faf_vect.push_back( cook			);
	faf_vect.push_back( smoke			);
	faf_vect.push_back( drink			);
	faf_vect.push_back( party			);
	faf_vect.push_back( political		);
	faf_vect.push_back( housing			);
	
	// relationship Table
	faf_vect.push_back( relationship	);
	
	// about_info
	// user_name already in login_info 
	faf_vect.push_back( screen_quote	);
	faf_vect.push_back( about_yourself	);
	// questionable field is a member but is not set by user		
	
	// billing_ingo Table
	//			 user_name						is a member but is not set by user
//	faf_vect.push_back( card_type		);
//	faf_vect.push_back( name_on_card	);
//	faf_vect.push_back( account_number	);
//	faf_vect.push_back( expiration_month);
//	faf_vect.push_back( expiration_year );
	//			 is_member_active				is a member but is not set by user
	//			 date_membership_expires		is a member but is not set by user

	// Cookies to be set
	faf_vect.push_back( user_name_cookie);
	faf_vect.push_back( password_cookie	);
	
	for(unsigned int i=0; i<faf_vect.size(); i++)
	{
		for(unsigned int j=0; j<DBTI_Vect.size(); j++)
			if(faf_vect[i].field == DBTI_Vect[j].db_column_name)
			{
				faf_vect[i].flag = true;
			}
	}
}

ostream &
operator<< (ostream & out, const vector<AddJavaScript::FieldAndFlag> & FAF_Vector)
{
	for(unsigned int i=0; i<FAF_Vector.size(); i++)
		if(FAF_Vector[i].flag == true)
			out << FAF_Vector[i].field << endl << flush;
		
		return out;
}

void 
AddJavaScript::ToggleFlag(const string & Field)
{
	for(unsigned int i=0; i<faf_vect.size(); i++)
	{
		if(faf_vect[i].field == Field)
		{
			faf_vect[i].flag = !faf_vect[i].flag;
		}
	}
}


void
AddJavaScript::InsertJavaScript()
{

	static int NumberOfExecutions = 0;
	bool Email = false;
	bool ContainsNumeric = false;
	bool SpecialCharacters = false;
	
	unsigned int i = 0;
	if(NumberOfExecutions == 0)
	{
		// start JavaScript
		cout << "<SCRIPT type=\"text/javascript\" language=\"javascript\">\n"
			<< "<!--\n"
			<< "\n"
			<< "function checkForm(theForm)\n"
			<< "{" << endl << flush;
		
		for(i=0; i<faf_vect.size(); i++)
		{
			// -------------- Mostly login_info scripts ------------------------
			if( (faf_vect[i].field == "user_name") && (faf_vect[i].flag == true) )
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				
				cout << "  if (!validName(theForm.user_name.value))\n"
					<< "  {\n"
					<< "    alert(\"Please enter a valid value for the \\\"User Name\\\" field.\\nThe following are invalid( ~`!@#$%^&*()-+={[}]|\\\"',<.>?/:;\\)\")\n"
					<< "    theForm.user_name.focus()\n"
					<< "    return (false)\n"
					<< "  }\n"
					<< endl << flush;
				SpecialCharacters = true;
			}
			else if( (faf_vect[i].field == "age") && (faf_vect[i].flag == true)	)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
			}
			else if( (faf_vect[i].field == "min_age_desired") && (faf_vect[i].flag == true)	)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				
				cout << "MinInt = parseInt(theForm.min_age_desired.value)\n"
					<< "MaxInt = parseInt(theForm.max_age_desired.value)\n"
					<< "\n"
					<< "  if(MaxInt < MinInt)\n"
					<< "  {\n"
					<< "    alert(\"Max age can not be less than Min Age.\");\n"
					<< "    theForm.max_age_desired.focus();\n"
					<< "    return (false);\n"
					<< "  }\n"
					
					<< endl << flush;
			}
			else if(faf_vect[i].field == "password" && faf_vect[i].flag == true)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				
				cout << "\n"
					<< "  if (!validName(theForm.password.value))\n"
					<< "  {\n"
					<< "    alert(\"Please enter a valid value for the \\\"Password\\\" field.\\nThe following are invalid( ~`!@#$%^&*()-+={[}]|\\\"',<.>?/:;\\)\")\n"
					<< "    theForm.password.focus()\n"
					<< "    return (false)\n"
					<< "  }\n"
					
					<< "\n"
					<< "  if (theForm.password.value.length < 4)\n"
					<< "  {\n"
					<< "    alert(\"Please enter at least 4 characters in the \\\"Password\\\" field.\")\n"
					<< "    theForm.password.focus()\n"
					<< "    theForm.password.select()\n"
					<< "    return (false)\n"
					<< "  }\n"
					
					<< "\n"
					<< "  if (theForm.password.value.length > 8)\n"
					<< "  {\n"
					<< "    alert(\"Please enter at most 8 characters in the \\\"Password\\\" field.\")\n"
					<< "    theForm.password.focus()\n"
					<< "    theForm.password.select()\n"
					<< "    return (false)\n"
					<< "  }\n"
					<< endl << flush;
				SpecialCharacters = true;
			}
			else if(faf_vect[i].field == "password_hint" && faf_vect[i].flag == true)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				
				cout << "\n"
					<< "  if (theForm.verify_password.value == \"\")\n"
					<< "  {\n"
					<< "    alert(\"Please enter a value for the \\\"Password Verification\\\" field.\")\n"
					<< "    theForm.verify_password.focus()\n"
					<< "    return (false)\n"
					<< "  }\n"
					
					<< "\n"
					<< "  if (theForm.verify_password.value.length < 4)\n"
					<< "  {\n"
					<< "    alert(\"Please enter at least 4 characters in the \\\"Password Verification\\\" field.\");\n"
					<< "    theForm.verify_password.focus()\n"
					<< "    theForm.verify_password.select()\n"
					<< "    return (false)\n"
					<< "  }\n"
					
					<< "\n"
					<< "  if (theForm.verify_password.value.length > 8)\n"
					<< "  {\n"
					<< "    alert(\"Please enter at most 8 characters in the \\\"Password Verification\\\" field.\")\n"
					<< "    theForm.verify_password.focus()\n"
					<< "    theForm.verify_password.select()\n"
					<< "    return (false)\n"
					<< "  }\n"
					
					<< "\n"
					<< "  if (theForm.password.value != theForm.verify_password.value)\n"
					<< "  {\n"
					<< "    alert(\"Password fields do not match\")\n"
					<< "    theForm.password.focus()\n"
					<< "    theForm.password.select()\n"
					<< "    return (false)\n"
					<< "  }\n"
					
					<< "\n"
					<< "  if (theForm.password_hint.value == \"\")\n"
					<< "  {\n"
					<< "    alert(\"Please enter a value for the \\\"Mother's Maiden Name\\\" field.\")\n"
					<< "    theForm.password_hint.focus()\n"
					<< "    return (false)\n"
					<< "  }" << endl << flush;
			}
			
			else if(faf_vect[i].field == "sex" && faf_vect[i].flag == true)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				
				cout << "  if (theForm.sex.selectedIndex < 0)\n"
					<< "  {\n"
					<< "    alert(\"Please select one of the \\\"Sex\\\" options.\")\n"
					<< "    theForm.sex.focus()\n"
					<< "    theForm.sex.select()\n"
					<< "    return (false)\n"
					<< "  }\n"
					
					<< "" << endl << flush;
			}
			
			else if(faf_vect[i].field == "email" && faf_vect[i].flag == true)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				
				cout << "\n"
					<< "  if (theForm.email.value == \"\")\n"
					<< "  {\n"
					<< "    alert(\"Please enter a value for the \\\"Email Address\\\" field.\")\n"
					<< "    theForm.email.focus()\n"
					<< "    return (false)\n"
					<< "  }\n"
					
					
					<< "  if (!validEmail(theForm.email.value))\n"
					<< "  {\n"
					<< "    alert(\"Please enter a valid \\\"email\\\" address.\");\n"
					<< "    theForm.email.focus();\n"
					<< "    theForm.email.select();\n"
					<< "    return (false);\n"
					<< "  }" << endl << flush;
				
				Email = true;
			}
			
			else if(faf_vect[i].field == "first_name" && faf_vect[i].flag == true)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				cout << "\n"
					<< "  if (theForm.first_name.value == \"\")\n"
					<< "  {\n"
					<< "    alert(\"Please enter a value for the \\\"First Name\\\" field.\");\n"
					<< "    theForm.first_name.focus();\n"
					<< "    return (false);\n"
					<< "  }\n"
					<< "" << endl << flush;
			}
			
			else if(faf_vect[i].field == "city" && faf_vect[i].flag == true)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				
				cout << "  if (theForm.city.value == \"\")\n"
					<< "  {\n"
					<< "    alert(\"Please enter a value for the \\\"City\\\" field.\");\n"
					<< "    theForm.city.focus();\n"
					<< "    return (false);\n"
					<< "  }\n"
					<< "" << endl << flush;
			}
			
			else if(faf_vect[i].field == "state" && faf_vect[i].flag == true)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				
				cout << "  if (theForm.state.selectedIndex < 0)\n"
					<< "  {\n"
					<< "    alert(\"Please select one of the \\\"State\\\" options.\");\n"
					<< "    theForm.state.focus();\n"
					<< "    return (false);\n"
					<< "  }\n"
					<< "\n"
					<< "" << endl << flush;
			}
			
			else if(faf_vect[i].field == "country" && faf_vect[i].flag == true)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				
				cout << "  if (theForm.country.selectedIndex < 0)\n"
					<< "  {\n"
					<< "    alert(\"Please select one of the \\\"Country\\\" options.\");\n"
					<< "    theForm.country.focus();\n"
					<< "    return (false);\n"
					<< "  }\n"
					<< "\n"
					<< "" << endl << flush;
			}
			
			else if(faf_vect[i].field == "zip" && faf_vect[i].flag == true)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				
				cout << "  if (theForm.zip.value == \"\")\n"
					<< "  {\n"
					<< "    alert(\"Please enter a value for the \\\"Postal Code\\\" field.\");\n"
					<< "    theForm.zip.focus();\n"
					<< "    return (false);\n"
					<< "  }\n"
					<< ""
					
					<< "if (!isNum(theForm.zip.value))\n"
					<< "  {\n"
					<< "    alert(\"Please enter numbers only in the \\\"Postal Code\\\" field.\");\n"
					<< "    theForm.zip.focus();\n"
					<< "    theForm.zip.select();\n"
					<< "    return (false);\n"
					<< "  }\n"
					<< "\n"
					
					<< "if(theForm.zip.value.length > 5)\n"
					<< "  {\n"
					<< "    alert(\"\\\"Postal Code\\\" field currently only supports 5 digits.\");\n"
					<< "    theForm.zip.focus();\n"
					<< "    theForm.zip.select();\n"
					<< "    return (false);\n"
					<< "  }\n"
					<< "\n"
					<< "" << endl << flush;
				
				ContainsNumeric = true;
			}			
			else if(faf_vect[i].field == "screen_quote" && faf_vect[i].flag == true)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				
				cout << "  if (theForm.screen_quote.value == \"\")\n"
					<< "  {\n"
					<< "    alert(\"Please enter a value for the \\\"Screen Quote\\\" field.\");\n"
					<< "    theForm.screen_quote.focus();\n"
					<< "    return (false);\n"
					<< "  }\n"
					<< "" << endl << flush;
			}			
			else if(faf_vect[i].field == "about_yourself" && faf_vect[i].flag == true)
			{
				cout << "// ----- " <<  faf_vect[i].field << endl;
				
				cout << "  if (theForm.about_yourself.value == \"\")\n"
					<< "  {\n"
					<< "    alert(\"Please enter a value for the \\\"About Yourself\\\" field.\");\n"
					<< "    theForm.about_yourself.focus();\n"
					<< "    return (false);\n"
					<< "  }\n"
					<< "" << endl << flush;
			}			
			else if(i == (faf_vect.size()-1) )
			{
				cout << "  return (true)\n"
					<< "}\n"
					<< "" << endl << flush;	
			}
			
			if(i == (faf_vect.size()-1) && Email)
			{
				cout << "function validEmail(email)\n"
					<< "{\n"
					<< "invalidChars = \" /:,;\"\n"
					<< "\n"
					<< "    // email cannot be empty...\n"
					<< "    if(email == \"\")\n"
					<< "    {\n"
					<< "        return false\n"
					<< "    }\n"
					
					<< "\n"
					<< "    // does it contain any invalid characters...\n"
					<< "    for (i=0; i<invalidChars.length; i++)\n"
					<< "    {\n"
					<< "        badChar = invalidChars.charAt(i)\n"
					<< "        if (email.indexOf(badChar, 0) > -1)\n"
					<< "        {\n"
					<< "            return false\n"
					<< "        }\n"
					<< "    }\n"
					
					<< "\n"
					<< "    // there must be one \"@\" symbol...\n"
					<< "    atPos = email.indexOf(\"@\",1)\n"
					<< "    if (atPos == -1)\n"
					<< "    {\n"
					<< "        return false\n"
					<< "    }\n"
					
					<< "\n"
					<< "    // and only one \"@\" symbol...\n"
					<< "    if (email.indexOf(\"@\", atPos+1) != -1)\n"
					<< "    {\n"
					<< "        return false\n"
					<< "    }\n"
					
					<< "\n"
					<< "    // and at least one \".\" after the \"@\"...\n"
					<< "    periodPos = email.indexOf(\".\", atPos)\n"
					<< "    if (periodPos == -1)\n"
					<< "    {\n"
					<< "        return false\n"
					<< "    }\n"
					
					<< "\n"
					<< "    // must be at least 2 characters after the \".\"...\n"
					<< "    if (periodPos+3 > email.length)\n"
					<< "    {\n"
					<< "        return false\n"
					<< "    }\n"
					<< "return true\n"
					<< "}\n"
					<< "" << endl << flush;
				Email = false;
			}
	}
	if(ContainsNumeric)
	{
		cout  << "function isNum (passedVal)\n"
			<< "{\n"
			<< "  for(i=0; i<passedVal.length; i++)\n"
			<< "  {\n"
			<< "    if(passedVal.charAt(i) < \"0\")\n"
			<< "    {\n"
			<< "    return false\n"
			<< "    }\n"
			<< "    if(passedVal.charAt(i) > \"9\")\n"
			<< "    {\n"
			<< "    return false\n"
			<< "    }\n"
			<< "  }\n"
			<< "return true\n"
			<< "}\n"
			<< endl << flush;
	}
	// Used with user_name and password fields
	if(SpecialCharacters)
	{
		cout  << "function validName(myName)\n"
			<< "{\n"
			<< "var invalidChars = \" ~`!@#$%^&*()-+={[}]|\\\"',<.>?/:;\\\\\"\n"
			<< "\n"
			<< "    // field cannot be empty...\n"
			<< "    if(myName == \"\")\n"
			<< "    {\n"
			<< "        return false\n"
			<< "    }\n"
			<< "\n"
			<< "    // does it contain any invalid characters...\n"
			<< "    for (i=0; i<invalidChars.length; i++)\n"
			<< "    {\n"
			<< "        badChar = invalidChars.charAt(i)\n"
			<< "        if (myName.indexOf(badChar, 0) > -1)\n"
			<< "        {\n"
			<< "            return false\n"
			<< "        }\n"
			<< "    }\n"
			<< "return true\n"
			<< "}\n"
			<< endl << flush;	
	}
	// Back Button Functionality...
	cout << "function back()\n"
		<< "{\n"
		<< "	window.history.back()\n"
		<< "}\n"
		
		<< "\n"
		<< "// -->\n"
		<< "</SCRIPT>\n"
		<< "" << endl << flush;
	
	}
	NumberOfExecutions++;
	//cout << "InsertJavaScript has been called " << NumberOfExecutions << " times." << endl << flush;
}

void
AddJavaScript::InsertJavaScriptFile(const string & Path, const string & File)
{
	// Add JavaScript File
	cout << "<SCRIPT language=\"javascript\" src=\"" << Path << "/" << File << "\"></SCRIPT>\n"
		<< endl << flush;
}




