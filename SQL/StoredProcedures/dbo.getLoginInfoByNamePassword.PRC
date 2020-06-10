SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getLoginInfoByNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getLoginInfoByNamePassword]
GO



CREATE PROCEDURE [getLoginInfoByNamePassword]
	@UserName varchar(32)
	, @Password varchar (16)
 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
/* Get raw login_info data */
	select	user_id
		, user_name
		, membership_type
		, password
		, password_hint
		, email
		, sex
		, creation_date
		, last_login
		, photo_submitted

	from login_info

	where user_name = @UserName
			and password = @Password

/* Get textual login_info data using a join */
	select	user_id
		, user_name
		, membership_type
		, password
		, password_hint
		, email
		, sex.choice as "sex"
		, creation_date
		, last_login
		, photo_submitted

	from login_info, sex

	where user_name = @UserName
			and password = @Password
			and login_info.sex = sex.value
	return 1
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

