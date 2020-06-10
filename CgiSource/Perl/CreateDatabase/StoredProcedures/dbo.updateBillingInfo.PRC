SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updateBillingInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updateBillingInfo]
GO



CREATE PROCEDURE [updateBillingInfo]
@UserName		VARCHAR(32)
, @CardType		CHAR(1)
, @NameOnCard	VARCHAR(64)
, @AccountNumber	VARCHAR(32)
, @ExpirationMonth	CHAR(2)
, @ExpirationYear	CHAR(4)
, @BankABACode	 VARCHAR(9)
, @BankAccountNumber VARCHAR(32)

 AS
-- update the user's credit card information in the billing_info table
UPDATE billing_info 
	SET card_type = @CardType
		, name_on_card = @NameOnCard
		, account_number = @AccountNumber
		, expiration_month = @ExpirationMonth
		, expiration_year = @ExpirationYear
		, bank_ABA_code = @BankABACode
		, bank_account_number = @BankAccountNumber
	WHERE user_name = @UserName
RETURN 1


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

