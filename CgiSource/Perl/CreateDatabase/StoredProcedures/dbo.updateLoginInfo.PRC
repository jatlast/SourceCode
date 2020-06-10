SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updateLoginInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updateLoginInfo]
GO

CREATE PROCEDURE [updateLoginInfo]
@UserId int
, @UserName varchar(32)
, @MembershipType char
, @Password varchar(16)
, @PasswordHint varchar(64)
, @Email varchar(64)
, @Sex char
, @CreationDate varchar(32)
, @LastLogin varchar(32)
, @PhotoSubmitted int -- not used 

 AS
-- UserId must be declared

-- membership_type, creation_date, and last_login must be declared
DECLARE @current_user_name varchar(32)

select @current_user_name = (select user_name from login_info where user_name = @UserName)

if (@current_user_name = @UserName)
BEGIN
	--If the user_name is unique add the user to the login_info table and exit with a return value of 1
	print 'user_name (' + @current_user_name + ')  IS remaining  (' + @UserName
	update login_info 
		set password = @Password
			, password_hint = @PasswordHint
			, email = @Email
			, sex = @Sex
		where user_id = @UserId
	return 1
END
ELSE
	BEGIN
		--Determine if the user_name is unique
		if exists (select user_name from login_info where user_name = @UserName)
		BEGIN
			--If the user_name is not unique exit with a return value of 666
			print 'user_name  is not unique'
			return 666
		END
	ELSE
	BEGIN
		select @current_user_name = (select user_name from login_info where user_id = @UserId)
		--If the user_name is unique add the user to the login_info table and exit with a return value of 1
		print 'user_name (' + @current_user_name + ')  IS unique and being changed to (' + @UserName + ')  in all tables'
		print 'Updating the login_info table'
		update login_info 
			set user_name = @UserName
				, password = @Password
				, password_hint = @PasswordHint
				, email = @Email
				, sex = @Sex
			where user_id = @UserId

		-- Update user_name in all other tables...

		-- Update contact_info table
		print 'Updating the contact_info table'
		update contact_info 
			set user_name = @UserName
			where user_name = @current_user_name

		-- Update personal_info table
		print 'Updating the personal_info table'
		update personal_info 
			set user_name = @UserName
			where user_name = @current_user_name

		-- Update about_info table
		print 'Updating the about_info table'
		update about_info 
			set user_name = @UserName
			where user_name = @current_user_name

		-- Update pictures table
		print 'Updating the pictures table'
		update pictures 
			set user_name = @UserName
			where user_name = @current_user_name

		-- Update relationship table
		print 'Updating the relationship table'
		update relationship 
			set user_name = @UserName
			where user_name = @current_user_name

		-- Update sent_to in mail table
		print 'Updating the sent_to field in the mail table'
		update mail 
			set sent_to = @UserName
			where sent_to = @current_user_name

		-- Update sent_from in mail table
		print 'Updating the sent_from field in the mail table'
		update mail 
			set sent_from = @UserName
			where sent_from = @current_user_name

		-- Update user_name in book_marks table
		print 'Updating the sent_to field in the book_marks table'
		update book_marks 
			set user_name = @UserName
			where user_name = @current_user_name

		-- Update book_mark in book_marks table
		print 'Updating the book_mark field in the book_marks table'
		update book_marks 
			set book_mark = @UserName
			where book_mark = @current_user_name

		-- Update billing_info table
		print 'Updating the billing_info table'
		update billing_info 
			set user_name = @UserName
			where user_name = @current_user_name

		-- Update recurring_transactions table
		print 'Updating the recurring_transactions table'
		update recurring_transactions 
			set user_name = @UserName
			where user_name = @current_user_name

		-- Update membership_cancellation table
		print 'Updating the membership_cancellation table'
		update membership_cancellation 
			set user_name = @UserName
			where user_name = @current_user_name

		-- Update transactions_log table
		print 'Updating the transactions_log table'
		update transactions_log 
			set user_name = @UserName
			where user_name = @current_user_name
			and user_id = @UserId

		return 1
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

