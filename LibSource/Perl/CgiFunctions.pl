#    CgiFunctions.pl
#    created on 12-17-2000
#    Author: Jason Baumbach

#        This file contains subroutines for calling CGI applications over the internet
#        Each subroutine can take 4 arguments and executes the passed in URL
#		 If the second argument = "1" debugging is "ON"

#        Example Code:
#        $ReturnValue = &Call_CGI_GET ("http://www.SomeAddress.com/cgi-bin/SomeScript.cgi?user_name=\'Joe\'\&password=\'pwd\'", "1");
#		 Returns the status of $response->is_success;

use LWP::UserAgent;
use HTTP::Request;
use HTTP::Response;
use HTTP::Headers;
use CGI qw/:standard/;
use CGI::Cookie;

$ua = new LWP::UserAgent;
#$ua->proxy('http', 'http://10.10.10.1:4480/');

package CgiFunctions;


sub Get_Cookie_Value
	{
		my($key, $Debug) = @_;
		#		print "key=\"$key\"\n";
		my %cookies = CGI::Cookie::fetch CGI::Cookie;
		my $value = $cookies{$key};
		if($value)
			{
				$value =~ m/$key=(.*);/;
				$value = $1;
				$value =~ s/\%40/\@/;
				$value =~ s/\s//;
				return $value;
			}
		else
			{
				print "<!-- No value found for key=\"$key\" --> \n" if $Debug eq "1";
				#		print "value=\"$value\"\n";
				return "";
			}
	}

#  &Call_CGI_GET ("http://www.SomeAddress.com/cgi-bin/SomeScript.cgi?user_name=\'Joe\'\&password=\'pwd\'", "1");
#  This subroutine executes the passed in URL over the internet
#  Returns the status of $response->is_success;
sub Call_CGI_GET
	{
		my($URL, $UserName, $Password, $Debug) = @_;
			
		# This method for calling cookies has not been tested...
		#			
		#my $cookie_name = new CGI::Cookie(-name    =>  'cookie_name',
		#                             -value   =>  '$UserName',
		#                             -expires =>  '+3M',
		#                             #-domain  =>  '.capricorn.com',
		#                             -path    =>  '/'
		#                             -secure  =>  1
		#                            );
		#
		#my $cookie_password = new CGI::Cookie(-name    =>  'cookie_name',
		#                             -value   =>  '$Password',
		#                             -expires =>  '+3M',
		#                            # -domain  =>  '.capricorn.com',
		#                             -path    =>  '/'
		#                             -secure  =>  1
		#                            );
			
		my $request = new HTTP::Request('GET', $URL);
		#		$request header(-cookie=>[$cookie_name,$cookie_password]);
		$request->header('Cookie' => "cookie_name=$UserName; cookie_password=$Password");
		my $response = $ua->request($request);
		my $ReturnStatus = $response->is_success;	
			
		if ($ReturnStatus == 1) 
			{
				if ($Debug == 1) 
					{
						print "SUCCESS: Call_CGI_GET(\"$URL\", \"$UserName\", \"$Password\")\n";
						print $response->content;	
						}						
						return 1;
					} 
				else 
					{
						if ($Debug == 1) 
							{
								print "ERROR: Call_CGI_GET(\"$URL\", \"$UserName\", \"$Password\") Failed!\n";
								print $response->content;	
								}			
								return 0;
							}
					}# End sub Call_CGI_GET
					
sub Print_Example_Call_CGI_GET
	{
		print "------------- Start Example for using Call_CGI_GET -------------------------\n";
		print "\n";
		print "my \$return_status = \&Call_CGI_GET (\"http://www.SomeAddress.com/cgi-bin/SomeScript.cgi?user_name=\'Joe\'\\&password=\'pwd\'\", 1);\n";
		print "if($return_status == 1)\n";
		print "	{\n";
		print "		print \"user_name=Joe password=pwd\\n\";\n";
		print "	}\n";
		print "else\n";
		print "	{\n";
		print "		print \"ERROR: Something went wrong\\n\";\n";
		print "	}\n";	
		print "\n";
		print "------------- End Example for using Call_CGI_GET -------------------------\n";
	}# End sub Print_Example_Call_CGI_GET
					
sub Call_CGI_POST
	{
		my($URL, $Name, $Pwd) = @_;
			
		my $header = new HTTP::Headers();
		$header->header('content-type' => 'multipart/form-data');
		$header->header('content-length' => '5');
			
		my $temp = $header->header('content-type');
		print "-- $temp --";
			
		my $request = new HTTP::Request('POST', $URL, $header);
		$request->header('Cookie' => "cookie_name=$UserName; cookie_password=$Password");
		my $response = $ua->request($request);
		if ($response->is_success) 
			{
				print "URL: $URL\n";	
				print $response->content;							
				return 1;
			} 
		else 
			{
				print "ERROR: $Name was not added.\n";
				print "URL: $URL\n";
				print $response->content;				
				print NEWFILE "ERROR: $Name was not added.\n";
				print NEWFILE "URL: $URL\n";
				return 0;
			}
			
	}# End sub Call_CGI_POST
					
sub Get_Cookie_String_From_File
	{
		my($LocalCookieFileName, $Debug) = @_;
		my $LocalCookieFilePath = "C:/Documents and Settings/baumbach/Cookies/";
		my $CookieFileToOpen = $LocalCookieFilePath . $LocalCookieFileName;
			
		# Open the cookie file...
		open (LOCALFILE, "$CookieFileToOpen") || die return "Can't open $CookieFileToOpen: $!";
			
		my $CookieString = "";
		my $CookieName = "";
		my $CookieValue = "";
			
		my $FirstTimeIn = 0;
		my $FoundStar = 0;
		my $FoundCookieName = 0;
			
		while (<LOCALFILE>) 
			{
				$FirstTimeIn++;
				# Remove all carrige returns...
				$_ =~ s/\n//;
					
				if($FirstTimeIn == 1)
					{
						$CookieName = $_;
						#				print "Found Cookie Name 1\n" if $DebugThisAp eq "1";
					}
				elsif($FirstTimeIn == 2)
					{
						$CookieValue = $_;
						$CookieString = "$CookieName=$CookieValue";
						#				print "Found Cookie Value 1\n" if $DebugThisAp eq "1";
						next;
					}
					
				if($_ =~ m/^\*/)
					{
						$FoundStar = 1;
						#				print "Found Star\n" if $DebugThisAp eq "1";
						next;
					}
					
				if($FoundStar == 1 && $FoundCookieName == 0)
					{
						$CookieName = $_;
						$FoundCookieName = 1;
						#				print "Found Cookie Name\n";
					}
				elsif($FoundStar == 1 && $FoundCookieName == 1)
					{
						$CookieValue = $_;
						$CookieString .= "; $CookieName=$CookieValue";
						$FoundStar = 0;
						$FoundCookieName = 0;
						#				print "Found Cookie Value\n" if $DebugThisAp eq "1";
						next;
					}
			}
		close (LOCALFILE);
		return $CookieString; 
	}# End sub Get_Cookie_String_From_File
					
sub Load_Query_String_Hash
	{
		my $QueryStingArray	= shift;
		my $Debug			= shift;

		my %QS_Hash;

		print "<!-- sub Load_Query_String_Hash(", join ' ', @$QueryStingArray, ", $$Debug) -->\n" if $$Debug eq "1";

		foreach my $QueryStringValue (@$QueryStingArray) 
			{
				$QS_Hash{$QueryStringValue} = CGI::param($QueryStringValue);
#				print "<!-- QS_Hash{$QueryStringValue} = (" . CGI::param($QueryStringValue) . ") -->\n" if $$Debug eq "1";
			}

		if ($$Debug eq "1") 
			{
				&Print_Query_String_Hash(\%QS_Hash ,\$Debug);
			}

		return %QS_Hash;
	}# End sub Load_Query_String_Hash

sub Print_Query_String_Hash
	{
		my $QueryStingArray	= shift;
		my $Debug			= shift;

		print "<!-- sub Print_Query_String_Hash(%$QueryStingArray, $$Debug) -->\n" if $$Debug eq "1";

		print "\n<!-- BEGIN Query String Name/Value Pairs -->\n";

		while( (my $Key, my $Value) = each(%$QueryStingArray) )
		{
		   print "<!-- $Key = ($Value) -->\n";
		}       
		
		print "\n<!-- END Query String Name/Value Pairs -->\n";
	}# End sub Print_Query_String_Hash

# Scripts that are to be include with other scripts must end with "1;"
1;
