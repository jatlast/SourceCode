SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[checkUsernamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[checkUsernamePassword]
GO



CREATE PROCEDURE [checkUsernamePassword]
	@UserName varchar(32)
	, @Password varchar (16)

 AS

if ( (select password from login_info where user_name = @UserName) = @Password)
BEGIN
	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'Valid user_name and password combination'
return 0
END
else
BEGIN
	print 'user_name and password did not match.'
	return 666
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

