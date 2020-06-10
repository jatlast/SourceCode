SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getAboutInfoByNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getAboutInfoByNamePassword]
GO



CREATE PROCEDURE [getAboutInfoByNamePassword]
	@UserName varchar(32)
	, @Password varchar (16)
 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
/* Get raw info */
	select user_name
		, screen_quote
		, about_yourself
		, questionable
	from about_info
	where user_name = @UserName

/* this is only needed to conform with the common database call that expects two result sets*/
	select user_name
		, screen_quote
		, about_yourself
		, questionable
	from about_info
	where user_name = @UserName

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

