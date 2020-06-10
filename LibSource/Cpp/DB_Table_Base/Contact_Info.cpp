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

#include "Contact_Info.h"

using std::cout;
using std::endl;
using std::flush;

Contact_Info::Contact_Info(const string & get_info_sql, const string & update_info_sql)
{
	DB_Table_Base::get_info_sql    = get_info_sql;
	DB_Table_Base::update_info_sql = update_info_sql;
	//										db_column_name	, db_column_data,   db_column_actual, web_form_name		, web_form_data, web_form_hidden_data, row_number	, vartype	, length
	DB_Table_Base::DB_Table_Info column1("user_name"		,	""			,		""			, "User Name"		,	""		   ,			""		,		1		, NTBSTRINGBIND	,	 USER_NAME);
	DB_Table_Base::DB_Table_Info column2("first_name"		,	""			,		""			, "First Name"		,	""		   ,			""		,		2		, NTBSTRINGBIND	,	 FIRST_NAME);
	DB_Table_Base::DB_Table_Info column3("last_name"		,	""			,		""			, "Last Name"		,	""		   ,			""		,		3		, NTBSTRINGBIND	,	 LAST_NAME);
	DB_Table_Base::DB_Table_Info column4("street_address"	,	""			,		""			, "Street Address"	,	""		   ,			""		,		4		, NTBSTRINGBIND	,	 STREET_ADDRESS);
	DB_Table_Base::DB_Table_Info column5("city"				,	""			,		""			, "City"			,	""		   ,			""		,		5		, NTBSTRINGBIND	,	 CITY);
	DB_Table_Base::DB_Table_Info column6("state"			,	""			,		""			, "State"			,	""		   ,			""		,		6		, NTBSTRINGBIND	,	 STATE);
	DB_Table_Base::DB_Table_Info column7("country"			,	""			,		""			, "Country"			,	""		   ,			""		,		7		, NTBSTRINGBIND	,	 COUNTRY);
	DB_Table_Base::DB_Table_Info column8("zip"				,	""			,		""			, "Zip/Postal Code"	,	""		   ,			""		,		8		, NTBSTRINGBIND	,	 ZIP);
	DB_Table_Base::DB_Table_Info column9("telephone"		,	""			,		""			, "Telephone #"		,	""		   ,			""		,		9		, NTBSTRINGBIND	,	 TELEPHONE);
	
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
Contact_Info::Print_Current_And_Change( const string & name )
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
		cout << "	<!--  first_name -->\n"
			
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"113\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"right\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\">\n"
			<< "              <FONT\n"
			<< "                face=\"Arial, Helvetica, sans-serif\" size=\"2\">&#160;&#160;&#160;&#160; <FONT color=\"Red\"><STRONG>*</STRONG></FONT>First name:</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"329\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"left\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\">\n"
			<< "		<INPUT\n"
			<< "               type=\"text\"\n"
			<< "               name=\"first_name\"\n"
			<< "               value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"20\">"
			<< "				<FONT\n"
			<< "               color=\"#FF0000\"\n"
			<< "               size=\"2\">Will not appear in profile</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "        </TR>" 
			<< endl << flush;
		break;
	case 3 :
		Print_Current(Vect[index]);
		
		cout << "	<!--  last_name -->\n"
			
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"113\"\n"
			<< "           height=\"21\"\n"
			<< "           align=\"right\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\">\n"
			<< "              <FONT\n"
			<< "               face=\"Arial, Helvetica, sans-serif\" size=\"2\">&#160;&#160;&#160;&#160;&#160;&#160; Last name:</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"329\"\n"
			<< "           height=\"21\"\n"
			<< "           align=\"left\">\n"
			<< "            <P\n"
			<< "             style=\"line-height: 100%\">\n"
			<< "               <INPUT\n"
			<< "               type=\"text\"\n"
			<< "               name=\"last_name\"\n"
			<< "               value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"20\">"
			<< "				<FONT\n"
			<< "               color=\"#FF0000\"\n"
			<< "               size=\"2\">Will not appear in profile</FONT>\n"
			<< "            </P>\n"
			<< "          </TD>\n"
			<< "        </TR>" << endl << flush;
		break;
	case 4 :
		Print_Current(Vect[index]);
		
		cout << "	<!--  street_address -->\n"
			
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"113\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             face=\"Arial, Helvetica, sans-serif\" size=\"2\">Street Address</FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"329\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"left\">\n"
			<< "            <INPUT\n"
			<< "             type=\"text\"\n"
			<< "             name=\"street_address\"\n"
			<< "               value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"20\">"
			<< "				<FONT\n"
			<< "             color=\"#FF0000\"\n"
			<< "             size=\"2\">Will not appear in profile</FONT>\n"
			<< "          </TD>\n"
			<< "        </TR>" << endl << flush;
		break;
	case 5 :
		Print_Current(Vect[index]);
		cout << "	<!--  city -->\n"
			
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"113\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             face=\"Arial, Helvetica, sans-serif\" size=\"2\"><FONT color=\"Red\"><STRONG>*</STRONG></FONT>City</FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"329\"\n"
			<< "           height=\"25\"\n"
			<< "           align=\"left\">\n"
			<< "		<INPUT\n"
			<< "             type=\"text\"\n"
			<< "             name=\"city\"\n"
			<< "             value=\"" << Vect[index].db_column_data << "\"\n"
			<< "             size=\"20\">\n"
			<< "          </TD>\n"
			<< "        </TR>" << endl << flush;
		break;
	case 6 :
		Print_Current(Vect[index]);
		cout << "<!--  state -->\n"
			
			<< "<TR>\n"
			<< "<TD width=\"113\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><FONT color=\"Red\"><STRONG>*</STRONG></FONT>State&nbsp;</FONT></TD>\n"
			<< "<TD width=\"329\" height=\"22\" align=\"left\"><SELECT name=\"state\" size=\"1\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "<OPTION value=\"1\">Alabama</OPTION>\n"
			<< "<OPTION value=\"2\">Alaska</OPTION>\n"
			<< "<OPTION value=\"3\">Arizona</OPTION>\n"
			<< "<OPTION value=\"4\">Arkansas</OPTION>\n"
			<< "<OPTION value=\"5\">California</OPTION>\n"
			<< "<OPTION value=\"9\">Colorado</OPTION>\n"
			<< "<OPTION value=\"10\">Connecticut</OPTION>\n"
			<< "<OPTION value=\"11\">Delaware</OPTION>\n"
			<< "<OPTION value=\"13\">Florida</OPTION>\n"
			<< "<OPTION value=\"14\">Georgia</OPTION>\n"
			<< "<OPTION value=\"16\">Hawaii</OPTION>\n"
			<< "<OPTION value=\"17\">Idaho</OPTION>\n"
			<< "<OPTION value=\"18\">Illinois</OPTION>\n"
			<< "<OPTION value=\"19\">Indiana</OPTION>\n"
			<< "<OPTION value=\"20\">Iowa</OPTION>\n"
			<< "<OPTION value=\"21\">Kansas</OPTION>\n"
			<< "<OPTION value=\"22\">Kentucky</OPTION>\n"
			<< "<OPTION value=\"23\">Louisiana</OPTION>\n"
			<< "<OPTION value=\"24\">Maine</OPTION>\n"
			<< "<OPTION value=\"25\">Maryland</OPTION>\n"
			<< "<OPTION value=\"26\">Massachusetts</OPTION>\n"
			<< "<OPTION value=\"27\">Michigan</OPTION>\n"
			<< "<OPTION value=\"28\">Minnesota</OPTION>\n"
			<< "<OPTION value=\"29\">Mississippi</OPTION>\n"
			<< "<OPTION value=\"30\">Missouri</OPTION>\n"
			<< "<OPTION value=\"31\">Montana</OPTION>\n"
			<< "<OPTION value=\"32\">Nebraska</OPTION>\n"
			<< "<OPTION value=\"33\">Nevada</OPTION>\n"
			<< "<OPTION value=\"34\">New Hampshire</OPTION>\n"
			<< "<OPTION value=\"35\">New Jersey</OPTION>\n"
			<< "<OPTION value=\"36\">New Mexico</OPTION>\n"
			<< "<OPTION value=\"37\">New York</OPTION>\n"
			<< "<OPTION value=\"39\">North Carolina</OPTION>\n"
			<< "<OPTION value=\"40\">North Dakota</OPTION>\n"
			<< "<OPTION value=\"41\">Ohio</OPTION>\n"
			<< "<OPTION value=\"42\">Oklahoma</OPTION>\n"
			<< "<OPTION value=\"43\">Oregon</OPTION>\n"
			<< "<OPTION value=\"44\">Pennsylvania</OPTION>\n"
			<< "<OPTION value=\"45\">Puerto Rico</OPTION>\n"
			<< "<OPTION value=\"46\">Rhode Island</OPTION>\n"
			<< "<OPTION value=\"47\">South Carolina</OPTION>\n"
			<< "<OPTION value=\"48\">South Dakota</OPTION>\n"
			<< "<OPTION value=\"49\">Tennessee</OPTION>\n"
			<< "<OPTION value=\"50\">Texas</OPTION>\n"
			<< "<OPTION value=\"54\">Utah</OPTION>\n"
			<< "<OPTION value=\"55\">Vermont</OPTION>\n"
			<< "<OPTION value=\"56\">Virginia</OPTION>\n"
			<< "<OPTION value=\"57\">Washington</OPTION>\n"
			<< "<OPTION value=\"12\">Washington, D.C.</OPTION>\n"
			<< "<OPTION value=\"58\">West Virginia</OPTION>\n"
			<< "<OPTION value=\"59\">Wisconsin</OPTION>\n"
			<< "<OPTION value=\"60\">Wyoming</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
		break;
	case 7 :
		Print_Current(Vect[index]);
		cout << "<!--  country -->\n"
			
			<< "<TR>\n"
			<< "<TD width=\"113\" height=\"22\" align=\"right\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\"><FONT color=\"Red\"><STRONG>*</STRONG></FONT>Country</FONT></TD>\n"
			<< "<TD width=\"329\" height=\"22\" align=\"left\"><SELECT name=\"country\" size=\"1\">\n"
			<< "<OPTION SELECTED value=\"" << Vect[index].db_column_actual << "\">" << Vect[index].db_column_data << "</OPTION>\n"			
			<< "<OPTION value=\"0\">Prefer not to say</OPTION>\n"
			<< "                    <OPTION value=\"1\">Afghanistan</OPTION>\n"
			<< "                    <OPTION value=\"2\">Albania</OPTION>\n"
			<< "                    <OPTION value=\"3\">Algeria</OPTION>\n"
			<< "                    <OPTION value=\"4\">American Samoa</OPTION>\n"
			<< "                    <OPTION value=\"5\">Andorra</OPTION>\n"
			<< "                    <OPTION value=\"6\">Angola</OPTION>\n"
			<< "                    <OPTION value=\"7\">Anguilla</OPTION>\n"
			<< "                    <OPTION value=\"8\">Antarctica</OPTION>\n"
			<< "                    <OPTION value=\"9\">Antigua/Barbuda</OPTION>\n"
			<< "                    <OPTION value=\"10\">Argentina</OPTION>\n"
			<< "                    <OPTION value=\"11\">Armenia</OPTION>\n"
			<< "                    <OPTION value=\"12\">Aruba</OPTION>\n"
			<< "                    <OPTION value=\"13\">Australia</OPTION>\n"
			<< "                    <OPTION value=\"14\">Austria</OPTION>\n"
			<< "                    <OPTION value=\"15\">Azerbaijan</OPTION>\n"
			<< "                    <OPTION value=\"16\">Bahamas</OPTION>\n"
			<< "                    <OPTION value=\"17\">Bahrain</OPTION>\n"
			<< "                    <OPTION value=\"18\">Bangladesh</OPTION>\n"
			<< "                    <OPTION value=\"19\">Barbados</OPTION>\n"
			<< "                    <OPTION value=\"20\">Belarus</OPTION>\n"
			<< "                    <OPTION value=\"21\">Belgium</OPTION>\n"
			<< "                    <OPTION value=\"22\">Belize</OPTION>\n"
			<< "                    <OPTION value=\"23\">Benin</OPTION>\n"
			<< "                    <OPTION value=\"24\">Bermuda</OPTION>\n"
			<< "                    <OPTION value=\"25\">Bhutan</OPTION>\n"
			<< "                    <OPTION value=\"26\">Bolivia</OPTION>\n"
			<< "                    <OPTION value=\"27\">Bosnia-Herzegovina</OPTION>\n"
			<< "                    <OPTION value=\"28\">Botswana</OPTION>\n"
			<< "                    <OPTION value=\"29\">Bouvet Island</OPTION>\n"
			<< "                    <OPTION value=\"30\">Brazil</OPTION>\n"
			<< "                    <OPTION value=\"31\">British Indian Ocean T.</OPTION>\n"
			<< "                    <OPTION value=\"32\">Brunei Darussalam</OPTION>\n"
			<< "                    <OPTION value=\"33\">Bulgaria</OPTION>\n"
			<< "                    <OPTION value=\"34\">Burkina Faso</OPTION>\n"
			<< "                    <OPTION value=\"35\">Burundi</OPTION>\n"
			<< "                    <OPTION value=\"36\">Cambodia</OPTION>\n"
			<< "                    <OPTION value=\"37\">Cameroon</OPTION>\n"
			<< "                    <OPTION value=\"38\">Canada</OPTION>\n"
			<< "                    <OPTION value=\"39\">Cape Verde</OPTION>\n"
			<< "                    <OPTION value=\"40\">Cayman Islands</OPTION>\n"
			<< "                    <OPTION value=\"41\">Central African, Rep.</OPTION>\n"
			<< "                    <OPTION value=\"42\">Chad</OPTION>\n"
			<< "                    <OPTION value=\"43\">Chile</OPTION>\n"
			<< "                    <OPTION value=\"44\">China</OPTION>\n"
			<< "                    <OPTION value=\"45\">Christmas Island</OPTION>\n"
			<< "                    <OPTION value=\"46\">Cocoa (Keeling) Islands</OPTION>\n"
			<< "                    <OPTION value=\"47\">Colombia</OPTION>\n"
			<< "                    <OPTION value=\"48\">Comoros</OPTION>\n"
			<< "                    <OPTION value=\"49\">Congo</OPTION>\n"
			<< "                    <OPTION value=\"50\">Cook Islands</OPTION>\n"
			<< "                    <OPTION value=\"51\">Costa Rica</OPTION>\n"
			<< "                    <OPTION value=\"52\">Cote Divoire</OPTION>\n"
			<< "                    <OPTION value=\"53\">Croatia</OPTION>\n"
			<< "                    <OPTION value=\"54\">Cuba</OPTION>\n"
			<< "                    <OPTION value=\"55\">Cyprus</OPTION>\n"
			<< "                    <OPTION value=\"56\">Czech Republic</OPTION>\n"
			<< "                    <OPTION value=\"57\">Denmark</OPTION>\n"
			<< "                    <OPTION value=\"58\">Djibouti</OPTION>\n"
			<< "                    <OPTION value=\"59\">Dominica</OPTION>\n"
			<< "                    <OPTION value=\"60\">Dominican Republic</OPTION>\n"
			<< "                    <OPTION value=\"61\">East Timor</OPTION>\n"
			<< "                    <OPTION value=\"62\">Ecuador</OPTION>\n"
			<< "                    <OPTION value=\"63\">Egypt</OPTION>\n"
			<< "                    <OPTION value=\"64\">El Salvador</OPTION>\n"
			<< "                    <OPTION value=\"65\">Equatorial Guinea</OPTION>\n"
			<< "                    <OPTION value=\"66\">Eritrea</OPTION>\n"
			<< "                    <OPTION value=\"67\">Estonia</OPTION>\n"
			<< "                    <OPTION value=\"68\">Ethiopia</OPTION>\n"
			<< "                    <OPTION value=\"69\">Falkland Islands-Malvinas</OPTION>\n"
			<< "                    <OPTION value=\"70\">Faroe Islands</OPTION>\n"
			<< "                    <OPTION value=\"71\">Fiji</OPTION>\n"
			<< "                    <OPTION value=\"72\">Finland</OPTION>\n"
			<< "                    <OPTION value=\"73\">France</OPTION>\n"
			<< "                    <OPTION value=\"74\">French Guiana</OPTION>\n"
			<< "                    <OPTION value=\"75\">French Polynesia</OPTION>\n"
			<< "                    <OPTION value=\"76\">French Southern Ter.</OPTION>\n"
			<< "                    <OPTION value=\"77\">Gabon</OPTION>\n"
			<< "                    <OPTION value=\"78\">Gambia</OPTION>\n"
			<< "                    <OPTION value=\"79\">Georgia</OPTION>\n"
			<< "                    <OPTION value=\"80\">Germany</OPTION>\n"
			<< "                    <OPTION value=\"81\">Ghana</OPTION>\n"
			<< "                    <OPTION value=\"82\">Gibraltar</OPTION>\n"
			<< "                    <OPTION value=\"83\">Great Britain</OPTION>\n"
			<< "                    <OPTION value=\"84\">Greece</OPTION>\n"
			<< "                    <OPTION value=\"85\">Greenland</OPTION>\n"
			<< "                    <OPTION value=\"86\">Grenada</OPTION>\n"
			<< "                    <OPTION value=\"87\">Guadeloupe</OPTION>\n"
			<< "                    <OPTION value=\"88\">Guam</OPTION>\n"
			<< "                    <OPTION value=\"89\">Guatemala</OPTION>\n"
			<< "                    <OPTION value=\"90\">Guinea</OPTION>\n"
			<< "                    <OPTION value=\"91\">Guinea-Bissau</OPTION>\n"
			<< "                    <OPTION value=\"92\">Guyana</OPTION>\n"
			<< "                    <OPTION value=\"93\">Haiti</OPTION>\n"
			<< "                    <OPTION value=\"94\">Heard/Mc Donald Islands</OPTION>\n"
			<< "                    <OPTION value=\"95\">Honduras</OPTION>\n"
			<< "                    <OPTION value=\"96\">Hong Kong</OPTION>\n"
			<< "                    <OPTION value=\"97\">Hungary</OPTION>\n"
			<< "                    <OPTION value=\"98\">Iceland</OPTION>\n"
			<< "                    <OPTION value=\"99\">India</OPTION>\n"
			<< "                    <OPTION value=\"100\">Indonesia</OPTION>\n"
			<< "                    <OPTION value=\"101\">Iran</OPTION>\n"
			<< "                    <OPTION value=\"102\">Iraq</OPTION>\n"
			<< "                    <OPTION value=\"103\">Ireland</OPTION>\n"
			<< "                    <OPTION value=\"104\">Israel</OPTION>\n"
			<< "                    <OPTION value=\"105\">Italy</OPTION>\n"
			<< "                    <OPTION value=\"106\">Jamaica</OPTION>\n"
			<< "                    <OPTION value=\"107\">Japan</OPTION>\n"
			<< "                    <OPTION value=\"108\">Jordan</OPTION>\n"
			<< "                    <OPTION value=\"109\">Kazakhstan</OPTION>\n"
			<< "                    <OPTION value=\"110\">Kenya</OPTION>\n"
			<< "                    <OPTION value=\"111\">Kiribati</OPTION>\n"
			<< "                    <OPTION value=\"112\">Korea, Democratic P. Rep.</OPTION>\n"
			<< "                    <OPTION value=\"113\">Korea, Republic</OPTION>\n"
			<< "                    <OPTION value=\"114\">Kuwait</OPTION>\n"
			<< "                    <OPTION value=\"115\">Kyrgyzstan</OPTION>\n"
			<< "                    <OPTION value=\"116\">Lao P. Democratic Rep.</OPTION>\n"
			<< "                    <OPTION value=\"117\">Latvia</OPTION>\n"
			<< "                    <OPTION value=\"118\">Lebanon</OPTION>\n"
			<< "                    <OPTION value=\"119\">Lesotho</OPTION>\n"
			<< "                    <OPTION value=\"120\">Liberia</OPTION>\n"
			<< "                    <OPTION value=\"121\">Libyan Arab Jamahiriya</OPTION>\n"
			<< "                    <OPTION value=\"122\">Liechtenstein</OPTION>\n"
			<< "                    <OPTION value=\"123\">Lithuania</OPTION>\n"
			<< "                    <OPTION value=\"124\">Luxembourg</OPTION>\n"
			<< "                    <OPTION value=\"125\">Macau</OPTION>\n"
			<< "                    <OPTION value=\"126\">Macedonia</OPTION>\n"
			<< "                    <OPTION value=\"127\">Madagascar</OPTION>\n"
			<< "                    <OPTION value=\"128\">Malawi</OPTION>\n"
			<< "                    <OPTION value=\"129\">Malaysia</OPTION>\n"
			<< "                    <OPTION value=\"130\">Maldives</OPTION>\n"
			<< "                    <OPTION value=\"131\">Mali</OPTION>\n"
			<< "                    <OPTION value=\"132\">Malta</OPTION>\n"
			<< "                    <OPTION value=\"133\">Marshall Islands</OPTION>\n"
			<< "                    <OPTION value=\"134\">Martinique</OPTION>\n"
			<< "                    <OPTION value=\"135\">Mauritania</OPTION>\n"
			<< "                    <OPTION value=\"136\">Mauritius</OPTION>\n"
			<< "                    <OPTION value=\"137\">Mayotte</OPTION>\n"
			<< "                    <OPTION value=\"138\">Mexico</OPTION>\n"
			<< "                    <OPTION value=\"139\">Micronesia</OPTION>\n"
			<< "                    <OPTION value=\"140\">Moldova</OPTION>\n"
			<< "                    <OPTION value=\"141\">Monaco</OPTION>\n"
			<< "                    <OPTION value=\"142\">Mongolia</OPTION>\n"
			<< "                    <OPTION value=\"143\">Montserrat</OPTION>\n"
			<< "                    <OPTION value=\"144\">Morocco</OPTION>\n"
			<< "                    <OPTION value=\"145\">Mozambique</OPTION>\n"
			<< "                    <OPTION value=\"146\">Myanmar</OPTION>\n"
			<< "                    <OPTION value=\"147\">Namibia</OPTION>\n"
			<< "                    <OPTION value=\"148\">Nauru</OPTION>\n"
			<< "                    <OPTION value=\"149\">Nepal</OPTION>\n"
			<< "                    <OPTION value=\"150\">Netherlands</OPTION>\n"
			<< "                    <OPTION value=\"151\">Netherlands Antilles</OPTION>\n"
			<< "                    <OPTION value=\"152\">New Caledonia</OPTION>\n"
			<< "                    <OPTION value=\"153\">New Zealand</OPTION>\n"
			<< "                    <OPTION value=\"154\">Newfoundland</OPTION>\n"
			<< "                    <OPTION value=\"155\">Nicaragua</OPTION>\n"
			<< "                    <OPTION value=\"156\">Niger</OPTION>\n"
			<< "                    <OPTION value=\"157\">Nigeria</OPTION>\n"
			<< "                    <OPTION value=\"158\">Niue</OPTION>\n"
			<< "                    <OPTION value=\"159\">Norfolk Island</OPTION>\n"
			<< "                    <OPTION value=\"160\">Northern Mariana Islands</OPTION>\n"
			<< "                    <OPTION value=\"161\">Norway</OPTION>\n"
			<< "                    <OPTION value=\"162\">Oman</OPTION>\n"
			<< "                    <OPTION value=\"163\">Pakistan</OPTION>\n"
			<< "                    <OPTION value=\"164\">Palau</OPTION>\n"
			<< "                    <OPTION value=\"165\">Panama</OPTION>\n"
			<< "                    <OPTION value=\"166\">Papua New Guinea</OPTION>\n"
			<< "                    <OPTION value=\"167\">Paraguay</OPTION>\n"
			<< "                    <OPTION value=\"168\">Peru</OPTION>\n"
			<< "                    <OPTION value=\"169\">Philippines</OPTION>\n"
			<< "                    <OPTION value=\"170\">Pitcairn</OPTION>\n"
			<< "                    <OPTION value=\"171\">Poland</OPTION>\n"
			<< "                    <OPTION value=\"172\">Portugal</OPTION>\n"
			<< "                    <OPTION value=\"173\">Puerto Rico</OPTION>\n"
			<< "                    <OPTION value=\"174\">Qatar</OPTION>\n"
			<< "                    <OPTION value=\"175\">Reunion</OPTION>\n"
			<< "                    <OPTION value=\"176\">Romania</OPTION>\n"
			<< "                    <OPTION value=\"177\">Russia</OPTION>\n"
			<< "                    <OPTION value=\"178\">Rwanda</OPTION>\n"
			<< "                    <OPTION value=\"179\">S. Georgia/S. Sandwich I.</OPTION>\n"
			<< "                    <OPTION value=\"180\">Saint Kitts and Nevis</OPTION>\n"
			<< "                    <OPTION value=\"181\">Saint Lucia</OPTION>\n"
			<< "                    <OPTION value=\"182\">Saint Vincent/Grenadines</OPTION>\n"
			<< "                    <OPTION value=\"183\">Samoa</OPTION>\n"
			<< "                    <OPTION value=\"184\">San Marino</OPTION>\n"
			<< "                    <OPTION value=\"185\">Sao Tome and Principe</OPTION>\n"
			<< "                    <OPTION value=\"186\">Saudi Arabia</OPTION>\n"
			<< "                    <OPTION value=\"187\">Senegal</OPTION>\n"
			<< "                    <OPTION value=\"188\">Seychelles</OPTION>\n"
			<< "                    <OPTION value=\"189\">Sierra Leone</OPTION>\n"
			<< "                    <OPTION value=\"190\">Singapore</OPTION>\n"
			<< "                    <OPTION value=\"191\">Slovakia (Slovak Rep.)</OPTION>\n"
			<< "                    <OPTION value=\"192\">Slovenia</OPTION>\n"
			<< "                    <OPTION value=\"193\">Solomon Islands</OPTION>\n"
			<< "                    <OPTION value=\"194\">Somalia</OPTION>\n"
			<< "                    <OPTION value=\"195\">South Africa</OPTION>\n"
			<< "                    <OPTION value=\"196\">Spain</OPTION>\n"
			<< "                    <OPTION value=\"197\">Sri Lanka</OPTION>\n"
			<< "                    <OPTION value=\"198\">St. Helena</OPTION>\n"
			<< "                    <OPTION value=\"199\">St. Pierre and Miquelon</OPTION>\n"
			<< "                    <OPTION value=\"200\">Sudan</OPTION>\n"
			<< "                    <OPTION value=\"201\">Suriname</OPTION>\n"
			<< "                    <OPTION value=\"202\">Svalbard/Jan Mayen Isl.</OPTION>\n"
			<< "                    <OPTION value=\"203\">Swaziland</OPTION>\n"
			<< "                    <OPTION value=\"204\">Sweden</OPTION>\n"
			<< "                    <OPTION value=\"205\">Switzerland</OPTION>\n"
			<< "                    <OPTION value=\"206\">Syrian Arab Republic</OPTION>\n"
			<< "                    <OPTION value=\"207\">Taiwan</OPTION>\n"
			<< "                    <OPTION value=\"208\">Tajikistan</OPTION>\n"
			<< "                    <OPTION value=\"209\">Tanzania</OPTION>\n"
			<< "                    <OPTION value=\"210\">Thailand</OPTION>\n"
			<< "                    <OPTION value=\"211\">Togo</OPTION>\n"
			<< "                    <OPTION value=\"212\">Tokelau</OPTION>\n"
			<< "                    <OPTION value=\"213\">Tonga</OPTION>\n"
			<< "                    <OPTION value=\"214\">Trinidad and Tobago</OPTION>\n"
			<< "                    <OPTION value=\"215\">Tunisia</OPTION>\n"
			<< "                    <OPTION value=\"216\">Turkey</OPTION>\n"
			<< "                    <OPTION value=\"217\">Turkmenistan</OPTION>\n"
			<< "                    <OPTION value=\"218\">Turks/Caicos Islands</OPTION>\n"
			<< "                    <OPTION value=\"219\">Tuvalu</OPTION>\n"
			<< "                    <OPTION value=\"220\">Uganda</OPTION>\n"
			<< "                    <OPTION value=\"221\">Ukraine</OPTION>\n"
			<< "                    <OPTION value=\"222\">United Arab Emirates</OPTION>\n"
			<< "                    <OPTION value=\"223\">United States</OPTION>\n"
			<< "                    <OPTION value=\"224\">Uruguay</OPTION>\n"
			<< "                    <OPTION value=\"225\">US Minor Outlying Islands</OPTION>\n"
			<< "                    <OPTION value=\"226\">Uzbekistan</OPTION>\n"
			<< "                    <OPTION value=\"227\">Vanuatu</OPTION>\n"
			<< "                    <OPTION value=\"228\">Vatican City</OPTION>\n"
			<< "                    <OPTION value=\"229\">Venezuela</OPTION>\n"
			<< "                    <OPTION value=\"230\">Viet Nam</OPTION>\n"
			<< "                    <OPTION value=\"231\">Virgin Islands (British)</OPTION>\n"
			<< "                    <OPTION value=\"232\">Virgin Islands (U.S.)</OPTION>\n"
			<< "                    <OPTION value=\"233\">Wallisw/Futuna Islands</OPTION>\n"
			<< "                    <OPTION value=\"234\">Western Sahara</OPTION>\n"
			<< "                    <OPTION value=\"235\">Yeman</OPTION>\n"
			<< "                    <OPTION value=\"236\">Yugoslavia</OPTION>\n"
			<< "                    <OPTION value=\"237\">Zaire</OPTION>\n"
			<< "                    <OPTION value=\"238\">Zambia</OPTION>\n"
			<< "                    <OPTION value=\"239\">Zimbabwe</OPTION>\n"
			<< "                    <OPTION value=\"0\">Other...</OPTION>\n"
			<< "</SELECT></TD>\n"
			<< "</TR>\n"
			<< endl << flush;
			break;
	case 8 :
		Print_Current(Vect[index]);
		cout << "	<!--  zip -->\n"
			
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"113\"\n"
			<< "           height=\"22\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             face=\"Arial, Helvetica, sans-serif\" size=\"2\"><FONT color=\"Red\"><STRONG>*</STRONG></FONT>Zip Code</FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"329\"\n"
			<< "           height=\"22\"\n"
			<< "           align=\"left\">\n"
			<< "            <INPUT\n"
			<< "             type=\"text\"\n"
			<< "             name=\"zip\"\n"
			<< "               value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"20\">"
			<< "				<FONT\n"
			<< "             color=\"#FF0000\"\n"
			<< "             size=\"2\">Will not appear in profile</FONT>\n"
			<< "          </TD>\n"
			<< "        </TR>" << endl << flush;
		break;
	case 9 :
		Print_Current(Vect[index]);
		cout << "	<!--  city -->\n"
			
			<< "        <TR>\n"
			<< "          <TD\n"
			<< "           width=\"113\"\n"
			<< "           height=\"22\"\n"
			<< "           align=\"right\">\n"
			<< "            <FONT\n"
			<< "             face=\"Arial, Helvetica, sans-serif\" size=\"2\">Telephone</FONT>\n"
			<< "          </TD>\n"
			<< "          <TD\n"
			<< "           width=\"329\"\n"
			<< "           height=\"22\"\n"
			<< "           align=\"left\">\n"
			<< "            <INPUT\n"
			<< "             type=\"text\"\n"
			<< "             name=\"telephone\"\n"
			<< "               value=\"" << Vect[index].db_column_data << "\"\n"
			<< "               size=\"20\">"
			<< "				<FONT\n"
			<< "             color=\"#FF0000\"\n"
			<< "             size=\"2\">Will not appear in profile</FONT>\n"
			<< "          </TD>\n"
			<< "        </TR>" << endl << flush;
		
		break;
	default:
		cout << "	<!--    Unknown Column Name  " << Vect[index].db_column_name << " -->" << endl << flush;
		
		break;
	}
}









