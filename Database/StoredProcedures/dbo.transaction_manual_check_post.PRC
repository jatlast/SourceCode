SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[transaction_manual_check_post]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[transaction_manual_check_post]
GO



CREATE PROCEDURE [transaction_manual_check_post]
@TransactionID CHAR(52)
, @UserName VARCHAR(32)
, @MonthsJoined VARCHAR(3)
, @Amount VARCHAR(8)
, @XTransID CHAR(9)
, @XMd5Hash VARCHAR(50)
, @XDescription VARCHAR(256)
, @NameOnCard VARCHAR(64)
, @BankABACode VARCHAR(9)
, @BankAccountNumber VARCHAR(32)

 AS

DECLARE @@DateOfThisTransaction DATETIME
DECLARE @@DateOfNextTransaction DATETIME

DECLARE @@MembershipType 		CHAR(4)
DECLARE @@IsMembershipActive	CHAR(1)

DECLARE @@UserId VARCHAR(10)
SELECT @@UserId = (SELECT user_id from login_info where user_name = @UserName)

-- Get user info from billing_info table...
SELECT @@IsMembershipActive = (SELECT is_membership_active from billing_info where user_name = @UserName)
	
-- Check if user is already a paying member...
SELECT @@MembershipType = (SELECT membership_type from login_info where user_name = @UserName)
IF( (@@MembershipType != '1' AND @@MembershipType != '2') OR ( @@IsMembershipActive = '0' AND (@@MembershipType = '1' OR @@MembershipType = '2') ) )
	BEGIN
		-- Set the current date 
		SELECT @@DateOfThisTransaction = GETDATE()
		
		-- Add @MonthsJoined to the DateOfThisTransaction to initialize the DateOfNextTransaction
		SELECT @@DateOfNextTransaction = DATEADD(MONTH, CONVERT (INT, @MonthsJoined), @@DateOfThisTransaction)
		
---------------------------------------
-- login_info
---------------------------------------
--  update the membership type to 1
		print 'update login_info table'
		IF( (SELECT date_started_paying FROM login_info where user_name = @UserName) = NULL)
			BEGIN
				-- update login_info table to reflect the successful transaction
				UPDATE login_info 
					SET membership_type 	= '1'
						, date_started_paying = @@DateOfThisTransaction
					WHERE user_name = @UserName
			END
		ELSE
			BEGIN
				-- update login_info table to reflect the successful transaction
				UPDATE login_info 
					SET membership_type 	= '1'
					WHERE user_name = @UserName
			END
---------------------------------------
-- billing_info
---------------------------------------
			print 'Updating the Bank Info in the billing_info table'
			-- Determine if the user_name is unique in the billing_info table
			if exists (select user_name from billing_info where user_name = @UserName)
			BEGIN
				-- If the user_name is NOT unique update the billing_info table with the current information
				print 'update billing_info table'
				update billing_info 
					set  is_membership_active = '1'
						, date_membership_expires = @@DateOfNextTransaction
						, bank_ABA_code = @BankABACode
						, bank_account_number = @BankAccountNumber
					where user_name = @UserName
			END
			else -- user has no billing_inifo table
			BEGIN
				-- If the user_name is unique add the user to the billing_info table
				print 'user_name IS unique in billing_info'
				insert into billing_info (user_name
						, card_type
						, name_on_card
						, account_number
						, expiration_month
						, expiration_year
						, is_membership_active
						, date_membership_expires
						, bank_ABA_code
						, bank_account_number
						) 
				values (@UserName
					, '9' -- 9 = Manual Check
					, @NameOnCard
					, '0'
					, '00'
					, '0000'
					, '1'
					, @@DateOfThisTransaction
					, @BankABACode
					, @BankAccountNumber
					)
			END

---------------------------------------
-- recurring_transactions
---------------------------------------
			print 'Updating the Credit Card info in the recurring_transactions  table'
			-- Determine if the user_name is unique in the recurring_transactions table
			if exists (select user_name from recurring_transactions where user_name = @UserName)
			BEGIN
				-- If the user_name is NOT unique update the recurring_transactions table with the current information
				print 'update recurring_transactions table'
				update recurring_transactions 
					set sendable = '0' -- 0 = NOT ok to process
						, transaction_type = 'MANUAL_CHECK'
						, date_of_this_transaction = @@DateOfThisTransaction
						, date_of_next_transaction = @@DateOfNextTransaction
						, card_type = '9' -- 9 = Manual Check
						, name_on_card = @NameOnCard
						, account_number = ''
						, expiration_month = ''
						, expiration_year = ''
						, x_method = 'MANUAL'
						,  bank_ABA_code = @BankABACode
						, bank_account_number = @BankAccountNumber
					where user_name = @UserName
			END
			else
			BEGIN
				-- If the user_name is unique add the user to the recurring_transactions table
				print 'user_name IS unique in recurring_transactions'
				insert into recurring_transactions (user_name
								, sendable
								, transaction_type
								, date_of_this_transaction
								, date_of_next_transaction
								, card_type
								, name_on_card
								, account_number
								, expiration_month
								, expiration_year
								, x_method
								, bank_ABA_code
								, bank_account_number
								) 
						values (@UserName
							, '0' -- 0 = NOT ok to process
							, 'MANUAL_CHECK'
							, @@DateOfThisTransaction
							, @@DateOfNextTransaction
							, '9' -- 9 = Manual Check
							, @NameOnCard
							, '0'
							, '00'
							, '0000'
							, 'MANUAL'
							, @BankABACode
							, @BankAccountNumber
							)
			END


---------------------------------------
-- transactions_log
---------------------------------------
		PRINT 'Enter new transaction into transactions_log table'
		INSERT INTO transactions_log (transaction_id
				, batch_transaction_id
				, user_id
				, user_name
				, card_type
				, name_on_card
				, account_number
				, expiration_month
				, expiration_year
				, transaction_type
				, x_response_code
				, months_joined
				, amount
				, date_of_this_transaction
				, date_of_next_transaction
				, x_response_reason_text
				, x_trans_id
				, x_md5_hash
				, x_description
				, x_method
				, bank_ABA_code
				, bank_account_number
				) 
		VALUES ( @TransactionID
			, ''
			, @@UserId
			, @UserName
			, '9' -- 9 = Manual Check
			, @NameOnCard
			, '0'
			, '00'
			, '0000'
			, 'MANUAL_CHECK'
			, '0' -- @XResponseCode
			, @MonthsJoined
			, CONVERT (MONEY, @Amount)
			, @@DateOfThisTransaction
			, @@DateOfNextTransaction
			, 'Not Cleared' -- @XResponseCode
			, @XTransID
			, @XMd5Hash
			, @XDescription
			, 'MANUAL'
			, @BankABACode
			, @BankAccountNumber
			)
		RETURN 1
		
	END
ELSE
	BEGIN
		PRINT 'ERROR:  User is already a paying member (' + @UserName + '):(' + @@MembershipType + ')'
		RETURN 666
	END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

