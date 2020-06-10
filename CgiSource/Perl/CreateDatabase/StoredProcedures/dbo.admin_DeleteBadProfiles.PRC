SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_DeleteBadProfiles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_DeleteBadProfiles]
GO


CREATE PROCEDURE [admin_DeleteBadProfiles]
 AS
/*
	the criteria:
	1)	creation_date = last_login
	2)	No Photo
	3)	No screen_quote
	4)	No about_yourself
	5)	Never has been a paying member
	6)	Has not logged in for at least an hour
*/

while	(
	select count(login_info.user_name) as 'Bad_Profiles'
	from login_info
		, about_info
	where login_info.last_login < dateadd( hour, -1, getdate() )
		and login_info.date_started_paying IS NULL
		and login_info.creation_date = login_info.last_login
		and login_info.photo_submitted = 0
		and
		 (
			(CONVERT( VARCHAR(32), about_info.screen_quote ) = '')
		    OR
	            		(CONVERT( VARCHAR(32), about_info.screen_quote ) = 'User did not enter any text')
		 )				
		and
		 (
			(CONVERT( VARCHAR(32), about_info.about_yourself ) = '')
		    OR
			(CONVERT( VARCHAR(32), about_info.about_yourself ) = 'User did not enter any text')
		)				
		and login_info.user_name = about_info.user_name
	) > 0
Begin
	declare @UserName varchar(32)
	select @UserName = (
				select max(login_info.user_name) as 'User_Name_To_Remove'
				from login_info
					, about_info
				where login_info.last_login < dateadd( hour, -1, getdate() )
					and login_info.date_started_paying IS NULL
					and login_info.creation_date = login_info.last_login
					and login_info.photo_submitted = 0
					and
					 (
						(CONVERT( VARCHAR(32), about_info.screen_quote ) = '')
					    OR
				            		(CONVERT( VARCHAR(32), about_info.screen_quote ) = 'User did not enter any text')
					 )				
					and
					 (
						(CONVERT( VARCHAR(32), about_info.about_yourself ) = '')
					    OR
						(CONVERT( VARCHAR(32), about_info.about_yourself ) = 'User did not enter any text')
					)				
					and login_info.user_name = about_info.user_name
			   )

	exec admin_DeleteEntireProfileByUserName @UserName
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

