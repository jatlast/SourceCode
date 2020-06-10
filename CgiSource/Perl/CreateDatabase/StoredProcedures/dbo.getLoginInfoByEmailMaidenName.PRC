SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getLoginInfoByEmailMaidenName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getLoginInfoByEmailMaidenName]
GO



CREATE PROCEDURE [getLoginInfoByEmailMaidenName]
	@Email varchar(32)
	, @MaidenName varchar (32)

 AS

if ( (select password_hint from login_info where email = @Email) = @MaidenName)
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

	where email = @Email
		and password_hint = @MaidenName

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

	from login_info
		, sex

	where login_info.email = @Email
		and login_info.password_hint = @MaidenName
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

