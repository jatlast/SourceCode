SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LogIn]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[LogIn]
GO



CREATE PROCEDURE [LogIn]
	@UserName varchar(32)
	, @Password varchar (16)
 AS

DECLARE @last_login datetime

/* Set the default values */
select @last_login = getdate()

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
	update login_info 
		set last_login = @last_login
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

