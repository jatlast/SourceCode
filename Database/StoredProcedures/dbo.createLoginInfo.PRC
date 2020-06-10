SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[createLoginInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[createLoginInfo]
GO



CREATE PROCEDURE [createLoginInfo]
@UserId int-- not used 
, @UserName varchar(32)
, @MembershipType char -- not used 
, @Password varchar(16)
, @PasswordHint varchar(64)
, @Email varchar(64)
, @Sex char
, @CreationDate varchar(32)-- not used 
, @LastLogin varchar(32) -- not used 
, @PhotoSubmitted int -- not used 

 AS
-- clean up database by removing all bad profiles
print 'Cleaning up Database'
EXEC admin_DeleteBadProfiles

-- UserId must be declared 
DECLARE @@UserId int
DECLARE @@return_status int
-- membership_type, creation_date, and last_login must be declared 
DECLARE @@membership_type char
DECLARE @@creation_date datetime
DECLARE @@last_login datetime

DECLARE @@WhichConnections varchar(32)
select @@WhichConnections = 'Administrator'

-- Get the maximum +1 user_id number fron the login_info table 
select @@UserId = max(user_id + 1) from login_info

--  If there are no user ids in the database this is the first and therefore #1 
if @@UserId is NULL
select @@UserId = 1

-- Set the default values 
select @@creation_date = getdate()
select @@last_login = getdate()

select @@membership_type = '0' -- 0 = basic
--select @@membership_type = '1' -- 0 = premium

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
		, @@membership_type
		, @@creation_date
		, @@last_login
		, 0
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
		, ''
		, ''
		, ''
		, ''
		, '0'
		, '0'
		, ''
		, ''
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
			, '1'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
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
				, income
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
			, '1'
			, '18'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '18'
			, '99'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
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
		, ''
		, ''
		, '0'
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
	, 'Nothing'
	, 'Nothing'
	, 'Nothing'
	, 'Nothing'
	, 'Nothing'
	)
END

exec @@return_status = mailSendNewUserWelcome @@WhichConnections, @UserName

if(@@return_status = 666)
	BEGIN
		print 'Mail could not be sent'
		return 666
	END
else
	BEGIN
		print 'Mail has been sent'
	END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

