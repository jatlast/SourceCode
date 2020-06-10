SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[genOutbox]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[genOutbox]
GO



CREATE PROCEDURE [genOutbox]
	@UserName varchar(32)
	, @Password varchar (16)


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

BEGIN

	print 'Get message cound sent to the user'	
	select count(login_info.user_name) as "count"
	from login_info
		, mail
	where login_info.user_name = @UserName
		and login_info.password = @Password
		and mail.sender_deleted != 1
		and login_info.user_name = mail.sent_from


	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'Get messages sent to the user'
	select login_info.user_name
		, login_info.membership_type
		, mail.mail_id
		, mail.sent_to
		, mail.sent_from
		, mail.subject
		, mail.message_text
		, mail.when_sent
		, mail.when_read
		, mail.sender_deleted
		, mail.receiver_deleted
		, pictures.photo_1
	from login_info
		, mail
		, pictures
	where login_info.user_name = @UserName
		and login_info.password = @Password
		and mail.sender_deleted != 1
		and login_info.user_name = mail.sent_from
		and pictures.user_name = mail.sent_to
	order by mail.when_sent desc
return 0

END

else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 666
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

