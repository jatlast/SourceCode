SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getEmailByUserName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getEmailByUserName]
GO



CREATE PROCEDURE [getEmailByUserName]
	@UserName varchar(32)
 AS

BEGIN
/* Get raw login_info data */
	select email as 'email'
	from login_info
	where user_name = @UserName
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

