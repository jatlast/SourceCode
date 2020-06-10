SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[genPicUpload]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[genPicUpload]
GO



CREATE PROCEDURE [genPicUpload]
	@UserName varchar(32)
	, @Password varchar (16)


 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'Get picture table information'
	select pictures.user_name
		, pictures.photo_1
		, pictures.photo_2
		, pictures.photo_3
		, pictures.photo_4
		, pictures.photo_5
	from pictures
	where pictures.user_name = @UserName

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

