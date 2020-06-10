SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_DeleteEntireProfileByUserName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_DeleteEntireProfileByUserName]
GO


CREATE PROCEDURE [admin_DeleteEntireProfileByUserName]
 @UserName varchar(32)

 AS

-- Determine if the user_name exists in the login_info  table
IF EXISTS (SELECT user_name FROM login_info WHERE user_name = @UserName)
BEGIN
	-- If the user_name exists delete the login_info for that user
	print 'Delete login_info'
	delete login_info 
		where user_name = @UserName
END
ELSE
	BEGIN
		-- print that the login_table was not changed
		PRINT 'user_name does not exist in the login_info table'
	END


-- Determine if the user_name exists in the contact_info  table
IF EXISTS (SELECT user_name FROM contact_info WHERE user_name = @UserName)
BEGIN
	-- If the user_name exists delete the contact_info for that user
	print 'Delete contact_Info'
	delete contact_info 
		where user_name = @UserName
END
ELSE
	BEGIN
		-- print that the contact_table was not changed
		PRINT 'user_name does not exist in the contact_Info table'
	END

-- Determine if the user_name exists in the personal_info  table
IF EXISTS (SELECT user_name FROM personal_info WHERE user_name = @UserName)
BEGIN
	-- If the user_name exists delete the personal_info for that user
	print 'Delete personal_info'
	delete personal_info 
		where user_name = @UserName
END
ELSE
	BEGIN
		-- print that the personal_info was not changed
		PRINT 'user_name does not exist in the personal_info table'
	END

-- Determine if the user_name exists in the about_info  table
IF EXISTS (SELECT user_name FROM about_info WHERE user_name = @UserName)
BEGIN
	-- If the user_name exists delete the about_info for that user
	print 'Delete about_info'
	delete about_info 
		where user_name = @UserName
END
ELSE
	BEGIN
		-- user does not have info in this table
		PRINT 'user_name does not exist in the about_info table'
	END

-- Determine if the user_name exists in the relationship  table
IF EXISTS (SELECT user_name FROM relationship WHERE user_name = @UserName)
BEGIN
	-- If the relationship exists delete the about_info for that user
	print 'Delete relationship'
	delete relationship 
		where user_name = @UserName
END
ELSE
	BEGIN
		-- user does not have info in this table
		PRINT 'user_name does not exist in the relationship table'
	END

-- Determine if the user_name exists in the pictures  table
IF EXISTS (SELECT user_name FROM pictures WHERE user_name = @UserName)
BEGIN
	-- If the user_name exists delete the pictures for that user
	print 'Delete pictures'
	delete pictures 
		where user_name = @UserName
END
ELSE
	BEGIN
		-- user does not have info in this table
		PRINT 'user_name does not exist in the pictures table'
	END

-- Determine if the user_name exists in the mail  table
IF EXISTS (SELECT sent_to FROM mail WHERE sent_to = @UserName)
	BEGIN
		-- If the user_name exists delete the user from the pictures table 
		PRINT 'Deleting user from mail using sent_to'
		DELETE mail 
		WHERE sent_to = @UserName
	END
ELSE
	BEGIN
		-- user does not have info in this table
		PRINT 'user had no sent_to mail'
	END

-- Determine if the user_name exists in the mail  table
IF EXISTS (SELECT sent_from FROM mail WHERE sent_from = @UserName)
	BEGIN
		-- If the user_name exists delete the user from the mail table 
		PRINT 'Deleting user from mail using sent_from'
		DELETE mail 
		WHERE sent_from = @UserName
	END
ELSE
	BEGIN
		-- user does not have info in this table
		PRINT 'user had no sent_from mail'
	END

-- Determine if the user_name exists in the book_marks  table
IF EXISTS (SELECT user_name FROM book_marks WHERE user_name = @UserName OR  book_mark = @UserName)
	BEGIN
		-- If the user_name exists delete the user from the book_marks table 
		PRINT 'Deleting user from book_marks'
		DELETE book_marks 
		WHERE user_name = @UserName
		OR book_mark = @UserName
	END
ELSE
	BEGIN
		-- user does not have info in this table
		PRINT 'user had no book_marks'
	END

-- Determine if the user_name exists in the billing_info  table
IF EXISTS (SELECT user_name FROM billing_info WHERE user_name = @UserName)
	BEGIN
		-- If the user_name exists delete the user from the billing_info table 
		PRINT 'Deleting user from billing_info'
		DELETE billing_info 
		WHERE user_name = @UserName
	END
ELSE
	BEGIN
		-- user does not have info in this table
		PRINT 'user had no billing_info'
	END

-- Determine if the user_name exists in the transactions_log  table
IF EXISTS (SELECT user_name FROM transactions_log WHERE user_name = @UserName)
	BEGIN
		-- If the user_name exists delete the user from the transactions_log table 
		PRINT 'Deleting user from transactions_log'
		DELETE transactions_log 
		WHERE user_name = @UserName
	END
ELSE
	BEGIN
		-- user does not have info in this table
		PRINT 'user had no transactions_log'
	END

-- Determine if the user_name exists in the recurring_transactions  table
IF EXISTS (SELECT user_name FROM recurring_transactions WHERE user_name = @UserName)
	BEGIN
		-- If the user_name exists delete the user from the recurring_transactions table 
		PRINT 'Deleting user from recurring_transactions'
		DELETE recurring_transactions 
		WHERE user_name = @UserName
	END
ELSE
	BEGIN
		-- user does not have info in this table
		PRINT 'user had no recurring_transactions'
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

