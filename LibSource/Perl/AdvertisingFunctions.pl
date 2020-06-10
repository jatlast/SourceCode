#!/usr/local/bin/perl -w
use strict;

package AdvertisingFunctions;

use MSSQL::DBlib::Const::General;

sub Get_Spam_Text_Ads
{
	my $host_unique_id	= shift;
	my $MapHash			= shift;
	my $Debug			= shift;

	my $TextAds_HTML	= "";

	my $font_face	    		= "";
	my $table_bgcolor    		= "";
	my $table_border_size		= "";
	my $headline_size    		= "";
	my $headline_color   		= "";
	my $text_1_size      		= "";
	my $text_1_color     		= "";
	my $text_2_size				= "";
	my $text_2_color     		= "";
	my $display_url_size 		= "";
	my $display_url_color		= "";
	my $local_bgcolor			= "";
	my $advertiser_type    		= "";
	my $unique_id    			= "";
	my $max_batch_size    		= "";
	my $horizontal_or_vertical	= "";
	my $become_advertiser_link	= "";
	my $search_param_name  		= "";
	my $state_param_name     	= "";
	my $country_param_name		= "";
	my $sex_searching_param_name= "";
	my $sex_sought_param_name  	= "";
	my $min_age_param_name     	= "";
	my $max_age_param_name     	= "";
	my $test_mode		  		= "";

	my $SqlStatement = "adv_GetHostTextLayouts \'$$host_unique_id\'";     

	my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($$MapHash{'DBUSER_ADVERTISING'}, $$MapHash{'DBPWD_ADVERTISING'}, $$MapHash{'DBNAME'}, "AdvertisingFunctions");
	$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
	$status = $MSSQL::DBlib::dbh->dbsqlexec();
		
	if($DatabaseFunctions::DatabaseError eq "1000" or $DatabaseFunctions::DatabaseError eq "1001")
		{
			$TextAds_HTML = $TextAds_HTML . "<BR><FONT color=\"red\">DB Error: ($DatabaseFunctions::DatabaseError)</FONT><BR>\n";
		}
	else
		{
			##########################
			# Get ONLY result set...
			##########################
			# dbresults() must be called for each result set...
			$status = $MSSQL::DBlib::dbh->dbresults();
			if($status != FAIL && $DatabaseFunctions::DatabaseError ne "1")
				{
					if($$Debug eq "1")
						{
							$TextAds_HTML = $TextAds_HTML . "<BR>SUCCESS: $SqlStatement returned with dbresults status = ($status).<BR>\n";
						}
					elsif($DatabaseFunctions::DatabaseError eq "1016")
						{
							$TextAds_HTML = $TextAds_HTML . "<BR>Retrieval Failure.<BR>\n<!-- SQL: \n($SqlStatement)\n DbError: \nROLLBACK ($DatabaseFunctions::DatabaseError)\n -->\n<BR>\n";
						}
					my %dataref = ("jason" => "baumbach");
					my $dataref = \%dataref;
					# Check for global DB error...
					if($DatabaseFunctions::DatabaseError eq "1")
						{
							$TextAds_HTML = $TextAds_HTML . "<BR>Retrieval Failure.<BR>\n<!-- SQL: \n($SqlStatement)\n DbError: \nROLLBACK ($DatabaseFunctions::DatabaseError)\n -->\n<BR>\n";
						}
					else
						{
							# Prevent infinite loop...
							while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
								{
									# Since there is no global DB error check get 
									# all database fields returned by the query...
										
									$font_face    				= $$dataref{font_face};
									$table_bgcolor    			= $$dataref{table_bgcolor};
									$table_border_size			= $$dataref{table_border_size};
									$headline_size    			= $$dataref{headline_size};
									$headline_color   			= $$dataref{headline_color};
									$text_1_size      			= $$dataref{text_1_size};
									$text_1_color     			= $$dataref{text_1_color};
									$text_2_size      			= $$dataref{text_2_size};
									$text_2_color     			= $$dataref{text_2_color};
									$display_url_size 			= $$dataref{display_url_size};
									$display_url_color			= $$dataref{display_url_color};
									$local_bgcolor    			= $$dataref{local_bgcolor};
									$max_batch_size        		= $$dataref{max_batch_size};
									$horizontal_or_vertical		= $$dataref{horizontal_or_vertical};
									$become_advertiser_link		= $$dataref{become_advertiser_link};
									$search_param_name     		= $$dataref{search_param_name};
									$state_param_name     		= $$dataref{state_param_name};
									$country_param_name			= $$dataref{country_param_name};
									$sex_searching_param_name	= $$dataref{sex_searching_param_name};
									$sex_sought_param_name  	= $$dataref{sex_sought_param_name};
									$min_age_param_name     	= $$dataref{min_age_param_name};
									$max_age_param_name     	= $$dataref{max_age_param_name};
									$test_mode             		= $$dataref{test_mode};
									$advertiser_type			= $$dataref{advertiser_type};

									$table_border_size	=~ s/\s//;
									$text_1_size		=~ s/\s//;
									$text_2_size		=~ s/\s//;
									$display_url_size	=~ s/\s//;
										
									if($$Debug eq "1")
										{
											$TextAds_HTML = $TextAds_HTML . "<BR>font_face                = ($font_face)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>table_bgcolor            = ($table_bgcolor)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>table_border_size        = ($table_border_size)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>headline_size            = ($headline_size)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>headline_color           = ($headline_color)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>text_1_size              = ($text_1_size)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>text_1_color             = ($text_1_color)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>text_2_size              = ($text_2_size)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>text_2_color             = ($text_2_color)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>display_url_size         = ($display_url_size )<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>display_url_color        = ($display_url_color)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>local_bgcolor            = ($local_bgcolor)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>max_batch_size           = ($max_batch_size)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>horizontal_or_vertical   = ($horizontal_or_vertical)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>become_advertiser_link   = ($become_advertiser_link)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>search_param_name        = ($search_param_name)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>state_param_name         = (state_param_name)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>country_param_name       = (country_param_name)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>sex_searching_param_name = (sex_searching_param_name)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>sex_sought_param_name    = (sex_sought_param_name)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>min_age_param_name       = (min_age_param_name)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>max_age_param_name       = (max_age_param_name)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>test_mode                = ($test_mode)<BR>\n";
											$TextAds_HTML = $TextAds_HTML . "<BR>advertiser_type          = ($advertiser_type)<BR>\n";
										}
								}
						}# END else (No db error) 
				}# END if($status != FAIL)
			else
				{
					$TextAds_HTML = $TextAds_HTML . "<BR>ERROR: $SqlStatement Failed for first result set!<BR>\n";
					$status = $MSSQL::DBlib::dbh->dbcancel();
				}
		}

	$TextAds_HTML = $TextAds_HTML . "<TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"4\" align=\"middle\" width=\"20%\">\n";
	$TextAds_HTML = $TextAds_HTML . "<TR>\n";
	if ($horizontal_or_vertical eq "V") 
		{
			$TextAds_HTML = $TextAds_HTML . "  <TD nowrap align=\"center\">\n";
		}											
	else
		{
			$TextAds_HTML = $TextAds_HTML . "  <TD nowrap align=\"center\" colspan=\"" . ($max_batch_size * 2) . "\">\n";
		}	
		
	if ($become_advertiser_link eq "0") 
		{
			$TextAds_HTML = $TextAds_HTML . "	 <SPAN><FONT face=\"$font_face\" color=\"gray\" size=\"-1\">Sponsored Links</FONT></SPAN>\n";
		}											

	$TextAds_HTML = $TextAds_HTML . "  </TD>\n";
	$TextAds_HTML = $TextAds_HTML . "</TR>\n";
	$TextAds_HTML = $TextAds_HTML . "<TR>\n";
	$TextAds_HTML = $TextAds_HTML . "  <TD>\n";


	if ($advertiser_type eq '1') 
		{
			$SqlStatement = "adv_InsertStaticAccessLog \'$$host_unique_id\', \'$max_batch_size\', \'$test_mode\'\n";     

			#$TextAds_HTML = $TextAds_HTML . "<BR>SQL = ($SqlStatement)<BR>\n";

			my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($$MapHash{'DBUSER_ADVERTISING'}, $$MapHash{'DBPWD_ADVERTISING'}, $$MapHash{'DBNAME'}, "AdvertisingFunctions");
			$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
			$status = $MSSQL::DBlib::dbh->dbsqlexec();
				
			if($DatabaseFunctions::DatabaseError eq "1000" or $DatabaseFunctions::DatabaseError eq "1001")
				{
					$TextAds_HTML = $TextAds_HTML . "<BR><FONT color=\"red\">DB Error: ($DatabaseFunctions::DatabaseError)</FONT><BR>\n";		
				}
			else
				{
					##########################
					# Get ONLY result set...
					##########################
					# dbresults() must be called for each result set...
					$status = $MSSQL::DBlib::dbh->dbresults();
					if($status != FAIL && $DatabaseFunctions::DatabaseError ne "1")
						{
							if($$Debug eq "1")
								{
									$TextAds_HTML = $TextAds_HTML . "<BR>SUCCESS: $SqlStatement returned with dbresults status = ($status).<BR>\n";
								}
							elsif($DatabaseFunctions::DatabaseError eq "1016")
								{
									$TextAds_HTML = $TextAds_HTML . "<BR>Retrieval Failure.<BR>\n<!-- SQL: \n($SqlStatement)\n DbError: \nROLLBACK ($DatabaseFunctions::DatabaseError)\n -->\n<BR>\n";
								}
							my %dataref = ("jason" => "baumbach");
							my $dataref = \%dataref;
							# Check for global DB error...
							if($DatabaseFunctions::DatabaseError eq "1")
								{
									$TextAds_HTML = $TextAds_HTML . "<BR>Retrieval Failure.<BR>\n<!-- SQL: \n($SqlStatement)\n DbError: \nROLLBACK ($DatabaseFunctions::DatabaseError)\n -->\n<BR>\n";
								}
							else
								{
									# Prevent infinite loop...
									while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
										{
											# Since there is no global DB error check get 
											# all database fields returned by the query...
												
											my $headline					= $$dataref{headline};
											my $text_1						= $$dataref{text_1};
											my $text_2						= $$dataref{text_2};
											my $display_url					= $$dataref{display_url};
											my $link_url					= $$dataref{link_url};
											my $position					= $$dataref{position};
											my $click_through_log_unique_id	= $$dataref{click_through_log_unique_id};
												
											if($$Debug eq "1")
												{
													$TextAds_HTML = $TextAds_HTML . "<BR>headline                    = ($headline)<BR>\n";
													$TextAds_HTML = $TextAds_HTML . "<BR>text_1                      = ($text_1)<BR>\n";
													$TextAds_HTML = $TextAds_HTML . "<BR>text_2                      = ($text_2)<BR>\n";
													$TextAds_HTML = $TextAds_HTML . "<BR>display_url                 = ($display_url)<BR>\n";
													$TextAds_HTML = $TextAds_HTML . "<BR>link_url                    = ($link_url)<BR>\n";
													$TextAds_HTML = $TextAds_HTML . "<BR>position                    = ($position)<BR>\n";
													$TextAds_HTML = $TextAds_HTML . "<BR>click_through_log_unique_id = ($click_through_log_unique_id)<BR>\n";
												}
											$TextAds_HTML = $TextAds_HTML . "  <TABLE border=\"0\" cellspacing=\"4\" width=\"100%\">\n";
											$TextAds_HTML = $TextAds_HTML . "	<TR>\n";
											$TextAds_HTML = $TextAds_HTML . "	  <TD>\n";
											$TextAds_HTML = $TextAds_HTML . "		<TABLE bgcolor=\"$table_bgcolor\" border=\"$table_border_size\" cellpadding=\"3\" cellspacing=\"0\" width=\"100%\">\n";
											$TextAds_HTML = $TextAds_HTML . "		  <TR>\n";
#  Old way with embeded JavaScript does not work in most email programs...
#											$TextAds_HTML = $TextAds_HTML . "			<TD align=\"left\" nowrap onmouseover=\"this.style.cursor='hand';window.status='go to $display_url';return true\" onmouseout=\"this.style.cursor='auto';window.status='';return true\" onclick=\"location.href='$$MapHash{'ADV_CGIBIN'}/ProcessAdClick.cgi?url=$link_url&amp;unique_id=$click_through_log_unique_id&amp;ip_address=0.0.0.0'\">\n";
#											$TextAds_HTML = $TextAds_HTML . "			  <A href=\"$$MapHash{'ADV_CGIBIN'}/ProcessAdClick.cgi?url=$link_url&amp;unique_id=$click_through_log_unique_id&amp;ip_address=0.0.0.0\" onmouseover=\"window.status='go to $display_url';return true\" onmouseout=\"window.status='';return true\"><FONT face=\"$font_face\" size=\"$headline_size\" color=\"$headline_color\">$headline</FONT></A>\n";

											$TextAds_HTML = $TextAds_HTML . "			<TD align=\"left\" nowrap>\n";
											$TextAds_HTML = $TextAds_HTML . "			  <A href=\"$$MapHash{'ADV_CGIBIN'}/ProcessAdClick.cgi?om_url=$link_url&amp;om_unique_id=$click_through_log_unique_id&amp;om_ip_address=0.0.0.0\"><FONT face=\"$font_face\" size=\"$headline_size\" color=\"$headline_color\">$headline</FONT></A>\n";

											$TextAds_HTML = $TextAds_HTML . "			  <BR>\n";
											$TextAds_HTML = $TextAds_HTML . "			  <FONT face=\"$font_face\" color=\"$text_1_color\" size=\"$text_1_size\">$text_1</FONT>\n";
											$TextAds_HTML = $TextAds_HTML . "			  <BR>\n";
											$TextAds_HTML = $TextAds_HTML . "			  <FONT face=\"$font_face\" color=\"$text_2_color\" size=\"$text_2_size\">$text_2</FONT>\n";
											$TextAds_HTML = $TextAds_HTML . "			  <BR>\n";
											$TextAds_HTML = $TextAds_HTML . "			  <FONT face=\"$font_face\" color=\"$display_url_color\" size=\"$display_url_size\">$display_url</FONT></FONT>\n";
											$TextAds_HTML = $TextAds_HTML . "			</TD>\n";
											$TextAds_HTML = $TextAds_HTML . "		  </TR>\n";
											$TextAds_HTML = $TextAds_HTML . "		</TABLE>\n";
											$TextAds_HTML = $TextAds_HTML . "	  </TD>\n";
											$TextAds_HTML = $TextAds_HTML . "	</TR>\n";
											$TextAds_HTML = $TextAds_HTML . "  </TABLE>\n";

											if ($horizontal_or_vertical eq "V") 
												{
													$TextAds_HTML = $TextAds_HTML . "  <BR>\n";
												}											
											else
												{
													$TextAds_HTML = $TextAds_HTML . "  </TD>\n";
													$TextAds_HTML = $TextAds_HTML . "  <TD>\n";
													$TextAds_HTML = $TextAds_HTML . "    &nbsp;\n";
													$TextAds_HTML = $TextAds_HTML . "  </TD>\n";
													$TextAds_HTML = $TextAds_HTML . "  <TD>\n";
												}											
										}
								}# END else (No db error) 
						}# END if($status != FAIL)
					else
						{
							$TextAds_HTML = $TextAds_HTML . "<BR>ERROR: $SqlStatement Failed for first result set!<BR>\n";
							$status = $MSSQL::DBlib::dbh->dbcancel();
						}
				}
		}

	$TextAds_HTML = $TextAds_HTML . "  </TD>\n";
	$TextAds_HTML = $TextAds_HTML . "</TR>\n";
	$TextAds_HTML = $TextAds_HTML . "<TR>\n";
	if ($horizontal_or_vertical eq "V") 
		{
			$TextAds_HTML = $TextAds_HTML . "  <TD nowrap align=\"center\">\n";
		}											
	else
		{
			$TextAds_HTML = $TextAds_HTML . "  <TD nowrap align=\"center\" colspan=\"" . ($max_batch_size * 2) . "\">\n";
		}											

	if ($become_advertiser_link eq "0") 
		{
			$TextAds_HTML = $TextAds_HTML . "	<A href=\"$$MapHash{'ADV_CGIBIN'}/Adv_CreateLogin.cgi?om_host_unique_id=$$host_unique_id&om_cmd=GenAdvertiserLogin&om_submit=Click+here+to+start\"><FONT face=\"$font_face\" color=\"gray\" size=\"-1\">See your ad here...</FONT></A>\n";
		}											

	$TextAds_HTML = $TextAds_HTML . "  </TD>\n";
	$TextAds_HTML = $TextAds_HTML . "</TR>\n";
	$TextAds_HTML = $TextAds_HTML . "</TABLE>\n";

	return $TextAds_HTML;
}


sub Insert_Mail_Sent_Log
{
	my $target_audience	= shift;
	my $MapHash			= shift;
	my $Debug			= shift;

	my $mail_sent_unique_id = "";  # return this value initiated

	my $SqlStatement = "mail_insertMailSentLog \'$$target_audience\' ,\'0\' ,\'Unknown\'"; 
	my $status = $MSSQL::DBlib::dbh = MSSQL::DBlib->dblogin($$MapHash{'DBUSER_MAILING_LIST'}, $$MapHash{'DBPWD_MAILING_LIST'}, $$MapHash{'DBNAME'}, "AdvertisingFunctions.pl");
	$status = $MSSQL::DBlib::dbh->dbcmd($SqlStatement);
	$status = $MSSQL::DBlib::dbh->dbsqlexec();
		
	if($DatabaseFunctions::DatabaseError eq "1001")
		{
			print "ERROR: ($SqlStatement) Failed!<BR>\n";
			return 0;
		}
	else
		{
			##########################
			# Get ONLY result set...
			##########################
			# dbresults() must be called for each result set...
			$status = $MSSQL::DBlib::dbh->dbresults();
			if($status != FAIL && $DatabaseFunctions::DatabaseError ne "1")
				{
					my $advertiser_unique_id = "";
					my $campaign_unique_id	 = "";
					my $group_unique_id		 = "";

					if($$Debug eq "1")
						{
							print "<!-- SUCCESS: $SqlStatement returned with dbresults status = ($status). -->\n";
						}
					my %dataref = ("jason" => "baumbach");
					my $dataref = \%dataref;
					# Check for global DB error...
					if($DatabaseFunctions::DatabaseError eq "1")
						{
							print "ERROR: ($SqlStatement) Failed!<BR>\n" if $$Debug eq "1";
							return 0;
						}
					else
						{
							# Prevent infinite loop...
							while ($MSSQL::DBlib::dbh->dbnextrow2($dataref, 1) != NO_MORE_ROWS) 
								{
									# Since there is no global DB error check get 
									# all database fields returned by the query...
									
									$mail_sent_unique_id = $$dataref{unique_id};

									if($$Debug eq "1")
										{
											print "<!-- mail_sent_unique_id = ($mail_sent_unique_id) -->\n";
										}	
								}
						}# END else (No db error) 
					}# END if($status != FAIL)
			else
				{
					print "<!-- DbError: ($DatabaseFunctions::DatabaseError)\n running SQL: \n($SqlStatement)\n -->\n" if $$Debug eq "1";
					return 0;
				}
		}
	return $mail_sent_unique_id;
}


sub Create_File_To_Send
{
	my $file_template		= shift;
	my $file_scratch_pad	= shift;
	my $file_to_send		= shift;
	my $TextAds_HTML		= shift;
	my $mail_sent_unique_id	= shift;
	my $email_address		= shift;
	my $MapHash				= shift;
	my $$Debug				= shift;

	######### Insert Text Ads ####################
	# Open the template HTML file that is the outline for the file sent to the user...
	open (HTML_FILE_TO_EDIT, "< $$file_template") || die "Can't open new file ($$file_template): $!\n";
	# Create/Open that is to be edited before sending it to the user...
	open (HTML_FILE_NO_URLS, "> $$file_scratch_pad") || die "Can't open new file ($$file_scratch_pad): $!\n";

	while (<HTML_FILE_TO_EDIT>) 
		{			
			$_ =~ s/replace_with_text_ads/$$TextAds_HTML/g;
			print HTML_FILE_NO_URLS $_;
		}
	close (HTML_FILE_TO_EDIT);
	close (HTML_FILE_NO_URLS);

	######### Replace URLs ####################

	# Create/Open that is to be edited before sending it to the user...
	open (HTML_FILE_NO_URLS, "< $$file_scratch_pad") || die "Can't open new file ($$file_scratch_pad): $!\n";
	# Create/Open that is to be edited before sending it to the user...
	open (HTML_FILE_TO_SEND, "> $$file_to_send") || die "Can't open new file ($$file_to_send): $!\n";

	while (<HTML_FILE_NO_URLS>) 
		{			
			if($_ =~ m%<A href="http://.*?"%gi
				or $_ =~ m%"location.href='http://.*?'"%gis
				or $_ =~ m%<form method="GET" action=".*?">%gis
				)
			{
				# Add a random number (pmc_stamp) to try and fool spam detectors...
				my $pmc_stamp = time;
				$_ =~ s%<A href="http://(.*?)"%<A href="$$MapHash{'ADV_CGIBIN'}/ProcessMailClick.cgi?pmc_url=http://$1&pmc_id=$$mail_sent_unique_id&pmc_respondent=$$email_address&pmc_stamp=$pmc_stamp"%gis;
				$_ =~ s%"location.href='http://(.*?)'"%"location.href='$$MapHash{'ADV_CGIBIN'}/ProcessMailClick.cgi?pmc_url=http://$1&pmc_id=$$mail_sent_unique_id&pmc_respondent=$$email_address&pmc_stamp=$pmc_stamp'"%gis;
				$_ =~ s%<form method="GET" action="(.*?)">%<form method="GET" action="$$MapHash{'ADV_CGIBIN'}/ProcessMailClick.cgi"><input type="hidden" name="pmc_url" value="$1?"><input type="hidden" name="pmc_id" value="$$mail_sent_unique_id"><input type="hidden" name="pmc_respondent" value="$$email_address"><input type="hidden" name="pmc_stamp" value="$pmc_stamp">%gis;

#				print MYLOGFILE $1 . "\n";
			}
			print HTML_FILE_TO_SEND $_;
		}
	close (HTML_FILE_NO_URLS);
	close (HTML_FILE_TO_SEND);
}




# Scripts that are to be include with other scripts must end with "1;"
1;
