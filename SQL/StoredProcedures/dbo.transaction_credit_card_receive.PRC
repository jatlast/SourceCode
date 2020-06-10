SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[transaction_credit_card_receive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[transaction_credit_card_receive]
GO



CREATE PROCEDURE [transaction_credit_card_receive]
@TransactionID CHAR(52)
, @XResponseCode CHAR(1)
, @XResponseSubcode CHAR(6)
, @XResponseReasonCode CHAR(2)
, @XResponseReasonText VARCHAR(320)
, @XAuthCode CHAR(8)
, @XAvsCode CHAR(1)
, @XTransID CHAR(9)
, @XMd5Hash VARCHAR(50)

 AS

-- Declare and initialize variables from the existing transaction in the transactions_log...
DECLARE @@UserName				VARCHAR(32)
DECLARE @@TransactionType		VARCHAR(18)
DECLARE @@CardType				CHAR(1)
DECLARE @@NameOnCard			VARCHAR(64)
DECLARE @@AccountNumber			VARCHAR(32)
DECLARE @@ExpirationMonth		CHAR(2)
DECLARE @@ExpirationYear		CHAR(4)
DECLARE @@BankABACode			VARCHAR(9)
DECLARE @@BankAccountNumber		VARCHAR(32)
DECLARE @@DateOfThisTransaction	DATETIME
DECLARE @@DateOfNextTransaction	DATETIME
DECLARE @@XMethod				VARCHAR(18)

SELECT @@UserName				= (SELECT user_name			from transactions_log WHERE transaction_id = @TransactionID)
	, @@TransactionType			= (SELECT transaction_type	from transactions_log WHERE transaction_id = @TransactionID)
	, @@CardType				= (SELECT card_type					from transactions_log WHERE transaction_id = @TransactionID)
	, @@NameOnCard				= (SELECT name_on_card				from transactions_log WHERE transaction_id = @TransactionID)
	, @@AccountNumber			= (SELECT account_number			from transactions_log WHERE transaction_id = @TransactionID)
	, @@ExpirationMonth			= (SELECT expiration_month			from transactions_log WHERE transaction_id = @TransactionID)
	, @@ExpirationYear			= (SELECT expiration_year			from transactions_log WHERE transaction_id = @TransactionID)
	, @@BankABACode				= (SELECT bank_ABA_code				from transactions_log WHERE transaction_id = @TransactionID)
	, @@BankAccountNumber		= (SELECT bank_account_number		from transactions_log WHERE transaction_id = @TransactionID)
	, @@DateOfThisTransaction	= (SELECT date_of_this_transaction	from transactions_log WHERE transaction_id = @TransactionID)
	, @@DateOfNextTransaction	= (SELECT date_of_next_transaction	from transactions_log WHERE transaction_id = @TransactionID)
	, @@XMethod					= (SELECT x_method					from transactions_log WHERE transaction_id = @TransactionID)


-- update the transactions_log table with the fields returned from Authorize.Net
UPDATE transactions_log 
	SET x_response_code  			= @XResponseCode
	        , x_response_subcode	= @XResponseSubcode
	        , x_response_reason_code= @XResponseReasonCode
	        , x_response_reason_text= @XResponseReasonText
	        , x_auth_code 			= @XAuthCode
	        , x_avs_code 			= @XAvsCode
	        , x_trans_id 			= @XTransID
	        , x_md5_hash 			= @XMd5Hash
	WHERE transaction_id = @TransactionID

-- If @XResponseCode = 1 update the membership type to 1 only if this is not a CREDIT or VOID
IF (
	@XResponseCode = "1" 
	AND @@TransactionType != 'CREDIT' 
	AND @@TransactionType != 'VOID'
   )-- VOID not currently supported!!!
	BEGIN
		IF( (SELECT date_started_paying FROM login_info where user_name = @@UserName) = NULL)
			BEGIN
				-- update login_info table to reflect the successful transaction
				UPDATE login_info 
					SET membership_type 	= '1'
						, date_started_paying =  (SELECT date_of_this_transaction from transactions_log WHERE transaction_id = @TransactionID)
					WHERE user_name = @@UserName
			END
		ELSE
			BEGIN
				-- update login_info table to reflect the successful transaction
				UPDATE login_info 
					SET membership_type 	= '1'
					WHERE user_name = @@UserName
			END

---------------------------------------
-- billing_info
---------------------------------------

		print 'Updating the Credit Card info in the billing_info table'			
		-- Determine if the user_name is unique in the billing_info table
		if exists (select user_name from billing_info where user_name = @@UserName)
			BEGIN
				-- Update the proper columns based on which method of transaction this is...
				IF (@@XMethod = 'CC')
					BEGIN
						-- If the user_name is NOT unique update the billing_info table with the current information
						print 'update billing_info table'
						update billing_info 
							set card_type = @@CardType
								, account_number = @@AccountNumber
								, name_on_card = @@NameOnCard
								, expiration_month = @@ExpirationMonth
								, expiration_year = @@ExpirationYear
								, is_membership_active = '1'
								, date_membership_expires = @@DateOfNextTransaction

							where user_name = @@UserName
					END
				ELSE
					BEGIN
						-- If the user_name is NOT unique update the billing_info table with the current information
						print 'update billing_info table'
						update billing_info 
							set bank_ABA_code = @@BankABACode
								, bank_account_number = @@BankAccountNumber
								, is_membership_active = '1'
								, date_membership_expires = @@DateOfNextTransaction
							where user_name = @@UserName
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
				values (@@UserName
					, @@CardType
					, @@NameOnCard
					, @@AccountNumber
					, @@ExpirationMonth
					, @@ExpirationYear
					, '1'
					, @@DateOfNextTransaction
					, @@BankABACode
					, @@BankAccountNumber
					)
			END

---------------------------------------
-- recurring_transactions
---------------------------------------
		print 'Updating the Credit Card info in the recurring_transactions  table'
		-- Determine if the user_name is unique in the recurring_transactions table
		if exists (select user_name from recurring_transactions where user_name = @@UserName)
			BEGIN
				-- Update the proper columns based on which method of transaction this is...
				IF (@@XMethod = 'CC' OR @@XMethod = 'ECHECK')
					BEGIN
						-- If the user_name is NOT unique update the recurring_transactions table with the current information
						print 'update recurring_transactions table'
						update recurring_transactions 
							set sendable = '1' -- 1 = OK to process
								, transaction_type = @@TransactionType
								, date_of_this_transaction = @@DateOfThisTransaction
								, date_of_next_transaction = @@DateOfNextTransaction
								, card_type = @@CardType
								, account_number = @@AccountNumber
								, name_on_card = @@NameOnCard
								, expiration_month = @@ExpirationMonth
								, expiration_year = @@ExpirationYear
								, x_method = @@XMethod
								,  bank_ABA_code = @@BankABACode
								, bank_account_number = @@BankAccountNumber
							where user_name = @@UserName
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
						values (@@UserName
							, '1' -- 1 = this is ok to process
							, @@TransactionType
							, @@DateOfThisTransaction
							, @@DateOfNextTransaction
							, @@CardType
							, @@NameOnCard
							, @@AccountNumber
							, @@ExpirationMonth
							, @@ExpirationYear
							, @@XMethod
							, @@BankABACode
							, @@BankAccountNumber
							)
			END


		PRINT 'login_info and billing_info were updated:   x_response_code = (' + @XResponseCode + ')'
	END -- END If @XResponseCode = 1 and not (CREDIT and VOID)
ELSE
	BEGIN	-- If @XResponseCode = 1 and transaction_type = CREDIT or VOID update the membership type to 0 to cancel the user's membership
		IF (
			@XResponseCode = "1" 
				AND (@@TransactionType = 'CREDIT' OR @@TransactionType = 'VOID') 
		   )-- VOID not currently supported!!!
			BEGIN
			-- cancel the user's paying membership
				UPDATE login_info 
					SET membership_type = '0'
					WHERE user_name = @@UserName

				PRINT 'Removing (' + @@UserName + ') from the recurring_transactions table'
				DELETE recurring_transactions
					WHERE user_name = @@UserName

			print 'Updating the Credit Card info in the billing_info table'			
			-- Determine if the user_name is unique in the billing_info table
			if exists (select user_name from billing_info where user_name = @@UserName)
				BEGIN
					print 'update billing_info table'
					update billing_info 
						set is_membership_active = '0'
							, date_membership_expires = @@DateOfThisTransaction
						where user_name = @@UserName
				END
	
				PRINT 'CANCEL or VOID so login_info and billing_info were updated:   x_response_code = (' + @XResponseCode + ')'
			END
		ELSE
			BEGIN
---------------------------------------
-- billing_info
---------------------------------------
				print 'Updating the Credit Card info in the billing_info table if the user does not already exist in the table'
				-- Determine if the user_name is unique in the billing_info table
				if not exists (select user_name from billing_info where user_name = @@UserName)
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
						values (@@UserName
							, @@CardType
							, @@NameOnCard
							, @@AccountNumber
							, @@ExpirationMonth
							, @@ExpirationYear
							, '0'
							, @@DateOfNextTransaction
							, @@BankABACode
							, @@BankAccountNumber
							)
					END

				
			END
	END

RETURN 1


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

