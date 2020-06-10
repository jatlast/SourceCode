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
IF( 
	(@@MembershipType != '1' AND @@MembershipType != '2') 
	OR (@TransactionType = 'CREDIT' OR @TransactionType = 'VOID')
	OR ( @@IsMembershipActive = '0' AND (@@MembershipType = '1' OR @@MembershipType = '2') ) )
	BEGIN
	
		-- Set the current date 
		SELECT @@DateOfThisTransaction = GETDATE()
		
		-- Add @MonthsJoined to the DateOfThisTransaction to initialize the DateOfNextTransaction
		SELECT @@DateOfNextTransaction = DATEADD(MONTH, CONVERT (INT, @MonthsJoined), @@DateOfThisTransaction)

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
			, 'ERROR: No Response From Server' -- @XResponseReasonText
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

