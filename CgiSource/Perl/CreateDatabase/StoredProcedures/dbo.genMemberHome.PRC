SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[genMemberHome]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[genMemberHome]
GO



CREATE PROCEDURE [genMemberHome]
	@UserName varchar(32)
	, @Password varchar (16)
	, @PromoDaysRemaining char(8) = ' '

 AS

DECLARE @@PremiumDaysRemaining	CHAR(8)
DECLARE @@MembershipType 		CHAR(4)
DECLARE @@IsMembershipActive		CHAR(1)
DECLARE @@DateMembershipExpires	DATETIME

-- Get membership_type from login_info table...
SELECT @@MembershipType = (SELECT membership_type FROM login_info WHERE user_name = @UserName)
-- Get is_membership_active from billing_info table...
SELECT @@IsMembershipActive = (SELECT is_membership_active from billing_info where user_name = @UserName)
-- Get date_membership_expires from billing_info table...
SELECT @@DateMembershipExpires = (SELECT date_membership_expires from billing_info where user_name = @UserName)

-- Only change the default value of @PromoDaysRemaining if the membership_type_id is promotional...
if (
	select datediff(day, getdate(), membership_type.date_promotion_ended) 
	from membership_type
		, login_info
	where login_info.user_name = @UserName
	and login_info.membership_type = membership_type.membership_type_id
  ) != NULL
	BEGIN
		print 'Get PromoDaysRemaining'
		select @PromoDaysRemaining = (
							select datediff(day, getdate(), membership_type.date_promotion_ended) 
							from membership_type
								, login_info
							where login_info.user_name = @UserName
							and login_info.membership_type = membership_type.membership_type_id
						    )
	END
ELSE
	BEGIN
		print 'Dont get PromoDaysRemaining'
	END

select @@PremiumDaysRemaining = ''
IF(@@IsMembershipActive = '0' AND( @@MembershipType = '1' OR  @@MembershipType = '2') )
	BEGIN
		print 'Get PremiumDaysRemaining'
		select @@PremiumDaysRemaining = (
							select datediff(day, getdate(), @@DateMembershipExpires) 
							from billing_info
							where billing_info.user_name = @UserName
						    )
	END
ELSE
	BEGIN
		print 'Dont get PremiumDaysRemaining'
	END


if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'Get login_info table information'
	select login_info.user_name
		, login_info.membership_type
		, membership_type.membership_type_name
		, login_info.photo_submitted
		, about_info.questionable
		, @PromoDaysRemaining AS 'PromoDaysRemaining'
		, @@IsMembershipActive AS 'IsMembershipActive'
		, @@PremiumDaysRemaining AS 'PremiumDaysRemaining'
	from login_info
		, about_info
		, membership_type
	where login_info.user_name = @UserName
		and login_info.password = @Password
		and login_info.user_name = about_info.user_name
		and login_info.membership_type = membership_type.membership_type_id

	print 'Get messages sent to the user'
	select mail.mail_id
		, mail.sent_to
		, mail.sent_from
		, mail.subject
		, mail.message_text
		, mail.when_sent
		, mail.when_read
		, mail.sender_deleted
		, mail.receiver_deleted
	from mail
	where mail.sent_to = @UserName

	PRINT 'Update last_login'
	UPDATE login_info
	SET last_login =  GETDATE()
	WHERE user_name = @UserName

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

