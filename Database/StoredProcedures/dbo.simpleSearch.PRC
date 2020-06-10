SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[simpleSearch]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[simpleSearch]
GO




CREATE PROCEDURE [simpleSearch]
 @Search int
, @IAm char(1)
, @Seeking char(1)
, @City varchar(32)
, @State varchar(2)
, @Country varchar(3)
, @MinAgeDesired varchar(2)
, @MaxAgeDesired varchar(2)
, @Limit int
, @Sort varchar(16)
, @Index varchar(6)

 AS

-- the SET string provides a slight performance gain for stored procedures
SET NOCOUNT ON

declare @GlobalRowCount INT
SELECT @GlobalRowCount = 500;

DECLARE @AlternativeMin	INT		-- Used as lower bound for sex_preference searches
DECLARE @AlternativeMax 	INT		-- Used as upper bound for sex_preference searches

-- Determine what sexual preference search needs to be performed...
IF (@IAm = @Seeking AND @IAm > "0")
BEGIN
	-- Same sex search...
	PRINT 'same sex search'
	SELECT @AlternativeMin = 2
	SELECT @AlternativeMax = 4
END
ELSE
	BEGIN
		-- Opposite sex search...
		PRINT 'opposite sex search'
		SELECT @AlternativeMin = 0
		SELECT @AlternativeMax = 1
	END
-- Check for city variable...
IF (@City = "")
BEGIN
	-- If no city has been entered then default to the match any string wildcard...
	SELECT @City = '%'
	PRINT 'City = ' + @City
END

-- Check for city variable...
IF (@State = "0")
BEGIN
	-- If no state has been entered then default to the match any string wildcard...
	SELECT @State = '%'
	PRINT 'State = ' + @State
END

-- Check for country variable...
IF (@Country = "0")
BEGIN
	-- If no country has been entered then default to the match any string wildcard...
	SELECT @Country = '%'
	PRINT 'Country = ' + @Country
END

-- Determin how the user whats the results ordered...
DECLARE @OrderBy CHAR(32) 	-- Holds the order by clause condition
IF( @Sort = 'user_name' )
	BEGIN
		SELECT @OrderBy = 'contact_info.user_name'
	END
ELSE
	IF( @Sort = 'state' )
		BEGIN
			SELECT @OrderBy = 'contact_info.state'
		END
	ELSE
		IF( @Sort = 'age' )
		BEGIN
			SELECT @OrderBy = 'personal_info.age'
		END
		ELSE
			IF( @Sort = 'creation_date' )
			BEGIN
				SELECT @OrderBy = 'login_info.creation_date DESC'
			END

PRINT 'Order by ' + @OrderBy

-- the SET ROWCOUNT limits the number of rows affected
SET ROWCOUNT @GlobalRowCount

/* Select the raw information by joining just the personal_info and relationship tables... */
SELECT CASE 
		WHEN COUNT(*) >= @GlobalRowCount THEN @GlobalRowCount
		ELSE COUNT(*)
	END 'Number of Rows'
	FROM login_info
		, contact_info
		, personal_info
		, about_info
	WHERE login_info.sex like @Seeking
	AND login_info.photo_submitted >= @Search
	AND personal_info.sex_preference >= @AlternativeMin
	AND personal_info.sex_preference <= @AlternativeMax
	AND contact_info.city like @City
	AND contact_info.state like @State
	AND contact_info.country like @Country
	AND personal_info.age >= @MinAgeDesired
	AND personal_info.age <= @MaxAgeDesired
	AND about_info.questionable = 0
	AND login_info.user_name = contact_info.user_name
	AND login_info.user_name = personal_info.user_name
	AND login_info.user_name = about_info.user_name

DECLARE @RowCount	INT -- Used to set the rowcount based on index and limit
SELECT @RowCount = ( @Index + @Limit + 2 )

SET ROWCOUNT @RowCount

-- Select the all the information by joining the tables... 
EXEC ('SELECT login_info.user_name as "user_name"
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
	SELECT login_info.user_name

		FROM login_info
			, contact_info
			, personal_info
			, about_info
		WHERE login_info.sex LIKE ''' + @Seeking +'''
		AND login_info.photo_submitted >= '''+ @Search + '''
		AND personal_info.sex_preference >= ''' + @AlternativeMin + '''
		AND personal_info.sex_preference <= ''' + @AlternativeMax + '''
		AND contact_info.city LIKE ''' + @City + '''
		AND contact_info.state LIKE ''' + @State + '''
		AND contact_info.country LIKE ''' + @Country + '''
		AND personal_info.age >= ''' + @MinAgeDesired + '''
		AND personal_info.age <= ''' + @MaxAgeDesired + '''
		AND about_info.questionable = 0
		AND login_info.user_name = contact_info.user_name
		AND login_info.user_name = personal_info.user_name
		AND login_info.user_name = about_info.user_name
	)

ORDER BY ' + @OrderBy
)

SET ROWCOUNT 0



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

