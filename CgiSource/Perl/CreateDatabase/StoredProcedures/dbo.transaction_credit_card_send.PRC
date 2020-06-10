SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[transaction_credit_card_send]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[transaction_credit_card_send]
GO



CREATE PROCEDURE [transaction_credit_card_send]
@TransactionID CHAR(52)
, @BatchTransactionID VARCHAR(60)
, @UserName VARCHAR(32)
, @MonthsJoined VARCHAR(3)
, @Amount VARCHAR(8)
, @NameOnCard VARCHAR(64)
, @CardType CHAR(1)
, @AccountNumber VARCHAR(32)
, @ExpirationMonth CHAR(2)
, @ExpirationYear CHAR(4)
, @TransactionType VARCHAR(18)
, @XTransID CHAR(9)
, @XDescription VARCHAR(256)
, @XMethod VARCHAR(18)
, @BankABACode VARCHAR(9)
, @BankAccountNumber VARCHAR(32)

 AS

DECLARE @@DateOfThisTransaction DATETIME
DECLARE @@DateOfNextTransaction DATETIME

DECLARE @@MembershipType 	CHAR(4)
DECLARE @@IsMembershipActive	CHAR(1)

DECLARE @@UserId			VARCHAR(10)
SELECT @@UserId = (SELECT user_id from login_info where user_name = @UserName)

-- Get user info from billing_info table...
SELECT @@IsMembershipActive = (SELECT is_membership_active from billing_info where user_name = @UserName)
	
print 'Method = ' + @XMethod

-- Check if user is already a paying member...
SELECT @@MembershipType = (SELECT membership_type from login_info where user_name = @UserName)
IF( (@@MembershipType != '1' AND @@MembershipType != '2') OR @TransactionType = 'CREDIT' OR ( @@IsMembershipActive = '0' AND (@@MembershipType = '1' OR @@MembershipType = '2') ) )
	BEGIN
	
		-- Set the current date 
		SELECT @@DateOfThisTransaction = GETDATE()
		
		-- Add @MonthsJoined to the DateOfThisTransaction to initialize the DateOfNextTransaction
		SELECT @@DateOfNextTransaction = DATEADD(MONTH, CONVERT (INT, @MonthsJoined), @@DateOfThisTransaction)
		
---------------------------------------
-- billing_info
---------------------------------------
			print 'Updating the Credit Card info in the billing_info table'			
			-- Determine if the user_name is unique in the billing_info table
			if exists (select user_name from billing_info where user_name = @UserName)
			BEGIN
				-- Update the proper columns based on which method of transaction this is...
				IF (@XMethod = 'CC')
					BEGIN
						-- If the user_name is NOT unique update the billing_info table with the current information
						print 'update billing_info table'
						update billing_info 
							set card_type = @CardType
								, account_number = @AccountNumber
								, name_on_card = @NameOnCard
								, expiration_month = @ExpirationMonth
								, expiration_year = @ExpirationYear
							where user_name = @UserName
					END
				ELSE
					BEGIN
						-- If the user_name is NOT unique update the billing_info table with the current information
						print 'update billing_info table'
						update billing_info 
							set bank_ABA_code = @BankABACode
								, bank_account_number = @BankAccountNumber
							where user_name = @UserName
					END
				
			-- Needs Refining...
				-- Add the new number of months_joined (* 30 in days) to the curent date_membership_expires...
				-- SELECT @@DateOfNextTransaction = DATEADD(DAY, CONVERT ( INT, (@MonthsJoined * 30) ), (SELECT date_membership_expires FROM billing_info) )
			END
			else
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
					, @CardType
					, @NameOnCard
					, @AccountNumber
					, @ExpirationMonth
					, @ExpirationYear
					, '0'
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
				-- Update the proper columns based on which method of transaction this is...
				IF (@XMethod = 'CC' OR @XMethod = 'ECHECK')
					BEGIN
						-- If the user_name is NOT unique update the recurring_transactions table with the current information
						print 'update recurring_transactions table'
						update recurring_transactions 
							set sendable = '1' -- 1 = OK to process
								, transaction_type = @TransactionType
								, date_of_this_transaction = @@DateOfThisTransaction
								, date_of_next_transaction = @@DateOfNextTransaction
								, card_type = @CardType
								, account_number = @AccountNumber
								, name_on_card = @NameOnCard
								, expiration_month = @ExpirationMonth
								, expiration_year = @ExpirationYear
								, x_method = @XMethod
								,  bank_ABA_code = @BankABACode
								, bank_account_number = @BankAccountNumber
							where user_name = @UserName
					END
			-- Needs Refining...
				-- Add the new number of months_joined (* 30 in days) to the curent date_membership_expires...
				-- SELECT @@DateOfNextTransaction = DATEADD(DAY, CONVERT ( INT, (@MonthsJoined * 30) ), (SELECT date_membership_expires FROM billing_info) )
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
							, '1' -- 1 = this is ok to process
							, @TransactionType
							, @@DateOfThisTransaction
							, @@DateOfNextTransaction
							, @CardType
							, @NameOnCard
							, @AccountNumber
							, @ExpirationMonth
							, @ExpirationYear
							, @XMethod
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
				, x_description
				, x_method
				, bank_ABA_code
				, bank_account_number
				) 
		VALUES ( @TransactionID
			, @BatchTransactionID
			, @@UserId
			, @UserName
			, @CardType
			, @NameOnCard
			, @AccountNumber
			, @ExpirationMonth
			, @ExpirationYear
			, @TransactionType
			, '0' -- @XResponseCode
			, @MonthsJoined
			, CONVERT (MONEY, @Amount)
			, @@DateOfThisTransaction
			, @@DateOfNextTransaction
			, 'Waiting for response' -- @XResponseCode
			, @XTransID
			, @XDescription
			, @XMethod
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

