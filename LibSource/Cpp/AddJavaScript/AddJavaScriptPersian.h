#ifndef ADDJAVASCRIPTPERSIAN_H
#define ADDJAVASCRIPTPERSIAN_H


#include <vector>
#include <string>

#include <iostream>

#include "AddJavaScript.h"
#include "DB_Table_Base/DB_Table_Base.h"

using std::ostream;

class AddJavaScriptPersian : public AddJavaScript
{
	
public:
	AddJavaScriptPersian(const vector<DB_Table_Base::DB_Table_Info> & dbti_vect)
	{
		// login_info Table
		// user_id is a member but is not set by user
		FieldAndFlag user_name("user_name", false);
		FieldAndFlag membership_type("membership_type", false);
		FieldAndFlag password("password", false);
		FieldAndFlag password_hint("password_hint", false);
		FieldAndFlag email("email", false);
		FieldAndFlag sex("sex", false);
		// creation_date is a member but is not set by user
		// last_login is a member but is not set by user
		
		// contact_info Table
		// user_name already in login_info
		FieldAndFlag first_name("first_name", false);
		FieldAndFlag last_name("last_name", false);
		FieldAndFlag street_address("street_address", false);
		FieldAndFlag city("city", false);
		FieldAndFlag state("state", false);
		FieldAndFlag country("country", false);
		FieldAndFlag zip("zip", false);
		FieldAndFlag telephone("telephone", false);
		
		// personal_info Table
		// user_name already in login_info
		FieldAndFlag sex_preference("sex_preference", false);
		FieldAndFlag age("age", false);
		FieldAndFlag marital_status("marital_status", false);
		FieldAndFlag professioin("professioin", false);
		FieldAndFlag education("education", false);
		FieldAndFlag religion("religion", false);
		FieldAndFlag height("height", false);
		FieldAndFlag weight("weight", false);
		FieldAndFlag eyes("eyes", false);
		FieldAndFlag hair("hair", false);
		FieldAndFlag min_age_desired("min_age_desired", false);
		FieldAndFlag max_age_desired("max_age_desired", false);
		FieldAndFlag cook("cook", false);
		FieldAndFlag smoke("smoke", false);
		FieldAndFlag drink("drink", false);
		FieldAndFlag party("party", false);
		FieldAndFlag political("political", false);
		FieldAndFlag housing("housing", false);
		
		// relationship Table
		FieldAndFlag relationship("relationship", false);
		
		// about_info
		//bool user_name already in login_info 
		FieldAndFlag screen_quote("screen_quote", false);
		FieldAndFlag about_yourself("about_yourself", false);
		// questionable field is a member but is not set by user		
		
		// Cookies to be set
		FieldAndFlag user_name_cookie("user_name_cookie", false);
		FieldAndFlag password_cookie("password_cookie", false);
		
		// login_info Table
		// user_id is a member but is not set by user
		faf_vect.push_back( user_name );
		// membership_type is a member but is not set by user
		faf_vect.push_back( password );
		faf_vect.push_back( password_hint );
		faf_vect.push_back( email );
		faf_vect.push_back( sex );
		// creation_date is a member but is not set by user
		// last_login is a member but is not set by user
		
		// contact_info Table
		// user_name already in login_info
		faf_vect.push_back( first_name );
		faf_vect.push_back( last_name );
		faf_vect.push_back( street_address );
		faf_vect.push_back( city );
		faf_vect.push_back( state );
		faf_vect.push_back( country );
		faf_vect.push_back( zip );
		faf_vect.push_back( telephone );
		
		// personal_info Table
		// user_name already in login_info
		faf_vect.push_back( sex_preference );
		faf_vect.push_back( age );
		faf_vect.push_back( marital_status );
		faf_vect.push_back( professioin );
		faf_vect.push_back( education );
		faf_vect.push_back( religion );
		faf_vect.push_back( height );
		faf_vect.push_back( weight );
		faf_vect.push_back( eyes );
		faf_vect.push_back( hair );
		faf_vect.push_back( min_age_desired );
		faf_vect.push_back( max_age_desired );
		faf_vect.push_back( cook );
		faf_vect.push_back( smoke );
		faf_vect.push_back( drink );
		faf_vect.push_back( party );
		faf_vect.push_back( political );
		faf_vect.push_back( housing );
		
		// relationship Table
		faf_vect.push_back( relationship );
		
		// about_info
		//bool user_name already in login_info 
		faf_vect.push_back( screen_quote );
		faf_vect.push_back( about_yourself );
		// questionable field is a member but is not set by user		
		
		// Cookies to be set
		faf_vect.push_back( user_name_cookie );
		faf_vect.push_back( password_cookie );
		
		for(int i=0; i<faf_vect.size(); i++)
		{
			for(int j=0; j<dbti_vect.size(); j++)
				if(faf_vect[i].field == dbti_vect[j].db_column_name)
				{
					faf_vect[i].flag = true;
				}
		}
	}

public:

	vector<AddJavaScript::FieldAndFlag> faf_vect;

	void
		InsertJavaScript();

private:
	AddJavaScriptPersian(const AddJavaScriptPersian & Dont_Use);

	
};


void
AddJavaScriptPersian::InsertJavaScript()
{
	AddJavaScript::InsertJavaScript(faf_vect);
}






#endif ADDJAVASCRIPTPERSIAN_H