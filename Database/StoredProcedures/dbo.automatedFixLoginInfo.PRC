SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[automatedFixLoginInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[automatedFixLoginInfo]
GO



CREATE PROCEDURE [automatedFixLoginInfo]
@UserName varchar(32)
, @Sex char

 AS

BEGIN
	print 'automatic sex change operation'
	update login_info 
		set sex = @Sex
		where user_name = @UserName
	return 1
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

