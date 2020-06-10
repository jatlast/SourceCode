SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GenManualCheckForm]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GenManualCheckForm]
GO



CREATE PROCEDURE [admin_GenManualCheckForm]
	@UserName varchar(32)
 AS

if exists (select user_name from login_info where user_name = @UserName)
BEGIN
	if exists (select user_name from billing_info where user_name = @UserName)
	BEGIN
		-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
		print 'Get info to populate the ManualCheckFormr with billing_info'
		select login_info.user_name
			,  login_info.date_started_paying
			, membership_type.membership_type_name
			, contact_info.first_name
			, contact_info.last_name
			, contact_info.street_address
			, contact_info.city
			, state.choice AS 'state'
			, contact_info.zip
			, country.choice AS 'country'
			, billing_info.bank_account_number
			, billing_info.bank_ABA_code
		from login_info
			, membership_type
			, contact_info
			, state
			, country
			, billing_info
		where login_info.user_name = @UserName
			and login_info.membership_type = membership_type.membership_type_id
			and login_info.user_name = contact_info.user_name
			and contact_info.state = state.value
			and contact_info.country = country.value
			and login_info.user_name = billing_info.user_name
	return 0
	END
	else
	BEGIN
	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
		print 'Get info to populate the ManualCheckFormr no billing_info'
	select login_info.user_name
		,  login_info.date_started_paying
		, membership_type.membership_type_name
		, contact_info.first_name
		, contact_info.last_name
		, contact_info.street_address
		, contact_info.city
		, state.choice AS 'state'
		, contact_info.zip
		, country.choice AS 'country'
		, 'BankAcctNum' AS 'bank_account_number'
		, 'BankABACode' AS 'bank_ABA_code'
	from login_info
		, membership_type
		, contact_info
		, state
		, country
	where login_info.user_name = @UserName
		and login_info.membership_type = membership_type.membership_type_id
		and login_info.user_name = contact_info.user_name
		and contact_info.state = state.value
		and contact_info.country = country.value
	return 0
	END
END
else
BEGIN
	-- If the user_name does not exist exit with a return value of 666 
	print 'user_name does not exist'
	return 665
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

