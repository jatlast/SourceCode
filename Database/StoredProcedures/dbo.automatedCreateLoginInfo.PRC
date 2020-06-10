SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[automatedCreateLoginInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[automatedCreateLoginInfo]
GO



CREATE PROCEDURE [automatedCreateLoginInfo]
	-- login_info
@ID			nvarchar(10)
, @UserName		varchar(32)
, @MembershipType	int
, @Password		varchar(16)
, @PasswordHint	varchar(64)
, @Email		varchar(64)
, @Sex			char
, @PhotoSubmitted	int
	-- contact_info
, @FirstName		varchar(32)
, @LastName		varchar(32)
, @StreetAddress	varchar(96)
, @City			varchar(32)
, @State		varchar(32)
, @Country		varchar(32)
, @Zip			nchar(5)
, @Telephone		varchar(16)
	-- personal_info
, @SexPreference	varchar(2)
, @Age			varchar(4)
, @MaritalStatus		varchar(2)
, @Profession		varchar(3)
, @Education		varchar(2)
, @Religion		varchar(2)
, @Height		varchar(4)
, @Weight		varchar(4)
, @Eyes		varchar(2)
, @Hair			varchar(2)
, @MinAgeDesired	varchar(4)
, @MaxAgeDesired	varchar(4)
, @Cook		varchar(2)
, @Smoke		varchar(2)
, @Drink		varchar(2)
, @Party		varchar(2)
, @Political		varchar(2)
, @HousingStatus	varchar(2)
	-- relationship
, @Relationship		varchar(32)
	-- about_info
, @ScreenQuote	varchar(1024)
, @AboutYourself	varchar(8000)
	-- pictures
, @PictureName		varchar(32)

 AS
-- UserId must be declared 
DECLARE @@UserId int

-- membership_type, creation_date, and last_login must be declared 
DECLARE @@membership_type char
DECLARE @@creation_date datetime
DECLARE @@last_login datetime

-- Get the maximum +1 user_id number fron the login_info table 
select @@UserId = max(user_id + 1) from login_info

--  If there are no user ids in the database this is the first and therefore #1 
if @@UserId is NULL
select @@UserId = 1

-- Set the default values 
select @@creation_date = getdate()
select @@last_login = getdate()
select @@membership_type = '0' -- 0 = voyer 

-- Determine if the user_name is unique in the login_info table
if exists (select user_name from login_info where user_name = @UserName)
BEGIN
	-- If the user_name is not unique exit with a return value of 666 
	print 'user_name is not unique in login_info' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
	return 666
END
else
BEGIN
	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'user_name IS unique in login_info'
	insert into login_info (user_id
			, user_name
			, password
			, password_hint
			, email
			, sex
			, membership_type
			, creation_date
			, last_login
			, photo_submitted
			) 
	values (@@UserId
		, @UserName
		, @Password
		, @PasswordHint
		, @Email
		, @Sex
		, @MembershipType
		, @@creation_date
		, @@last_login
		, @PhotoSubmitted
		)
END
-- Determine if the user_name is unique in the contact_info table
if exists (select user_name from contact_info where user_name = @UserName)
BEGIN
	-- If the user_name is not unique exit with a return value of 665
	print 'user_name is not unique in contact_info' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
	return 665
END
else
BEGIN
	-- If the user_name is unique add the user to the contact_info table and exit with a return value of 1 
	print 'user_name IS unique in contact_info'
	insert into contact_info (user_name
			, first_name
			, last_name
			, street_address
			, city
			, state
			, country
			, zip
			, telephone
			) 
	values (@UserName
		, @FirstName
		, @LastName
		, @StreetAddress
		, @City
		, @State
		, @Country
		, @Zip
		, @Telephone
		)
END

-- Determine if the user_name is unique in the relationship table
if exists (select user_name from relationship where user_name = @UserName)
BEGIN
	-- If the user_name is not unique exit with a return value of 664
	print 'user_name is not unique in relationship' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
	return 664
END
else
BEGIN
	-- If the user_name is unique add the user to the relationship table and exit with a return value of 1 
	print 'user_name IS unique in relationship'
		insert into relationship (user_name
				, prefer_not_to_say
				, any_relationship
				, hang_out
				, short_term
				, long_term
				, talk_email
				, photo_exchange
				, marriage
				, other
				) 
		values (@UserName
			, "1"
			, "0"
			, "0"
			, "0"
			, "0"
			, "0"
			, "0"
			, "0"
			, "0"
			)
END

-- Determine if the user_name is unique in the personal_info table
if exists (select user_name from personal_info where user_name = @UserName)
BEGIN
	-- If the user_name is not unique exit with a return value of 663
	print 'user_name is not unique in personal_info' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
	return 663
END
else
BEGIN
	-- If the user_name is unique add the user to the personal_info table and exit with a return value of 1 
	print 'user_name IS unique in personal_info'
		insert into personal_info(user_name
				, sex_preference
				, age
				, marital_status
				, profession
				, education
				, religion
				, height
				, weight
				, eyes
				, hair
				, min_age_desired
				, max_age_desired
				, cook
				, smoke
				, drink
				, party
				, political
				, housing_status
				) 
		values (@UserName
			, "1"
			, @Age			 
			, @MaritalStatus 
			, @Profession	 
			, @Education	 
			, @Religion		 
			, @Height		 
			, @Weight		 
			, @Eyes			 
			, @Hair			 
			, @MinAgeDesired 
			, @MaxAgeDesired 
			, @Cook			 
			, @Smoke		 
			, @Drink		 
			, @Party		 
			, @Political	 
			, @HousingStatus 
			)
END
-- Determine if the user_name is unique in the about_info table
if exists (select user_name from about_info where user_name = @UserName)
BEGIN
	-- If the user_name is not unique exit with a return value of 662 
	print 'user_name is not unique in about_info' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
	return 662
END
else
BEGIN
	-- If the user_name is unique add the user to the about_info table and exit with a return value of 1 
	print 'user_name IS unique in about_info'
	insert into about_info (user_name
			, screen_quote
			, about_yourself
			, questionable
			) 
	values (@UserName
		, @ScreenQuote
		, @AboutYourself
		, "1"
		)
END

-- Determine if the user_name is unique in the about_info table
if exists (select user_name from pictures where user_name = @UserName)
BEGIN
	-- If the user_name is not unique exit with a return value of 662 
	print 'user_name is not unique in pictures' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
	return 661
END
else
BEGIN
	-- If the user_name is unique add the user to the pictures table and exit with a return value of 1 
print 'user_name IS unique in pictures'
insert into pictures (user_name
		, photo_1
		, photo_2
		, photo_3
		, photo_4
		, photo_5
		) 
values (@UserName
	, @PictureName
	, 'Nothing'
	, 'Nothing'
	, 'Nothing'
	, 'Nothing'
	)
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

