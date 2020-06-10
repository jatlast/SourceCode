SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[deleteMail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[deleteMail]
GO



CREATE PROCEDURE [deleteMail]
	@UserName varchar(32)
	, @Password varchar (16)
	, @MailId varchar (16)


 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	if ( (select sent_from from mail where mail_id = @MailId) = @UserName)
	BEGIN
		print 'Update sender_deleted in mail table'
		update mail
		set sender_deleted = 1
		where mail_id = @MailId
		and @UserName = sent_from
	END

	if ( (select sent_to from mail where mail_id = @MailId) = @UserName)
	BEGIN
		print 'Update receiver_deleted in mail table'
		update mail
		set receiver_deleted = 1
		where mail_id = @MailId
		and @UserName = sent_to

		print 'Update when_read in mail table'
		update mail
		set receiver_deleted = 1
		, when_read = getdate()
		where mail_id = @MailId
		and @UserName = sent_to
		and when_read = NULL
	return 0
	END
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

