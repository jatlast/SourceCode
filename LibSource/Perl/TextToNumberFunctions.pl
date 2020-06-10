#    TextToNumber.pl
#    created on 12-17-2000
#    Author: Jason Baumbach

#        This file contains subroutines for returning integer values when passed text values
#        Each subroutine can take 2 arguments and returns the appropriate value.
#		 If the second argument = "1" debugging is "ON"

#        Explination: 
#		 Calling Sex with an input of "Male" returns value of "1"

#        Example Code:
#        $Gender = "Male";
#        print $Gender;
#        print "\n";
#        $Gender = &Sex($Gender, 0);
#
#        print $Gender;
#        The output would be:
#        Male
#        1

sub Smoke(\$)
	{
		my $new_value = "0";
		(my $temp, my $Debug) = @_;	
		if ($temp =~ m/Yes/i)
			{
				$new_value = "1";
			}
		elsif ($temp =~ m/No/i)
			{
				$new_value = "2";
			}
		if($Debug == 1)
			{
				print "<!-- Smoke(\"$temp\") returned \"$new_value\" -->\n";
			}
			
		return $new_value;
	}
	
sub Sex(\$)
	{
		my $new_value = "0";
		(my $temp, my $Debug) = @_;	
		if ($temp =~ m/Female/i)
			{
				$new_value = "2";
			}
		elsif ($temp =~ m/Male/i)
			{
				$new_value = "1";
			}
		if($Debug == 1)
			{
				print "<!-- Sex(\"$temp\") returned \"$new_value\" -->\n";
			}
		return $new_value;
	}
	
sub Drink(\$)
	{
		my $new_value = "0";
		(my $temp, my $Debug) = @_;	
		if ($temp =~ m/Yes/i)
			{
				$new_value = "1";
			}
		elsif ($temp =~ m/No/i)
			{
				$new_value = "2";
			}
		if($Debug == 1)
			{
				print "<!-- Drink(\"$temp\") returned \"$new_value\" -->\n";
			}
		return $new_value;
	}
	
	
sub State(\$) 
	{
		my $new_value = "0";
				(my $temp, my $Debug) = @_;	
		if ($temp =~ m/Alabama/i)
			{
				$new_value = "1";
			}
		elsif ($temp =~ m/Alaska/i)
			{
				$new_value = "2";
			}
		elsif ($temp =~ m/Arizona/i)
			{
				$new_value = "3";
			}
		elsif ($temp =~ m/Arkansas/i)
			{
				$new_value = "4";
			}
		elsif ($temp =~ m/California/i)
			{
				$new_value = "5";
			}
		elsif ($temp =~ m/California/i)
			{
				$new_value = "6";
			}
		elsif ($temp =~ m/California/i)
			{
				$new_value = "7";
			}
		elsif ($temp =~ m/California/i)
			{
				$new_value = "8";
			}
		elsif ($temp =~ m/Colorado/i)
			{
				$new_value = "9";
			}
		elsif ($temp =~ m/Connecticut/i)
			{
				$new_value = "10";
			}
		elsif ($temp =~ m/Delaware/i)
			{
				$new_value = "11";
			}
		elsif ($temp =~ m/District of Columbia/i)
			{
				$new_value = "12";
			}
		elsif ($temp =~ m/Florida/i)
			{
				$new_value = "13";
			}
		elsif ($temp =~ m/Georgia/i)
			{
				$new_value = "14";
			}
		elsif ($temp =~ m/Hawaii/i)
			{
				$new_value = "16";
			}
		elsif ($temp =~ m/Idaho/i)
			{
				$new_value = "17";
			}
		elsif ($temp =~ m/Illinois/i)
			{
				$new_value = "18";
			}
		elsif ($temp =~ m/Indiana/i)
			{
				$new_value = "19";
			}
		elsif ($temp =~ m/Iowa/i)
			{
				$new_value = "20";
			}
		elsif ($temp =~ m/Kansas/i)
			{
				$new_value = "21";
			}
		elsif ($temp =~ m/Kentucky/i)
			{
				$new_value = "22";
			}
		elsif ($temp =~ m/Louisiana/i)
			{
				$new_value = "23";
			}
		elsif ($temp =~ m/Maine/i)
			{
				$new_value = "24";
			}
		elsif ($temp =~ m/Maryland/i)
			{
				$new_value = "25";
			}
		elsif ($temp =~ m/Massachusetts/i)
			{
				$new_value = "26";
			}
		elsif ($temp =~ m/Michigan/i)
			{
				$new_value = "27";
			}
		elsif ($temp =~ m/Minnesota/i)
			{
				$new_value = "28";
			}
		elsif ($temp =~ m/Mississippi/i)
			{
				$new_value = "29";
			}
		elsif ($temp =~ m/Missouri/i)
			{
				$new_value = "30";
			}
		elsif ($temp =~ m/Montana/i)
			{
				$new_value = "31";
			}
		elsif ($temp =~ m/Nebraska/i)
			{
				$new_value = "32";
			}
		elsif ($temp =~ m/Nevada/i)
			{
				$new_value = "33";
			}
		elsif ($temp =~ m/New Hampshire/i)
			{
				$new_value = "34";
			}
		elsif ($temp =~ m/New Jersey/i)
			{
				$new_value = "35";
			}
		elsif ($temp =~ m/New Mexico/i)
			{
				$new_value = "36";
			}
		elsif ($temp =~ m/New York/i)
			{
				$new_value = "37";
			}
		elsif ($temp =~ m/New York City/i)
			{
				$new_value = "38";
			}
		elsif ($temp =~ m/North Carolina/i)
			{
				$new_value = "39";
			}
		elsif ($temp =~ m/North Dakota/i)
			{
				$new_value = "40";
			}
		elsif ($temp =~ m/Ohio/i)
			{
				$new_value = "41";
			}
		elsif ($temp =~ m/Oklahoma/i)
			{
				$new_value = "42";
			}
		elsif ($temp =~ m/Oregon/i)
			{
				$new_value = "43";
			}
		elsif ($temp =~ m/Pennsylvania/i)
			{
				$new_value = "44";
			}
		elsif ($temp =~ m/Rhode Island/i)
			{
				$new_value = "46";
			}
		elsif ($temp =~ m/South Carolina/i)
			{
				$new_value = "47";
			}
		elsif ($temp =~ m/South Dakota/i)
			{
				$new_value = "48";
			}
		elsif ($temp =~ m/Tennessee/i)
			{
				$new_value = "49";
			}
		elsif ($temp =~ m/Texas/i)
			{
				$new_value = "50";
			}
		elsif ($temp =~ m/Texas/i)
			{
				$new_value = "51";
			}
		elsif ($temp =~ m/Texas/i)
			{
				$new_value = "52";
			}
		elsif ($temp =~ m/Texas/i)
			{
				$new_value = "53";
			}
		elsif ($temp =~ m/Utah/i)
			{
				$new_value = "54";
			}
		elsif ($temp =~ m/Vermont/i)
			{
				$new_value = "55";
			}
		elsif ($temp =~ m/Virginia/i)
			{
				$new_value = "56";
			}
		elsif ($temp =~ m/Washington/i)
			{
				$new_value = "57";
			}
		elsif ($temp =~ m/West Virginia/i)
			{
				$new_value = "58";
			}
		elsif ($temp =~ m/Wisconsin/i)
			{
				$new_value = "59";
			}
		elsif ($temp =~ m/Wyoming/i)
			{
				$new_value = "60";
			}
		elsif ($temp =~ m/Prefer not to say/i)
			{
				$new_value = "0";
			}
		if($Debug == 1)
			{
				print "<!-- State(\"$temp\") returned \"$new_value\" -->\n";
			}
		return $new_value;
	}# End sub State 
	
sub Country(\$)
	{
		my $new_value = "0";
		(my $temp, my $Debug) = @_;	
		if ($temp =~ m/United States/i)
			{
				$new_value = "1";
			}
		elsif ($temp =~ m/Africa/i)
			{
				$new_value = "2";
			}
		elsif ($temp =~ m/Australia/i)
			{
				$new_value = "3";
			}
		elsif ($temp =~ m/India/i)
			{
				$new_value = "4";
			}
		elsif ($temp =~ m/Japan/i)
			{
				$new_value = "5";
			}
		elsif ($temp =~ m/New Zealand/i)
			{
				$new_value = "6";
			}
		elsif ($temp =~ m/Other/i)
			{
				$new_value = "7";
			}
		elsif ($temp =~ m/Alberta/i)
			{
				$new_value = "8";
			}
		elsif ($temp =~ m/British Columbia/i)
			{
				$new_value = "9";
			}
		elsif ($temp =~ m/Manitoba/i)
			{
				$new_value = "10";
			}
		elsif ($temp =~ m/New Brunswick/i)
			{
				$new_value = "11";
			}
		elsif ($temp =~ m/Newfoundland/i)
			{
				$new_value = "12";
			}
		elsif ($temp =~ m/Northwest Territories/i)
			{
				$new_value = "13";
			}
		elsif ($temp =~ m/Nova Scotia/i)
			{
				$new_value = "14";
			}
		elsif ($temp =~ m/Ontario/i)
			{
				$new_value = "15";
			}
		elsif ($temp =~ m/Prince Edward Island/i)
			{
				$new_value = "16";
			}
		elsif ($temp =~ m/Quebec/i)
			{
				$new_value = "17";
			}
		elsif ($temp =~ m/Saskatchewan/i)
			{
				$new_value = "18";
			}
		elsif ($temp =~ m/Yukon/i)
			{
				$new_value = "19";
			}
		elsif ($temp =~ m/Eastern Europe/i)
			{
				$new_value = "20";
			}
		elsif ($temp =~ m/France/i)
			{
				$new_value = "21";
			}
		elsif ($temp =~ m/Germany/i)
			{
				$new_value = "22";
			}
		elsif ($temp =~ m/Ireland/i)
			{
				$new_value = "23";
			}
		elsif ($temp =~ m/Italy/i)
			{
				$new_value = "24";
			}
		elsif ($temp =~ m/Netherlands/i)
			{
				$new_value = "25";
			}
		elsif ($temp =~ m/Scandinavia/i)
			{
				$new_value = "26";
			}
		elsif ($temp =~ m/Other/i)
			{
				$new_value = "27";
			}
		elsif ($temp =~ m/Guam/i)
			{
				$new_value = "28";
			}
		elsif ($temp =~ m/Channel Islands/i)
			{
				$new_value = "29";
			}
		elsif ($temp =~ m/England/i)
			{
				$new_value = "30";
			}
		elsif ($temp =~ m/England/i)
			{
				$new_value = "31";
			}
		elsif ($temp =~ m/England/i)
			{
				$new_value = "32";
			}
		elsif ($temp =~ m/England/i)
			{
				$new_value = "33";
			}
		elsif ($temp =~ m/England/i)
			{
				$new_value = "34";
			}
		elsif ($temp =~ m/Isle of Man/i)
			{
				$new_value = "45";
			}
		elsif ($temp =~ m/Northern Ireland/i)
			{
				$new_value = "36";
			}
		elsif ($temp =~ m/Scotland/i)
			{
				$new_value = "37";
			}
		elsif ($temp =~ m/Wales/i)
			{
				$new_value = "38";
			}
		elsif ($temp =~ m/Latin America/i)
			{
				$new_value = "39";
			}
		elsif ($temp =~ m/Middle East/i)
			{
				$new_value = "40";
			}
		elsif ($temp =~ m/Puerto Rico/i)
			{
				$new_value = "41";
			}
		elsif ($temp =~ m/Other Area/i)
			{
				$new_value = "42";
			}
		elsif ($temp =~ m/Prefer not to say/i)
			{
				$new_value = "0";
			}
		if($Debug == 1)
			{
				print "<!-- Country(\"$temp\") returned \"$new_value\" -->\n";
			}
		return $new_value;
	}# End sub Country 
	
	
sub MaritalStatus(\$)
	{
		my $new_value = "0";
		(my $temp, my $Debug) = @_;	
		if ($temp =~ m/Prefer not to say/i)
			{
				$new_value = "0";
			}
		elsif ($temp =~ m/Single/i)
			{
				$new_value = "1";
			}
		elsif ($temp =~ m/Married/i)
			{
				$new_value = "3";
			}
		elsif ($temp =~ m/Divorced/i)
			{
				$new_value = "4";
			}
		elsif ($temp =~ m/Divorced/i)
			{
				$new_value = "5";
			}
		elsif ($temp =~ m/Widowed/i)
			{
				$new_value = "6";
			}
		elsif ($temp =~ m/Widowed/i)
			{
				$new_value = "7";
			}
		elsif ($temp =~ m/Single with children/i)
			{
				$new_value = "2";
			}
		if($Debug == 1)
			{
				print "<!-- MaritalStatus(\"$temp\") returned \"$new_value\" -->\n";
			}
		return $new_value;
	}# End sub MaritalStatus
	
sub Profession(\$)
	{
		my $new_value = "0";
		(my $temp, my $Debug) = @_;	
		if ($temp =~ m/Please choose one/i)
			{
				$new_value = "0";
			}
		elsif ($temp =~ m/Accounting/i)
			{
				$new_value = "1";
			}
		elsif ($temp =~ m/Advertising/i)
			{
				$new_value = "2";
			}
		elsif ($temp =~ m/Advertising/i)
			{
				$new_value = "3";
			}
		elsif ($temp =~ m/Advertising/i)
			{
				$new_value = "4";
			}
		elsif ($temp =~ m/Aerospace/i)
			{
				$new_value = "5";
			}
		elsif ($temp =~ m/Textile/i)
			{
				$new_value = "6";
			}
		elsif ($temp =~ m/Architecture/i)
			{
				$new_value = "7";
			}
		elsif ($temp =~ m/Photography/i)
			{
				$new_value = "8";
			}
		elsif ($temp =~ m/Arts/i)
			{
				$new_value = "9";
			}
		elsif ($temp =~ m/Motor Vehicles/i)
			{
				$new_value = "10";
			}
		elsif ($temp =~ m/Financial Services/i)
			{
				$new_value = "11";
			}
		elsif ($temp =~ m/Bio-Pharmaceutical/i)
			{
				$new_value = "12";
			}
		elsif ($temp =~ m/Biotechnology/i)
			{
				$new_value = "13";
			}
		elsif ($temp =~ m/Building Materials/i)
			{
				$new_value = "14";
			}
		elsif ($temp =~ m/Contruction/i)
			{
				$new_value = "15";
			}
		elsif ($temp =~ m/Not for Profit/i)
			{
				$new_value = "16";
			}
		elsif ($temp =~ m/Clerical/i)
			{
				$new_value = "17";
			}
		elsif ($temp =~ m/Clerical/i)
			{
				$new_value = "18";
			}
		elsif ($temp =~ m/Composer/i)
			{
				$new_value = "19";
			}
		elsif ($temp =~ m/Computer Hardware/i)
			{
				$new_value = "20";
			}
		elsif ($temp =~ m/Computer Software/i)
			{
				$new_value = "21";
			}
		elsif ($temp =~ m/Construction/i)
			{
				$new_value = "22";
			}
		elsif ($temp =~ m/Consultant/i)
			{
				$new_value = "23";
			}
		elsif ($temp =~ m/Consulting/i)
			{
				$new_value = "24";
			}
		elsif ($temp =~ m/Doctor/i)
			{
				$new_value = "25";
			}
		elsif ($temp =~ m/College/i)
			{
				$new_value = "26";
			}
		elsif ($temp =~ m/Education/i)
			{
				$new_value = "27";
			}
		elsif ($temp =~ m/Recruiting/i)
			{
				$new_value = "28";
			}
		elsif ($temp =~ m/Utilities/i)
			{
				$new_value = "29";
			}
		elsif ($temp =~ m/Engineering/i)
			{
				$new_value = "30";
			}
		elsif ($temp =~ m/Radio/i)
			{
				$new_value = "31";
			}
		elsif ($temp =~ m/Finance/i)
			{
				$new_value = "32";
			}
		elsif ($temp =~ m/Food Services/i)
			{
				$new_value = "33";
			}
		elsif ($temp =~ m/Civil Service/i)
			{
				$new_value = "34";
			}
		elsif ($temp =~ m/Graphic Artist/i)
			{
				$new_value = "35";
			}
		elsif ($temp =~ m/Medical/i)
			{
				$new_value = "36";
			}
		elsif ($temp =~ m/Health Care/i)
			{
				$new_value = "37";
			}
		elsif ($temp =~ m/Home Business/i)
			{
				$new_value = "38";
			}
		elsif ($temp =~ m/Home Maker/i)
			{
				$new_value = "39";
			}
		elsif ($temp =~ m/Hospitality/i)
			{
				$new_value = "40";
			}
		elsif ($temp =~ m/Human Resources/i)
			{
				$new_value = "41";
			}
		elsif ($temp =~ m/HVAC/i)
			{
				$new_value = "42";
			}
		elsif ($temp =~ m/Industrial/i)
			{
				$new_value = "43";
			}
		elsif ($temp =~ m/Insurance/i)
			{
				$new_value = "44";
			}
		elsif ($temp =~ m/Internet/i)
			{
				$new_value = "45";
			}
		elsif ($temp =~ m/K-12 Faculty/i)
			{
				$new_value = "46";
			}
		elsif ($temp =~ m/Military/i)
			{
				$new_value = "47";
			}
		elsif ($temp =~ m/Lawyer/i)
			{
				$new_value = "48";
			}
		elsif ($temp =~ m/Legal/i)
			{
				$new_value = "49";
			}
		elsif ($temp =~ m/Manufacturing/i)
			{
				$new_value = "50";
			}
		elsif ($temp =~ m/Manufacturing/i)
			{
				$new_value = "51";
			}
		elsif ($temp =~ m/Marketing/i)
			{
				$new_value = "52";
			}
		elsif ($temp =~ m/Merchandising/i)
			{
				$new_value = "53";
			}
		elsif ($temp =~ m/Middle Management/i)
			{
				$new_value = "54";
			}
		elsif ($temp =~ m/MIS/i)
			{
				$new_value = "55";
			}
		elsif ($temp =~ m/Mortgage/i)
			{
				$new_value = "56";
			}
		elsif ($temp =~ m/New Media/i)
			{
				$new_value = "57";
			}
		elsif ($temp =~ m/Office Equipment/i)
			{
				$new_value = "58";
			}
		elsif ($temp =~ m/Office Manager/i)
			{
				$new_value = "59";
			}
		elsif ($temp =~ m/Petroleum/i)
			{
				$new_value = "60";
			}
		elsif ($temp =~ m/Pharmaceutical/i)
			{
				$new_value = "61";
			}
		elsif ($temp =~ m/Political/i)
			{
				$new_value = "62";
			}
		elsif ($temp =~ m/Prefer not to say/i)
			{
				$new_value = "63";
			}
		elsif ($temp =~ m/Publishing/i)
			{
				$new_value = "64";
			}
		elsif ($temp =~ m/Professional/i)
			{
				$new_value = "65";
			}
		elsif ($temp =~ m/Fund Raising/i)
			{
				$new_value = "66";
			}
		elsif ($temp =~ m/Public Sector/i)
			{
				$new_value = "67";
			}
		elsif ($temp =~ m/R&D Engineering/i)
			{
				$new_value = "68";
			}
		elsif ($temp =~ m/Property Mgt/i)
			{
				$new_value = "69";
			}
		elsif ($temp =~ m/Recreation/i)
			{
				$new_value = "70";
			}
		elsif ($temp =~ m/Retail/i)
			{
				$new_value = "71";
			}
		elsif ($temp =~ m/Retail Products/i)
			{
				$new_value = "72";
			}
		elsif ($temp =~ m/Retired/i)
			{
				$new_value = "73";
			}
		elsif ($temp =~ m/Sales/i)
			{
				$new_value = "74";
			}
		elsif ($temp =~ m/Sales/i)
			{
				$new_value = "75";
			}
		elsif ($temp =~ m/Scientist/i)
			{
				$new_value = "76";
			}
		elsif ($temp =~ m/Electronics/i)
			{
				$new_value = "77";
			}
		elsif ($temp =~ m/Technical Management/i)
			{
				$new_value = "78";
			}
		elsif ($temp =~ m/Technology/i)
			{
				$new_value = "79";
			}
		elsif ($temp =~ m/Telecommunications/i)
			{
				$new_value = "80";
			}
		elsif ($temp =~ m/Telecommunications/i)
			{
				$new_value = "81";
			}
		elsif ($temp =~ m/Tourism/i)
			{
				$new_value = "82";
			}
		elsif ($temp =~ m/Tradesman/i)
			{
				$new_value = "83";
			}
		elsif ($temp =~ m/Training/i)
			{
				$new_value = "84";
			}
		elsif ($temp =~ m/Railroad/i)
			{
				$new_value = "85";
			}
		elsif ($temp =~ m/Transportation/i)
			{
				$new_value = "86";
			}
		elsif ($temp =~ m/University Staff/i)
			{
				$new_value = "87";
			}
		elsif ($temp =~ m/University Student/i)
			{
				$new_value = "88";
			}
		elsif ($temp =~ m/Upper Management/i)
			{
				$new_value = "89";
			}
		if($Debug == 1)
			{
				print "<!-- Profession(\"$temp\") returned \"$new_value\" -->\n";
			}
		return $new_value;
	}# End sub Profession
	
sub Education(\$)
	{
		my $new_value = "0";
		(my $temp, my $Debug) = @_;	
		if ($temp =~ m/Prefer not to say/i)
			{
				$new_value = "0";
			}
		elsif ($temp =~ m/Still a student/i)
			{
				$new_value = "1";
			}
		elsif ($temp =~ m/High School/i)
			{
				$new_value = "2";
			}
		elsif ($temp =~ m/Some College/i)
			{
				$new_value = "3";
			}
		elsif ($temp =~ m/College Degree/i)
			{
				$new_value = "4";
			}
		elsif ($temp =~ m/Graduate Degree/i)
			{
				$new_value = "5";
			}
		elsif ($temp =~ m/Post Graduate/i)
			{
				$new_value = "6";
			}
		if($Debug == 1)
			{
				print "<!-- Education(\"$temp\") returned \"$new_value\" -->\n";
			}
		return $new_value;
	}# End sub Education
	
sub Religion(\$)
	{
		my $new_value = "0";
		(my $temp, my $Debug) = @_;	
		if ($temp =~ m/Prefer not to say/i)
			{
				$new_value = "0";
			}
		elsif ($temp =~ m/Islam/i || $temp =~ m/Muslim/i)
			{
				$new_value = "1";
			}
		elsif ($temp =~ m/Christian/i)
			{
				$new_value = "2";
			}
		elsif ($temp =~ m/Catholic/i)
			{
				$new_value = "3";
			}
		elsif ($temp =~ m/Jewish/i)
			{
				$new_value = "4";
			}
		elsif ($temp =~ m/Zoroastrian/i)
			{
				$new_value = "5";
			}
		elsif ($temp =~ m/Bahai/i)
			{
				$new_value = "6";
			}
		elsif ($temp =~ m/Other/i)
			{
				$new_value = "7";
			}
		elsif ($temp =~ m/Not religious/i)
			{
				$new_value = "8";
			}
		if($Debug == 1)
			{
				print "<!-- Religion(\"$temp\") returned \"$new_value\" -->\n";
			}
		return $new_value;
	}# End sub Religion
	
	
	
sub Height(\$)
	{
		my $new_value = "0";
		(my $temp, my $Debug) = @_;	
		if ($temp =~ m/Prefer not to say/i)
			{
				$new_value = "0";
			}
		elsif ($temp =~ m/4\' 01\" \(1.24m\)/i)
			{
				$new_value = "1";
			}
		elsif ($temp =~ m/4\' 02\" \(1.27m\)/i)
			{
				$new_value = "2";
			}
		elsif ($temp =~ m/4\' 03\" \(1.30m\)/i)
			{
				$new_value = "3";
			}
		elsif ($temp =~ m/4\' 04\" \(1.32m\)/i)
			{
				$new_value = "4";
			}
		elsif ($temp =~ m/4\' 05\" \(1.35m\)/i)
			{
				$new_value = "5";
			}
		elsif ($temp =~ m/4\' 06\" \(1.37m\)/i)
			{
				$new_value = "6";
			}
		elsif ($temp =~ m/4\' 07\" \(1.40m\)/i)
			{
				$new_value = "7";
			}
		elsif ($temp =~ m/4\' 08\" \(1.42m\)/i)
			{
				$new_value = "8";
			}
		elsif ($temp =~ m/4\' 09\" \(1.45m\)/i)
			{
				$new_value = "9";
			}
		elsif ($temp =~ m/4\' 10\" \(1.47m\)/i)
			{
				$new_value = "10";
			}
		elsif ($temp =~ m/4\' 11\" \(1.50m\)/i)
			{
				$new_value = "11";
			}
		elsif ($temp =~ m/5\' 00\" \(1.52m\)/i)
			{
				$new_value = "12";
			}
		elsif ($temp =~ m/5\' 01\" \(1.55m\)/i)
			{
				$new_value = "13";
			}
		elsif ($temp =~ m/5\' 02\" \(1.57m\)/i)
			{
				$new_value = "14";
			}
		elsif ($temp =~ m/5\' 03\" \(1.60m\)/i)
			{
				$new_value = "15";
			}
		elsif ($temp =~ m/5\' 04\" \(1.63m\)/i)
			{
				$new_value = "16";
			}
		elsif ($temp =~ m/5\' 05\" \(1.65m\)/i)
			{
				$new_value = "17";
			}
		elsif ($temp =~ m/5\' 06\" \(1.68m\)/i)
			{
				$new_value = "18";
			}
		elsif ($temp =~ m/5\' 07\" \(1.70m\)/i)
			{
				$new_value = "19";
			}
		elsif ($temp =~ m/5\' 08\" \(1.73m\)/i)
			{
				$new_value = "20";
			}
		elsif ($temp =~ m/5\' 09\" \(1.75m\)/i)
			{
				$new_value = "21";
			}
		elsif ($temp =~ m/5\' 10\" \(1.78m\)/i)
			{
				$new_value = "22";
			}
		elsif ($temp =~ m/5\' 11\" \(1.80m\)/i)
			{
				$new_value = "23";
			}
		elsif ($temp =~ m/6\' 00\" \(1.83m\)/i)
			{
				$new_value = "24";
			}
		elsif ($temp =~ m/6\' 01\" \(1.85m\)/i)
			{
				$new_value = "25";
			}
		elsif ($temp =~ m/6\' 02\" \(1.88m\)/i)
			{
				$new_value = "26";
			}
		elsif ($temp =~ m/6\' 03\" \(1.90m\)/i)
			{
				$new_value = "27";
			}
		elsif ($temp =~ m/6\' 04\" \(1.93m\)/i)
			{
				$new_value = "28";
			}
		elsif ($temp =~ m/6\' 05\" \(1.96m\)/i)
			{
				$new_value = "29";
			}
		elsif ($temp =~ m/6\' 06\" \(1.98m\)/i)
			{
				$new_value = "30";
			}
		elsif ($temp =~ m/6\' 07\" \(2.01m\)/i)
			{
				$new_value = "31";
			}
		elsif ($temp =~ m/6\' 08\" \(2.03m\)/i)
			{
				$new_value = "32";
			}
		elsif ($temp =~ m/6\' 09\" \(2.06m\)/i)
			{
				$new_value = "33";
			}
		elsif ($temp =~ m/6\' 10\" \(2.08m\)/i)
			{
				$new_value = "34";
			}
		elsif ($temp =~ m/6\' 11\" \(2.11m\)/i)
			{
				$new_value = "35";
			}
		elsif ($temp =~ m/7\' 00\" \(2.13m\)/i)
			{
				$new_value = "36";
			}
		elsif ($temp =~ m/7\' 01\" \(2.16m\)/i)
			{
				$new_value = "37";
			}
		elsif ($temp =~ m/7\' 02\" \(2.18m\)/i)
			{
				$new_value = "38";
			}
		elsif ($temp =~ m/7\' 03\" \(2.21m\)/i)
			{
				$new_value = "39";
			}
		elsif ($temp =~ m/7\' 04\" \(2.24m\)/i)
			{
				$new_value = "40";
			}
		elsif ($temp =~ m/7\' 05\" \(2.26m\)/i)
			{
				$new_value = "41";
			}
		elsif ($temp =~ m/7\' 06\" \(2.29m\)/i)
			{
				$new_value = "42";
			}
		if($Debug == 1)
			{
				print "<!-- Height(\"$temp\") returned \"$new_value\" -->\n";
			}
		return $new_value;
	}# End sub Height
	
sub Weight(\$)
	{
		my $new_value = "0";
		(my $temp, my $Debug) = @_;	
		if ($temp =~ m/85 lbs/i)
			{
				$new_value = "1";
			}
		elsif ($temp =~ m/90 lbs/i)
			{
				$new_value = "2";
			}
		elsif ($temp =~ m/95 lbs/i)
			{
				$new_value = "3";
			}
		elsif ($temp =~ m/100 lbs/i)
			{
				$new_value = "4";
			}
		elsif ($temp =~ m/105 lbs/i)
			{
				$new_value = "5";
			}
		elsif ($temp =~ m/110 lbs/i)
			{
				$new_value = "6";
			}
		elsif ($temp =~ m/115 lbs/i)
			{
				$new_value = "7";
			}
		elsif ($temp =~ m/120 lbs/i)
			{
				$new_value = "8";
			}
		elsif ($temp =~ m/125 lbs/i)
			{
				$new_value = "9";
			}
		elsif ($temp =~ m/130 lbs/i)
			{
				$new_value = "10";
			}
		elsif ($temp =~ m/135 lbs/i)
			{
				$new_value = "11";
			}
		elsif ($temp =~ m/140 lbs/i)
			{
				$new_value = "12";
			}
		elsif ($temp =~ m/145 lbs/i)
			{
				$new_value = "13";
			}
		elsif ($temp =~ m/150 lbs/i)
			{
				$new_value = "14";
			}
		elsif ($temp =~ m/155 lbs/i)
			{
				$new_value = "15";
			}
		elsif ($temp =~ m/160 lbs/i)
			{
				$new_value = "16";
			}
		elsif ($temp =~ m/165 lbs/i)
			{
				$new_value = "17";
			}
		elsif ($temp =~ m/170 lbs/i)
			{
				$new_value = "18";
			}
		elsif ($temp =~ m/175 lbs/i)
			{
				$new_value = "19";
			}
		elsif ($temp =~ m/180 lbs/i)
			{
				$new_value = "20";
			}
		elsif ($temp =~ m/185 lbs/i)
			{
				$new_value = "21";
			}
		elsif ($temp =~ m/190 lbs/i)
			{
				$new_value = "22";
			}
		elsif ($temp =~ m/195 lbs/i)
			{
				$new_value = "23";
			}
		elsif ($temp =~ m/200 lbs/i)
			{
				$new_value = "24";
			}
		elsif ($temp =~ m/205 lbs/i)
			{
				$new_value = "25";
			}
		elsif ($temp =~ m/210 lbs/i)
			{
				$new_value = "26";
			}
		elsif ($temp =~ m/215 lbs/i)
			{
				$new_value = "27";
			}
		elsif ($temp =~ m/220 lbs/i)
			{
				$new_value = "28";
			}
		elsif ($temp =~ m/225 lbs/i)
			{
				$new_value = "29";
			}
		elsif ($temp =~ m/230 lbs/i)
			{
				$new_value = "30";
			}
		elsif ($temp =~ m/235 lbs/i)
			{
				$new_value = "31";
			}
		elsif ($temp =~ m/240 lbs/i)
			{
				$new_value = "32";
			}
		elsif ($temp =~ m/245 lbs/i)
			{
				$new_value = "33";
			}
		elsif ($temp =~ m/250 lbs/i)
			{
				$new_value = "34";
			}
		elsif ($temp =~ m/255 lbs/i)
			{
				$new_value = "35";
			}
		elsif ($temp =~ m/260 lbs/i)
			{
				$new_value = "36";
			}
		elsif ($temp =~ m/265 lbs/i)
			{
				$new_value = "37";
			}
		elsif ($temp =~ m/270 lbs/i)
			{
				$new_value = "38";
			}
		elsif ($temp =~ m/275 lbs/i)
			{
				$new_value = "39";
			}
		elsif ($temp =~ m/280 lbs/i)
			{
				$new_value = "40";
			}
		elsif ($temp =~ m/285 lbs/i)
			{
				$new_value = "41";
			}
		elsif ($temp =~ m/290 lbs/i)
			{
				$new_value = "42";
			}
		elsif ($temp =~ m/295 lbs/i)
			{
				$new_value = "43";
			}
		elsif ($temp =~ m/300 lbs/i)
			{
				$new_value = "44";
			}
		elsif ($temp =~ m/300+ lbs/i)
			{
				$new_value = "45";
			}
		elsif ($temp =~ m/Prefer not to s/i)
			{
				$new_value = "0";
			}
		if($Debug == 1)
			{
				print "<!-- Weight(\"$temp\") returned \"$new_value\" -->\n";
			}
		return $new_value;
	}# End sub Weight
	
	
sub Hair(\$)
	{
		my $new_value = "0";
		(my $temp, my $Debug) = @_;	
		if ($temp =~ m/Prefer not to say/i)
			{
				$new_value = "0";
			}
		elsif ($temp =~ m/Black/i)
			{
				$new_value = "1";
			}
		elsif ($temp =~ m/Brown/i)
			{
				$new_value = "2";
			}
		elsif ($temp =~ m/Red/i)
			{
				$new_value = "3";
			}
		elsif ($temp =~ m/Blonde/i)
			{
				$new_value = "4";
			}
		elsif ($temp =~ m/Balding/i)
			{
				$new_value = "5";
			}
		elsif ($temp =~ m/Other/i)
			{
				$new_value = "6";
			}
		if($Debug == 1)
			{
				print "<!-- Hair(\"$temp\") returned \"$new_value\" -->\n";
			}
		return $new_value;
	}# End sub Hair
	
sub Eyes(\$)
	{
		my $new_value = "0";
		(my $temp, my $Debug) = @_;	
		if ($temp =~ m/Prefer not to say/i)
			{
				$new_value = "0";
			}
		elsif ($temp =~ m/Brown/i)
			{
				$new_value = "1";
			}
		elsif ($temp =~ m/Black/i)
			{
				$new_value = "2";
			}
		elsif ($temp =~ m/Blue/i)
			{
				$new_value = "3";
			}
		elsif ($temp =~ m/Green/i)
			{
				$new_value = "4";
			}
		elsif ($temp =~ m/Hazel/i)
			{
				$new_value = "5";
			}
		if($Debug == 1)
			{
				print "<!-- Eyes(\"$temp\") returned \"$new_value\" -->\n";
			}
		return $new_value;
	}# End sub Eyes

# Scripts that are to be include with other scripts must end with "1;"
1;
