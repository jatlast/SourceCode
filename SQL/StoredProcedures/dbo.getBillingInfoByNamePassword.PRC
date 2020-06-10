SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getBillingInfoByNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getBillingInfoByNamePassword]
GO



CREATE PROCEDURE [getBillingInfoByNamePassword]
	@UserName VARCHAR(32)
	, @Password VARCHAR (16)
 AS

DECLARE @@CardType VARCHAR(16)
SELECT @@CardType = ''
SELECT @@CardType = 	(
				SELECT credit_card_type.choice
					FROM billing_info
						, credit_card_type 
				WHERE billing_info.user_name = @UserName
					and billing_info.card_type = credit_card_type.value 
				)	

IF ( (SELECT password FROM login_info WHERE user_name = @UserName) = @Password)
	BEGIN
		SELECT user_name
				, card_type
				, name_on_card
				, account_number
				, expiration_month
				, expiration_year
				, bank_ABA_code
				, bank_account_number
		FROM billing_info
		WHERE user_name = @UserName
		
		SELECT billing_info.user_name
				, @@CardType
				, billing_info.name_on_card
				, billing_info.account_number
				, billing_info.expiration_month
				, billing_info.expiration_year
				, billing_info.bank_ABA_code
				, billing_info.bank_account_number
		FROM billing_info
		WHERE billing_info.user_name = @UserName
		
		RETURN 1
	END
ELSE
	BEGIN
		PRINT 'ERROR: User Name and Password did not match.'
		RETURN 138
	END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

