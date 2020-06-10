SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[massMail_FindDuplicates]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[massMail_FindDuplicates]
GO



CREATE PROCEDURE [massMail_FindDuplicates]
 @DupToFind VARCHAR(64) 		= 'email'
, @TableWithDup VARCHAR(64) 	= 'login_info'

 AS

-- the SET string provides a slight performance gain for stored procedures
SET NOCOUNT ON

PRINT 'Order by ' + @TableWithDup + '.' + @DupToFind


-- count the total number of rows in the login_info table...
EXEC ( 'SELECT ' + @DupToFind + '
		INTO #dups FROM  ' + @TableWithDup + '
		GROUP BY ' + @DupToFind + '
		HAVING COUNT(*) > 1

SELECT COUNT(*) AS "count"
	FROM ' + @TableWithDup +'
		, #dups
	WHERE ' + @TableWithDup + '.' + @DupToFind + ' = #dups.' + @DupToFind + '


SELECT login_info.user_name		AS "user_name"
		, login_info.password		AS "password"
		, login_info.email		AS "email"
		, sex.choice			AS "sex"
		, pictures.photo_1		AS "photo_1"
		, pictures.photo_2		AS "photo_2"
		, pictures.photo_3		AS "photo_3"
		, pictures.photo_4		AS "photo_4"
		, pictures.photo_5		AS "photo_5"
		, contact_info.first_name		AS "first_name"
		, contact_info.last_name		AS "last_name"
		, contact_info.street_address	AS "street_address"
		, contact_info.city		AS "city"
		, state.choice			AS "state"
		, country.choice			AS "country"
		, contact_info.zip		AS "zip"
		, contact_info.telephone		AS "telephone"
		, about_info.screen_quote	AS "screen_quote"
		, about_info.about_yourself	AS "about_yourself"
		, about_info.questionable	AS "questionable"
		, login_info.creation_date	AS "creation_date"
		, login_info.last_login		AS "last_login"
	FROM login_info
		, pictures
		, contact_info
		, about_info
		, sex
		, state
		, country
		, #dups
	WHERE ' + @TableWithDup + '.' + @DupToFind + ' = #dups.' + @DupToFind + '
		AND login_info.user_name = pictures.user_name
		AND login_info.user_name = contact_info.user_name
		AND login_info.user_name = about_info.user_name
		AND login_info.sex = sex.value
		AND contact_info.state = state.value
		AND contact_info.country = country.value
	ORDER BY  ' + @TableWithDup  + '.' + @DupToFind
) -- end EXEC


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

