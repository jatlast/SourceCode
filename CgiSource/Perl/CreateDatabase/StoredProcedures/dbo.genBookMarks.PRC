SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[genBookMarks]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[genBookMarks]
GO



CREATE PROCEDURE [genBookMarks]
	@UserName varchar(32)
	, @Password varchar (16)
 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
	print 'Get total count'
	SELECT COUNT (*) AS  "count"
	FROM login_info
	WHERE user_name IN
		(
		SELECT book_mark
			FROM book_marks
			WHERE user_name = @UserName
		)

	print 'Get  table information'
	SELECT login_info.user_name as "user_name"
		, contact_info.city as "city"
		, state.choice as "state"
		, country.choice as "country"
		, personal_info.age as "age"
		, about_info.screen_quote as "screen_quote"
		, about_info.about_yourself as "about_yourself"
		, pictures.photo_1 as "pic 1"
	FROM login_info
		, contact_info
		, personal_info
		, about_info
		, state
		, country
		, pictures
	WHERE login_info.user_name = contact_info.user_name
		AND login_info.user_name = personal_info.user_name
		AND login_info.user_name = about_info.user_name
		AND login_info.user_name = pictures.user_name
		AND contact_info.state = state.value
		AND contact_info.country = country.value
		AND login_info.user_name in 
		(
		SELECT book_mark
			FROM book_marks
			WHERE user_name = @UserName
		)
	return 0
END
else
BEGIN
	print 'ERROR: User Name and Password did not match genBookMarks.'
	return 666
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

