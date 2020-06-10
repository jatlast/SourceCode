SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[deleteUserFromAllTables]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[deleteUserFromAllTables]
GO


CREATE PROCEDURE [deleteUserFromAllTables]
@UserName		varchar(32)
, @Password		varchar(16)

 AS

-- Determine if the user_name and password match
if ( (select password from login_info where user_name = @UserName) = @Password)
	BEGIN
		-- Determine if the user_name exists in the login_info table
		if exists (select user_name from login_info where user_name = @UserName)
			BEGIN
				-- If the user_name exists delete the user from the login_info table 
				print 'Deleting user from login_info'
				delete login_info 
				where user_name = @UserName
			END
		else
			BEGIN
				-- If the user_name is not unique exit with a return value of 666 
				print 'user_name does not exist in the login_info table' -- 
			END
	
		-- Determine if the user_name exists in the contact_info table
		if exists (select user_name from contact_info where user_name = @UserName)
			BEGIN
				-- If the user_name exists delete the user from the contact_info table 
				print 'Deleting user from contact_info'
				delete contact_info 
				where user_name = @UserName
			END
		else
			BEGIN
				-- If the user_name is not unique exit with a return value of 666 
				print 'user_name does not exist in the contact_info table' -- 
			END
	
		-- Determine if the user_name exists in the personal_info table
		if exists (select user_name from personal_info where user_name = @UserName)
			BEGIN
				-- If the user_name exists delete the user from the personal_info table 
				print 'Deleting user from personal_info'
				delete personal_info 
				where user_name = @UserName
			END
		else
			BEGIN
				-- If the user_name is not unique exit with a return value of 666 
				print 'user_name does not exist in the personal_info table' -- 
			END
	
		-- Determine if the user_name exists in the relationship table
		if exists (select user_name from relationship where user_name = @UserName)
			BEGIN
				-- If the user_name exists delete the user from the relationship table 
				print 'Deleting user from relationship'
				delete relationship 
				where user_name = @UserName
			END
		else
			BEGIN
				-- If the relationship is not unique exit with a return value of 666 
				print 'user_name does not exist in the relationship table' -- 
			END
	
		-- Determine if the user_name exists in the about_info table
		if exists (select user_name from about_info where user_name = @UserName)
			BEGIN
				-- If the user_name exists delete the user from the about_info table 
				print 'Deleting user from about_info'
				delete about_info 
				where user_name = @UserName
			END
		else
			BEGIN
				-- If the user_name is not unique exit with a return value of 666 
				print 'user_name does not exist in the about_info table' -- 
			END
	
		-- Determine if the user_name exists in the pictures table
		if exists (select user_name from pictures where user_name = @UserName)
			BEGIN
				-- If the user_name exists delete the user from the pictures table 
				print 'Deleting user from pictures'
				delete pictures 
				where user_name = @UserName
			END
		else
			BEGIN
				-- If the user_name is not unique exit with a return value of 666 
				print 'user_name does not exist in the pictures table' -- 
			END

		-- Determine if the user_name exists in the billing_info table
		if exists (select user_name from billing_info where user_name = @UserName)
			BEGIN
				-- If the user_name exists delete the user from the billing_info table 
				print 'Deleting user from billing_info'
				delete billing_info 
				where user_name = @UserName
			END
		else
			BEGIN
				-- If the user_name is not unique exit with a return value of 666 
				print 'user_name does not exist in the billing_info table' -- 
			END

		-- Determine if the user_name exists in the bookmarks table
		if exists (select user_name from bookmarks where user_name = @UserName)
			BEGIN
				-- If the user_name exists delete the user from the bookmarks table 
				print 'Deleting user from bookmarks'
				delete bookmarks 
				where user_name = @UserName
			END
		else
			BEGIN
				-- If the user_name is not unique exit with a return value of 666 
				print 'user_name does not exist in the bookmarks table' -- 
			END

		-- Determine if the user_name has incomming mail in the mail table
		if exists (select sent_to from mail where sent_to = @UserName)
			BEGIN
				-- If the user_name has incomming mail in the mail table
				print 'Deleting incomming mail'
				delete mail 
				where sent_to = @UserName
			END
		else
			BEGIN
				-- No incomming mail in the mail table
				print 'user_name does have any incomming mail in the mail table' -- 
			END

		-- Determine if the user_name has outgoing mail in the mail table
		if exists (select sent_from from mail where sent_from = @UserName)
			BEGIN
				-- If the user_name has outgoing mail in the mail table
				print 'Deleting outgoing mail'
				delete mail 
				where sent_from = @UserName
			END
		else
			BEGIN
				-- No incomming mail in the mail table
				print 'user_name does have any outgoing mail in the mail table' -- 
			END
	END -- determine if the user_name and password match
else
	BEGIN
		-- If the user_name and password do not match exit
		print 'user_name and password did not match' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
		return 660
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

