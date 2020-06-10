SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[readReceivedMail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[readReceivedMail]
GO



CREATE PROCEDURE [readReceivedMail]
	@UserName varchar(32)
	, @Password varchar (16)
	, @MailId varchar (16)
 AS

-- START Verify Permissions
DECLARE @@ReturnValue char(4)

EXEC @@ReturnValue = verifyMembershipTypePermissions  @UserName, 'allow_mail_read'
-- Check membership_type for permission
if ( @@ReturnValue != 1	)
	BEGIN--  DENIED
		print 'You must upgrade your membership to use this feature'
		return @@ReturnValue
	END
-- END Verify Permissions

if ( (select password from login_info where user_name = @UserName) = @Password)
	BEGIN-- Begin user_name and password match
		-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
		print 'Retrieving actual mail message from mail table'
		select mail.mail_id
			, mail.sent_to
			, mail.sent_from
			, mail.subject
			, mail.message_text
			, mail.when_sent
			, mail.when_read
			, mail.sender_deleted
			, mail.receiver_deleted
			, contact_info.city
			, contact_info.state
			, personal_info.age
			, pictures.photo_1
		from mail
		, contact_info
		, personal_info
		, state
		, pictures
		where @MailId like mail.mail_id
		and state.value = contact_info.state
		and contact_info.user_name = mail.sent_from
		and personal_info.user_name = mail.sent_from
		and mail.sent_to = @UserName
		and pictures.user_name = mail.sent_from

		print 'Retrieving data mail message from mail table'
		select mail.mail_id
			, mail.sent_to
			, mail.sent_from
			, mail.subject
			, mail.message_text
			, mail.when_sent
			, mail.when_read
			, mail.sender_deleted
			, mail.receiver_deleted
			, contact_info.city
			, state.choice as "state"
			, personal_info.age
			, pictures.photo_1
		from mail
		, contact_info
		, personal_info
		, state
		, pictures
		where @MailId like mail.mail_id
		and state.value = contact_info.state
		and contact_info.user_name = mail.sent_from
		and personal_info.user_name = mail.sent_from
		and mail.sent_to = @UserName
		and pictures.user_name = mail.sent_from

		print 'Updating when_read mail field'
		update mail
		set when_read= getdate()
		where @MailId like mail.mail_id

	return 0
	END-- End user_name and password match
ELSE
	BEGIN-- Begin user_name and password DON'T match
		-- If the user_name does not exist exit with a return value of 666 
		print 'ERROR: User Name and Password did not match.'
		return 134
	END-- End user_name and password DON'T match


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

