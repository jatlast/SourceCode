SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[hideUnhideProfile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[hideUnhideProfile]
GO



CREATE PROCEDURE [hideUnhideProfile]
	@UserName varchar(32)
	, @Password varchar (16)

 AS

if ( (select password from login_info where user_name = @UserName) = @Password)
BEGIN
	if ( (select questionable from about_info where user_name = @UserName) = 0)
	BEGIN
		print 'Hide user profile'
		update about_info
		set questionable = 1
		where user_name = @UserName
	END
	else
	if ( (select questionable from about_info where user_name = @UserName) = 1)
	BEGIN
		print 'Unhide user profile'
		update about_info
		set questionable = 0
		where user_name = @UserName
	END
END
else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 137
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

