#    UtilityFunctions.pl
#    created on 3-16-2000
#    Author: Jason Baumbach

#        This file contains utility subroutines 
#		 If the second argument = "1" debugging is "ON"

#        Example Code:
#		 my %Map = &UtilityFunctions::Load_LinkMap(1); 
#		 print the value for the geven key...
# 	 	 print "Root = $Map{'CONFIG'}\n";

# Initialize LinkMap Hash variable "Map"...
#my %Map = &UtilityFunctions::Load_LinkMap(1); 

package UtilityFunctions;

#  &Load_LinkMap ("1"); "1" if debug "0" if not. 
#  This subroutine loads the key value pairs into a hash table
#  Returns a the hash table containing the 
#   Key/Value pairs of lth LinkMap.dat file. 
sub Load_LinkMap
	{
		# File::Basename module is used to parse the path that is passed to Load_LinkMap
		use File::Basename;
			
		(my $LinkMapPath, my $Debug) = @_;
		print "<!-- sub Load_LinkMap($LinkMapPath, $Debug) -->\n" if $Debug eq "1";

		# You select the syntax via the routine fileparse_set_fstype()...
		fileparse_set_fstype("MSWin32");
		# returns the directory portion of the input file...
		my $CurrentPath = dirname($LinkMapPath);
		my $LINKMAP = "$CurrentPath/LinkMap.dat";	
			
		my $opened  = open (LOCALFILE, $LINKMAP);	
			
		# Use Local LinkMap.dat...
		if ($opened)
			{
				$LinkMap{'CONFIG'} = "Local";
				$LinkMap{'LINKMAP_FILE'} = $LINKMAP;
				while (<LOCALFILE>) 
					{
						if(m/^#/ || m/^\s/)
							{
								next;
							}
						else
							{
								my $Key	  = "";
								my $Value = "";
								if(m/(\w*)\s*\[(.*)\]$/)
									{
										$Key   = $1;
										$Value = $2;
										#print "key = ($Key)\n";
										#print "val = ($Value)\n";
									}
									else
									{
										($Key, $Value) = split(/\s+/, $_);
									}
								$LinkMap{$Key} = $Value;
							}
					} 
				close (LOCALFILE);
				return %LinkMap;
			}
		# Use Shared LinkMap.dat...
		else
			{
				$LINKMAP = "C:/Required/Shared/LinkMap/Shared_LinkMap.dat";	
				$opened  = open (LOCALFILE, $LINKMAP);	
					
				# Use Shared C:\ LinkMap.dat...
				if ($opened)
					{
						$LinkMap{'CONFIG'} = "Shared_C";
						$LinkMap{'LINKMAP_FILE'} = $LINKMAP;
					}
				# Look for shared D:\ LinkMap.dat...
				else
					{
						$LINKMAP = "D:/Required/Shared/LinkMap/Shared_LinkMap.dat";	
						$opened  = open (LOCALFILE, $LINKMAP);	
							
						# Use Shared D:\ LinkMap.dat...
						if ($opened)
							{
								$LinkMap{'CONFIG'} = "Shared_D";
								$LinkMap{'LINKMAP_FILE'} = $LINKMAP;
							}
						# ERROR:  No LinkMap.dat found...
						else
						{
							$LinkMap{'CONFIG'} = 'ERROR';
							print "<!-- Load_LinkMap could not open $LINKMAP: $! -->\n" if $Debug eq "1";
							return %LinkMap;
						}
					} # End Not C:\
			} # End Not Local

		while (<LOCALFILE>) 
			{
				if(m/^#/ || m/^\s/)
					{
						next;
					}
				else
					{
						my $Key	  = "";
						my $Value = "";
						if(m/(\w*)\s*\[(.*)\]$/)
							{
								$Key   = $1;
								$Value = $2;
								#print "key = ($Key)\n";
								#print "val = ($Value)\n";
							}
							else
							{
								($Key, $Value) = split(/\s+/, $_);
							}
						$LinkMap{$Key} = $Value;
					}
			} 
		close (LOCALFILE);

		# Determine which Specific LinkMap.dat needs to be loaded...
		my $specific_LM_key = lc($ENV{SERVER_NAME});
		$CurrentPath = dirname($LINKMAP);
		$LINKMAP = $CurrentPath . "/" . $LinkMap{$specific_LM_key};	
		$opened  = open (LOCALFILE, $LINKMAP);	
			
		# Use Local LinkMap.dat...
		if ($opened)
			{
				$LinkMap{'LINKMAP_FILE_SPECIFIC'} = $LINKMAP;
				while (<LOCALFILE>) 
					{
						if(m/^#/ || m/^\s/)
							{
								next;
							}
						else
							{
								my $Key	  = "";
								my $Value = "";
								if(m/(\w*)\s*\[(.*)\]$/)
									{
										$Key   = $1;
										$Value = $2;
										#print "key = ($Key)\n";
										#print "val = ($Value)\n";
									}
									else
									{
										($Key, $Value) = split(/\s+/, $_);
									}
								$LinkMap{$Key} = $Value;
							}
					} 
				close (LOCALFILE);
			}
		# Use Shared LinkMap.dat...
		else
			{
				print "<!-- ERROR:  No Specific LM Found -- Path = ($CurrentPath) LM = ($specific_LM_key) Translated = ($LinkMap{$specific_LM_key})-->\n" if $Debug eq "1";
				$LinkMap{'CONFIG'} = 'ERROR';
				print "<!-- Load_LinkMap could not open Specific LM at $LINKMAP: $! -->\n" if $Debug eq "1";
			}
#		&Print_LinkMap($Debug, %LinkMap);
		return %LinkMap;

	}# End sub Load_LinkMap
	
#  &Load_Both_LinkMaps ("1"); "1" if debug "0" if not. 
#  This subroutine loads the key value pairs into a hash table
#  Returns a the hash table containing the 
#   Key/Value pairs of lth LinkMap.dat file. 
sub Load_Both_LinkMaps
	{
		# File::Basename module is used to parse the path that is passed to Load_LinkMap
		use File::Basename;
			
		(my $LinkMapPath, my $Debug) = @_;
		print "<!-- sub Load_Both_LinkMaps($LinkMapPath, $Debug) -->\n" if $Debug eq "1";

		# You select the syntax via the routine fileparse_set_fstype()...
		fileparse_set_fstype("MSWin32");
		# returns the directory portion of the input file...
		my $CurrentPath	= dirname($LinkMapPath);
	   $CurrentPath	=~ s%\\%/%g;


		if($CurrentPath =~ m%/admin/cgi-bin$%)
		{
		   $CurrentPath		=~ s%admin/cgi-bin%%;
		}
		elsif($CurrentPath =~ m%/cgi-bin$%)
		{
		   $CurrentPath		=~ s%cgi-bin%%;
		}
		else
		{
			print "Load_Both_LinkMaps ERROR: this should never happen!";
			return -1;
		}

		my $CurrentRoot		= $CurrentPath;
		   $CurrentRoot		=~ s%//%/%g;
		   $CurrentRoot		=~ s%/$%%;
		print "<!-- Load_Both_LinkMaps currentRoot =  $CurrentRoot -->\n" if $Debug eq "1";

		my $LINKMAP_ADMIN	= "$CurrentRoot/admin/cgi-bin/LinkMap.dat";
		my $LINKMAP			= "$CurrentRoot/cgi-bin/LinkMap.dat";
		
		my $opened  = open (LOCALFILE, $LINKMAP_ADMIN);	
			
		if ($opened)
			{
				$LinkMap{'ADMIN_CONFIG'} = $CurrentRoot . "/admin/cgi-bin";
				$LinkMap{'ADMIN_LINKMAP_FILE'} = $LINKMAP_ADMIN;
				while (<LOCALFILE>) 
					{
						if(m/^#/ || m/^\s/)
							{
								next;
							}
						else
							{
								(my $Key, my $Value) = split(/\s+/, $_);

								$LinkMap{"ADMIN_" . $Key} = $Value;
							}
					} 
					close (LOCALFILE);

					my $opened  = open (LOCALFILE, $LINKMAP);	
						
					if ($opened)
						{
							$LinkMap{'CONFIG'} = $CurrentRoot . "/cgi-bin";
							$LinkMap{'LINKMAP_FILE'} = $LINKMAP;
							while (<LOCALFILE>) 
								{
									if(m/^#/ || m/^\s/)
										{
											next;
										}
									else
										{
											(my $Key, my $Value) = split(/\s+/, $_);
											$LinkMap{$Key} = $Value;
										}
								} 
							close (LOCALFILE);
							return %LinkMap;
						}
					else
						{
							$LinkMap{'CONFIG'} = 'ERROR';
							print "<!-- Load_Both_LinkMaps could not open $LINKMAP: $! -->\n" if $Debug eq "1";
							return %LinkMap;
						}
			}
		else
			{
				$LinkMap{'CONFIG'} = 'ERROR';
				print "<!-- Load_Both_LinkMaps could not open $LINKMAP: $! -->\n" if $Debug eq "1";
				return %LinkMap;
			}
	}# End sub Load_Both_LinkMaps

	
	
#  &Print_LinkMap ("1", "%Map"); 
#     Param 1: "1" if debug "0" if not. 
#     Param 2: "%Map" Hash table to print 
#  This subroutine prints the key value pairs
#  Returns 1 for success -1 for error 
sub Print_LinkMap
	{
		(my $Debug, my %Map) = @_;
		
		if ($Map{'CONFIG'} eq 'ERROR')
			{
				print "<!-- Print_LinkMap Error trying to print LinkMap -->\n" if $Debug eq "1";
				return -1;
			}
		else
			{
                while( (my $Key, my $Value) = each(%Map) )
                {
                   print "<FONT color=\"blue\">$Key</FONT> <FONT color=\"red\">$Value</FONT><BR>\n";
                }                
				return 1;
			}
	}# End sub Load_LinkMap
	

#  &BackUp_LinkMaps ("1", "%Map"); 
#     Param 1: "1" if debug "0" if not. 
#     Param 2: "%Map" Hash table to print 
#  This subroutine makes an exact backup of 
#   the current LinkMap.dat files as:
#		/cgi-bin/LinkMap.bak
#		/admin/cgi-bin/LinkMap.bak
#  Returns 1 for success -1 for error 
sub BackUp_LinkMaps
	{
		(my $Debug, my %Map) = @_;
	
		if ($Map{'CONFIG'} eq 'ERROR' || $Map{'ADMIN_CONFIG'} eq 'ERROR')
			{
				print "<!-- BackUp_LinkMaps Error trying to back up LinkMap.dat files: Map not initialized. -->\n";
				return -1;
			}
		else
			{
				my $LinkMapFileBak	= "$Map{'CONFIG'}/LinkMap.bak";	
				my $LinkMapFileBak_Admin = "$Map{'ADMIN_CONFIG'}/LinkMap.bak";	
					
				my $opened	= open (LINKMAPFILE, $Map{'ADMIN_LINKMAP_FILE'});	
					
				if ($opened)
					{
						my $opened	= open (LINKMAPFILE_BAK, ">$LinkMapFileBak_Admin");	
						if ($opened)
							{
								while (<LINKMAPFILE>) 
									{
										print LINKMAPFILE_BAK $_;
									} 
								close(LINKMAPFILE_BAK);

								my $opened	= open (LINKMAPFILE, $Map{'LINKMAP_FILE'});	
								if ($opened)
									{
										my $opened	= open (LINKMAPFILE_BAK, ">$LinkMapFileBak");	
										if ($opened)
											{
												while (<LINKMAPFILE>) 
													{
														print LINKMAPFILE_BAK $_;
													} 
												close(LINKMAPFILE_BAK);
												return 1;
											}
										else
											{
												print "<!-- BackUp_LinkMaps could not open $LinkMapFileBak: $! -->\n";
												return -1;
											}
										close(LINKMAPFILE);
									}
								else
									{
										print "<!-- BackUp_LinkMaps could not open $Map{'LINKMAP_FILE'}: $! -->\n";
										return -1;
									}
							}
						else
							{
								print "<!-- BackUp_LinkMaps could not open $LinkMapFileBak_Admin: $! -->\n";
								return -1;
							}
						close(LINKMAPFILE);
					}
				else
					{
						print "<!-- BackUp_LinkMaps could not open $Map{'ADMIN_LINKMAP_FILE'}: $! -->\n";
						return -1;
					}
			}
	}# End sub BackUp_LinkMaps
	

#  &Restore_LinkMaps_From_Backups ("1", "%Map"); 
#     Param 1: "1" if debug "0" if not. 
#     Param 2: "%Map" Hash table to print 
#  This subroutine uses the contents ot LinkMap.bak
#   to overwrite the current contents of LinkMap.dat
#  Returns 1 for success -1 for error 

################ Important !!!!!!!!!!!
# this does not work...
# for some reason it will not let me login to the dir when restoring from .bak files????
##########################################
sub Restore_LinkMaps_From_Backups
	{
		(my $Debug, my %Map) = @_;
	
		if ($Map{'CONFIG'} eq 'ERROR' || $Map{'ADMIN_CONFIG'} eq 'ERROR')
			{
				print "<!-- Restore_LinkMaps_From_Backups Error trying to restore LinkMap.dat files from LinkMap.bak files: Map not initialized. -->\n";
				return -1;
			}
		else
			{
				my $LinkMapFileBak	= "$Map{'CONFIG'}/LinkMap.bak";	
				my $LinkMapFileBak_Admin = "$Map{'ADMIN_CONFIG'}/LinkMap.bak";	
					
				my $opened	= open (LINKMAPFILE_BAK, $LinkMapFileBak);						
				if ($opened)
					{
						my $opened	= open (LINKMAPFILE, $Map{'LINKMAP_FILE'});	
						if ($opened)
							{
								while (<LINKMAPFILE_BAK>) 
									{
										print LINKMAPFILE $_;
									} 
								close(LINKMAPFILE);
								my $opened	= open (LINKMAPFILE_BAK, $LinkMapFileBak_Admin);						
								if ($opened)
									{
										my $opened	= open (LINKMAPFILE, $Map{'ADMIN_LINKMAP_FILE'});	
										if ($opened)
											{
												while (<LINKMAPFILE_BAK>) 
													{
														print LINKMAPFILE $_;
													} 
												close(LINKMAPFILE);
												return 1;
											}
										else
											{
												print "<!-- Restore_LinkMaps_From_Backups could not open $Map{'ADMIN_LINKMAP_FILE'}: $! -->\n";
												return -1;
											}
										close(LINKMAPFILE_BAK);
									}
								else
									{
										print "<!-- Restore_LinkMaps_From_Backups could not open $LinkMapFileBak_Admin: $! -->\n";
										return -1;
									}
							}
						else
							{
								print "<!-- Restore_LinkMaps_From_Backups could not open $Map{'LINKMAP_FILE'}: $! -->\n";
								return -1;
							}
						close(LINKMAPFILE_BAK);
					}
				else
					{
						print "<!-- Restore_LinkMaps_From_Backups could not open $LinkMapFileBak: $! -->\n";
						return -1;
					}
			}
	}# End sub Restore_LinkMaps_From_Backups
	


#  &Overwrite_Both_LinkMaps ("1", "%Map"); 
#     Param 1: "1" if debug "0" if not. 
#     Param 2: "%Map" Hash table to print 
#  This subroutine overwrites the current LinkMap.dat file
#  Returns 1 for success -1 for error 
sub Overwrite_Both_LinkMaps
	{
		(my $Debug, my %Map) = @_;
		if ($Map{'CONFIG'} eq 'ERROR')
			{
				print "<!-- Overwrite_Both_LinkMaps Error LinkMap not currently loaded properly -->\n" if $Debug eq "1";
				return -1;
			}
		else
			{
			# Parse the current date...
			(my $sec, my $min, my $hour, my $mday, my $mon, my $year, my $wday, my $yday, my $isdst) = localtime(time);
			 my $TimeStamp = ($mon+1)  . "/" . $mday  . "/" . ($year+1900) . " " . $hour  . ":" . $min . ":" . $sec;

				my $opened  = open ( LOCALFILE, ">$Map{'ADMIN_LINKMAP_FILE'}" );	
				if ($opened)
					{
						print LOCALFILE "################################## ADMIN ######################################\n";
						print LOCALFILE "#                      LinkMap.dat Usage Directions\n";
						print LOCALFILE "#\n";
						print LOCALFILE "#  1. LinkMap.dat is a configuration file containing Key/Value pairs\n";
						print LOCALFILE "#  2. Left  column = Key\n";
						print LOCALFILE "#  3. Right column = Value\n";
						print LOCALFILE "#  4. No spaces are allowed in neither Keys nor Values\n";
						print LOCALFILE "#  5. Lines beginning with the Number Sign (#) are ignored\n";
						print LOCALFILE "#  6. Each group of Key/Value pairs should have a title decribing its purpose\n";
						print LOCALFILE "#\n";
						print LOCALFILE "#			Last updated on: $TimeStamp\n";
						print LOCALFILE "#\n";
						print LOCALFILE "###############################################################################\n";
						print LOCALFILE "\n";
						print LOCALFILE "# KEY			VALUE\n";
						print LOCALFILE "\n";
						print LOCALFILE "######### Debugging #############\n";
						print LOCALFILE "SYSTEM			$Map{'WHICH_CONNECTIONS'}_Cgi_Admin\n";
						print LOCALFILE "\n";
						print LOCALFILE "######### Database Login #############\n";
						print LOCALFILE "DBNAME			$Map{'DBNAME'}\n";
						print LOCALFILE "DBUSER			$Map{'ADMIN_DBUSER'}\n";
						print LOCALFILE "DBPWD			$Map{'ADMIN_DBPWD'}\n";
						print LOCALFILE "\n";
						print LOCALFILE "######### URLs #############\n";
						print LOCALFILE "ROOT			$Map{'ROOT'}\n";
						print LOCALFILE "IMAGES			$Map{'IMAGES'}\n";
						print LOCALFILE "PICTURES		$Map{'PICTURES'}\n";
						print LOCALFILE "CGIBIN			$Map{'CGIBIN'}\n";
						print LOCALFILE "\n";
						print LOCALFILE "######### Web Page Colors #############\n";
						print LOCALFILE "HTML_POPUP_BGCOLOR	$Map{'HTML_POPUP_BGCOLOR'}\n";
						print LOCALFILE "HTML_HEADFOOT_BGCOLOR	$Map{'HTML_HEADFOOT_BGCOLOR'}\n";
						print LOCALFILE "HTML_NAV_BGCOLOR	$Map{'HTML_NAV_BGCOLOR'}\n";
						print LOCALFILE "HTML_BODY_BGCOLOR	$Map{'HTML_BODY_BGCOLOR'}\n";
						print LOCALFILE "\n";
						print LOCALFILE "INBOX_COLOR_1		$Map{'INBOX_COLOR_1'}\n";
						print LOCALFILE "INBOX_COLOR_2		$Map{'INBOX_COLOR_2'}\n";
						print LOCALFILE "OUTBOX_COLOR_1		$Map{'OUTBOX_COLOR_1'}\n";
						print LOCALFILE "OUTBOX_COLOR_2		$Map{'OUTBOX_COLOR_2'}\n";
						print LOCALFILE "\n";
						print LOCALFILE "######### Web Page Text #############\n";
						print LOCALFILE "HTML_TITLE 		$Map{'HTML_TITLE'}\n";
						print LOCALFILE "HTML_HEAD		$Map{'HTML_HEAD'}\n";
						print LOCALFILE "COPYRIGHT_YEAR		$Map{'COPYRIGHT_YEAR'}\n";
						print LOCALFILE "EMAIL			$Map{'EMAIL'}\n";
						print LOCALFILE "WHICH_CONNECTIONS 	$Map{'WHICH_CONNECTIONS'}\n";
						print LOCALFILE "\n";
						print LOCALFILE "######### Icon Names #############\n";
						print LOCALFILE "FIRSTARROW		$Map{'FIRSTARROW'}\n";
						print LOCALFILE "NEXTARROW		$Map{'NEXTARROW'}\n";
						print LOCALFILE "PREVIOUSARROW		$Map{'PREVIOUSARROW'}\n";
						print LOCALFILE "LASTARROW		$Map{'LASTARROW'}\n";
						print LOCALFILE "\n";
						print LOCALFILE "LOGO			$Map{'LOGO'}\n";
						print LOCALFILE "FOOTER			$Map{'FOOTER'}\n";
						print LOCALFILE "\n";
						print LOCALFILE "NO_PIC_SMALL		$Map{'NO_PIC_SMALL'}\n";
						print LOCALFILE "NO_PIC_MEDIUM		$Map{'NO_PIC_MEDIUM'}\n";
						print LOCALFILE "NO_PIC_LARGE		$Map{'NO_PIC_LARGE'}\n";
						print LOCALFILE "\n";
						print LOCALFILE "######### Blat #############\n";
						print LOCALFILE "SMTP_HOST		$Map{'SMTP_HOST'}\n";
						print LOCALFILE "BLAT_PATH		$Map{'BLAT_PATH'}\n";
						print LOCALFILE "\n";
						print LOCALFILE "######### Membership Prices #############\n";
						print LOCALFILE "PRICE_ONE		$Map{'PRICE_ONE'}\n";
						print LOCALFILE "\n";
						print LOCALFILE "######### Local Paths #############\n";
						print LOCALFILE "LOG_FOLDER		$Map{'LOG_FOLDER'}\n";
						print LOCALFILE "PICTURES_FOLDER		$Map{'PICTURES_FOLDER'}\n";
						print LOCALFILE "\n";
						print LOCALFILE "######### Flagged Words #############\n";
						for(my $j=1; $j<=$Map{'ADMIN_NUMBER_OF_WORDS_TO_FLAG'}; $j++)
							{
								my $LM_KEY = "ADMIN_WORD_TO_FLAG_$j";
								print LOCALFILE "WORD_TO_FLAG_" . $j . "		$Map{\"$LM_KEY\"}\n";
							}
						print LOCALFILE "NUMBER_OF_WORDS_TO_FLAG	$Map{'ADMIN_NUMBER_OF_WORDS_TO_FLAG'}\n";
						print LOCALFILE "\n";
						
						print LOCALFILE "######### Mail Drop Down Lists #############\n";
						for(my $j=1; $j<=$Map{'ADMIN_NUMBER_OF_MAIL_SENT_FROM'}; $j++)
							{
								my $LM_KEY = "ADMIN_ADMIN_MAIL_SENT_FROM_$j";
								print LOCALFILE "ADMIN_MAIL_SENT_FROM_" . $j . "		$Map{\"$LM_KEY\"}\n";
							}
						print LOCALFILE "NUMBER_OF_MAIL_SENT_FROM	$Map{'ADMIN_NUMBER_OF_MAIL_SENT_FROM'}\n";
						print LOCALFILE "\n";
						for(my $j=1; $j<=$Map{'ADMIN_NUMBER_OF_MAIL_SENT_TO'}; $j++)
							{
								my $LM_KEY = "ADMIN_ADMIN_MAIL_SENT_TO_$j";
								print LOCALFILE "ADMIN_MAIL_SENT_TO_" . $j . "		$Map{\"$LM_KEY\"}\n";
							}
						print LOCALFILE "NUMBER_OF_MAIL_SENT_TO		$Map{'ADMIN_NUMBER_OF_MAIL_SENT_TO'}\n";
						close (LOCALFILE);
							
						my $opened  = open ( LOCALFILE, ">$Map{'LINKMAP_FILE'}" );	
						if ($opened)
							{
								print LOCALFILE "################################## USER ######################################\n";
								print LOCALFILE "#                      LinkMap.dat Usage Directions\n";
								print LOCALFILE "#\n";
								print LOCALFILE "#  1. LinkMap.dat is a configuration file containing Key/Value pairs\n";
								print LOCALFILE "#  2. Left  column = Key\n";
								print LOCALFILE "#  3. Right column = Value\n";
								print LOCALFILE "#  4. No spaces are allowed in neither Keys nor Values\n";
								print LOCALFILE "#  5. Lines beginning with the Number Sign (#) are ignored\n";
								print LOCALFILE "#  6. Each group of Key/Value pairs should have a title decribing its purpose\n";
								print LOCALFILE "#\n";
								print LOCALFILE "#			Last updated on: $TimeStamp\n";
								print LOCALFILE "#\n";
								print LOCALFILE "###############################################################################\n";
								print LOCALFILE "\n";
								print LOCALFILE "# KEY			VALUE\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### Debugging #############\n";
								print LOCALFILE "SYSTEM			$Map{'WHICH_CONNECTIONS'}_Cgi_User\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### Database Login #############\n";
								print LOCALFILE "DBNAME			$Map{'DBNAME'}\n";
								print LOCALFILE "DBUSER			$Map{'DBUSER'}\n";
								print LOCALFILE "DBPWD			$Map{'DBPWD'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### URLs #############\n";
								print LOCALFILE "ROOT			$Map{'ROOT'}\n";
								print LOCALFILE "IMAGES			$Map{'IMAGES'}\n";
								print LOCALFILE "PICTURES		$Map{'PICTURES'}\n";
								print LOCALFILE "CGIBIN			$Map{'CGIBIN'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### CSS #############\n";
								print LOCALFILE "STYLE_SHEET	$Map{'STYLE_SHEET'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### Web Page Colors #############\n";
								print LOCALFILE "HTML_POPUP_BGCOLOR	$Map{'HTML_POPUP_BGCOLOR'}\n";
								print LOCALFILE "HTML_HEADFOOT_BGCOLOR	$Map{'HTML_HEADFOOT_BGCOLOR'}\n";
								print LOCALFILE "HTML_NAV_BGCOLOR	$Map{'HTML_NAV_BGCOLOR'}\n";
								print LOCALFILE "HTML_BODY_BGCOLOR	$Map{'HTML_BODY_BGCOLOR'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "INBOX_COLOR_1		$Map{'INBOX_COLOR_1'}\n";
								print LOCALFILE "INBOX_COLOR_2		$Map{'INBOX_COLOR_2'}\n";
								print LOCALFILE "OUTBOX_COLOR_1		$Map{'OUTBOX_COLOR_1'}\n";
								print LOCALFILE "OUTBOX_COLOR_2		$Map{'OUTBOX_COLOR_2'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### Web Page Text #############\n";
								print LOCALFILE "HTML_TITLE 		$Map{'HTML_TITLE'}\n";
								print LOCALFILE "HTML_HEAD		$Map{'HTML_HEAD'}\n";
								print LOCALFILE "COPYRIGHT_YEAR		$Map{'COPYRIGHT_YEAR'}\n";
								print LOCALFILE "EMAIL			$Map{'EMAIL'}\n";
								print LOCALFILE "WHICH_CONNECTIONS 	$Map{'WHICH_CONNECTIONS'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### Icon Names #############\n";
								print LOCALFILE "FIRSTARROW		$Map{'FIRSTARROW'}\n";
								print LOCALFILE "NEXTARROW		$Map{'NEXTARROW'}\n";
								print LOCALFILE "PREVIOUSARROW		$Map{'PREVIOUSARROW'}\n";
								print LOCALFILE "LASTARROW		$Map{'LASTARROW'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "LOGO			$Map{'LOGO'}\n";
								print LOCALFILE "FOOTER			$Map{'FOOTER'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "NO_PIC_SMALL		$Map{'NO_PIC_SMALL'}\n";
								print LOCALFILE "NO_PIC_MEDIUM		$Map{'NO_PIC_MEDIUM'}\n";
								print LOCALFILE "NO_PIC_LARGE		$Map{'NO_PIC_LARGE'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "EMAILSYMBOL		$Map{'EMAILSYMBOL'}\n";
								print LOCALFILE "DELETSYMBOL		$Map{'DELETSYMBOL'}\n";
								print LOCALFILE "BOOKMARKSYMBOL		$Map{'BOOKMARKSYMBOL'}\n";
								print LOCALFILE "UNREADSYMBOL		$Map{'UNREADSYMBOL'}\n";
								print LOCALFILE "LINESYMBOL		$Map{'LINESYMBOL'}\n";
								print LOCALFILE "SPACESYMBOL		$Map{'SPACESYMBOL'}\n";
								print LOCALFILE "PROCESSINGSYMBOL	$Map{'PROCESSINGSYMBOL'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "BECOME_PREMIUM_MEMBER	$Map{'BECOME_PREMIUM_MEMBER'}\n";
								print LOCALFILE "BECOME_MEMBER_GIF	$Map{'BECOME_MEMBER_GIF'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### Blat #############\n";
								print LOCALFILE "SMTP_HOST		$Map{'SMTP_HOST'}\n";
								print LOCALFILE "BLAT_PATH		$Map{'BLAT_PATH'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### CC Processing Test/Live Switch #############\n";
								print LOCALFILE "# 0 = Live\n";
								print LOCALFILE "# 1 = Test\n";
								print LOCALFILE "AUTHORIZE_TEST_MODE	$Map{'AUTHORIZE_TEST_MODE'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### Membership Prices #############\n";
								print LOCALFILE "PRICE_ONE		$Map{'PRICE_ONE'}\n";
								print LOCALFILE "PRICE_THREE		$Map{'PRICE_THREE'}\n";
								print LOCALFILE "PRICE_TWELVE		$Map{'PRICE_TWELVE'}\n";
								print LOCALFILE "PRICE_LIFETIME		$Map{'PRICE_LIFETIME'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### Local Paths #############\n";
								print LOCALFILE "LOG_FOLDER		$Map{'LOG_FOLDER'}\n";
								print LOCALFILE "PICTURES_FOLDER		$Map{'PICTURES_FOLDER'}\n";
								print LOCALFILE "DOS_PICTURES_FOLDER	$Map{'DOS_PICTURES_FOLDER'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### Advertising #############\n";
								print LOCALFILE "ADV_CGIBIN		$Map{'ADV_CGIBIN'}\n";
								print LOCALFILE "#Program name used to retrieve text ads...\n";
								print LOCALFILE "ADV_RETRIEVE		$Map{'ADV_RETRIEVE'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "ADV_HOST_UNIQUE_ID	$Map{'ADV_HOST_UNIQUE_ID'}\n";
								print LOCALFILE "\n";
								print LOCALFILE "######### Rotating Gifs (Not used) #############\n";
								#                                print LOCALFILE "#MALE			$Map{'MALE'}\n";
								#                                print LOCALFILE "#MNAME			$Map{'MNAME'}\n";
								#                                print LOCALFILE "#FEMALE			$Map{'FEMALE'}\n";
								#                                print LOCALFILE "#FNAME			$Map{'FNAME'}\n";
								close (LOCALFILE);
								return 1;
							}
						else
							{
								print "<!-- Overwrite_Both_LinkMaps SUCCESS: Overwrote $Map{'ADMIN_LINKMAP_FILE'} but errored.  See below... -->\n" if $Debug eq "1";
								print "<!-- Overwrite_Both_LinkMaps could not overwrite current $Map{'LINKMAP_FILE'}: $! -->\n" if $Debug eq "1";
								return -1;
							}
					}
				else
					{
						print "<!-- Overwrite_Both_LinkMaps could not overwrite current $Map{'ADMIN_LINKMAP_FILE'}: $! -->\n" if $Debug eq "1";
						print "<!-- Overwrite_Both_LinkMaps could not overwrite current $Map{'LINKMAP_FILE'}.  See error above. -->\n" if $Debug eq "1";
						return -1;
					}
			}
	}# End sub Overwrite_Both_LinkMaps

sub Print_Error
	{
		my($Message, $Debug, %Map) = @_;
		print " <HEAD>\n";
		print "    <TITLE>\n";
		print "      I/O Error\n";
		print "    </TITLE>\n";
		print "<SCRIPT LANGUAGE=\"javascript\">\n";
		print "<!--\n";
		print "function Back(jump)";
		print "{\n";
		print "   window.history.go(jump)\n";
		print "}\n";
		print "  //-->\n";
		print "  </SCRIPT>\n";
		print "  </HEAD>\n";		 
		print "  <BODY bgcolor=\"$Map{'HTML_POPUP_BGCOLOR'}\">\n";
		print "<p>$Message</p>\n" ;
		print "<FORM>\n";
		print "<INPUT TYPE=\"SUBMIT\" Value=\"Back\" onClick=\"Back(-1)\">\n";
		print "</FORM>\n";		
		print "  </BODY><!-- End Body -->\n";
			
		#End HTML...
		print "</HTML>\n";
		exit 0;
	} # End Print_Error

sub Print_Error_Clean
	{
		my($Message, $Debug, %Map) = @_;
        print "        <TABLE align=\"center\" border=\"0\" cellspacing=\"0\" width=\"50%\" bgcolor=\"white\">\n";
        print "          <TR>\n";
        print "            <TD>\n";
        print "              <IMG src=\"$Map{'IMAGES'}/error.gif\" alt=\"Error\" border=\"0\">\n";
        print "            </TD>\n";
        print "            <TD>\n";
        print "              <H3>\n";
        print "                <FONT face=\"Arial, Helvetica, sans-serif\" color=\"black\">Problem(s) completing your request:</FONT>\n";
        print "              </H3>\n";
        print "              <HR size=\"1\" noshade>\n";
        print "              <UL>\n";
        print "                <LI>\n";
        print "                  <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\" color=\"black\">$Message</FONT>\n";
        print "                </LI>\n";
        print "              </UL>\n";
        print "              <HR size=\"1\" noshade>\n";
        print "            </TD>\n";
        print "          </TR>\n";
		print "          <TR>\n";
		print "            <TD colspan=\"2\" align=\"center\">\n";
		print "				<INPUT TYPE=\"SUBMIT\" Value=\"Back\" onClick=\"Back(-1)\">\n";
		print "            </TD>\n";
		print "          </TR>\n";
        print "        </TABLE>\n";
		print "<SCRIPT LANGUAGE=\"javascript\">\n";
		print "<!--\n";
		print "function Back(jump)";
		print "{\n";
		print "   window.history.go(jump)\n";
		print "}\n";
		print "//-->\n";
		print "</SCRIPT>\n";
		exit 0;	
		#End HTML...
		print "</HTML>\n";
	} # End Print_Error

sub Print_HTML
	{
		my($Message, $Debug, %Map) = @_;
			
		print "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\n";
		print "<HTML>\n";
		print "  <HEAD>\n";
		print "    <TITLE>\n";
		print "      $Map{'HTML_TITLE'}\n";
		print "    </TITLE>\n";
		print "  </HEAD>\n";
		print "  <!-- Begin Entire Body -->\n";
		print "  <BODY>\n";
		print "    <TABLE border=\"0\" cellpadding=\"3\" cellspacing=\"4\" width=\"700\">\n";
		print "      <!-- Begin Header Row -->\n";
		print "      <TR>\n";
		print "        <TD colspan=\"2\" bgcolor=$Map{'HTML_HEADFOOT_BGCOLOR'}>\n";
		print "          <IMG alt=\"$Map{'WHICH_CONNECTIONS'} dot com Logo!\" src=\"$Map{'IMAGES'}/$Map{'LOGO'}\" border=\"0\">\n";
		print "        </TD>\n";
		print "      </TR>\n";
		print "      <!-- End Header Row -->\n";
		print "      <TR>\n";
		print "        <TD bgcolor=$Map{'HTML_NAV_BGCOLOR'} valign=\"top\" width=\"150\" height=\"424\">\n";
		print "          <TABLE border=\"0\" cellpadding=\"3\" cellspacing=\"3\" width=\"150\">\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"GenHome.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Member Home</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"GenInbox.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Inbox</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"GenOutbox.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Outbox</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"../AdvancedSearch.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Advanced Search</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"../SimpleSearch.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Simple Search</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"../LogOut.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">LogOut</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"mailto:admin\@$Map{'WHICH_CONNECTIONS'}.com\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Contact us</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <DIV align=\"left\">\n";
		print "                  <TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n";
		print "                    <TR>\n";
		print "                      <TD>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                  </TABLE>\n";
		print "                </DIV>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "          </TABLE>\n";
		print "          <!-- End Navigation Table -->\n";
		print "        </TD>\n";
		print "        <!-- End Navigation Table Data Cell--><!-- Begin Main Data Cell -->\n";
		print "        <TD width=\"577\" bgcolor=$Map{'HTML_BODY_BGCOLOR'} height=\"500\" valign=\"top\">\n";
		print "          $Message\n";
		print "          <BR>\n";
		print "           \n";
		print "          <FORM>\n";
		print "          <P align=\"center\" style=\"line-height: 100%\">\n";
		print "             <INPUT type=\"BUTTON\" value=\"Back\" onclick=\"Back(-1)\">\n";
		print "          </P>\n";
		print "          </FORM>\n";
		print "        </TD>\n";
		print "        <!-- End Main Data Cell -->\n";
		print "      </TR>\n";
		print "      <!-- End Navigation and Main Row --><!-- Begin Copyright Row -->\n";
		print "      <TR>\n";
		print "        <TD colspan=\"2\" bgcolor=$Map{'HTML_HEADFOOT_BGCOLOR'}>\n";
		print "          <IMG alt=\"$Map{'WHICH_CONNECTIONS'} dot com Footer!\" src=\"$Map{'IMAGES'}/$Map{'FOOTER'}\" border=\"0\">\n";
		print "        </TD>\n";
#		print "        <TD width=\"659\" colspan=\"2\" bgcolor=$Map{'HTML_HEADFOOT_BGCOLOR'} height=\"23\" valign=\"middle\">\n";
#		print "          <FONT size=\"4\">$Map{'WHICH_CONNECTIONS'}.com</FONT>\n";
#		print "          <BR>\n";
#		print "           Copyright &copy; $Map{'COPYRIGHT_YEAR'} $Map{'WHICH_CONNECTIONS'}.com. All rights reserved.\n";
#		print "        </TD>\n";
		print "      </TR>\n";
		print "      <!-- End Copyright Row -->\n";
		print "    </TABLE>\n";
		print "    <!-- End Main Table --><!-- End Entire Body -->\n";
		print "  </BODY>\n";
		print "<SCRIPT LANGUAGE=\"javascript\">\n";
		print "<!--\n";
		print "function Back(jump)";
		print "{\n";
		print "   window.history.go(jump)\n";
		print "}\n";
		print "//-->\n";
		print "</SCRIPT>\n";		
		print "</HTML>\n";
		print "\n";
		exit 0;
	} # End Print_HTML

sub Afl_Print_HTML_Top
	{
		my $IsUserLoggedIn	= shift;
		my $ProgramName		= shift;
		my $Debug			= shift;
		my $MapHash			= shift;

        print "<HTML>\n";
        print "  <HEAD>\n";
        print "    <TITLE>\n";
        print "      StrategicAffiliates.com\n";
        print "    </TITLE>\n";
        print "    <LINK href=\"" . $$MapHash{'ROOT'} . "/css/" . $$MapHash{'STYLE_SHEET'} . "\" rel=\"stylesheet\" type=\"text/css\">\n";
		print "	   <SCRIPT language=\"javascript\" src=\"" . $$MapHash{'ROOT'} . "/JavaScript/MyFunctions.js\"></SCRIPT>\n";
        print "  </HEAD>\n";
        print "  <BODY>\n";
        print "    <TABLE width=\"800\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n";
        print "      <TR>\n";
        print "        <TD colspan=\"3\" class=\"BGHeader\">\n";
        print "          <IMG src=\"" . $$MapHash{'IMAGES'} . "/" . $$MapHash{'LOGO'} . "\" alt=\"Logo\" border=\"0\">\n";
        print "        </TD>\n";
        print "      </TR>\n";
        print "      <TR bgcolor=\"#000000\">\n";
        print "        <TD height=\"2\" colspan=\"3\"><IMG src=\"" . $$MapHash{'IMAGES'} . "/spacer.gif\" width=\"800\" height=\"2\"></TD>\n";
        print "      </TR>\n";
        print "      <TR class=\"BGLeftColumn\">\n";
        print "        <TD height=\"19\" colspan=\"3\">\n";
        print "          <TABLE border=\"0\" cellspacing=\"0\" cellpadding=\"4\">\n";
        print "            <TR>\n";
		if($$IsUserLoggedIn ne "1")
			{
				print "              <TD>\n";
				print "                <A href=\"" . $$MapHash{'ROOT'} . "/Afl_LogIn.html\" class=\"NavText\">Login</A> |\n";
				print "              </TD>\n";
				print "              <TD>\n";
				print "                <A href=\"" . $$MapHash{'ROOT'} . "/JoinNow.html\" class=\"NavText\">Join Now</A> |\n";
				print "              </TD>\n";
				print "              <TD>\n";
				print "                <A href=\"" . $$MapHash{'ROOT'} . "/HowItWorks.html\" class=\"NavText\">How It Works</A> |\n";
				print "              </TD>\n";
			}
		else
			{
				print "              <TD>\n";
				print "                <A href=\"" . $$MapHash{'CGIBIN'} . "/Afl_AccountDetails.cgi\" class=\"NavText\">Manage Account</A> |\n";
				print "              </TD>\n";
				print "              <TD>\n";
				print "                <A href=\"" . $$MapHash{'CGIBIN'} . "/Afl_Statistics.cgi\" class=\"NavText\">View Statistics</A> |\n";
				print "              </TD>\n";
				print "              <TD>\n";
				print "                <A href=\"" . $$MapHash{'CGIBIN'} . "/Afl_GenBannerChoices.cgi\" class=\"NavText\">Get Banner Ads</A> |\n";
				print "              </TD>\n";
				print "              <TD>\n";
				print "                <A href=\"" . $$MapHash{'CGIBIN'} . "/Afl_GenAffiliateChoices.cgi\" class=\"NavText\">Partnerships</A> |\n";
				print "              </TD>\n";
				print "              <TD>\n";
				print "                <A href=\"" . $$MapHash{'ROOT'} . "/Afl_LogOut.html\" class=\"NavText\">Log Out</A> |\n";
				print "              </TD>\n";
			}
		print "              <TD>\n";
		print "                <A href=\"mailto:" . $$MapHash{'EMAIL'} . "\" class=\"NavText\">Contact Us</A> |\n";
		print "              </TD>\n";
        print "            </TR>\n";
        print "          </TABLE>\n";
        print "        </TD>\n";
        print "      </TR>\n";
        print "      <TR bgcolor=\"#000000\">\n";
        print "        <TD height=\"2\" colspan=\"3\"><IMG src=\"" . $$MapHash{'IMAGES'} . "/spacer.gif\" width=\"800\" height=\"2\"></TD>\n";
        print "      </TR>\n";
        print "      <TR>\n";
        print "        <TD width=\"1\" valign=\"top\" class=\"BGLeftColumn\"><IMG src=\"" . $$MapHash{'IMAGES'} . "/spacer.gif\" width=\"1\" height=\"5\"></TD>\n";
        print "        <TD width=\"798\" valign=\"top\">\n";
	} # End Print_HTML


sub Afl_Print_HTML_Bottom
	{
		my $ProgramName	= shift;
		my $Debug		= shift;
		my $MapHash		= shift;
			
        print "        </TD>\n";
        print "        <TD width=\"1\" valign=\"top\" class=\"BGLeftColumn\"><IMG src=\"" . $$MapHash{'IMAGES'} . "/spacer.gif\" width=\"1\" height=\"5\"></TD>\n";
		print "      </TR>\n";
		print "      <TR>\n";

		if($$MapHash{'FOOTER_ALL_TEXT'})
			{
				print "          " . $$MapHash{'FOOTER_ALL_TEXT'} . "\n";
			}
		else
			{
				print "        <TD colspan=\"3\" class=\"BGFooter\">\n";
				print "          <IMG src=\"" . $$MapHash{'IMAGES'} . "/" . $$MapHash{'FOOTER'} . "\" alt=\"footer\" border=\"0\">\n";
				print "        </TD>\n";
			}

        print "      </TR>\n";
        print "    </TABLE>\n";
        print "  </BODY>\n";
	} # End Print_HTML

sub Print_HTML_Top
	{
		my($ProgramName, $Debug, %Map) = @_;
			
#		print "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\n";
#		print "<HTML>\n";
		print "  <HEAD>\n";
		print "    <TITLE>\n";
		print "      $Map{'HTML_TITLE'}\n";
		print "    </TITLE>\n";
		print "    <LINK href=\"$Map{'ROOT'}/css/$Map{'STYLE_SHEET'}\" rel=\"stylesheet\" type=\"text/css\">";
		print "  </HEAD>\n";
		print "  <!-- Begin Entire Body -->\n";
		print "  <BODY>\n";
		print "    <TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"4\" width=\"700\">\n";
		print "      <!-- Begin Header Row -->\n";
		print "      <TR>\n";
		print "        <TD colspan=\"2\" bgcolor=$Map{'HTML_HEADFOOT_BGCOLOR'}>\n";
		print "          <IMG alt=\"$Map{'WHICH_CONNECTIONS'} dot com Logo!\" src=\"$Map{'IMAGES'}/$Map{'LOGO'}\" border=\"0\">\n";
		print "        </TD>\n";
		print "      </TR>\n";
		print "      <!-- End Header Row -->\n";
		print "      <TR>\n";
		print "        <TD bgcolor=$Map{'HTML_NAV_BGCOLOR'} valign=\"top\" width=\"150\" height=\"424\">\n";
		print "          <TABLE border=\"0\" cellpadding=\"3\" cellspacing=\"3\" width=\"150\">\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"GenHome.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Member Home</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"GenInbox.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Inbox</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"GenOutbox.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Outbox</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"../AdvancedSearch.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Advanced Search</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"../SimpleSearch.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Simple Search</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"../LogOut.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">LogOut</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"mailto:admin\@$Map{'WHICH_CONNECTIONS'}.com\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Contact us</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <DIV align=\"left\">\n";
		print "                  <TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n";
		print "                    <TR>\n";
		print "                      <TD>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		print "                  </TABLE>\n";
		print "                </DIV>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "          </TABLE>\n";
		print "          <!-- End Navigation Table -->\n";
		print "        </TD>\n";
		print "        <!-- End Navigation Table Data Cell--><!-- Begin Main Data Cell -->\n";
		print "        <TD width=\"577\" bgcolor=$Map{'HTML_BODY_BGCOLOR'} height=\"500\" valign=\"top\">\n";
#		print "          $Message\n";
#		print "          <BR>\n";
#		print "           \n";
#		print "          <FORM>\n";
#		print "          <P align=\"center\" style=\"line-height: 100%\">\n";
#		print "             <INPUT type=\"BUTTON\" value=\"Back\" onclick=\"Back(-1)\">\n";
#		print "          </P>\n";
#		print "          </FORM>\n";
		print "\n";
	} # End Print_HTML


sub Print_HTML_Bottom
	{
		my($ProgramName, $Debug, %Map) = @_;
			
		print "        </TD>\n";
		print "        <!-- End Main Data Cell -->\n";
		print "      </TR>\n";
		print "      <!-- End Navigation and Main Row --><!-- Begin Copyright Row -->\n";
		print "      <TR>\n";
		print "        <TD colspan=\"2\" bgcolor=$Map{'HTML_HEADFOOT_BGCOLOR'}>\n";
		print "          <IMG alt=\"$Map{'WHICH_CONNECTIONS'} dot com Footer!\" src=\"$Map{'IMAGES'}/$Map{'FOOTER'}\" border=\"0\">\n";
		print "        </TD>\n";
		print "      </TR>\n";
		print "      <!-- End Copyright Row -->\n";
		print "    </TABLE>\n";
#		print "    <!-- End Main Table --><!-- End Entire Body -->\n";
#		print "  </BODY>\n";
#		print "<SCRIPT LANGUAGE=\"javascript\">\n";
#		print "<!--\n";
#		print "function Back(jump)";
#		print "{\n";
#		print "   window.history.go(jump)\n";
#		print "}\n";
#		print "//-->\n";
#		print "</SCRIPT>\n";		
#		print "</HTML>\n";
#		print "\n";
	} # End Print_HTML


sub Print_Framed_Error
	{
		my($Message, $Debug, %Map) = @_;
		print "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">\n";
		print "<HTML>\n";
		print "  <HEAD>\n";
		print "    <TITLE>\n";
		print "      $Map{'HTML_TITLE'}.com\n";
		print "    </TITLE>\n";
		print "  </HEAD>\n";
		print "  <BODY>\n";
		print "    <TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"4\" width=\"700\">\n";
		print "      <!-- Begin Header Row -->\n";
		print "      <TR>\n";
		print "        <TD colspan=\"2\" bgcolor=$Map{'HTML_HEADFOOT_BGCOLOR'}>\n";
		print "          <IMG alt=\"$Map{'WHICH_CONNECTIONS'} dot com Logo!\" src=\"$Map{'IMAGES'}/$Map{'LOGO'}\" border=\"0\">\n";
		print "        </TD>\n";
		print "      </TR>\n";
		print "      <!-- End Header Row -->\n";
		print "      <TR>\n";
		print "        <TD bgcolor=$Map{'HTML_NAV_BGCOLOR'} valign=\"top\" width=\"150\" height=\"424\">\n";
		print "          <TABLE border=\"0\" cellpadding=\"3\" cellspacing=\"3\" width=\"150\">\n";
#		print "            <TR>\n";
#		print "              <TD>\n";
#		print "                <A href=\"GenHome.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Member Home</FONT></A>\n";
#		print "              </TD>\n";
#		print "            </TR>\n";
#		print "            <TR>\n";
#		print "              <TD>\n";
#		print "                <A href=\"GenInbox.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Inbox</FONT></A>\n";
#		print "              </TD>\n";
#		print "            </TR>\n";
#		print "            <TR>\n";
#		print "              <TD>\n";
#		print "                <A href=\"GenOutbox.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Outbox</FONT></A>\n";
#		print "              </TD>\n";
#		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"../AdvancedSearch.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Advanced Search</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"../SimpleSearch.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Simple Search</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"../LogIn.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">LogIn</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD width=\"143\">\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "            <TR>\n";
		print "              <TD width=\"143\" height=\"94\">\n";
		print "                <DIV align=\"left\">\n";
		print "                  <TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n";
		print "                    <TR>\n";
		print "                      <TD>\n";
		print "                      </TD>\n";
		print "                    </TR>\n";
		#print "<!--\n";
		#print "                    <TR>\n";
		#print "                      <TD height=\"65\">\n";
		#print "                        <FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"#FF0000\">FREE Membership</FONT><FONT face=\"Arial, Helvetica, sans-serif\" size=\"2\" color=\"#3F4958\"> for women who post a picture personal ad&nbsp;</FONT> <FONT size=\"2\" face=\"Arial\"><A href=\"http://\"><FONT face=\"Arial, Helvetica, sans-serif\" color=\"#FF0000\">Click Here</FONT></A><FONT color=\"#FF0000\" face=\"Arial, Helvetica, sans-serif\">.</FONT></FONT>\n";
		#print "                      </TD>\n";
		#print "                    </TR>\n";
		#print "-->\n";
		print "                  </TABLE>\n";
		print "                </DIV>\n";
		print "              </TD>\n";
		print "            </TR>\n";
		print "          </TABLE>\n";
		print "        </TD>\n";
		print "        <TD width=\"666\" bgcolor=$Map{'HTML_BODY_BGCOLOR'} height=\"483\" valign=\"top\">\n";
		print "          <FORM>\n";
		print "            <DIV align=\"left\">\n";
		print "              <P>\n";
		print "                <FONT face=\"Arial, Helvetica, sans-serif\"><STRONG>General Error:</STRONG></FONT>\n";
		print "              </P>\n";
		print "              <TABLE border=\"0\" cellpadding=\"4\" cellspacing=\"4\" width=\"400\">\n";
		print "                <TR>\n";
		# Error Message...
		print "                  <TD>\n";
		print "                    $Message\n";
		print "                  </TD>\n";
		print "                </TR>\n";

		if($Map{'PROGRAM_NAME'} eq "UploadPicture.cgi")
			{
				print "            <TR>\n";
				print "              <TD>\n";
				print "                <A href=\"GenPicUpload.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Return to Manage Your Pictures screen...</FONT></A>\n";
				print "              </TD>\n";
				print "            </TR>\n";
			}
		elsif($Map{'PROGRAM_NAME'} eq "CancelPayingMembership.cgi")
			{
				print "            <TR>\n";
				print "              <TD>\n";
				print "                <A href=\"GenPicUpload.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Return to Membership Cancellation screen...</FONT></A>\n";
				print "              </TD>\n";
				print "            </TR>\n";
			}
		elsif($Map{'PROGRAM_NAME'} eq "ManageEmailVerification.cgi")
			{
				print "            <TR>\n";
				print "              <TD>\n";
				print "                <A href=\"GenPicUpload.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Email Verification Options screen...</FONT></A>\n";
				print "              </TD>\n";
				print "            </TR>\n";
			}
		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"../LogIn.html\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Proceed to LogIn screen...</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";

		print "            <TR>\n";
		print "              <TD>\n";
		print "                <A href=\"GenHome.exe\"><FONT size=\"2\" face=\"Arial\" color=\"#3F4958\">Proceed to Member Home...</FONT></A>\n";
		print "              </TD>\n";
		print "            </TR>\n";

#		print "                <TR>\n";
#		print "                  <TD>\n";
#		print "					 	<INPUT TYPE=\"SUBMIT\" Value=\"Back\" onClick=\"Back(-2)\">\n";
#		print "                  </TD>\n";
#		print "                </TR>\n";
		print "              </TABLE>\n";
		print "            </DIV>\n";
		print "          </FORM>\n";
		print "        </TD>\n";
		print "      </TR>\n";
		print "      <TR>\n";
		print "        <TD colspan=\"2\" bgcolor=$Map{'HTML_HEADFOOT_BGCOLOR'}>\n";
		print "          <IMG alt=\"$Map{'WHICH_CONNECTIONS'} dot com Footer!\" src=\"$Map{'IMAGES'}/$Map{'FOOTER'}\" border=\"0\">\n";
		print "        </TD>\n";
		print "      </TR>\n";
		print "    </TABLE>\n";
		print "<SCRIPT LANGUAGE=\"javascript\">\n";
		print "<!--\n";
		print "function Back(jump)";
		print "{\n";
		print "   window.history.go(jump)\n";
		print "}\n";
		print "//-->\n";
		print "</SCRIPT>\n";
		print "  </BODY>\n";
		print "</HTML>\n";
		print "\n";
		exit 0;	
	} # End Print_Framed_Error
	
sub Adv_Print_Framed_Error
	{
		my($AdvertiserUniqueID, $Message, $Debug, %Map) = @_;

		my $UrlParams = "advertiser_unique_id=$AdvertiserUniqueID";
		&Print_Adv_Host_HTML_Top(\$UrlParams, \$Debug, \%Map);
	
        print "        <TABLE align=\"center\" border=\"0\" cellspacing=\"0\" width=\"50%\" bgcolor=\"white\">\n";
        print "          <TR>\n";
        print "            <TD>\n";
        print "              <IMG src=\"$Map{'IMAGES'}/error.gif\" alt=\"Error\" border=\"0\">\n";
        print "            </TD>\n";
        print "            <TD>\n";
        print "              <H3>\n";
        print "                <FONT face=\"Arial, Helvetica, sans-serif\" color=\"black\">Problem(s) completing your request:</FONT>\n";
        print "              </H3>\n";
        print "              <HR size=\"1\" noshade>\n";
        print "              <UL>\n";
        print "                <LI>\n";
        print "                  <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\" color=\"black\">$Message</FONT>\n";
        print "                </LI>\n";
        print "              </UL>\n";
        print "              <HR size=\"1\" noshade>\n";
        print "            </TD>\n";
        print "          </TR>\n";
		if($Message =~ m/You must be logged in to view this page/ or $Message =~ m/password did not match/)
			{

				print "          <TR>\n";
				print "            <TD colspan=\"2\" align=\"center\">\n";
				print "	             <SCRIPT language=\"javascript\" src=\"$Map{'ROOT'}/JavaScript/Adv_LogIn.js\"></SCRIPT>\n";
				print "                <TABLE border=\"0\" cellspacing=\"0\" width=\"100%\">\n";
				print "                  <TR>\n";
				print "                    <TD nowrap align=\"center\" bgcolor=\"#FFFFFF\">\n";
				print "                      <STRONG><FONT size=\"-1\" color=\"#000000\">LOGIN</FONT></STRONG>\n";
				print "                    </TD>\n";
				print "                  </TR>\n";
				print "                  <TR>\n";
				print "                    <TD align=\"center\" bgcolor=\"#FFFFFF\">\n";
				print "                      <FORM method=\"POST\" action=\"$Map{'CGIBIN'}/Adv_LogIn.cgi\" onsubmit=\"return checkForm(this)\">\n";
				print "                        <BR>\n";
				print "                          <TABLE cellpadding=\"2\" cellspacing=\"0\">\n";
				print "                            <TR>\n";
				print "                              <TD align=\"right\">\n";
				print "                                <DIV>\n";
				print "                                  <FONT size=\"-2\">Unique ID:</FONT>\n";
				print "                                </DIV>\n";
				print "                              </TD>\n";
				print "                              <TD>\n";
				print "                                <INPUT type=\"text\" name=\"unique_id\" vaule=\"$AdvertiserUniqueID\" tabindex=\"1\" size=\"15\"> \n";
				print "                                  <SCRIPT type=\"text/javascript\">\n";
				print "                                  <!--\n";
				print "                                  focusField('unique_id');\n";
				print "                                  //--> \n";
				print "                                  </SCRIPT>\n";
				print "                              </TD>\n";
				print "                            </TR>\n";
				print "                            <TR>\n";
				print "                              <TD align=\"right\">\n";
				print "                                <FONT size=\"-2\">Password:</FONT>\n";
				print "                              </TD>\n";
				print "                              <TD>\n";
				print "                                <INPUT type=\"password\" name=\"password\" tabindex=\"2\" size=\"15\">\n";
				print "                              </TD>\n";
				print "                            </TR>\n";
				print "                            <TR>\n";
				print "                              <TD align=\"center\" colspan=\"2\">\n";
				print "                                <TABLE>\n";
				print "                                  <TR>\n";
				print "                                    <TD>\n";
				print "                                      <DIV class=\"buttonborder\">\n";
				print "                                        <INPUT type=\"submit\" name=\"submit\" value=\"Login\" tabindex=\"3\">\n";
				print "                                      </DIV>\n";
				print "                                    </TD>\n";
				print "                                  </TR>\n";
				print "                                </TABLE>\n";
				print "                              </TD>\n";
				print "                            </TR>\n";
				print "                          </TABLE>\n";
				print "                        <A href=\"$Map{'ROOT'}/LoginHelp.html\"><FONT size=\"-2\">Forgot your password?</FONT></A>\n";
				print "                      </FORM>\n";
				print "                    </TD>\n";
				print "                  </TR>\n";
				print "                </TABLE>\n";
				print "            </TD>\n";
				print "          </TR>\n";
			}
		else
			{
				print "          <TR>\n";
				print "            <TD colspan=\"2\" align=\"center\">\n";
				print "				<INPUT TYPE=\"SUBMIT\" Value=\"Back\" onClick=\"Back(-1)\">\n";
				print "            </TD>\n";
				print "          </TR>\n";
			}
        print "        </TABLE>\n";
		print "<SCRIPT LANGUAGE=\"javascript\">\n";
		print "<!--\n";
		print "function Back(jump)";
		print "{\n";
		print "   window.history.go(jump)\n";
		print "}\n";
		print "//-->\n";
		print "</SCRIPT>\n";
		exit 0;	
	} # End Adv_Print_Framed_Error
	
sub Afl_Print_Framed_Error
	{
		my($AffiliateUniqueID, $Message, $Debug, %Map) = @_;

		my $IsUserLoggedIn = "0";
		if($AffiliateUniqueID ne "")
		{
			$IsUserLoggedIn = "1";
		}

		&UtilityFunctions::Afl_Print_HTML_Top(\$IsUserLoggedIn, \$ProgramName, \$DebugUtilityFunctions, \%Map);
	
        print "        <TABLE align=\"center\" border=\"0\" cellspacing=\"0\" width=\"50%\" bgcolor=\"white\">\n";
        print "          <TR>\n";
        print "            <TD>\n";
        print "              <IMG src=\"" . $Map{'IMAGES'} . "/error.gif\" alt=\"Error\" border=\"0\">\n";
        print "            </TD>\n";
        print "            <TD>\n";
        print "              <H3>\n";
        print "                <FONT face=\"Arial, Helvetica, sans-serif\" color=\"black\">Problem(s) completing your request:</FONT>\n";
        print "              </H3>\n";
        print "              <HR size=\"1\" noshade>\n";
        print "              <UL>\n";
        print "                <LI>\n";
        print "                  <FONT size=\"2\" face=\"Arial, Helvetica, sans-serif\" color=\"black\">" . $Message . "</FONT>\n";
        print "                </LI>\n";
        print "              </UL>\n";
        print "              <HR size=\"1\" noshade>\n";
        print "            </TD>\n";
        print "          </TR>\n";
		if($Message =~ m/You must be logged in to view this page/ or $Message =~ m/password did not match/)
			{
				print "          <TR>\n";
				print "            <TD colspan=\"2\" align=\"center\">\n";
				print "	             <SCRIPT language=\"javascript\" src=\"" . $Map{'ROOT'} . "/JavaScript/Afl_LogIn.js\"></SCRIPT>\n";
				print "                <TABLE border=\"0\" cellspacing=\"0\" width=\"100%\">\n";
				print "                  <TR>\n";
				print "                    <TD nowrap align=\"center\" bgcolor=\"#FFFFFF\">\n";
				print "                      <STRONG><FONT size=\"-1\" color=\"#000000\">LOGIN</FONT></STRONG>\n";
				print "                    </TD>\n";
				print "                  </TR>\n";
				print "                  <TR>\n";
				print "                    <TD align=\"center\" bgcolor=\"#FFFFFF\">\n";
				print "                      <FORM method=\"POST\" action=\"" . $Map{'CGIBIN'} . "/Afl_LogIn.cgi\" onsubmit=\"return check_Afl_LogInForm(this)\">\n";
				print "                        <BR>\n";
				print "                          <TABLE cellpadding=\"2\" cellspacing=\"0\">\n";
				print "                            <TR>\n";
				print "                              <TD align=\"right\">\n";
				print "                                <DIV>\n";
				print "                                  <FONT size=\"-2\">Email:</FONT>\n";
				print "                                </DIV>\n";
				print "                              </TD>\n";
				print "                              <TD>\n";
				print "                                <INPUT type=\"text\" name=\"email\" vaule=\"" . $AffiliateUniqueID . "\" tabindex=\"1\" size=\"15\"> \n";
				print "                                  <SCRIPT type=\"text/javascript\">\n";
				print "                                  <!--\n";
				print "                                  focusField('email');\n";
				print "                                  //--> \n";
				print "                                  </SCRIPT>\n";
				print "                              </TD>\n";
				print "                            </TR>\n";
				print "                            <TR>\n";
				print "                              <TD align=\"right\">\n";
				print "                                <FONT size=\"-2\">Password:</FONT>\n";
				print "                              </TD>\n";
				print "                              <TD>\n";
				print "                                <INPUT type=\"password\" name=\"password\" tabindex=\"2\" size=\"15\">\n";
				print "                              </TD>\n";
				print "                            </TR>\n";
				print "                            <TR>\n";
				print "                              <TD align=\"center\" colspan=\"2\">\n";
				print "                                <TABLE>\n";
				print "                                  <TR>\n";
				print "                                    <TD>\n";
				print "                                      <DIV class=\"buttonborder\">\n";
				print "                                        <INPUT type=\"submit\" name=\"submit\" value=\"Login\" tabindex=\"3\">\n";
				print "                                      </DIV>\n";
				print "                                    </TD>\n";
				print "                                  </TR>\n";
				print "                                </TABLE>\n";
				print "                              </TD>\n";
				print "                            </TR>\n";
				print "                          </TABLE>\n";
				print "                        <A href=\"" . $Map{'ROOT'} . "/LoginHelp.html\"><FONT size=\"-2\">Forgot your password?</FONT></A>\n";
				print "                      </FORM>\n";
				print "                    </TD>\n";
				print "                  </TR>\n";
				print "                </TABLE>\n";
				print "            </TD>\n";
				print "          </TR>\n";
			}
		else
			{
				print "          <TR>\n";
				print "            <TD colspan=\"2\" align=\"center\">\n";
				print "				<INPUT TYPE=\"SUBMIT\" Value=\"Back\" onClick=\"Back(-1)\">\n";
				print "            </TD>\n";
				print "          </TR>\n";
			}
        print "        </TABLE>\n";
		print "<SCRIPT LANGUAGE=\"javascript\">\n";
		print "<!--\n";
		print "function Back(jump)";
		print "{\n";
		print "   window.history.go(jump)\n";
		print "}\n";
		print "//-->\n";
		print "</SCRIPT>\n";
        &UtilityFunctions::Afl_Print_HTML_Bottom(\$ProgramName, \$DebugUtilityFunctions, \%Map);
		exit 0;	
	} # End Adv_Print_Framed_Error
	
sub Print_Admin_HTML_Top
	{
		my($ProgramName, $Debug, %Map) = @_;
			
		print "  <HEAD>\n";
		print "    <TITLE>$Map{'WHICH_CONNECTIONS'} Admin Mail</TITLE></HEAD>\n";
		print "<SCRIPT type=\"text/javascript\" language=\"javascript\">\n";
		print "<!--\n";
		print "function mOvr(src,clrOver){ \n";
		print "    if (!src.contains(event.fromElement)){ \n";
		print "        src.style.cursor = 'hand'; \n";
		print "        src.bgColor = clrOver; \n";
		print "    } \n";
		print "} \n";
		print "function mOut(src,clrIn){ \n";
		print "    if (!src.contains(event.toElement)){ \n";
		print "        src.style.cursor = 'default'; \n";
		print "        src.bgColor = clrIn; \n";
		print "    } \n";
		print "} \n";
		print "function mClk(src){ \n";
		print "    if(event.srcElement.tagName=='TD')\n";
		print "        src.children.tags('A')[0].click();\n";
		print "}\n";
		print "// -->\n";
		print "</SCRIPT>\n";
		print "  </HEAD>\n";
		print "    <!-- Begin Entire Body NOT Logged In -->\n";
		# Begin Entire Body NOT Logged In
		print "  <BODY>\n";
		print "    <!-- Begin Header Table -->\n";
		# Begin Header Table
		print "    <TABLE border=\"0\" cellpadding=\"0\" cellspacing=\"4\" width=\"100%\">\n";
		print "      <!-- Begin Header Row -->\n";
		print "      <TR>\n";
		print "        <TD colspan=\"100%\" bgcolor=\"$Map{'HTML_HEADFOOT_BGCOLOR'}\">\n";
		print "          <IMG alt=\"$Map{'WHICH_CONNECTIONS'} Logo\" src=\"$Map{'IMAGES'}/$Map{'LOGO'}\" border=\"0\">\n";
		print "        </TD>\n";
		print "      </TR>\n";
		print "    </TABLE>\n";
		print "    <!-- End Header Row -->\n";
		# End Header Row
		print "    <!-- Begin Admin Navigation Table -->\n";
		# Begin Admin Navigation Table
		print "    <TABLE border=\"0\" cellpadding=\"3\" cellspacing=\"3\" width=\"100%\">\n";
		print "      <TR align=\"center\">\n";
			
		if($ProgramName eq "Admin_FreeFormAudit.cgi")
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_1'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_1'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_FreeFormAudit.cgi\"><FONT color=\"666666\">Free Form Audit</FONT></A>\n";
				print "        </TD>\n";
			}
		else
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_2'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_2'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_FreeFormAudit.cgi\"><FONT color=\"666666\">Free Form Audit</FONT></A>\n";
				print "        </TD>\n";
			}
			
		if($ProgramName eq "Admin_FindDuplicates.cgi")
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_1'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_1'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_FindDuplicates.cgi\"><FONT color=\"666666\">Find Duplicates</FONT></A>\n";
				print "        </TD>\n";
			}
		else
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_2'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_2'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_FindDuplicates.cgi\"><FONT color=\"666666\">Find Duplicates</FONT></A>\n";
				print "        </TD>\n";
			}
			
		if($ProgramName eq "Admin_GraphNewMembers.cgi")
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_1'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_1'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_GraphNewMembers.cgi\"><FONT color=\"666666\">Graph Member Creation Date</FONT></A>\n";
				print "        </TD>\n";
			}
		else
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_2'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_2'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_GraphNewMembers.cgi\"><FONT color=\"666666\">Graph Member Creation Date</A>\n";
				print "        </TD>\n";
			}

		if($ProgramName eq "Admin_GetDanglingUserNames.cgi")
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_1'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_1'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_GetDanglingUserNames.cgi\"><FONT color=\"666666\">Get Dangling User Names</FONT></A>\n";
				print "        </TD>\n";
			}
		else
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_2'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_2'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_GetDanglingUserNames.cgi\"><FONT color=\"666666\">Get Dangling User Names</FONT></A>\n";
				print "        </TD>\n";
			}

		if($ProgramName eq "Admin_GetAllTableInfo.cgi")
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_1'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_1'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_GetAllTableInfo.cgi\"><FONT color=\"666666\">Get All Table Info</FONT></A>\n";
				print "        </TD>\n";
			}
		else
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_2'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_2'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_GetAllTableInfo.cgi\"><FONT color=\"666666\">Get All Table Info</FONT></A>\n";
				print "        </TD>\n";
			}
			
		if($ProgramName eq "Admin_TransactionsLogAudit.cgi")
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_1'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_1'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_TransactionsLogAudit.cgi\"><FONT color=\"666666\">Transactions Log</FONT></A>\n";
				print "        </TD>\n";
			}
		else
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_2'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_2'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_TransactionsLogAudit.cgi\"><FONT color=\"666666\">Transactions Log</FONT></A>\n";
				print "        </TD>\n";
			}
			
		if($ProgramName eq "Admin_ManipulateLinkMap.cgi")
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_1'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_1'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_ManipulateLinkMap.cgi\"><FONT color=\"666666\">Edit LinkMaps</FONT></A>\n";
				print "        </TD>\n";
			}
		else
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_2'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_2'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_ManipulateLinkMap.cgi\"><FONT color=\"666666\">Edit LinkMaps</FONT></A>\n";
				print "        </TD>\n";
			}
		if($ProgramName eq "Admin_GetMembershipCancellations.cgi")
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_1'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_1'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_GetMembershipCancellations.cgi\"><FONT color=\"666666\">Get Cancellations</FONT></A>\n";
				print "        </TD>\n";
			}
		else
			{
				print "        <TD bgcolor=\"$Map{'INBOX_COLOR_2'}\" onmouseover='mOvr(this,\"$Map{'INBOX_COLOR_1'}\");' onmouseout='mOut(this,\"$Map{'INBOX_COLOR_2'}\");' onclick=\"mClk(this);\">\n";
				print "          <A href=\"Admin_GetMembershipCancellations.cgi\"><FONT color=\"666666\">Get Cancellations</FONT></A>\n";
				print "        </TD>\n";
			}
		print "      </TR>\n";
		print "    </TABLE>\n";
		print "    <!-- End Admin Navigation Table -->\n";
		# End Admin Navigation Table
			
	} # End Print_Admin_HTML_Top


sub Print_Admin_HTML_Bottom
	{
		my($ProgramName, $OrderBy, $AscDesc, $Limit, $Index, $Total, $Debug, %Map) = @_;
			
		# Begin Debugging...	
		if($Debug eq "1")
			{
				print "<!-- ProgramName = ($ProgramName) -->\n";
				print "<!-- OrderBy     = ($OrderBy) -->\n";
				print "<!-- AscDesc     = ($AscDesc) -->\n";
				print "<!-- Limit       = ($Limit) -->\n";
				print "<!-- Index       = ($Index) -->\n";
				print "<!-- Total       = ($Total) -->\n";
				print "<!-- Debug       = ($Debug) -->\n";
				print "<!-- Map         = ($Map{'SYSTEM'}) -->\n";
			}
		if($Total > 1)
			{
				# Begin Navigation Table
				print "<!-- Begin Navigation Table -->\n";
				print "          <TABLE width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"3\" bgcolor=$Map{'HTML_BODY_BGCOLOR'}>\n";
				print "            <TBODY>\n";
				print "              <TR>\n";
				print "                <TD align=\"right\">\n";
					
				my $index_next = $Index + $Limit;
				if($Index > $Limit)
					{
						my $index_previous = $Index - $Limit;
						print "<!-- First Result Set -->\n";
						print "                  <A href=\"/admin/cgi-bin/". "$ProgramName" . "order_by=$OrderBy&asc_desc=$AscDesc&limit=$Limit&index=1\"><IMG ALT=\"Display First\" border=\"0\" src=\"$Map{'IMAGES'}/$Map{'FIRSTARROW'}\"></A> \n";
						print "<!-- Previous Result Set -->\n";
						print "                  <A href=\"/admin/cgi-bin/". "$ProgramName" . "order_by=$OrderBy&asc_desc=$AscDesc&limit=$Limit&index=$index_previous\"><IMG ALT=\"Display Previous\" border=\"0\" src=\"$Map{'IMAGES'}/$Map{'PREVIOUSARROW'}\"></A> \n";
					}
				if( ($Limit+$Index) < $Total)
					{
						my $index_last = $Total - $Limit;
						print "<!-- Next Result Set -->\n";
						print "                  <A href=\"/admin/cgi-bin/". "$ProgramName" . "order_by=$OrderBy&asc_desc=$AscDesc&limit=$Limit&index=$index_next\"><IMG ALT=\"Display Next\" border=\"0\" src=\"$Map{'IMAGES'}/$Map{'NEXTARROW'}\"></A> \n";
						print "<!-- Last Result Set -->\n";
						print "                  <A href=\"/admin/cgi-bin/". "$ProgramName" . "order_by=$OrderBy&asc_desc=$AscDesc&limit=$Limit&index=$index_last\"><IMG ALT=\"Display Last\" border=\"0\" src=\"$Map{'IMAGES'}/$Map{'LASTARROW'}\"></A> \n";
					}
				print "                </TD>\n";
				print "              </TR>\n";
				print "      		 <TR>\n";
				print "        		 	<TD colspan=\"3\" align=\"left\" height=\"21\">\n";
				print "          			<STRONG>($Total) total messages</STRONG>\n";
				print "        			</TD>\n";
				print "        			<TD colspan=\"2\" align=\"right\" height=\"21\">\n";
				print "          			<STRONG>Results $Index Through $index_next of $Total</STRONG>\n";
				print "        			</TD>\n";
				print "      		 </TR>\n";
				print "            </TBODY>\n";
				print "          </TABLE>\n";
				print "    <!-- End Navigation Table -->\n";
				# End Navigation Table
			}
			
			
		# Begin Footer Table (Copyright)
		print "    <TABLE width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"3\">\n";
		print "      <TR>\n";
		print "        <TD colspan=\"2\" bgcolor=$Map{'HTML_HEADFOOT_BGCOLOR'}>\n";
		print "          <IMG alt=\"$Map{'WHICH_CONNECTIONS'} dot com Footer!\" src=\"$Map{'IMAGES'}/$Map{'FOOTER'}\" border=\"0\">\n";
		print "        </TD>\n";
		print "      </TR>\n";
		print "    </TABLE>\n";
		print "    <!-- End Footer Table (Copyright) -->\n";
		# End Footer Table (Copyright)
		print "<SCRIPT type=\"text/javascript\" language=\"javascript\">\n";
		print "<!--\n";
		print "function newWindowSingleProfile(URLtoOpen) \n";
		print "{\n";
		print "    var myWindow = window.open(URLtoOpen, 'SingleProfile', 'toolbar=yes,location=yes,scrollbars=yes,resizable=yes,width=850,height=850')\n";
		print "    myWindow.focus()\n";
		print "}\n";
		print "function newWindowBecomeUser(URLtoOpen) \n";
		print "{\n";
		print "    var myWindow = window.open(URLtoOpen, 'AssumeUserName', 'toolbar=yes,location=yes,scrollbars=yes,resizable=yes,width=850,height=700')\n";
		print "    myWindow.focus()\n";
		print "}\n";
			
		print "function newWindowDeletePic(picName) \n";
		print "{\n";
		print "	if (confirm(\"WARNING! There is no way to undo a DELETE!!!  Are you sure you want to continue?\")) \n";
		print "		{\n";
		print "    		var myWindow = window.open(picName, 'Guidelines', 'toolbar=no,location=no,scrollbars=yes,resizable=yes,width=850,height=1000')\n";
		print "    		myWindow.focus()\n";
		print "		}\n";
		print "}\n";

		print "function newWindowCreditAccount(myURL) \n";
		print "{\n";
		print "	if (confirm(\"Are you sure you want to credit the user?\")) \n";
		print "		{\n";
		print "    		var myWindow = window.open(myURL, 'Guidelines', 'toolbar=no,location=no,scrollbars=yes,resizable=yes,width=850,height=1000')\n";
		print "    		myWindow.focus()\n";
		print "		}\n";
		print "}\n";
			
		print "function newWindowGeneric(picName) \n";
		print "{\n";
		print "		var myWindow = window.open(picName, 'Guidelines', 'toolbar=no,location=no,scrollbars=yes,resizable=yes,width=850,height=1000')\n";
		print "		myWindow.focus()\n";
		print "}\n";
			
		print "// -->\n";
		print "</SCRIPT>\n";
		print "  </BODY>\n";
			
	} # End Print_Admin_HTML_Top

sub Print_Adv_Host_HTML_Top
	{
		my $CgiUrl	= shift;
		my $Debug	= shift;
		my $MapHash	= shift;

		print "  <HEAD>\n";
		print "    <TITLE>$$MapHash{'HTML_TITLE'}</TITLE>\n";
		print "	   <SCRIPT language=\"javascript\" src=\"$$MapHash{'ROOT'}/JavaScript/MyFunctions.js\"></SCRIPT>\n";
		print "  </HEAD>\n";
		# Begin Entire Body NOT Logged In
		print "  <BODY>\n";
		
#<map name="SubliminalAds_TopNav_Host_map" id="SubliminalAds_TopNav_Host_map">
#  <area shape="rect" coords="0,-1,100,42" href="Adv_HostCampaignSettings.cgi?menu_item=Advertising_Settings" alt="alt=&quot;Manage your Host campaign settings...&quot;" title="Manage your Host campaign settings..."/>
#  <area shape="rect" coords="101,-3,202,51" href="ManageEmailVerification.cgi?menu_item=Change/Verify_Email_Address" alt="Manage your email and password settings..." title="Manage your email and password settings..."/>
#  <area shape="rect" coords="200,-6,302,68" href="Adv_LogIn.cgi?unique_id=910&password=¢°§®¢«°»&antiquated=ÈÑÉËÑÊÉÈ&submit=Login" alt="Login to your default advertising account..." title="Login to your default advertising account..." />
#  <area shape="rect" coords="300,-5,413,57" href="#" />
#</map>


		# Begin Host navigation map...
        print "    <P>\n";
        print "       <MAP name=\"SubliminalAds_TopNav_Host_map\">\n";
		# Manage Campaigns...
        print "        <AREA shape=\"rect\" href=\"Adv_HostCampaignSettings.cgi?menu_item=Advertising_Settings\" coords=\"0,-1,100,42\" alt=\"Manage your Host campaign settings...\" title=\"Manage your Host campaign settings...\">\n";
		# Manage Account...
        print "        <AREA shape=\"rect\" href=\"ManageEmailVerification.cgi?menu_item=Change/Verify_Email_Address\" coords=\"101,-3,202,51\" alt=\"Manage your email and password settings...\" title=\"Manage your email and password settings...\">\n";
		# Outstanding Payment...
        print "        <AREA shape=\"rect\" href=\"Adv_LogIn.cgi?$$CgiUrl\" coords=\"200,-6,302,68\" alt=\"Login to your default advertising account...\" title=\"Login to your default advertising account...\">\n";
		# Log Out...
        print "        <AREA shape=\"rect\" href=\"$$MapHash{'ROOT'}/LogOut.html\" coords=\"300,-5,413,57\" alt=\"Logout of your session...\" title=\"Logout of your session...\">\n";
        print "      </MAP>\n";
        print "    </P>\n";

        print "    <CENTER>\n";

		# Begin Header Table
        print "      <TABLE width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" vspace=\"0\">\n";
        print "        <TR>\n";

		# OneMonkey Logo...
        print "          <TD width=\"25%\" rowspan=\"2\">\n";
        print "            &nbsp;\n";
        print "          </TD>\n";
        print "          <TD align=\"left\" valign=\"bottom\">\n";
        print "            <A href=\"/index.html\"><IMG src=\"../images/OneMonkey_Logo.gif\" alt=\"One Monkey, Inc.\" border=\"0\"></A>\n";
        print "          </TD>\n";

		# Host Top Nav Logo...
        print "          <TD width=\"10%\">\n";
        print "            &nbsp;\n";
        print "          </TD>\n";
        print "          <TD align=\"right\">\n";
#        print "            <IMG src=\"../images/SubliminalAds_TopNav_Host.gif\" width=\"211\" height=\"22\" alt=\"\" usemap=\"#SubliminalAds_TopNav_Host_map\" border=\"0\">\n";
        print "            <IMG src=\"../images/SubliminalAds_TopNav_Host.gif\" alt=\"OneMonkey.com Host Navigation\" usemap=\"#SubliminalAds_TopNav_Host_map\" border=\"0\">\n";
        print "          </TD>\n";
        print "          <TD align=\"right\" rowspan=\"2\" width=\"25%\">\n";
        print "            &nbsp;\n";
        print "          </TD>\n";

        print "        </TR>\n";
#        print "        <TR valign=\"bottom\">\n";
#        print "          <TD colspan=\"3\" align=\"center\">\n";
#        print "            &nbsp;\n";
#        print "          </TD>\n";
#        print "        </TR>\n";
        print "      </TABLE>\n";
        print "    </CENTER>\n";
	} # End Print_Host_HTML_Top


sub Print_Adv_Advertiser_HTML_Top
	{
		my $CgiUrl				= shift;
		my $Debug				= shift;
		my $HostSettingsHash	= shift;
		my $MapHash				= shift;

		print "  <HEAD>\n";
		print "    <TITLE>$$MapHash{'HTML_TITLE'}</TITLE>\n";
		print "	   <SCRIPT language=\"javascript\" src=\"$$MapHash{'ROOT'}/JavaScript/MyFunctions.js\"></SCRIPT>\n";
		print "  </HEAD>\n";
		# Begin Entire Body NOT Logged In
		print "  <BODY>\n";
		# Begin Header Table

#<map name="SubliminalAds_TopNav_map" id="SubliminalAds_TopNav_map">
#  <area shape="rect" coords="0,0,102,60" href="Adv_AdCampaigns.cgi?&menu_item=View_All_Campaigns" alt="Manage your ad campaigns" title="Manage your ad campaigns" />
#  <area shape="rect" coords="101,-5,190,63" href="Adv_AccountManagement.cgi?&menu_item=Update_Billing_Address" alt="Manage your billing and personal information" title="Manage your account settings" />
#  <area shape="rect" coords="189,-6,320,75" href="Adv_PaymentProcessing.cgi?&menu_item=Campaigns_Pending_Payment&cmd=DisplayCampaignsPendingPayment" alt="View your current outstanding campaigns." title="View your current outstanding campaigns." />
#  <area shape="rect" coords="319,-2,420,69" href="#" />
#</map>

        print "    <P>\n";
        print "       <MAP name=\"SubliminalAds_TopNav_map\">\n";
		# Manage Campaigns...
        print "        <AREA shape=\"rect\" href=\"Adv_AdCampaigns.cgi?$$CgiUrl&menu_item=View_All_Campaigns\" coords=\"0,0,102,60\" alt=\"Manage your ad campaigns\" title=\"Manage your ad campaigns\">\n";
		# Manage Account...
        print "        <AREA shape=\"rect\" href=\"Adv_AccountManagement.cgi?$$CgiUrl&menu_item=Update_Billing_Address\" coords=\"101,-5,190,631\" alt=\"Manage your billing and personal information\" title=\"Manage your account settings\">\n";
		# Outstanding Payment...
        print "        <AREA shape=\"rect\" href=\"Adv_PaymentProcessing.cgi?$$CgiUrl&menu_item=Campaigns_Pending_Payment&cmd=DisplayCampaignsPendingPayment\" coords=\"189,-6,320,75\" alt=\"View your current outstanding campaigns.\" title=\"View your current outstanding campaigns.\">\n";
		# Log Out...
        print "        <AREA shape=\"rect\" href=\"$$MapHash{'ROOT'}/LogOut.html\" coords=\"319,-2,420,69\" alt=\"Logout of your session...\" title=\"Logout of your session...\">\n";
        print "      </MAP>\n";
        print "    </P>\n";

        print "    <CENTER>\n";
        print "      <TABLE width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" vspace=\"0\">\n";
        print "        <TR>\n";
        print "          <TD width=\"25%\" rowspan=\"2\">\n";
        print "            &nbsp;\n";
        print "          </TD>\n";
        print "          <TD align=\"left\" valign=\"bottom\">\n";
        print "            <A href=\"$$HostSettingsHash{'site_url'}\"><IMG src=\"$$HostSettingsHash{'logo_url'}\" width=\"$$HostSettingsHash{'logo_width'}\" height=\"$$HostSettingsHash{'logo_height'}\" alt=\"\" border=\"0\"></A>\n";
#        print "            <A href=\"$$HostSettingsHash{'site_url'}\"><IMG src=\"$$HostSettingsHash{'logo_url'}\" alt=\"One Monkey, Inc.\" border=\"0\"></A>\n";
        print "          </TD>\n";
        print "          <TD width=\"10%\">\n";
        print "            &nbsp;\n";
        print "          </TD>\n";
        print "          <TD align=\"right\">\n";
		if ($$HostSettingsHash{'show_top_nav'} eq "true") 
			{
#				print "            <IMG src=\"../images/SubliminalAds_TopNav.gif\" width=\"300\" height=\"22\" alt=\"\" usemap=\"#SubliminalAds_TopNav_map\" border=\"0\">\n";
				print "            <IMG src=\"../images/SubliminalAds_TopNav.gif\" alt=\"OneMonkey.com Advertiser Navigation\" usemap=\"#SubliminalAds_TopNav_map\" border=\"0\">\n";
			}
		else
			{
		        print "            &nbsp;\n";
			}
        print "          </TD>\n";
        print "          <TD align=\"right\" rowspan=\"2\" width=\"25%\">\n";
        print "            &nbsp;\n";
        print "          </TD>\n";
        print "        </TR>\n";
        print "        <TR valign=\"bottom\">\n";
        print "          <TD colspan=\"3\" align=\"center\">\n";
        print "            &nbsp;\n";
        print "          </TD>\n";
        print "        </TR>\n";
        print "      </TABLE>\n";
        print "    </CENTER>\n";
		# End Header Row			
	} # End Print_Adv_Advertiser_HTML_Top

sub Print_Adv_HTML_Bottom 
	{
		my $Debug			= shift;
		my $MapHash			= shift;
			
        print "    <HR width=\"50%\" size=\"1\" noshade>\n";
		print "    <TABLE width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"3\">\n";
		print "      <TR>\n";
		print "        <TD colspan=\"100%\" bgcolor=$$MapHash{'HTML_HEADFOOT_BGCOLOR'} valign=\"middle\" align=\"middle\">\n";
		print "           <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-3\">Copyright &copy; $$MapHash{'COPYRIGHT_YEAR'} <A href=\"$$MapHash{'ROOT'}\">$$MapHash{'WHICH_CONNECTIONS'}\.com</A>. All rights reserved.</FONT>\n";
		print "        </TD>\n";
		print "      </TR>\n";
		print "    </TABLE>\n";
		print "  </BODY>\n";
		print " </HTML>\n";
	} # End Print_Adv_HTML_Bottom

sub Print_Generic_HTML_Top
	{
		my $IsCampaignActive= shift;
		my $NameToDisplay	= shift;
		my $MenuItem		= shift;
		my $MenuActionHash	= shift;
		my $Debug			= shift;
		my $MapHash			= shift;

		my $FoundItem		= 0;
#		print "passed in parameter:<BR>\n";			
#		print "IsCampaignActive = ($$IsCampaignActive)<BR>\n";			
#		print "NameToDisplay    = ($$NameToDisplay)<BR>\n";			
#		print "MenuItem         = ($$MenuItem)<BR>\n";			
#		print "Debug            = ($$Debug)<BR>\n";			
#		print "MenuActionHash   = (";	
#		my $key;
#		foreach $key (sort keys(%$MenuActionHash))
#		{
#			print "$key = <FONT color=red>$$MenuActionHash{$key}</FONT><p>";
#		}
#		print ")<BR>\n";			

		print "    <TABLE border=\"0\" cellspacing=\"0\" align=\"center\" width=\"100%\" cellpadding=\"3\">\n";
		print "      <TR>\n";
			
		foreach my $CurrentMenuItem (sort keys(%$MenuActionHash))
			{
				if($$MenuItem eq $CurrentMenuItem)
					{
						print "        <TD align=\"center\" width=\"12%\" bgcolor=\"$$MapHash{'NAV_ADVERTISER_COLOR_1'}\" onmouseover='mOvr(this,\"$$MapHash{'NAV_ADVERTISER_COLOR_1'}\");' onmouseout='mOut(this,\"$$MapHash{'NAV_ADVERTISER_COLOR_1'}\");' onclick=\"mClk(this);\">\n";
						print "          <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-2\" color=\"666666\"><STRONG>$$MenuItem</STRONG></FONT>\n";
						print "        </TD>\n";
						$FoundItem = 1;
					}
				elsif($CurrentMenuItem eq '')
					{
						print "        <TD align=\"center\" width=\"12%\" bgcolor=\"$$MapHash{'NAV_ADVERTISER_COLOR_2'}\" onmouseover='mOvr(this,\"$$MapHash{'NAV_ADVERTISER_COLOR_1'}\");' onmouseout='mOut(this,\"$$MapHash{'NAV_ADVERTISER_COLOR_2'}\");' onclick=\"mClk(this);\">\n";
						print "          <FONT face=\"Arial, Helvetica, sans-serif\" size=\"-2\" color=\"666666\"><STRONG>$CurrentMenuItem</STRONG></FONT>\n";
						print "        </TD>\n";
					}
				else
					{
						if ($$MenuActionHash{$CurrentMenuItem} !~ m/\?/) {$$MenuActionHash{$CurrentMenuItem} = $$MenuActionHash{$CurrentMenuItem} . "?";}
						print "        <TD align=\"center\" width=\"12%\" bgcolor=\"$$MapHash{'NAV_ADVERTISER_COLOR_2'}\" onmouseover='mOvr(this,\"$$MapHash{'NAV_ADVERTISER_COLOR_1'}\");' onmouseout='mOut(this,\"$$MapHash{'NAV_ADVERTISER_COLOR_2'}\");' onclick=\"mClk(this);\">\n";
						print "          <A href=\"$$MenuActionHash{$CurrentMenuItem}&menu_item=$CurrentMenuItem\"><FONT face=\"Arial, Helvetica, sans-serif\" size=\"-2\" color=\"666666\"><STRONG>$CurrentMenuItem</STRONG></FONT></A>\n";
						print "        </TD>\n";
					}
				print "          <TD width=\"2%\">\n";
				print "            &nbsp;\n";
				print "          </TD>\n";
			}
		# if a menu item was found print the bottom of the menu...
		if ($FoundItem == 1 and $$NameToDisplay eq "")
			{
				print "        <TR>\n";
				print "          <TD colspan=\"13\" bgcolor=\"$$MapHash{'NAV_ADVERTISER_COLOR_1'}\" width=\"100%\">\n";
				print "            <TABLE cellspacing=\"0\" width=\"100%\" cellpadding=\"3\">\n";
				print "              <TR>\n";
				print "                <TD>\n";
				print "		            &nbsp;\n";
				print "                </TD>\n";
				print "              </TR>\n";
				print "            </TABLE>\n";
				print "          </TD>\n";
				print "        </TR>\n";
				print "    </TABLE>\n";
				print "    <!-- End Admin Navigation Table -->\n";
			}
		else
			{
				print "        <TR>\n";
				print "          <TD colspan=\"13\" bgcolor=\"$$MapHash{'NAV_ADVERTISER_COLOR_1'}\" width=\"100%\">\n";
				print "            <TABLE cellspacing=\"0\" width=\"100%\" cellpadding=\"3\">\n";
				print "              <TR>\n";
				print "                <TD align=\"center\">\n";
				if($$IsCampaignActive eq '0')
					{
						print "		            <A id=\"$$NameToDisplay\" name=\"$$NameToDisplay\"></A><FONT face=\"Arial, Helvetica, sans-serif\" size=\"3\"><STRONG>$$NameToDisplay</STRONG> -- <FONT size=\"3\" color=\"red\"><STRONG>Not Active</STRONG></FONT></FONT>\n";
					}
				elsif($$IsCampaignActive eq '1')
					{
						print "		            <A id=\"$$NameToDisplay\" name=\"$$NameToDisplay\"></A><FONT face=\"Arial, Helvetica, sans-serif\" size=\"3\"><STRONG>$$NameToDisplay</STRONG> -- <FONT size=\"3\" color=\"green\"><STRONG>Active</STRONG></FONT></FONT>\n";
					}
				else
					{
						print "		            <A id=\"$$NameToDisplay\" name=\"$$NameToDisplay\"></A><FONT face=\"Arial, Helvetica, sans-serif\" size=\"3\"><STRONG>$$NameToDisplay</STRONG></FONT>\n";
					}
				print "                </TD>\n";
				print "              </TR>\n";
				print "            </TABLE>\n";
				print "          </TD>\n";
				print "        </TR>\n";
				print "    </TABLE>\n";
				print "        <BR>\n";
				print "    <!-- End Admin Navigation Table -->\n";
			}

		# End Admin Navigation Table
			
	} # End Print_Generic_HTML_Top

sub Simple_Encryption 
	{
		my $Key_String		= shift;
		my $Crypt_String	= shift;
		my $Debug			= shift;

		my %KeyValueReturn = "";
		
		if ($$Key_String eq "")
			{
				$random = &Random_String(length($$Crypt_String));
				print "<!-- random Encrypt = ($random) -->\n"	if $$Debug eq "1";
			}
		else
			{
				$random = $$Key_String;
				print "<!-- random Decrypt = ($random) -->\n"	if $$Debug eq "1";
			}

		print "<!-- Crypt_String Before = ($$Crypt_String) -->\n"	if $$Debug eq "1";
#		print "<!-- Key_String	 Before = ($$Key_String) -->\n"		if $$Debug eq "1";

		$KeyValueReturn{'Key_String'}	= $random;
		$KeyValueReturn{'Crypt_String'} = $$Crypt_String ^ $random;

		print "<!-- Crypt_String After  = ($KeyValueReturn{'Crypt_String'}) -->\n"	if $$Debug eq "1";

		return %KeyValueReturn;				

	} # End Print_Adv_HTML_Bottom

sub Random_String 
	{
		#-------------------------------------------------
		# a random string of the same length as the
		# message is generated.. thats than
		# XOR'ed, character-by-character, on the
		# message, the result is mixed but when
		# you XOR this mix with the same random string,
		# you get the original message back 
		#-------------------------------------------------

		my $ret;
#		for (1 .. $_[0]) { $ret .= chr(rand 256) }  
		for (1 .. $_[0]) { $ret .= chr( (rand 10) + 200) }  

		return $ret;
	}

sub Remove_Special_Characters 
	{
		my $String = shift;

		my $Return_String = $$String;

		if ($Return_String =~ m/\%/)
			{
				$Return_String =~ s/\%20/ /g;
				$Return_String =~ s/\%21/\!/g;
				$Return_String =~ s/\%22/\"/g;
				$Return_String =~ s/\%23/\#/g;
				$Return_String =~ s/\%24/\$/g;
				$Return_String =~ s/\%25/\%/g;
				$Return_String =~ s/\%26/\&/g;
				$Return_String =~ s/\%27/\'/g;
				$Return_String =~ s/\%28/\(/g;
				$Return_String =~ s/\%29/\)/g;
				$Return_String =~ s/\%2A/\*/g;
				$Return_String =~ s/\%2B/\+/g;
				$Return_String =~ s/\%2C/\'/g;
				$Return_String =~ s/\%2D/\-/g;
				$Return_String =~ s/\%2E/\./g;
				$Return_String =~ s/\%2F/\//g;
				$Return_String =~ s/\%30/0/g;
				$Return_String =~ s/\%31/1/g;
				$Return_String =~ s/\%32/2/g;
				$Return_String =~ s/\%33/3/g;
				$Return_String =~ s/\%34/4/g;
				$Return_String =~ s/\%35/5/g;
				$Return_String =~ s/\%36/6/g;
				$Return_String =~ s/\%37/7/g;
				$Return_String =~ s/\%38/8/g;
				$Return_String =~ s/\%39/9/g;
				$Return_String =~ s/\%3A/\:/g;
				$Return_String =~ s/\%3B/\;/g;
				$Return_String =~ s/\%3C/\</g;
				$Return_String =~ s/\%3D/\=/g;
				$Return_String =~ s/\%3E/\>/g;
				$Return_String =~ s/\%3F/\?/g;

				$Return_String =~ s/\%40/\@/g;
				$Return_String =~ s/\%41/A/g;
				$Return_String =~ s/\%42/B/g;
				$Return_String =~ s/\%43/C/g;
				$Return_String =~ s/\%44/D/g;
				$Return_String =~ s/\%45/E/g;
				$Return_String =~ s/\%46/F/g;
				$Return_String =~ s/\%47/G/g;
				$Return_String =~ s/\%48/H/g;
				$Return_String =~ s/\%49/I/g;
				$Return_String =~ s/\%4A/J/g;
				$Return_String =~ s/\%4B/K/g;
				$Return_String =~ s/\%4C/L/g;
				$Return_String =~ s/\%4D/M/g;
				$Return_String =~ s/\%4E/N/g;
				$Return_String =~ s/\%4F/O/g;
				$Return_String =~ s/\%50/P/g;
				$Return_String =~ s/\%51/Q/g;
				$Return_String =~ s/\%52/R/g;
				$Return_String =~ s/\%53/S/g;
				$Return_String =~ s/\%54/T/g;
				$Return_String =~ s/\%55/U/g;
				$Return_String =~ s/\%56/V/g;
				$Return_String =~ s/\%57/W/g;
				$Return_String =~ s/\%58/X/g;
				$Return_String =~ s/\%59/Y/g;
				$Return_String =~ s/\%5A/Z/g;
				$Return_String =~ s/\%5B/\[/g;
				$Return_String =~ s/\%5C/\\/g;
				$Return_String =~ s/\%5D/\]/g;
				$Return_String =~ s/\%5E/\^/g;
				$Return_String =~ s/\%5F/\_/g;

				$Return_String =~ s/\%60/\`/g;
				$Return_String =~ s/\%61/a/g;
				$Return_String =~ s/\%62/b/g;
				$Return_String =~ s/\%63/c/g;
				$Return_String =~ s/\%64/d/g;
				$Return_String =~ s/\%65/e/g;
				$Return_String =~ s/\%66/f/g;
				$Return_String =~ s/\%67/g/g;
				$Return_String =~ s/\%68/h/g;
				$Return_String =~ s/\%69/i/g;
				$Return_String =~ s/\%6A/j/g;
				$Return_String =~ s/\%6B/k/g;
				$Return_String =~ s/\%6C/l/g;
				$Return_String =~ s/\%6D/m/g;
				$Return_String =~ s/\%6E/n/g;
				$Return_String =~ s/\%6F/o/g;
				$Return_String =~ s/\%70/p/g;
				$Return_String =~ s/\%71/q/g;
				$Return_String =~ s/\%72/r/g;
				$Return_String =~ s/\%73/s/g;
				$Return_String =~ s/\%74/t/g;
				$Return_String =~ s/\%75/u/g;
				$Return_String =~ s/\%76/v/g;
				$Return_String =~ s/\%77/w/g;
				$Return_String =~ s/\%78/x/g;
				$Return_String =~ s/\%79/y/g;
				$Return_String =~ s/\%7A/z/g;
				$Return_String =~ s/\%7B/\{/g;
				$Return_String =~ s/\%7C/\|/g;
				$Return_String =~ s/\%7D/\}/g;
				$Return_String =~ s/\%7E/\~/g;
				$Return_String =~ s/\%7F/DEL/g;
			}
		return $Return_String;
	}

sub Delete_Banner
	{
		my $banner_unique_id		= shift;
		my $banner_dot_extension	= shift;
		my $Debug					= shift;
		my $MapHash					= shift;

		my $FileToDelete = $$MapHash{'DOS_BANNER_FOLDER'} . $$banner_unique_id . $$banner_dot_extension; 
		my $SystemCall = "del $FileToDelete";
			
		my $output = `$SystemCall`; 
		if($output eq "")
			{
				return "1";
			}
		else
			{
				return "-1";
			}
	} # End Delete_Picture.


# Scripts that are to be include with other scripts must end with "1;"
1;

