SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[mailSend]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[mailSend]
GO



CREATE PROCEDURE [mailSend]
@MailId int -- not used
, @SentTo varchar(32)
, @SentFrom varchar(32)
, @Subject varchar(128)
, @MessageText varchar(3000)
, @WhenSent datetime
, @WhenRead datetime
, @SenderDeleted int --not used
, @ReceiverDeleted int --not used

 AS

-- Verify Permissions
DECLARE @@AllowSend char(4)
DECLARE @@AllowReply char(4)

EXEC @@AllowSend = verifyMembershipTypePermissions  @SentFrom, 'allow_mail_send'
EXEC @@AllowReply = verifyMembershipTypePermissions  @SentFrom, 'allow_mail_reply'

--if ( @@AllowSend != 1 OR @@AllowReply != 1)
--	BEGIN--  DENIED
--		print 'You must upgrade your membership to use this feature 1'
--		return @@AllowReply
--	END

-- UserId must be declared 
DECLARE @@MailId int
-- Get the maximum +1 mail_id number fron the mail table 
select @@MailId = max(mail_id + 1) from mail

--  If there are no mail ids in the database this is the first and therefore #1 
if @@MailId is NULL
select @@MailId = 1

DECLARE @@MembershipType int
-- Set the default values 
select @WhenSent = getdate()
select @@MembershipType = (select membership_type from login_info where user_name = @SentFrom)

-- Determine if the user_name has mailing permission in the login_info table
if (@@AllowSend = 1 or @SentFrom = 'Administrator')
BEGIN
print 'user has send permission'
	if exists (select user_name from login_info where user_name = @SentTo)
	BEGIN
		-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
		print 'Posting new mail message to mail table'
		insert into mail ( mail_id
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
			, @Subject
			, @MessageText
			, @WhenSent
			, 0	
			, 0	
			)
	return 0
	END
	else
	BEGIN
		-- If the user_name does not exist exit with a return value of 666 
		print 'user_name does not exist'
		return 665
	END
END
else
if (@@AllowReply = 1)
BEGIN
print 'user has reply permission'
	if (
	 exists (select user_name from login_info where user_name = @SentTo)
	and exists (select sent_from from mail where sent_to = @SentFrom AND sent_from = @SentTo)
	)
	BEGIN
		-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
		print 'Posting new mail message to mail table'
		insert into mail ( mail_id
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
			, @Subject
			, @MessageText
			, @WhenSent
			, 0	
			, 0	
			)
	return 0
	END
	else
	BEGIN
		-- If the user_name does not exist exit with a return value of 666 
		print 'user_name does not exist or not a reply'
		return 665
	END
END
else
BEGIN--  DENIED
	print 'You must upgrade your membership to use this feature 2'
	return @@AllowReply
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

