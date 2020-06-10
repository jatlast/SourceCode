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
, @XMd5Hash VARCHAR(50)

 AS

DECLARE @@UserName CHAR(32)
SELECT @@UserName = (SELECT user_name from transactions_log WHERE transaction_id = @TransactionID)

-- update the transactions_log table with the fields returned from Authorize.Net
UPDATE transactions_log 
	SET x_response_code  	= @XResponseCode
	        , x_response_subcode	= @XResponseSubcode
	        , x_response_reason_code 	= @XResponseReasonCode
	        , x_response_reason_text 	= @XResponseReasonText
	        , x_auth_code 		= @XAuthCode
	        , x_avs_code 		= @XAvsCode
	        , x_md5_hash 		= @XMd5Hash
	WHERE transaction_id = @TransactionID

-- If @XResponseCode = 1 update the membership type to 1
IF (@XResponseCode = "1")
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

		-- update billing_info table to reflect the successful transaction
		UPDATE billing_info 
			SET is_membership_active = '1'
				, date_membership_expires =  (SELECT date_of_next_transaction from transactions_log WHERE transaction_id = @TransactionID)
			WHERE user_name = @@UserName
		
		PRINT 'login_info and billing_info were updated:   x_response_code = (' + @XResponseCode + ')'
	END
ELSE
	BEGIN
		PRINT 'login_info and billing_info were not updated because x_response_code = (' + @XResponseCode + ')'

		PRINT 'Removing (' + @@UserName + ') from the recurring_transactions table'
		DELETE recurring_transactions
			WHERE user_name = @@UserName
	END

RETURN 1


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

