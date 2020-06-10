SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[mailSendNewUserWelcome]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[mailSendNewUserWelcome]
GO


CREATE PROCEDURE [mailSendNewUserWelcome]
@SentFrom varchar(32)
, @SentTo varchar(32)

 AS

DECLARE @@WhenSent datetime
DECLARE @@MessageText VARCHAR(3000)
-- UserId must be declared 
DECLARE @@MailId int
-- Get the maximum +1 mail_id number fron the mail table 
select @@MailId = max(mail_id + 1) from mail

SELECT @@MessageText =  'Thank you for filling out your profile and becoming a Basic member!

Below you will find information about what features are available to our members.

As you may have noticed before you became a member you were able to execute a Simple Search.  This is the only feature a non-member is allowed to use.  But now that you have become a Basic member, simply by filling out your profile, you are given access to many of the more advanced features.  As a Basic member you are given access to the additional features:

<UL>
	<LI><A HREF="GenInbox.exe">Receive Mail</A>
	<LI>Reply Only To Received Mail
	<LI><A HREF="GenBookmarks.exe">Bookmarks</A>
	<LI>Hide / Unhide Profile
	<LI><A HREF="GenOutbox.exe">View Sent Mail</A>
	<LI><A HREF="SingleProfile.exe?user_name=' + @SentTo + '">View Your Profile</A>
	<LI><A HREF="UpdateLogin.exe">Update Your Profile</A>
	<LI><A HREF="GenPicUpload.exe">Upload Pictures</A>
</UL>	

If you decide you would like access to every feature we provide simply <A HREF="../PaymentOptions.html">become a Premium member</A> and receive access to the additional features:

<UL>
	<LI>Advanced Search
	<LI>Send Mail To Any Member
	<LI>View Detailed Profiles
	<LI>View Enlarged Pictures
</UL>	

If you have any questions please reply to this mail and we will gladly do what we can to make your time with us as enjoyable as we can.

Thank you again and we hope you enjoy your time with us.

Administrator
'
--  If there are no mail ids in the database this is the first and therefore #1 
if @@MailId is NULL
select @@MailId = 1

-- Set the default values 
select @@WhenSent = getdate()



if exists (select user_name from login_info where user_name = @SentTo)
BEGIN
	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'Posting new mail message to mail table'
	insert into mail (mail_id
			, sent_to
			, sent_from
			, subject
			, message_text
			, when_sent
			, sender_deleted
			, receiver_deleted
			) 
	values ( @@MailId
		, @SentTo
		, @SentFrom
		, 'Welcome!'
		, @@MessageText
		, @@WhenSent
		, 0	
		, 0	
		)
return 0
END
else
BEGIN
	-- If the user_name does not exist exit with a return value of 666 
	print 'user_name does not exist'
	return 666
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

