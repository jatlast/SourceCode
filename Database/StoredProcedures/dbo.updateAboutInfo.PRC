SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updateAboutInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updateAboutInfo]
GO



CREATE PROCEDURE [updateAboutInfo]
@UserName varchar(32)
, @ScreenQuote varchar(128)
, @AboutYourself varchar(3000)
, @Questionable char

 AS

	/* update the about_info table and exit with a return value of 1 */
	
update about_info 
	set user_name =	@UserName
		, screen_quote = @ScreenQuote
		, about_yourself = @AboutYourself
		, questionable = @Questionable
	where user_name = @UserName

return 1


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

