#!/usr/local/bin/perl -w

use strict;

		if (!open(PRE_SEND_MAIL_FILE, "Test_PreSendMail.html")) 
			{
				print "ERROR: Could not open Test_PreSendMail.html\n"; 
				die; 
			}
		if (!open(RECOVERY_FILE, "> TestRecoveryFile.html")) 
			{
				print "ERROR: Could not open TestRecoveryFile.html\n"; 
				die; 
			}
			
		print RECOVERY_FILE "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\n";
		print RECOVERY_FILE "<HTML>\n";
		print RECOVERY_FILE "  <HEAD>\n";
		print RECOVERY_FILE "    <TITLE>\n";
		print RECOVERY_FILE "      	Admin_SendMail.cgi time out recovery file\n";
		print RECOVERY_FILE "    </TITLE>\n";
		# Open in new JavaScript...
		print RECOVERY_FILE"	 <SCRIPT type=\"text/javascript\" language=\"javascript\">\n";
		print RECOVERY_FILE"	 <!--\n";
		print RECOVERY_FILE"	 function newWindowGeneric(picName) \n";
		print RECOVERY_FILE"	 {\n";
		print RECOVERY_FILE"	 		var myWindow = window.open(picName, 'Guidelines', 'toolbar=no,location=no,scrollbars=yes,resizable=yes,width=850,height=1000')\n";
		print RECOVERY_FILE"				myWindow.focus()\n";
		print RECOVERY_FILE"	 }\n";
		print RECOVERY_FILE"	 // -->\n";
		print RECOVERY_FILE"	 </SCRIPT>\n";
		
		print RECOVERY_FILE "  </HEAD>\n";
		print RECOVERY_FILE "  <BODY>\n";
		print RECOVERY_FILE "    <TABLE border=\"0\" cellpadding=\"3\" cellspacing=\"3\" width=\"700\">\n";
		print RECOVERY_FILE "            <TR align=\"left\">\n";
		print RECOVERY_FILE "              <TD>\n";
		print RECOVERY_FILE "                  <FONT face=\"Arial, Helvetica, sans-serif\" size=\"3\"><STRONG>Results from sending multiple unique \"To:\" messages</STRONG></FONT>\n";
		print RECOVERY_FILE "                  <BR>&nbsp;<BR>\n";
		print RECOVERY_FILE "              </TD>\n";
		print RECOVERY_FILE "            </TR>\n";
		
		my $Count = 1;
		
		my $WhichConnections = "";
		my $ConnectionsEmail = "";
		my $HtmlRoot 		 = "";
			
		my $BlatExe  = "";
		my $BlatSmtp = "";
		my $BlatLog  = "";
		
		my $UserName      = "";
		my $Password      = "";
		my $Sex			  = "";
		my $Email      	  = "";
		my $FirstName     = "";
		my $LastName      = "";
		my $StreetAddress = "";
		my $City	      = "";
		my $State	      = "";
		my $Country	      = "";
		my $Zip			  = "";
		my $Questionable  = "";
		my $CreationDate  = "";
		my $LastLogin	  = "";
		
		
		while (<PRE_SEND_MAIL_FILE>) 
			{ 
				my $Subject = "";
				my $Message = "";
					
				if($Count == 0)
					{
						last;
					}
				elsif ($_ =~ m%^Local Paramaters%)
					{
						#       WhichConnections,Email, Admin/cgi-bin 
						m%Local Paramaters <!-- (.*), (.*), (.*) -->%;
						$WhichConnections = $1;
						$ConnectionsEmail = $2;
						$HtmlRoot		  = $3;
					}
				elsif ($_ =~ m%^Blat Paramaters%)
					{
						#            			Exe, Smtp, Log 
						m%Blat Paramaters <!-- (.*), (.*), (.*) -->%;
						$BlatExe  = $1;
						$BlatSmtp = "smtpout.verizon.net";
						#$BlatSmtp = $2;
						$BlatLog  = $3;
					}
				elsif ($_ =~ m%^\(%)
					{
						#          	   UN,   PW,   Em,   Sx,   LN,   SA,   Ct,   St,   Ct,   Zp,   Qu,   Cd,  LL 
						m%^\(.*\)<!-- (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*)\|\| (.*) -->%;
						$UserName 	   = $1;
						$Password 	   = $2;
						$Email 	  	   = $3;
						$Sex 	  	   = $4;
						$LastName 	   = $5;
						$StreetAddress = $6;
						$City 		   = $7;
						$State 		   = $8;
						$Country 	   = $9;
						$Zip 		   = $10;
						$Questionable  = $11;
						$CreationDate  = $12;
						$LastLogin 	   = $13;
							
#						print RECOVERY_FILE "UserName  	  = ($UserName)\n";
#						print RECOVERY_FILE "Password	  = ($Password)\n";
                        print RECOVERY_FILE "Email		  = ($Email)\n";
#                        print RECOVERY_FILE "Sex		  = ($Sex)\n";
#                        print RECOVERY_FILE "LastName	  = ($LastName)\n";
#                        print RECOVERY_FILE "StreetAddress= ($StreetAddress)\n";
#                        print RECOVERY_FILE "City		  = ($City)\n";
#                        print RECOVERY_FILE "State 		  = ($State)\n";
#                        print RECOVERY_FILE "Country 	  = ($Country)\n";
#                        print RECOVERY_FILE "Zip 		  = ($Zip)\n";
#                        print RECOVERY_FILE "Questionable = ($Questionable)\n";
#                        print RECOVERY_FILE "CreationDate = ($CreationDate)\n";
#                        print RECOVERY_FILE "LastLogin	  = ($LastLogin)\n\n";
							
						if($Sex eq "Male")
							{
								$Subject =~ s/replace_last_name/Mr. $LastName/g;
							}
						else
							{
								$Subject =~ s/replace_last_name/Ms. $LastName/g;
							}
							
						$Subject =~ s/replace_user_name/$UserName/g;
						$Subject =~ s/replace_which_connections/$WhichConnections/g;
						
						$Message =~ s/replace_user_name/$UserName/g;
						$Message =~ s/replace_which_connections/$WhichConnections/g;
						$Message =~ s/replace_admin_email/$ConnectionsEmail/g;
						$Message =~ s/replace_html_root/$HtmlRoot/g;
						
#						print RECOVERY_FILE "Send_Individual_Blat_Mail($BlatExe, $BlatSmtp, $BlatLog, $ConnectionsEmail, $Email, \"\", Subject, Message)\n\n";
							}
						$Count++;
					}
		close (PRE_SEND_MAIL_FILE);
		
		print RECOVERY_FILE "                    <!-- submit -->\n";
		print RECOVERY_FILE "                    <TR>\n";
		print RECOVERY_FILE "                      <TD>\n";
		print RECOVERY_FILE "						   <INPUT TYPE=BUTTON VALUE=\"Close Window\" onClick=\"Closer()\">\n";
		print RECOVERY_FILE "                      </TD>\n";
		print RECOVERY_FILE "                    </TR>\n";
		print RECOVERY_FILE "						  <SCRIPT type=\"text/javascript\" language=\"javascript\">\n";
		print RECOVERY_FILE "						  <!--\n";
		print RECOVERY_FILE "    					 		 function Closer()\n";
		print RECOVERY_FILE "    							 {\n";
		print RECOVERY_FILE "        						 	  window.close()\n";
		print RECOVERY_FILE "    							 }\n";
		print RECOVERY_FILE "						  //-->\n";
		print RECOVERY_FILE "						 </SCRIPT>\n";
			
		print RECOVERY_FILE "          </TABLE>\n";
		print RECOVERY_FILE "        </TD>\n";
		print RECOVERY_FILE "        <!-- End Main Data Cell -->\n";
		print RECOVERY_FILE "      </TR>\n";
		print RECOVERY_FILE "      <!-- End Navigation and Main Row -->\n";
		print RECOVERY_FILE "    </TABLE>\n";
			
		print RECOVERY_FILE "  </BODY>\n";
		print RECOVERY_FILE "</HTML>\n";
		
		close(RECOVERY_FILE);


