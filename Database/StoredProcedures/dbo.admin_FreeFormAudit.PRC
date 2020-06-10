SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_FreeFormAudit]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_FreeFormAudit]
GO



CREATE PROCEDURE [admin_FreeFormAudit]
@OrderBy CHAR(26)		= 'login_info.creation_date'
, @AscDesc CHAR(4)		= 'DESC'
, @Limit INT			= 100
, @Index CHAR(6)		= '1'
, @UserName VARCHAR(32)	= '%'

 AS

-- the SET string provides a slight performance gain for stored procedures
SET NOCOUNT ON

PRINT 'Order by ' + @OrderBy  + @AscDesc

-- If UserName != "%" the user entered data to search for 
IF (@UserName != "%")
BEGIN
	PRINT 'user entered a user_name'
	-- Pad with SQL wildcards for searching 
	SELECT @UserName = ( SELECT ( @UserName + '%') )
END

PRINT 'user_name = ' + @UserName

DECLARE @RowCount INT -- Used to set the rowcount based on index and limit
SELECT @RowCount = ( @Index + @Limit + 1 )

-- count the total number of rows in the login_info table...
SELECT COUNT(*) AS "count"
	FROM login_info

SET ROWCOUNT @RowCount

PRINT 'SQL:  SELECT login_info.user_name		AS "user_name"
		, login_info.password		AS "password"
		, login_info.email		AS "email"
		, login_info.sex			AS "sex"
		, pictures.photo_1		AS "photo_1"
		, pictures.photo_2		AS "photo_2"
		, pictures.photo_3		AS "photo_3"
		, pictures.photo_4		AS "photo_4"
		, pictures.photo_5		AS "photo_5"
		, contact_info.last_name		AS "last_name"
		, contact_info.city		AS "city"
		, about_info.screen_quote	AS "screen_quote"
		, about_info.about_yourself	AS "about_yourself"
		, about_info.questionable	AS "questionable"
		, login_info.creation_date	AS "creation_date"
		, login_info.last_login		AS "last_login"
	FROM login_info
		, pictures
		, contact_info
		, about_info
	WHERE login_info.user_name LIKE ''' + @UserName + '''
		AND login_info.user_name = pictures.user_name
		AND login_info.user_name = contact_info.user_name
		AND login_info.user_name = about_info.user_name
	ORDER BY ' + @OrderBy + @AscDesc

EXEC ('SELECT login_info.user_name		AS "user_name"
		, login_info.password		AS "password"
		, login_info.email		AS "email"
		, login_info.sex			AS "sex"
		, pictures.photo_1		AS "photo_1"
		, pictures.photo_2		AS "photo_2"
		, pictures.photo_3		AS "photo_3"
		, pictures.photo_4		AS "photo_4"
		, pictures.photo_5		AS "photo_5"
		, contact_info.last_name		AS "last_name"
		, contact_info.city		AS "city"
		, about_info.screen_quote	AS "screen_quote"
		, about_info.about_yourself	AS "about_yourself"
		, about_info.questionable	AS "questionable"
		, login_info.creation_date	AS "creation_date"
		, login_info.last_login		AS "last_login"
	FROM login_info
		, pictures
		, contact_info
		, about_info
	WHERE login_info.user_name LIKE ''' + @UserName + '''
		AND login_info.user_name = pictures.user_name
		AND login_info.user_name = contact_info.user_name
		AND login_info.user_name = about_info.user_name
	ORDER BY ' + @OrderBy + @AscDesc
) -- end EXEC


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

