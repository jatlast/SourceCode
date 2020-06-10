SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[advancedSearch]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[advancedSearch]
GO



CREATE PROCEDURE [advancedSearch]
@Search INT
, @IAm CHAR
, @Seeking CHAR
, @MaritalStatus VARCHAR(2)
, @City VARCHAR(32)
, @State VARCHAR(2)
, @Country VARCHAR(3)
, @Profession VARCHAR(2)
, @Income VARCHAR(2)
, @Education VARCHAR(2)
, @Religion VARCHAR(2)
, @MinAgeDesired VARCHAR(2)
, @MaxAgeDesired VARCHAR(2)
, @MinHeight VARCHAR(2)
, @MaxHeight VARCHAR(2)
, @MinWeight VARCHAR(2)
, @MaxWeight VARCHAR(2)
, @Eyes VARCHAR(2)
, @Hair VARCHAR(2)
, @Cook VARCHAR(2)
, @Smoke VARCHAR(2)
, @Drink VARCHAR(2)
, @Party VARCHAR(2)
, @Political VARCHAR(2)
, @HousingStatus VARCHAR(2)
, @Relationship VARCHAR(2)
, @TextSearch VARCHAR(64)
, @WhichFields VARCHAR(2)
, @Limit INT
, @Sort VARCHAR(16)
, @Index VARCHAR(6)
, @UserName VARCHAR(32)

 AS

-- START Verify Permissions
DECLARE @@ReturnValue char(4)

EXEC @@ReturnValue = verifyMembershipTypePermissions  @UserName, 'allow_search_advanced'
-- Check membership_type for permission
if ( @@ReturnValue != 1	)
	BEGIN--  DENIED
		print 'You must upgrade your membership to use this feature'
		return @@ReturnValue
	END
-- END Verify Permissions

-- the SET string provides a slight performance gain for stored procedures
SET NOCOUNT ON

declare @GlobalRowCount INT
SELECT @GlobalRowCount = 100;

declare @AlternativeMin INT
declare @AlternativeMax INT

-- hold the relationship types
declare @prefer_not_to_say CHAR
declare @any_relationship CHAR
declare @hang_out CHAR
declare @short_term CHAR
declare @long_term CHAR
declare @talk_email CHAR
declare @photo_exchange CHAR
declare @marriage CHAR
declare @other CHAR

-- set all relationship types to a non existant value
SELECT @prefer_not_to_say = 9
SELECT @any_relationship = 9
SELECT @hang_out = 9
SELECT @short_term = 9
SELECT @long_term = 9
SELECT @talk_email = 9
SELECT @photo_exchange = 9
SELECT @marriage = 9
SELECT @other = 9


IF (@IAm = @Seeking AND @IAm > "0")
BEGIN
	-- If the user is searching same sex set Alternative to true 
	PRINT 'same sex search'
	SELECT @AlternativeMin = 2
	SELECT @AlternativeMax = 4
END
else
BEGIN
	-- If the user is searching opposite sex OR all set Alternative to false 
	PRINT 'opposite sex search'
	SELECT @AlternativeMin = 0
	SELECT @AlternativeMax = 1
END

-- If MaritalStatus = 0 user is searching all types of status 
IF (@MaritalStatus = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @MaritalStatus = '%'
END

	-- If City != "" the user entered data to search for 
IF (@City != "")
BEGIN
	-- Pad with SQL wildcards for searching 
	SELECT @City = ( SELECT ('%' + @City + '%') )
END
	-- If City = "" the user did not narrow the search by city 
IF (@City = "")
BEGIN
	-- add an SQL wildcard for searching 
	SELECT @City = '%'
END
	-- If State = 0 the user did not narrow the search by state 
IF (@State = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @State = '%'
END

	-- If Country = 0 the user did not narrow the search by country 
IF (@Country = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Country = '%'
END

-- If Profession = 0 the user did not narrow the search by profession 
IF (@Profession = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Profession = '%'
END

-- If Income = 0 the user did not narrow the search by income 
IF (@Income = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Income = '0'
END

-- If Education = 0 the user did not narrow the search by education 
IF (@Education = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Education = '%'
END

-- If Religion = 0 the user did not narrow the search by religion 
IF (@Religion = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Religion = '%'
END

-- If Eyes = 0 the user did not narrow the search by eye color 
IF (@Eyes = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Eyes = '%'
END

-- If Hair = 0 the user did not narrow the search by hair color 
IF (@Hair = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Hair = '%'
END

-- If Cook = 0 the user did not narrow the search by cooking abilities 
IF (@Cook = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Cook = '%'
END

-- If Smoke = 0 the user did not narrow the search by smoking habits 
IF (@Smoke = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Smoke = '%'
END

-- If Drink = 0 the user did not narrow the search by Drinking habits 
IF (@Drink = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Drink = '%'
END

-- If Party = 0 the user did not narrow the search by the amount of partying 
IF (@Party = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Party = '%'
END

-- If Political = 0 the user did not narrow the search by political affiliation 
IF (@Political = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Political = '%'
END

-- If HousingStatus = 0 the user did not narrow the search by housing status 
IF (@HousingStatus = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @HousingStatus = '%'
END


--------------- Initialize the proper relationship types

IF (@Relationship = "1")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @prefer_not_to_say = 1

END

IF (@Relationship = "2")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @hang_out = 1

END

IF (@Relationship = "3")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @short_term = 1

END

IF (@Relationship = "4")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @long_term = 1

END

IF (@Relationship = "5")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @talk_email = 1

END

IF (@Relationship = "6")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @photo_exchange = 1

END

IF (@Relationship = "7")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @marriage = 1

END

IF (@Relationship = "8")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @other = 1

END
------------------------------------------------

-- If TextSearch != "" the user entered a text string to search for 
IF (@TextSearch != "")
BEGIN
	-- Pad with SQL wildcard for searching 
	SELECT @TextSearch = ( SELECT ('%' + @TextSearch + '%') )
END

-- If TextSearch = "" the euser did not enter a text string to search for 
IF (@TextSearch = "")
BEGIN
	-- Add an SQL wildcard for searching 
	SELECT @TextSearch = '%' 
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

DECLARE @RowCount	INT -- Used to set the rowcount based on index and limit
SELECT @RowCount = ( @Index + @Limit + 2 )

-- the SET ROWCOUNT limits the number of rows affected
SET ROWCOUNT @GlobalRowCount


-- If WhichFields = 1 AND TextSearch != '%' the user is looking for a user_name
IF (@WhichFields = "1" AND @TextSearch != '%')
BEGIN
		PRINT 'Find a single user_name'
-- Start DO NOT limit search by relationship type
IF (@Relationship = 0)
BEGIN
	PRINT 'Any Relationship count'
	-- Select the raw information by joining just the personal_info and relationship tables... 
		SELECT CASE 
				WHEN COUNT(*) >= @GlobalRowCount THEN @GlobalRowCount
				ELSE COUNT(*)
			END 'Number of Rows 1'
		FROM login_info 
			, contact_info
			, personal_info
			, about_info
		WHERE login_info.user_name LIKE @TextSearch
		AND about_info.questionable = 0
		AND login_info.photo_submitted >= @Search
		AND login_info.sex LIKE @Seeking
		AND CONVERT (INT, personal_info.sex_preference) >= @AlternativeMin
		AND CONVERT (INT, personal_info.sex_preference) <= @AlternativeMax

		AND personal_info.marital_status LIKE @MaritalStatus
		AND contact_info.city LIKE @City
		AND contact_info.state LIKE @State
		AND contact_info.country LIKE @Country
		AND personal_info.profession LIKE @Profession
		AND CONVERT (INT, personal_info.income) >= @Income
		AND personal_info.education LIKE @Education
		AND personal_info.religion LIKE @Religion

		AND CONVERT (INT, personal_info.age) >= @MinAgeDesired
		AND CONVERT (INT, personal_info.age) <= @MaxAgeDesired

		AND CONVERT (INT, personal_info.height) >= @MinHeight
		AND CONVERT (INT, personal_info.height) <= @MaxHeight
		AND CONVERT (INT, personal_info.weight) >= @MinWeight
		AND CONVERT (INT, personal_info.weight) <= @MaxWeight

		AND personal_info.eyes LIKE @Eyes
		AND personal_info.hair LIKE @Hair
		AND personal_info.cook LIKE @Cook
		AND personal_info.smoke LIKE @Smoke
		AND personal_info.drink LIKE @Drink
		AND personal_info.party LIKE @Party
		AND personal_info.political LIKE @Political		
		AND personal_info.housing_status LIKE @HousingStatus

		AND login_info.user_name = contact_info.user_name
		AND login_info.user_name = personal_info.user_name
		AND login_info.user_name = about_info.user_name

		PRINT 'Any Relationship Sort by ' + @OrderBy
		
SET ROWCOUNT @RowCount
		-- Select the raw information by joining just the personal_info and relationship tables... 
		EXEC ('SELECT login_info.user_name AS "user_name"
			, contact_info.city AS "city"
			, state.choice AS "state"
			, country.choice AS "country"
			, personal_info.age AS "age"
			, about_info.screen_quote AS "screen_quote"
			, about_info.about_yourself AS "about_yourself"
			, pictures.photo_1 AS "pic 1"

		FROM login_info
			, contact_info
			, personal_info
			, about_info
			, state
			, country
			, pictures
		WHERE login_info.user_name LIKE ''' + @TextSearch + '''
			AND login_info.photo_submitted >= ''' + @Search + '''
			AND login_info.user_name = contact_info.user_name
			AND login_info.user_name = personal_info.user_name
			AND login_info.user_name = about_info.user_name
			AND login_info.user_name = pictures.user_name
			AND contact_info.state = state.value
			AND contact_info.country = country.value
			AND personal_info.user_name IN 
			(
			SELECT login_info.user_name
				FROM login_info
					, contact_info
					, personal_info
					, about_info
				WHERE login_info.sex LIKE ''' + @Seeking + '''
				AND about_info.questionable = 0
				AND CONVERT (INT, personal_info.sex_preference) >= ''' + @AlternativeMin + '''
				AND CONVERT (INT, personal_info.sex_preference) <= ''' + @AlternativeMax + '''
	
				AND personal_info.marital_status LIKE ''' + @MaritalStatus + '''
				AND contact_info.city LIKE ''' + @City + '''
				AND contact_info.state LIKE ''' + @State + '''
				AND contact_info.country LIKE ''' + @Country + '''
				AND personal_info.profession LIKE ''' + @Profession + '''
				AND CONVERT (INT, personal_info.income) >= ''' + @Income + '''
				AND personal_info.education LIKE ''' + @Education + '''
				AND personal_info.religion LIKE ''' + @Religion + '''
		
				AND CONVERT (INT, personal_info.age) >= ''' + @MinAgeDesired + '''
				AND CONVERT (INT, personal_info.age) <= ''' + @MaxAgeDesired + '''
		
				AND CONVERT (INT, personal_info.height) >= ''' + @MinHeight + '''
				AND CONVERT (INT, personal_info.height) <= ''' + @MaxHeight + '''
				AND CONVERT (INT, personal_info.weight) >= ''' + @MinWeight + '''
				AND CONVERT (INT, personal_info.weight) <= ''' + @MaxWeight + '''

	
				AND personal_info.eyes LIKE ''' + @Eyes + '''
				AND personal_info.hair LIKE ''' + @Hair + '''
				AND personal_info.cook LIKE ''' + @Cook + '''
				AND personal_info.smoke LIKE ''' + @Smoke + '''
				AND personal_info.drink LIKE ''' + @Drink + '''
				AND personal_info.party LIKE ''' + @Party + '''
				AND personal_info.political LIKE ''' + @Political + '''
				AND personal_info.housing_status LIKE ''' + @HousingStatus + '''
		
				AND login_info.user_name = contact_info.user_name
				AND login_info.user_name = personal_info.user_name
				AND login_info.user_name = about_info.user_name
			)
	ORDER BY ' + @OrderBy
	) -- end EXEC
SET ROWCOUNT 0
		RETURN 1
END -- Relationship = 0 "Any"


-- Start Limit search by relationship type
IF (@Relationship != 0)
BEGIN
PRINT 'Limit Relationship Count'
-- Select the raw information by joining just the personal_info and relationship tables... 

SELECT CASE 
		WHEN COUNT(*) >= @GlobalRowCount THEN @GlobalRowCount
		ELSE COUNT(*)
	END 'Number of Rows 2'
	FROM relationship 
	WHERE relationship.user_name LIKE @TextSearch
		AND
		(
		relationship.prefer_not_to_say = @prefer_not_to_say	
		OR relationship.hang_out = @hang_out
		OR relationship.short_term = @short_term		
		OR relationship.long_term = @long_term				
		OR relationship.talk_email = @talk_email		
		OR relationship.photo_exchange = @photo_exchange		
		OR relationship.marriage = @marriage				
		OR relationship.other = @other
		)
		AND relationship.user_name IN 
		(
		SELECT login_info.user_name
			FROM login_info
				, contact_info
				, personal_info
				, about_info
			WHERE login_info.sex LIKE @Seeking
			AND about_info.questionable = 0
			AND login_info.photo_submitted >= @Search
			AND CONVERT (INT, personal_info.sex_preference) >= @AlternativeMin
			AND CONVERT (INT, personal_info.sex_preference) <= @AlternativeMax
			AND personal_info.marital_status LIKE @MaritalStatus
			AND contact_info.city LIKE @City
			AND contact_info.state LIKE @State
			AND contact_info.country LIKE @Country
			AND personal_info.profession LIKE @Profession
			AND CONVERT (INT, personal_info.income) >= @Income
			AND personal_info.education LIKE @Education
			AND personal_info.religion LIKE @Religion
			AND CONVERT (INT, personal_info.age) >= @MinAgeDesired
			AND CONVERT (INT, personal_info.age) <= @MaxAgeDesired

			AND CONVERT (INT, personal_info.height) >= @MinHeight
			AND CONVERT (INT, personal_info.height) <= @MaxHeight
			AND CONVERT (INT, personal_info.weight) >= @MinWeight
			AND CONVERT (INT, personal_info.weight) <= @MaxWeight
			AND personal_info.eyes LIKE @Eyes
			AND personal_info.hair LIKE @Hair
			AND personal_info.cook LIKE @Cook
			AND personal_info.smoke LIKE @Smoke
			AND personal_info.drink LIKE @Drink
			AND personal_info.party LIKE @Party
			AND personal_info.political LIKE @Political
			AND personal_info.housing_status LIKE @HousingStatus
			AND login_info.user_name = contact_info.user_name
			AND login_info.user_name = personal_info.user_name
			AND login_info.user_name = about_info.user_name
			)

		PRINT 'Limit Relationship Sort by ' + @OrderBy

SET ROWCOUNT @RowCount
		-- Select the raw information by joining just the personal_info and relationship tables... 
		EXEC ('SELECT login_info.user_name AS "user_name"
			, contact_info.city AS "city"
			, state.choice AS "state"
			, country.choice AS "country"
			, personal_info.age AS "age"
			, about_info.screen_quote AS "screen_quote"
			, about_info.about_yourself AS "about_yourself"
			, pictures.photo_1 AS "pic 1"

		FROM login_info
			, contact_info
			, personal_info
			, about_info
			, state
			, country
			, pictures
		WHERE login_info.user_name LIKE ''' + @TextSearch + '''
			AND login_info.photo_submitted >= ''' + @Search + '''
			AND login_info.user_name = contact_info.user_name
			AND login_info.user_name = personal_info.user_name
			AND login_info.user_name = about_info.user_name
			AND login_info.user_name = pictures.user_name
			AND contact_info.state = state.value
			AND contact_info.country = country.value
			AND personal_info.user_name IN 
			(
			SELECT relationship.user_name
				FROM relationship 
			WHERE (
				relationship.prefer_not_to_say = ''' + @prefer_not_to_say + '''
				OR relationship.hang_out = ''' + @hang_out + '''
				OR relationship.short_term = ''' + @short_term + '''
				OR relationship.long_term = ''' + @long_term + '''
				OR relationship.talk_email = ''' + @talk_email + '''
				OR relationship.photo_exchange = ''' + @photo_exchange + '''
				OR relationship.marriage = ''' + @marriage + '''
				OR relationship.other = ''' + @other + '''
				)

			AND relationship.user_name IN 
					(
					SELECT login_info.user_name
						FROM login_info
							, contact_info
							, personal_info
							, about_info
						WHERE login_info.sex LIKE ''' + @Seeking + '''
						AND about_info.questionable = 0
						AND CONVERT (INT, personal_info.sex_preference) >= ''' + @AlternativeMin + '''
						AND CONVERT (INT, personal_info.sex_preference) <= ''' + @AlternativeMax + '''
						AND personal_info.marital_status LIKE ''' + @MaritalStatus + '''
						AND contact_info.city LIKE ''' + @City + '''
						AND contact_info.state LIKE ''' + @State + '''
						AND contact_info.country LIKE ''' + @Country + '''
						AND personal_info.profession LIKE ''' + @Profession + '''
						AND CONVERT (INT, personal_info.income) >= ''' + @Income + '''
						AND personal_info.education LIKE ''' + @Education + '''

						AND personal_info.religion LIKE ''' + @Religion + '''
						AND CONVERT (INT, personal_info.age) >= ''' + @MinAgeDesired + '''
						AND CONVERT (INT, personal_info.age) <= ''' + @MaxAgeDesired + '''
				
						AND CONVERT (INT, personal_info.height) >= ''' + @MinHeight + '''
						AND CONVERT (INT, personal_info.height) <= ''' + @MaxHeight + '''
						AND CONVERT (INT, personal_info.weight) >= ''' + @MinWeight + '''
						AND CONVERT (INT, personal_info.weight) <= ''' + @MaxWeight + '''
						AND personal_info.eyes LIKE ''' + @Eyes + '''
						AND personal_info.hair LIKE ''' + @Hair + '''
						AND personal_info.cook LIKE ''' + @Cook + '''
						AND personal_info.smoke LIKE ''' + @Smoke + '''
						AND personal_info.drink LIKE ''' + @Drink + '''
						AND personal_info.party LIKE ''' + @Party + '''
						AND personal_info.political LIKE ''' + @Political + '''
						AND personal_info.housing_status LIKE ''' + @HousingStatus + '''
						AND login_info.user_name = contact_info.user_name
						AND login_info.user_name = personal_info.user_name
						AND login_info.user_name = about_info.user_name
				)
			)
	ORDER BY ' + @OrderBy
	) -- end EXEC
SET ROWCOUNT 0
		RETURN 1
END -- Limit search by relationship type @Relationship != 0

END -- END find user_name

ELSE --------------------------- ALL OTHER SEARCHES ---------------------------------------------


BEGIN --------------------------- ALL OTHER SEARCHES ---------------------------------------------
-- Start DO NOT limit search by relationship type
IF (@Relationship = 0)
BEGIN
	PRINT 'Any Relationship count'
	-- Select the raw information by joining just the personal_info and relationship tables... 
SELECT CASE 
		WHEN COUNT(*) >= @GlobalRowCount THEN @GlobalRowCount
		ELSE COUNT(*)
	END 'Number of Rows 3'
		FROM login_info 
			, contact_info
			, personal_info
			, about_info
		WHERE login_info.sex LIKE @Seeking
		AND about_info.questionable = 0
		AND login_info.photo_submitted >= @Search
		AND CONVERT (INT, personal_info.sex_preference) >= @AlternativeMin
		AND CONVERT (INT, personal_info.sex_preference) <= @AlternativeMax

		AND personal_info.marital_status LIKE @MaritalStatus
		AND contact_info.city LIKE @City
		AND contact_info.state LIKE @State
		AND contact_info.country LIKE @Country
		AND personal_info.profession LIKE @Profession
		AND CONVERT (INT, personal_info.income) >= @Income
		AND personal_info.education LIKE @Education
		AND personal_info.religion LIKE @Religion

		AND CONVERT (INT, personal_info.age) >= @MinAgeDesired
		AND CONVERT (INT, personal_info.age) <= @MaxAgeDesired

		AND CONVERT (INT, personal_info.height) >= @MinHeight
		AND CONVERT (INT, personal_info.height) <= @MaxHeight
		AND CONVERT (INT, personal_info.weight) >= @MinWeight
		AND CONVERT (INT, personal_info.weight) <= @MaxWeight

		AND 
		(
		about_info.screen_quote LIKE @TextSearch
		OR about_info.about_yourself LIKE @TextSearch
		)

		AND personal_info.eyes LIKE @Eyes
		AND personal_info.hair LIKE @Hair
		AND personal_info.cook LIKE @Cook
		AND personal_info.smoke LIKE @Smoke
		AND personal_info.drink LIKE @Drink
		AND personal_info.party LIKE @Party
		AND personal_info.political LIKE @Political		
		AND personal_info.housing_status LIKE @HousingStatus

		AND login_info.user_name = contact_info.user_name
		AND login_info.user_name = personal_info.user_name
		AND login_info.user_name = about_info.user_name

		PRINT 'Any Relationship Sort by ' + @OrderBy
		PRINT @Search


SET ROWCOUNT @RowCount
		
		-- Select the raw information by joining just the personal_info AND relationship tables... 
		EXEC ('SELECT login_info.user_name AS "user_name"
			, contact_info.city AS "city"
			, state.choice AS "state"
			, country.choice AS "country"
			, personal_info.age AS "age"
			, about_info.screen_quote AS "screen_quote"
			, about_info.about_yourself AS "about_yourself"
			, pictures.photo_1 AS "pic 1"

		FROM login_info
			, contact_info
			, personal_info
			, about_info
			, state
			, country
			, pictures
		WHERE login_info.user_name = contact_info.user_name
			AND login_info.photo_submitted >= ''' + @Search + '''
			AND login_info.user_name = personal_info.user_name
			AND login_info.user_name = about_info.user_name
			AND login_info.user_name = pictures.user_name
			AND contact_info.state = state.value
			AND contact_info.country = country.value
			AND personal_info.user_name IN 
			(
			SELECT login_info.user_name
				FROM login_info
					, contact_info
					, personal_info
					, about_info
				WHERE login_info.sex LIKE ''' + @Seeking + '''
				AND about_info.questionable = 0
				AND CONVERT (INT, personal_info.sex_preference) >= ''' + @AlternativeMin + '''
				AND CONVERT (INT, personal_info.sex_preference) <= ''' + @AlternativeMax + '''
	
				AND personal_info.marital_status LIKE ''' + @MaritalStatus + '''
				AND contact_info.city LIKE ''' + @City + '''
				AND contact_info.state LIKE ''' + @State + '''
				AND contact_info.country LIKE ''' + @Country + '''
				AND personal_info.profession LIKE ''' + @Profession + '''
				AND CONVERT (INT, personal_info.income) >= ''' + @Income + '''
				AND personal_info.education LIKE ''' + @Education + '''
				AND personal_info.religion LIKE ''' + @Religion + '''
		
				AND CONVERT (INT, personal_info.age) >= ''' + @MinAgeDesired + '''
				AND CONVERT (INT, personal_info.age) <= ''' + @MaxAgeDesired + '''
		
				AND CONVERT (INT, personal_info.height) >= ''' + @MinHeight + '''
				AND CONVERT (INT, personal_info.height) <= ''' + @MaxHeight + '''
				AND CONVERT (INT, personal_info.weight) >= ''' + @MinWeight + '''
				AND CONVERT (INT, personal_info.weight) <= ''' + @MaxWeight + '''
	
				AND 
				(
				about_info.screen_quote LIKE ''' + @TextSearch + '''
				OR about_info.about_yourself LIKE ''' + @TextSearch + '''
				)

				AND personal_info.eyes LIKE ''' + @Eyes + '''
				AND personal_info.hair LIKE ''' + @Hair + '''
				AND personal_info.cook LIKE ''' + @Cook + '''
				AND personal_info.smoke LIKE ''' + @Smoke + '''
				AND personal_info.drink LIKE ''' + @Drink + '''
				AND personal_info.party LIKE ''' + @Party + '''
				AND personal_info.political LIKE ''' + @Political + '''
				AND personal_info.housing_status LIKE ''' + @HousingStatus + '''
		
				AND login_info.user_name = contact_info.user_name
				AND login_info.user_name = personal_info.user_name
				AND login_info.user_name = about_info.user_name
			)
	
	ORDER BY ' + @OrderBy
	) -- end EXEC
SET ROWCOUNT 0
		RETURN 1
END -- Relationship = 0 "Any"





-- Start Limit search by relationship type
IF (@Relationship != 0)
BEGIN
PRINT 'Limit Relationship Count'
-- Select the raw information by joining just the personal_info and relationship tables... 
SELECT CASE 
		WHEN COUNT(*) >= @GlobalRowCount THEN @GlobalRowCount
		ELSE COUNT(*)
	END 'Number of Rows 4'
	FROM relationship 
	WHERE (
			relationship.prefer_not_to_say = @prefer_not_to_say	
			OR relationship.hang_out = @hang_out
			OR relationship.short_term = @short_term		
			OR relationship.long_term = @long_term				
			OR relationship.talk_email = @talk_email		
			OR relationship.photo_exchange = @photo_exchange		
			OR relationship.marriage = @marriage				
			OR relationship.other = @other
		  )
						
		AND relationship.user_name IN 
		(
			SELECT login_info.user_name
				FROM login_info
					, contact_info
					, personal_info
					, about_info
				WHERE login_info.user_name = contact_info.user_name
				AND about_info.questionable = 0
				AND login_info.user_name = personal_info.user_name
				AND login_info.user_name = about_info.user_name

				AND login_info.sex LIKE @Seeking
				AND login_info.photo_submitted >= @Search
				AND CONVERT (INT, personal_info.sex_preference) >= @AlternativeMin
				AND CONVERT (INT, personal_info.sex_preference) <= @AlternativeMax
				AND contact_info.city LIKE @City
				AND contact_info.state LIKE @State
				AND contact_info.country LIKE @Country
				AND personal_info.marital_status LIKE @MaritalStatus
				AND personal_info.profession LIKE @Profession
				AND CONVERT (INT, personal_info.income) >= @Income
				AND personal_info.education LIKE @Education
				AND personal_info.religion LIKE @Religion

				AND CONVERT (INT, personal_info.age) >= @MinAgeDesired
				AND CONVERT (INT, personal_info.age) <= @MaxAgeDesired

				AND CONVERT (INT, personal_info.height) >= @MinHeight
				AND CONVERT (INT, personal_info.height) <= @MaxHeight
				AND CONVERT (INT, personal_info.weight) >= @MinWeight
				AND CONVERT (INT, personal_info.weight) <= @MaxWeight

				AND personal_info.eyes LIKE @Eyes
				AND personal_info.hair LIKE @Hair
				AND personal_info.cook LIKE @Cook
				AND personal_info.smoke LIKE @Smoke
				AND personal_info.drink LIKE @Drink
				AND personal_info.party LIKE @Party
				AND personal_info.political LIKE @Political
				AND personal_info.housing_status LIKE @HousingStatus
				AND 
				(
					about_info.screen_quote LIKE @TextSearch
					OR about_info.about_yourself LIKE @TextSearch
				)

		)
		PRINT 'Limit Relationship Sort by ' + @OrderBy

SET ROWCOUNT @RowCount

		-- Select the raw information by joining just the personal_info and relationship tables... 
		EXEC ('SELECT login_info.user_name AS "user_name"
			, contact_info.city AS "city"
			, state.choice AS "state"
			, country.choice AS "country"
			, personal_info.age AS "age"
			, about_info.screen_quote AS "screen_quote"
			, about_info.about_yourself AS "about_yourself"
			, pictures.photo_1 AS "pic 1"

		FROM login_info
			, contact_info
			, personal_info
			, about_info
			, state
			, country
			, pictures
		WHERE login_info.user_name = contact_info.user_name
			AND login_info.photo_submitted >= ''' + @Search + '''
			AND login_info.user_name = personal_info.user_name
			AND login_info.user_name = about_info.user_name
			AND login_info.user_name = pictures.user_name
			AND contact_info.state = state.value
			AND contact_info.country = country.value
			AND personal_info.user_name IN 
			(
			SELECT relationship.user_name
				FROM relationship 
			WHERE (
				relationship.prefer_not_to_say = ''' + @prefer_not_to_say + '''
				OR relationship.hang_out = ''' + @hang_out + '''
				OR relationship.short_term = ''' + @short_term + '''
				OR relationship.long_term = ''' + @long_term + '''				
				OR relationship.talk_email = ''' + @talk_email + '''		
				OR relationship.photo_exchange = ''' + @photo_exchange + '''
				OR relationship.marriage = ''' + @marriage + '''
				OR relationship.other = ''' + @other + '''
				)

			AND relationship.user_name IN 
					(
					SELECT login_info.user_name
						FROM login_info
							, contact_info
							, personal_info
							, about_info
						WHERE login_info.sex LIKE ''' + @Seeking + '''
						AND about_info.questionable = 0
						AND CONVERT (INT, personal_info.sex_preference) >= ''' + @AlternativeMin + '''
						AND CONVERT (INT, personal_info.sex_preference) <= ''' + @AlternativeMax + '''
						AND contact_info.city LIKE ''' + @City + '''
						AND contact_info.state LIKE ''' + @State + '''
						AND contact_info.country LIKE ''' + @Country + '''
						AND personal_info.marital_status LIKE ''' + @MaritalStatus + '''
						AND personal_info.profession LIKE ''' + @Profession + '''
						AND CONVERT (INT, personal_info.income) >= ''' + @Income + '''
						AND personal_info.education LIKE ''' + @Education + '''

						AND personal_info.religion LIKE ''' + @Religion + '''
						AND CONVERT (INT, personal_info.age) >= ''' + @MinAgeDesired + '''
						AND CONVERT (INT, personal_info.age) <= ''' + @MaxAgeDesired + '''
				
						AND CONVERT (INT, personal_info.height) >= ''' + @MinHeight + '''
						AND CONVERT (INT, personal_info.height) <= ''' + @MaxHeight + '''
						AND CONVERT (INT, personal_info.weight) >= ''' + @MinWeight + '''
						AND CONVERT (INT, personal_info.weight) <= ''' + @MaxWeight + '''

						AND 
						(
						about_info.screen_quote LIKE ''' + @TextSearch + '''
						OR about_info.about_yourself LIKE ''' + @TextSearch + '''
						)

						AND personal_info.eyes LIKE ''' + @Eyes + '''
						AND personal_info.hair LIKE ''' + @Hair + '''
						AND personal_info.cook LIKE ''' + @Cook + '''
						AND personal_info.smoke LIKE ''' + @Smoke + '''
						AND personal_info.drink LIKE ''' + @Drink + '''
						AND personal_info.party LIKE ''' + @Party + '''
						AND personal_info.political LIKE ''' + @Political + '''
						AND personal_info.housing_status LIKE ''' + @HousingStatus + '''
						AND login_info.user_name = contact_info.user_name
						AND login_info.user_name = personal_info.user_name
						AND login_info.user_name = about_info.user_name
				)
			)
	ORDER BY ' + @OrderBy
	) -- end EXEC
SET ROWCOUNT 0
		RETURN 1

END -- Limit search by relationship type @Relationship != 0

END	--- ALL OTHER SEARCHES ---


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

