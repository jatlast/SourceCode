if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LogIn]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[LogIn]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_BatchMailUsersBeforeRebilling]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_BatchMailUsersBeforeRebilling]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_BatchNightlyTransactionSend]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_BatchNightlyTransactionSend]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_DeleteAllDanglingUserNames]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_DeleteAllDanglingUserNames]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_DeleteBadProfiles]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_DeleteBadProfiles]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_DeleteEntireProfileByUserName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_DeleteEntireProfileByUserName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_FindDuplicates]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_FindDuplicates]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_FreeFormAudit]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_FreeFormAudit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GetDanglingUserNames]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GetDanglingUserNames]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GetIndividualTableInfoByUserName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GetIndividualTableInfoByUserName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GetMembershipCancellations]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GetMembershipCancellations]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GraphHourlyCreationDateStatsByDayMonthYear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GraphHourlyCreationDateStatsByDayMonthYear]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GraphMonthlyCreationDateStatsByMonthYear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GraphMonthlyCreationDateStatsByMonthYear]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GraphMonthlyCreationDateStatsByYear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GraphMonthlyCreationDateStatsByYear]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GraphYearlyCreationDateStats]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GraphYearlyCreationDateStats]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_TransactionsLogAudit]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_TransactionsLogAudit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[advancedSearch]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[advancedSearch]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cancel_paying_membership]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[cancel_paying_membership]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[changeEmailAddress]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[changeEmailAddress]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[checkUsernamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[checkUsernamePassword]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[createLoginInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[createLoginInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[deleteMail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[deleteMail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[func_GetProfileScore]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[func_GetProfileScore]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[genAuthorizeNetFormCC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[genAuthorizeNetFormCC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[genBookMarks]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[genBookMarks]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[genInbox]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[genInbox]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[genMemberHome]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[genMemberHome]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[genOutbox]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[genOutbox]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[genPicUpload]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[genPicUpload]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[genSendMail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[genSendMail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getAboutInfoByNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getAboutInfoByNamePassword]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getBillingInfoByNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getBillingInfoByNamePassword]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getContactInfoByNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getContactInfoByNamePassword]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getEmailByUserName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getEmailByUserName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getLoginInfoByEmailMaidenName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getLoginInfoByEmailMaidenName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getLoginInfoByNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getLoginInfoByNamePassword]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getLoginInfoByUserNameMaidenName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getLoginInfoByUserNameMaidenName]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getPersonalInfoByNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getPersonalInfoByNamePassword]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[hideUnhideProfile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[hideUnhideProfile]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[insert_membership_cancellation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[insert_membership_cancellation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[mailSend]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[mailSend]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[mailSendNewUserWelcome]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[mailSendNewUserWelcome]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[readReceivedMail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[readReceivedMail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[readSentMail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[readSentMail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[simpleSearch]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[simpleSearch]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[singleProfile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[singleProfile]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[transaction_credit_card_receive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[transaction_credit_card_receive]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[transaction_credit_card_send]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[transaction_credit_card_send]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[transaction_manual_check_post]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[transaction_manual_check_post]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updateAboutInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updateAboutInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updateBillingInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updateBillingInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updateBookMarks]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updateBookMarks]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updateContactInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updateContactInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updateLoginInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updateLoginInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updatePersonalInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updatePersonalInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updatePicture]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updatePicture]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[verifyEmailAddress]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[verifyEmailAddress]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[verifyMembershipTypePermissions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[verifyMembershipTypePermissions]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE [LogIn]
	@UserName varchar(32)
	, @Password varchar (16)
 AS

DECLARE @last_login datetime

/* Set the default values */
select @last_login = getdate()

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
	update login_info 
		set last_login = @last_login
		where user_name = @UserName
	return 1
END

else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 666
END








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

-- This script should be run NIGHTLY
-- It gathers the information necessary to:
--	1. Inform users that their credit card will expire before their next transaction
--	2. inform users that their Premium membership will be cancelled if they have not logged in within a month of ther next billing
--		a)  tells the user how many days since their last login
--	3. inform users of the date and amount of their next billing
--		a)  tells the user how many days until their next billing
--	4. inform users if their email addresses need to be verified
CREATE PROCEDURE [admin_BatchMailUsersBeforeRebilling]

 AS

	SELECT recurring_transactions.user_name
		, CONVERT(CHAR(19), recurring_transactions.date_of_next_transaction, 100) AS 'date_of_next_transaction'
		, DATEDIFF(DAY, GETDATE(), recurring_transactions.date_of_next_transaction) AS 'days_until_next_transaction'
		, RIGHT(recurring_transactions.account_number, 4) AS 'last_four_digits'
		, recurring_transactions.rebilling_amount
		, CASE
			WHEN recurring_transactions.expiration_year < DATEPART(YEAR, recurring_transactions.date_of_next_transaction)
				OR (
					recurring_transactions.expiration_year = DATEPART(YEAR, recurring_transactions.date_of_next_transaction)
					AND recurring_transactions.expiration_month < DATEPART(MONTH, recurring_transactions.date_of_next_transaction)
				   )
			THEN 'YES'
			ELSE 'NO'
		END AS 'card_expires'
		, CASE
			WHEN login_info.last_login < DATEADD(month, -1, recurring_transactions.date_of_next_transaction)
			THEN 'NO'
			ELSE 'YES'
		END AS 'user_logged_in_this_month'
		, (SELECT RTRIM(membership_type_name) FROM membership_type where membership_type_id = login_info.membership_type) AS 'membership_type'
		, login_info.password
		, login_info.email
		, login_info.sex
		, DATEDIFF(DAY, login_info.last_login, GETDATE()) AS 'days_since_last_login'
		, login_info.email_verification_code
		, login_info.is_email_verified
	FROM recurring_transactions
		, login_info
	WHERE recurring_transactions.date_of_next_transaction < DATEADD(day, 7, GETDATE())
		AND recurring_transactions.date_of_next_transaction > DATEADD(day, 6, GETDATE())
		AND login_info.user_name = recurring_transactions.user_name
		AND recurring_transactions.sendable = '1'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

-- This script should be run NIGHTLY
-- It does the following:
--	1. cleans up  the mail table
--	2. resets  the login_info.photo_submitted field
--	3. cleans up membership status so users accounts expire when they should
--	4. Inserst an automatic cancellation for users who are supposed to be billed but is_email_verified = 0
--	5. Inserts an automatic cancellation for users whose credit cards are no longer valid
--	6. Inserts an automatic cancellation for users whose have not logged into their accounts within a month of their re-billing date
--	7. retrieves the user_names of the members who should be re-billed their monthly fee...
CREATE PROCEDURE [admin_BatchNightlyTransactionSend]

 AS

------- 1 -------
-- clean up mail table
print 'Cleaning up mail'
delete mail where sender_deleted = 1 and receiver_deleted = 1

------- 2 -------
-- reset login_info.photo_submitted = 0 for users who have deleted all their photos...
print 'Cleaning up picture status'
update login_info set photo_submitted = 0 
	where user_name in
			(
			select pictures.user_name 
			from pictures
				, login_info
			where login_info.user_name = pictures.user_name
				and login_info.photo_submitted = 1
				and photo_1 = 'Nothing'
				and photo_2 = 'Nothing'
				and photo_3 = 'Nothing'
				and photo_4 = 'Nothing'
				and photo_5 = 'Nothing'
			)

------- 3 -------
-- change the user's membership_type to "0" (basic) if the promotion has ended or 
-- they have canceled their paying membership...
print 'Cleaning up membership status'
UPDATE login_info
	SET membership_type = 0 -- 0 = Basic Membership
	WHERE 
		-- find all user_names with canceled paying memberships...
		membership_type 
				IN
					(
					-- find all NON recurring membership_type_id's...
						SELECT membership_type_id
							FROM membership_type
							WHERE  membership_type_id != 0
					)
		AND	user_name 
				IN 
					(
					-- find all user_names with inactive memberships 
					 -- past the date of membership expiration...
						SELECT user_name
							FROM billing_info
							WHERE date_membership_expires <  GETDATE()
							-- We used to give paying members an extra day a month...
							--and DATEDIFF( DAY, GETDATE(), date_membership_expires ) < 0
					)

DECLARE @@UniqueId		INT
DECLARE @@DateCancelled		DATETIME
DECLARE @@UserName 		VARCHAR(32)
DECLARE @@Email			VARCHAR(64)
DECLARE @@DateStartedPaying	DATETIME
-- Get the maximum +1 unique_id number fron the membership_cancellation table 
SELECT @@UniqueId = MAX(unique_id + 1) FROM membership_cancellation
--  If there are no user ids in the database this is the first and therefore #1 
IF @@UniqueId IS NULL
SELECT @@UniqueId = 1

-- Set the current date 
SELECT @@DateCancelled = GETDATE()

------- 4 -------
-- Insert an automatic cancellation for users who are supposed to be billed but is_email_verified = 0
-- And delete that user from the recurring_transactions table
WHILE (
	SELECT count(* )
	FROM recurring_transactions
		, login_info
	WHERE recurring_transactions.date_of_next_transaction < @@DateCancelled
		AND login_info.is_email_verified = '0'
		AND login_info.user_name = recurring_transactions.user_name
	 ) > 0
	BEGIN
		SELECT @@UserName = (
					SELECT MAX(recurring_transactions.user_name)
					FROM recurring_transactions
						, login_info
					WHERE recurring_transactions.date_of_next_transaction < @@DateCancelled
						AND login_info.is_email_verified = '0'
						AND login_info.user_name = recurring_transactions.user_name
					 )
		SELECT @@Email = (
					SELECT email
					FROM login_info
					WHERE user_name = @@UserName
				           )
		SELECT @@DateStartedPaying = (
							SELECT date_started_paying
							FROM login_info
							WHERE user_name = @@UserName
						       )
		PRINT 'Inserting (' + @@UserName + ') into membership_cancellation table'
		INSERT INTO membership_cancellation (unique_id
							, user_name
							, email
							, date_started_paying
							, date_cancelled
							, reason_for_leaving
							, membership_prices
							, website_design
							, suggestions
						         ) 
						VALUES (@@UniqueId
							, @@UserName
							, @@Email
							, @@DateStartedPaying
							, @@DateCancelled
							, 'Automatic Cancel'
							, 'N/A'
							, 'N/A'
							, 'Automatic Cancel because email not verified when recurring transaction bacame due'
							)
	
		PRINT 'Update is_membership_active to 0 for (' + @@UserName + ') in billing_info table'
		UPDATE billing_info
			SET is_membership_active = '0'
			WHERE user_name = @@UserName

		PRINT 'Delete (' + @@UserName + ') from recurring_transactions table'
		DELETE recurring_transactions WHERE user_name = @@UserName

		SELECT @@UniqueId = @@UniqueId + 1
		
	END

------- 5 -------
-- Insert an automatic cancellation for users whose credit cards are no longer valid
--	Delete from recurring_transctions table when:
--		login_info.membership_type 	  = '0' 
--	    AND billing_info.is_membership_active = '1'
WHILE (
	SELECT count(*)
	FROM recurring_transactions
		, login_info
		, billing_info
	WHERE recurring_transactions.date_of_next_transaction < DATEADD(day, -1, GETDATE())
		AND login_info.membership_type = '0'
		AND billing_info.is_membership_active = '1'
		AND login_info.user_name = recurring_transactions.user_name
		AND login_info.user_name = billing_info.user_name
	 ) > 0
	BEGIN
		SELECT @@UserName = (
					SELECT MAX(recurring_transactions.user_name)
					FROM recurring_transactions
						, login_info
						, billing_info
					WHERE recurring_transactions.date_of_next_transaction < DATEADD(day, -1, GETDATE())
						AND login_info.membership_type = '0'
						AND billing_info.is_membership_active = '1'
						AND login_info.user_name = recurring_transactions.user_name
						AND login_info.user_name = billing_info.user_name
					)

		SELECT @@Email = (
					SELECT email
					FROM login_info
					WHERE user_name = @@UserName
				)

		SELECT @@DateStartedPaying = (
						SELECT date_started_paying
						FROM login_info
						WHERE user_name = @@UserName
						)

		PRINT 'Inserting (' + @@UserName + ') into membership_cancellation table'
		INSERT INTO membership_cancellation (unique_id
							, user_name
							, email
							, date_started_paying
							, date_cancelled
							, reason_for_leaving
							, membership_prices
							, website_design
							, suggestions
						         ) 
						VALUES (@@UniqueId
							, @@UserName
							, @@Email
							, @@DateStartedPaying
							, @@DateCancelled
							, 'Automatic Cancel'
							, 'N/A'
							, 'N/A'
							, 'Automatic Cancel because credit card no longer works'
							)
	
		PRINT 'Update is_membership_active to 0 for (' + @@UserName + ') in billing_info table'
		UPDATE billing_info
			SET is_membership_active = '0'
			WHERE user_name = @@UserName

		PRINT 'Delete (' + @@UserName + ') from recurring_transactions table'
		DELETE recurring_transactions WHERE user_name = @@UserName

		SELECT @@UniqueId = @@UniqueId + 1
		
	END


------- 6 -------
-- Inserts an automatic cancellation for users whose have not logged into their accounts within a month of their re-billing date
--	Delete from recurring_transctions table when:
--		login_info.last_login < 2 month from re-billing date 
--	    AND billing_info.is_membership_active = '1'
WHILE (
	SELECT count(*)
	FROM recurring_transactions
		, login_info
		, billing_info
	WHERE recurring_transactions.date_of_next_transaction < GETDATE()
		AND login_info.last_login < DATEADD(month, -2, recurring_transactions.date_of_next_transaction)
		AND login_info.user_name = recurring_transactions.user_name
		AND login_info.user_name = billing_info.user_name
	 ) > 0
	BEGIN
		SELECT @@UserName = (
					SELECT MAX(recurring_transactions.user_name)
					FROM recurring_transactions
						, login_info
						, billing_info
					WHERE recurring_transactions.date_of_next_transaction < GETDATE()
						AND login_info.last_login < DATEADD(month, -2, recurring_transactions.date_of_next_transaction)
						AND login_info.user_name = recurring_transactions.user_name
						AND login_info.user_name = billing_info.user_name
					)

		SELECT @@Email = (
					SELECT email
					FROM login_info
					WHERE user_name = @@UserName
					)

		SELECT @@DateStartedPaying = (
						SELECT date_started_paying
						FROM login_info
						WHERE user_name = @@UserName
						)

		DECLARE @@DaysSinceLastLogin VARCHAR(8)
		SELECT @@DaysSinceLastLogin = (
						SELECT DATEDIFF(DAY, last_login, GETDATE())
						FROM login_info
						WHERE user_name = @@UserName
						)

		PRINT 'Inserting (' + @@UserName + ') into membership_cancellation table'
		INSERT INTO membership_cancellation (unique_id
							, user_name
							, email
							, date_started_paying
							, date_cancelled
							, reason_for_leaving
							, membership_prices
							, website_design
							, suggestions
						         ) 
						VALUES (@@UniqueId
							, @@UserName
							, @@Email
							, @@DateStartedPaying
							, @@DateCancelled
							, 'Automatic Cancel'
							, 'N/A'
							, 'N/A'
							, 'Automatic Cancel because user has not logged for ' + @@DaysSinceLastLogin + ' days'
							)
	
		PRINT 'Update is_membership_active to 0 for (' + @@UserName + ') in billing_info table'
		UPDATE billing_info
			SET is_membership_active = '0'
			WHERE user_name = @@UserName

		PRINT 'Delete (' + @@UserName + ') from recurring_transactions table'
		DELETE recurring_transactions WHERE user_name = @@UserName

		SELECT @@UniqueId = @@UniqueId + 1
		
	END


------- 7 -------
-- Get all user_names that need to be billed
print 'Retrieving chargable users'
SELECT recurring_transactions.* 
		, login_info.password
	FROM recurring_transactions
		, login_info
	WHERE recurring_transactions.date_of_next_transaction < GETDATE()
		AND login_info.user_name = recurring_transactions.user_name
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO




CREATE PROCEDURE [admin_DeleteAllDanglingUserNames]

 AS

CREATE TABLE #DanglingUserNames( user_name VARCHAR(32) COLLATE database_default NOT NULL )
CREATE TABLE #IndividualUserNames( user_name VARCHAR(32) COLLATE database_default NOT NULL )

---------------- login_info ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from login_info 
	where user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from relationship)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- contact_info ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from contact_info 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from relationship)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- personal_info ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from personal_info 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from relationship)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- about_info ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from about_info 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from relationship)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- relationship ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from relationship 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
select user_name from #IndividualUserNames 
	where user_name not in (select user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- pictures ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from pictures 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from relationship)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

---------------- sent_from ----------------------------------------------
INSERT #IndividualUserNames

	select sent_from from mail 
		where sent_from not in (select user_name from login_info)
		or sent_from not in (select user_name from contact_info)
		or sent_from not in (select user_name from personal_info)
		or sent_from not in (select user_name from about_info)
		or sent_from not in (select user_name from relationship)
		or sent_from not in (select user_name from pictures)
	group by sent_from

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- sent_to ----------------------------------------------
INSERT #IndividualUserNames
	select sent_to from mail 
		where sent_to not in (select user_name from login_info)
		or sent_to not in (select user_name from contact_info)
		or sent_to not in (select user_name from personal_info)
		or sent_to not in (select user_name from about_info)
		or sent_to not in (select user_name from relationship)
		or sent_to not in (select user_name from pictures)
	group by sent_to

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

-- Drop both the tempory tables
drop table #IndividualUserNames

-- delete dangling profiles found using the login_info table...
PRINT 'Deleting dangling user_names found while running the stored procedure admin_GetDanglingUserNames'
DECLARE @UserName VARCHAR(32)
WHILE ( SELECT COUNT(*) FROM #DanglingUserNames ) > 370
BEGIN
	SELECT @UserName = (SELECT MAX(user_name) FROM #DanglingUserNames )
	PRINT 'Deleting User Name = (' + @UserName + ') based on stored procedure admin_GetDanglingUserNames'
	EXEC admin_DeleteEntireProfileByUserName @UserName
	PRINT 'Deleting User Name = (' + @UserName + ') from temp table'
	DELETE #DanglingUserNames WHERE user_name = @UserName
END

-- Drop the tempory table...
drop table #DanglingUserNames



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO



CREATE PROCEDURE [admin_DeleteBadProfiles]
 AS
/*
	the criteria:
	1)	creation_date = last_login
	2)	No Photo
	3)	No screen_quote
	4)	No about_yourself
	5)	Never has been a paying member
	6)	Has not logged in for at least an hour
*/

while	(
	select count(login_info.user_name) as 'Bad_Profiles'
	from login_info
		, about_info
	where login_info.last_login < dateadd( hour, -1, getdate() )
		and login_info.date_started_paying IS NULL
		and login_info.creation_date = login_info.last_login
		and login_info.photo_submitted = 0
		and
		 (
			(CONVERT( VARCHAR(32), about_info.screen_quote ) = '')
		    OR
	            		(CONVERT( VARCHAR(32), about_info.screen_quote ) = 'User did not enter any text')
		 )				
		and
		 (
			(CONVERT( VARCHAR(32), about_info.about_yourself ) = '')
		    OR
			(CONVERT( VARCHAR(32), about_info.about_yourself ) = 'User did not enter any text')
		)				
		and login_info.user_name = about_info.user_name
	) > 0
Begin
	declare @UserName varchar(32)
	select @UserName = (
				select max(login_info.user_name) as 'User_Name_To_Remove'
				from login_info
					, about_info
				where login_info.last_login < dateadd( hour, -1, getdate() )
					and login_info.date_started_paying IS NULL
					and login_info.creation_date = login_info.last_login
					and login_info.photo_submitted = 0
					and
					 (
						(CONVERT( VARCHAR(32), about_info.screen_quote ) = '')
					    OR
				            		(CONVERT( VARCHAR(32), about_info.screen_quote ) = 'User did not enter any text')
					 )				
					and
					 (
						(CONVERT( VARCHAR(32), about_info.about_yourself ) = '')
					    OR
						(CONVERT( VARCHAR(32), about_info.about_yourself ) = 'User did not enter any text')
					)				
					and login_info.user_name = about_info.user_name
			   )

	exec admin_DeleteEntireProfileByUserName @UserName
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO




CREATE PROCEDURE [admin_FindDuplicates]
 @DupToFind VARCHAR(64) 		= 'email'
, @TableWithDup VARCHAR(64) 	= 'login_info'
, @OrderBy VARCHAR(26)		= 'login_info.user_name'
, @AscDesc VARCHAR(4)		= 'ASC'
, @Limit INT				= 100
, @Index VARCHAR(6)			= '1'
, @UserName VARCHAR(32)		= '%'

 AS

PRINT 'Order by ' + @TableWithDup + '.' + @DupToFind + ', ' + @OrderBy  + ' ' + @AscDesc

-- count the total number of rows in the login_info table...
EXEC ( '	SELECT ' + @DupToFind + '
		INTO #dups FROM  ' + @TableWithDup + '
		GROUP BY ' + @DupToFind + '
		HAVING COUNT(*) > 1

SELECT COUNT(*) AS "count"
	FROM ' + @TableWithDup +'
		, #dups
	WHERE ' + @TableWithDup + '.' + @DupToFind + ' = #dups.' + @DupToFind + '

SELECT login_info.user_name		AS "user_name"
		, login_info.password		AS "password"
		, login_info.email		AS "email"
		, sex.choice			AS "sex"
		, pictures.photo_1		AS "photo_1"
		, pictures.photo_2		AS "photo_2"
		, pictures.photo_3		AS "photo_3"
		, pictures.photo_4		AS "photo_4"
		, pictures.photo_5		AS "photo_5"
		, contact_info.first_name		AS "first_name"
		, contact_info.last_name		AS "last_name"
		, contact_info.street_address	AS "street_address"
		, contact_info.city		AS "city"
		, state.choice			AS "state"
		, country.choice			AS "country"
		, contact_info.zip		AS "zip"
		, contact_info.telephone		AS "telephone"
		, about_info.screen_quote	AS "screen_quote"
		, about_info.about_yourself	AS "about_yourself"
		, about_info.questionable	AS "questionable"
		, login_info.creation_date	AS "creation_date"
		, login_info.last_login		AS "last_login"
	FROM login_info
		, pictures
		, contact_info
		, about_info
		, sex
		, state
		, country
		, #dups
	WHERE ' + @TableWithDup + '.' + @DupToFind + ' = #dups.' + @DupToFind + '
		AND login_info.user_name LIKE ''' + @UserName + '''
		AND login_info.user_name = pictures.user_name
		AND login_info.user_name = contact_info.user_name
		AND login_info.user_name = about_info.user_name
		AND login_info.sex = sex.value
		AND contact_info.state = state.value
		AND contact_info.country = country.value
	ORDER BY  ' + @TableWithDup  + '.' + @DupToFind  + ' ' + @AscDesc + ', ' + @OrderBy  + ' ' + @AscDesc
) -- end EXEC


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE [admin_FreeFormAudit]
@OrderBy CHAR(26)		= 'login_info.creation_date'
, @AscDesc CHAR(4)		= 'DESC'
, @Limit INT			= 100
, @Index CHAR(6)		= '1'
, @UserName VARCHAR(32)	= '%'
, @Email VARCHAR(64)	= '%'

 AS

-- the SET string provides a slight performance gain for stored procedures
SET NOCOUNT ON

PRINT 'Order by ' + @OrderBy  + @AscDesc

-- If UserName != "%" the user entered data to search for 
IF (@UserName != "%")
BEGIN
	PRINT 'user entered a user_name'
	-- Pad with SQL wildcards for searching 
	SELECT @UserName = ( SELECT ( @UserName + '%') )
END

PRINT 'user_name = ' + @UserName

IF (@Email != "%")
BEGIN
	PRINT 'user entered an email'
	-- Pad with SQL wildcards for searching 
	SELECT @Email = ( SELECT ( @Email + '%') )
END

PRINT 'email = ' + @Email

DECLARE @RowCount INT -- Used to set the rowcount based on index and limit
SELECT @RowCount = ( @Index + @Limit + 1 )

-- count the total number of rows in the login_info table...
SELECT COUNT(*) AS "count"
	FROM login_info

SET ROWCOUNT @RowCount

PRINT 'SQL:  SELECT login_info.user_name		AS "user_name"
		, login_info.password		AS "password"
		, login_info.email		AS "email"
		, login_info.sex			AS "sex"
		, pictures.photo_1		AS "photo_1"
		, pictures.photo_2		AS "photo_2"
		, pictures.photo_3		AS "photo_3"
		, pictures.photo_4		AS "photo_4"
		, pictures.photo_5		AS "photo_5"
		, contact_info.last_name		AS "last_name"
		, contact_info.city		AS "city"
		, about_info.screen_quote	AS "screen_quote"
		, about_info.about_yourself	AS "about_yourself"
		, about_info.questionable	AS "questionable"
		, login_info.creation_date	AS "creation_date"
		, login_info.last_login		AS "last_login"
	FROM login_info
		, pictures
		, contact_info
		, about_info
	WHERE login_info.user_name LIKE ''' + @UserName + '''
		AND login_info.email LIKE ''' + @Email + '''
		AND login_info.user_name = pictures.user_name
		AND login_info.user_name = contact_info.user_name
		AND login_info.user_name = about_info.user_name
	ORDER BY ' + @OrderBy + @AscDesc

EXEC ('SELECT login_info.user_name		AS "user_name"
		, login_info.password		AS "password"
		, login_info.email		AS "email"
		, login_info.sex			AS "sex"
		, pictures.photo_1		AS "photo_1"
		, pictures.photo_2		AS "photo_2"
		, pictures.photo_3		AS "photo_3"
		, pictures.photo_4		AS "photo_4"
		, pictures.photo_5		AS "photo_5"
		, contact_info.last_name		AS "last_name"
		, contact_info.city		AS "city"
		, about_info.screen_quote	AS "screen_quote"
		, about_info.about_yourself	AS "about_yourself"
		, about_info.questionable	AS "questionable"
		, login_info.creation_date	AS "creation_date"
		, login_info.last_login		AS "last_login"
	FROM login_info
		, pictures
		, contact_info
		, about_info
	WHERE login_info.user_name LIKE ''' + @UserName + '''
		AND login_info.email LIKE ''' + @Email + '''
		AND login_info.user_name = pictures.user_name
		AND login_info.user_name = contact_info.user_name
		AND login_info.user_name = about_info.user_name
	ORDER BY ' + @OrderBy + @AscDesc
) -- end EXEC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO




CREATE PROCEDURE [admin_GetDanglingUserNames]

 AS
CREATE TABLE #DanglingUserNames( user_name VARCHAR(32) COLLATE database_default NOT NULL )
CREATE TABLE #IndividualUserNames( user_name VARCHAR(32) COLLATE database_default NOT NULL )

---------------- login_info ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from login_info 
	where user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from relationship)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- contact_info ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from contact_info 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from relationship)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- personal_info ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from personal_info 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from relationship)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- about_info ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from about_info 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from relationship)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- relationship ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from relationship 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
select user_name from #IndividualUserNames 
	where user_name not in (select user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- pictures ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from pictures 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from relationship)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

---------------- sent_from ----------------------------------------------
INSERT #IndividualUserNames
	select sent_from from mail 
		where sent_from not in (select user_name from login_info)
		or sent_from not in (select user_name from contact_info)
		or sent_from not in (select user_name from personal_info)
		or sent_from not in (select user_name from about_info)
		or sent_from not in (select user_name from relationship)
		or sent_from not in (select user_name from pictures)
	group by sent_from

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- sent_to ----------------------------------------------
INSERT #IndividualUserNames
	select sent_to from mail 
		where sent_to not in (select user_name from login_info)
		or sent_to not in (select user_name from contact_info)
		or sent_to not in (select user_name from personal_info)
		or sent_to not in (select user_name from about_info)
		or sent_to not in (select user_name from relationship)
		or sent_to not in (select user_name from pictures)
	group by sent_to

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)


-- Return the number of dangling user_names...
SELECT count(*) AS 'count'
FROM #DanglingUserNames

-- Return the actual dangling user_names...
SELECT user_name FROM #DanglingUserNames
ORDER BY user_name

-- Drop both the tempory tables
drop table #IndividualUserNames
drop table #DanglingUserNames



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO




CREATE PROCEDURE [admin_GetIndividualTableInfoByUserName]
 @UserName varchar(32) = 'PersianConnections'

 AS

----------------------- login_info ---------------------------
print 'get text info from login_info table'
select	user_id
	, user_name
	, membership_type.membership_type_name as 'membership_type'
	, password
	, password_hint
	, email
	, sex.choice as 'sex'
	, creation_date
	, last_login
	, photo_submitted
from login_info
	, sex
	, membership_type
where user_name = @UserName
	and login_info.sex = sex.value
	and login_info.membership_type = membership_type.membership_type_id

----------------------- contact_info ---------------------------
print 'get text info from contact_info table'
select contact_info.user_name
		, contact_info.first_name
		, contact_info.last_name
		, contact_info.street_address
		, contact_info.city
		, state.choice as 'state'
		, country.choice as 'country'
		, contact_info.zip
		, contact_info.telephone
from contact_info
	, state
	, country
where user_name = @UserName
	and contact_info.state = state.value 
	and contact_info.country = country.value 

----------------------- personal_info ---------------------------
print 'get text info from personal_info table'
select personal_info.user_name 
		, sex_preference.choice as 'sex_preference'
	, personal_info.age as 'age'
	, marital_status.choice as 'marital_status'
	, profession.choice as 'profession'
	, education.choice as 'education'
	, religion.choice as 'religion'
	, height.choice as 'height'
		, weight.choice  as 'weight'
	, eyes.choice as 'eyes'
	, hair.choice as 'hair'
	, personal_info.min_age_desired
	, personal_info.max_age_desired
	, cook.choice as 'cook'
	, smoke.choice as 'smoke'
	, drink.choice as 'drink'
	, party.choice as 'party'
	, political.choice as 'political'
	, housing_status.choice as 'housing_status'

from personal_info
	, sex_preference
	, marital_status
	, profession
	, education
	, religion
	, height
	, weight
	, eyes
	, hair
	, cook
	, smoke
	, drink
	, party
	, political
	, housing_status
where personal_info.user_name = @UserName
	and personal_info.sex_preference = sex_preference.value
	and personal_info.marital_status = marital_status.value
	and personal_info.profession = profession.value
	and personal_info.education = education.value
	and personal_info.religion = religion.value
	and personal_info.height = height.value
	and personal_info.weight = weight.value
	and personal_info.eyes = eyes.value
	and personal_info.hair = hair.value
	and personal_info.cook = cook.value
	and personal_info.smoke = smoke.value
	and personal_info.drink = drink.value
	and personal_info.party = party.value
	and personal_info.political = political.value
	and personal_info.housing_status = housing_status.value

----------------------- about_info ---------------------------
print 'get info from about_info table'
select user_name
	, screen_quote
	, about_yourself
	, questionable
from about_info
where user_name = @UserName

----------------------- relationship ---------------------------
print 'get text info from relationship table'
select user_name
	,  prefer_not_to_say 
	, any_relationship
	, hang_out 
	, short_term 
	, long_term 
	, talk_email
	, photo_exchange
	, marriage
	, other
from relationship
where user_name = @UserName

----------------------- pictures ---------------------------
print 'get info from pictures table'
SELECT user_name
	, photo_1
	, photo_2
	, photo_3
	, photo_4
	, photo_5
FROM pictures 
where user_name = @UserName

----------------------- mail ---------------------------
print 'get info from mail table'
SELECT mail_id
	, sent_to
	, sent_from
	, subject
	, message_text
	, when_sent
	, when_read
	, sender_deleted
	, receiver_deleted
FROM mail 
where sent_to = @UserName 
	or sent_from = @UserName

----------------------- book_marks ---------------------------
print 'get info from book_marks table'
SELECT user_name
	, book_mark
FROM book_marks
WHERE user_name = @UserName

----------------------- billing_info ---------------------------
print 'get info from billing_info table'
SELECT user_name
	, credit_card_type.choice as 'card_type'
	, name_on_card
	, account_number
	, expiration_month
	, expiration_year
	, is_membership_active
	, date_membership_expires
	, bank_ABA_code
	, bank_account_number
FROM billing_info
	, credit_card_type 
where billing_info.user_name = @UserName 
	and billing_info.card_type = credit_card_type.value

----------------------- transactions_log ---------------------------
print 'get info from transactions_log table'
SELECT transaction_id
	, user_name
	, transaction_type
	, x_response_code
	, months_joined
	, amount
	, date_of_this_transaction
	, date_of_next_transaction
	, x_response_subcode
	, x_response_reason_code
	, x_response_reason_text
	, x_auth_code
	, x_avs_code
	, x_trans_id
	, x_md5_hash
	, x_description
	, batch_transaction_id
	, user_id
	, credit_card_type.choice as 'card_type'
	, name_on_card
	, account_number
	, expiration_month
	, expiration_year
	, x_method
	, bank_ABA_code
	, bank_account_number
FROM transactions_log
	, credit_card_type 
where transactions_log.user_name = @UserName 
	and transactions_log.card_type = credit_card_type.value

----------------------- membership_cancellation ---------------------------
print 'get info from membership_cancellation table'
SELECT unique_id
	, user_name
	, email
	, date_started_paying
	, date_cancelled
	, reason_for_leaving
	, membership_prices
	, website_design
	, suggestions
FROM membership_cancellation
where membership_cancellation.user_name = @UserName


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO



CREATE PROCEDURE [admin_GetMembershipCancellations]
@OrderBy VARCHAR(64)	= 'membership_cancellation.date_cancelled'
, @AscDesc CHAR(4)		= 'DESC'
, @Limit INT			= 100
, @Index CHAR(6)		= '1'
, @UserName VARCHAR(32)	= '%'

 AS

-- the SET string provides a slight performance gain for stored procedures
SET NOCOUNT ON

PRINT 'Order by ' + @OrderBy  + @AscDesc

-- If UserName != "%" the user entered data to search for 
IF (@UserName != "%")
BEGIN
	PRINT 'user entered a user_name'
	-- Pad with SQL wildcards for searching 
	SELECT @UserName = ( SELECT ( @UserName + '%') )
END

PRINT 'user_name = ' + @UserName

DECLARE @RowCount INT -- Used to set the rowcount based on index and limit
SELECT @RowCount = ( @Index + @Limit + 1 )

-- count the total number of rows in the login_info table...
EXEC ('SQL:  SELECT COUNT(*) as count
	FROM membership_cancellation
	WHERE membership_cancellation.user_name LIKE ''' + @UserName + '''
') -- end EXEC

SET ROWCOUNT @RowCount

PRINT 'SQL:  SELECT membership_cancellation.* 
	FROM membership_cancellation
	WHERE membership_cancellation.user_name LIKE ''' + @UserName + '''
	ORDER BY ' + @OrderBy + ' ' + @AscDesc

EXEC ('SQL:  SELECT membership_cancellation.* 
	FROM membership_cancellation
	WHERE membership_cancellation.user_name LIKE ''' + @UserName + '''
	ORDER BY ' + @OrderBy + ' ' + @AscDesc
) -- end EXEC


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE [admin_GraphHourlyCreationDateStatsByDayMonthYear]
@Day char(2) = '1'
 , @Month char(2) = ''
,  @Year char(4) = '2001'

 AS

-- Declare a variable to hold the month to get results from...
declare @SearchDay datetime

-- Set the current search date to the most recent creation_date 
-- if the procedure was called without parameters...
if(@Month = '')
	begin
		select @SearchDay = ( select max(creation_date) from login_info )
	end
ELSE
	begin
		select @SearchDay = @Month + '-' + @Day + '-' + @Year
	end

-- Print all month variables for debugging...
print 'SearchDay = '  + convert(char(25), @SearchDay , 113)

-- Create temporary table
-- to hold the stats...
CREATE TABLE #MembershipStats 
(
	loop_date		VARCHAR(2)	NOT NULL
	, new_members		INT		NOT NULL
	, validated_email	INT		NOT NULL
	, added_photos		INT		NOT NULL
	, joined_through_affiliate	INT		NOT NULL
	, paid_in_the_past	INT		NOT NULL
	, paying_now		INT		NOT NULL
)

-- Populate a temporary table with login_info data for only the search MONTH's data...
INSERT INTO #MembershipStats
SELECT DATEPART( HOUR, creation_date )		-- loop_date
	, COUNT(*) 					-- new_members
	, SUM 	(
			CASE
				WHEN is_email_verified = '1' THEN 1
				ELSE 0
			END
		)					-- validated_email
	, SUM(photo_submitted) 			-- added_photos
	, SUM 	(
			CASE
				WHEN affiliate_tracking_id != '' THEN 1
				ELSE 0
			END
		)					-- joined_through_affiliate
	, SUM 	(
			CASE
				WHEN date_started_paying IS NOT NULL THEN 1
				ELSE 0
			END
		)					-- paid_in_the_past
	, SUM 	(
			CASE
				WHEN login_info.membership_type > 0 THEN 1
				ELSE 0
			END
		)					-- paying_now
FROM login_info
WHERE DATEPART( DAY, 		creation_date ) = DATEPART(DAY, 	@SearchDay)
	AND DATEPART( MONTH,	creation_date ) = DATEPART(MONTH, 	@SearchDay)
	AND DATEPART( YEAR,	creation_date ) = DATEPART(YEAR, 	@SearchDay)
	AND DATEPART( HOUR,	creation_date ) < 24
	AND email NOT IN 	(
					'jatlast@hotmail.com'
					, 'jatlast@yahoo.com'
					, 'jatlast@excite.com'
					, 'jubin@pejman.net' 
					, 'jubin_pejman@hotmail.com' 
					, 'baumbach@optonline.net' 
					, 'baumbach@bellatlantic.net' 
					, 'connectionsadmin@earthlink.net'
					, 'info@BibleMatch.com'
					, 'info@GayLoveMatch.com'
					, 'info@JewishLoveMatch.com'
					, 'info@IsraeliConnections.com'
					, 'info@NetLoveMatch.com'
					, 'info@ManhattanConnections.com'
					, 'info@PersianConnections.com'
					, 'info@PersonalsConnections.com'
					, 'info@UkLoveMatch.com'
				)
GROUP BY DATEPART( HOUR, creation_date )

---------------------------------------------------------
-- Return the maximum number of days in the search month
-- So the DB takes care of figuring out leap year crap
---------------------------------------------------------
declare @TempSearchDay datetime
-- First: set the @Day variable to 1 and the rest equal to the current search date
-- and reset the current month search to those fields (last day of that month and year)...
select @Day = '1'
select @Month = datepart(month, @SearchDay)
select @Year = datepart(year, @SearchDay)
-- Declare a variable to represent the last day of the search month/day/year...
select @TempSearchDay = @Month + '-' + @Day + '-' + @Year
-- Second: Add a month so we are on the first of next month...
select @TempSearchDay = dateadd(month, 1, @TempSearchDay)
-- Third: Subtract a single day to return the last day of the search month...
select @TempSearchDay = dateadd(day, -1, @TempSearchDay)
-- Finally: Select the day...
select datepart( day, @TempSearchDay ) as 'days_in_month'
print 'SearchDay = ' + convert(char(10), @TempSearchDay, 101)
-----------------------------------------------------------------------


-- Return the search_month and search_year
select datepart(day, @SearchDay) as 'search_day'
	, datepart(month, @SearchDay) as 'search_month'
	, datepart(year, @SearchDay) as 'search_year'

SELECT loop_date
	, new_members
	, validated_email	
	, added_photos		
	, joined_through_affiliate
	, paid_in_the_past	
	, paying_now		
 FROM #MembershipStats
ORDER BY loop_date

-- Drop the temporary table
DROP TABLE #MembershipStats

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE [admin_GraphMonthlyCreationDateStatsByMonthYear]
@Day		CHAR(1) = '1'
, @Month	CHAR(3) = '1'
, @Year	CHAR(4) = '1999'

 AS

-- Declare a variable to hold the MONTH to get results FROM...
DECLARE @SearchMonth SMALLDATETIME

-- Set the current search date to the most recent creation_date 
-- if the procedure wAS called without parameters...
IF(@Year = '1999')
	BEGIN
		SELECT @SearchMonth = ( SELECT max(creation_date) FROM login_info )
	END
ELSE
	BEGIN
		SELECT @SearchMonth = @Month + '-' + @Day + '-' + @Year
	END

-- Declare a variable to represent the precious MONTH to limith the lower bound of the SELECTions...
DECLARE @PreviousMonth SMALLDATETIME
-- Subtract one MONTH FROM the search MONTH to initialize the PreviousMonth
SELECT @PreviousMonth = DATEADD(MONTH, -1, @SearchMonth)

-- Declare a variable to represent the next MONTH to limith the upper bound of the SELECTions...
DECLARE @NextMonth SMALLDATETIME
-- Add one MONTH to the search MONTH to initialize the NextMonth
SELECT @NextMonth = DATEADD(MONTH, 1, @SearchMonth)

-- PRINT all MONTH variables for debugging...
PRINT 'PreviousMonth	= ' + CONVERT(CHAR(10), @PreviousMonth	, 101)
PRINT 'SearchMonth	= ' + CONVERT(CHAR(10), @SearchMonth	, 101)
PRINT 'NextMonth	= ' + CONVERT(CHAR(10), @NextMonth	, 101)

-- Create temporary table
-- to hold the stats...
CREATE TABLE #MembershipStats 
(
	loop_date		SMALLDATETIME	NOT NULL
	, new_members		INT			NOT NULL
	, validated_email	INT			NOT NULL
	, added_photos		INT			NOT NULL
	, joined_through_affiliate	INT			NOT NULL
	, paid_in_the_past	INT			NOT NULL
	, paying_now		INT			NOT NULL
)

-- Populate a temporary table with login_info data for only the search MONTH's data...
INSERT INTO #MembershipStats
SELECT CONVERT(CHAR(10), login_info.creation_date, 101) -- loop_date
	, COUNT(*) 					-- new_members
	, SUM 	(
			CASE
				WHEN is_email_verified = '1' THEN 1
				ELSE 0
			END
		)					-- validated_email
	, SUM(photo_submitted) 			-- added_photos
	, SUM 	(
			CASE
				WHEN affiliate_tracking_id != '' THEN 1
				ELSE 0
			END
		)					-- joined_through_affiliate
	, SUM 	(
			CASE
				WHEN date_started_paying IS NOT NULL THEN 1
				ELSE 0
			END
		)					-- paid_in_the_past
	, SUM 	(
			CASE
				WHEN login_info.membership_type > 0 THEN 1
				ELSE 0
			END
		)					-- paying_now
FROM login_info
WHERE DATEPART(MONTH,  login_info.creation_date) = DATEPART(MONTH, @SearchMonth)
	AND DATEPART(YEAR,  login_info.creation_date) = DATEPART(YEAR, @SearchMonth)
	AND email NOT IN 	(
					'jatlast@hotmail.com'
					, 'jatlast@yahoo.com'
					, 'jatlast@excite.com'
					, 'jubin@pejman.net' 
					, 'jubin_pejman@hotmail.com' 
					, 'baumbach@optonline.net' 
					, 'baumbach@bellatlantic.net' 
					, 'connectionsadmin@earthlink.net'
					, 'info@BibleMatch.com'
					, 'info@GayLoveMatch.com'
					, 'info@JewishLoveMatch.com'
					, 'info@IsraeliConnections.com'
					, 'info@NetLoveMatch.com'
					, 'info@ManhattanConnections.com'
					, 'info@PersianConnections.com'
					, 'info@PersonalsConnections.com'
					, 'info@UkLoveMatch.com'
				)
GROUP BY CONVERT(CHAR(10), login_info.creation_date, 101)

---------------------------------------------------------
-- Return the maximum number of days in the search MONTH
-- So the DB takes care of figuring out leap YEAR crap
---------------------------------------------------------
-- First: set the @Day variable to 1 AND the rest equal to the current search date
-- AND reset the current MONTH search to those fields (last day of that MONTH AND YEAR)...
SELECT @Day = '1'
SELECT @Month = DATEPART(MONTH, @SearchMonth)
SELECT @Year = DATEPART(YEAR, @SearchMonth)
-- Declare a variable to represent the lASt day of the search MONTH/day/YEAR...
SELECT @SearchMonth = @Month + '-' + @Day + '-' + @Year
-- Second: Add a MONTH so we are on the first of next MONTH...
SELECT @SearchMonth = DATEADD(MONTH, 1, @SearchMonth)
-- Third: Subtract a single day to return the lASt day of the search MONTH...
SELECT @SearchMonth = DATEADD(day, -1, @SearchMonth)
-- Finally: SELECT the day...
SELECT DATEPART( day, @SearchMonth ) AS 'days_in_month'
PRINT 'SearchMonth = ' 	+ CONVERT(CHAR(10), @SearchMonth, 101)
-----------------------------------------------------------------------

-- Return the search_MONTH AND search_YEAR
SELECT DATEPART(MONTH, @SearchMonth) AS 'search_month'
	, DATEPART(YEAR, @SearchMonth) AS 'search_year'

-- Return the Weekday name AND number AS well AS the number of new members for that day...
SELECT datename(weekday, loop_date) AS 'week_day'
	, DATEPART(day, loop_date) AS 'day_number'
	, new_members
	, validated_email	
	, added_photos		
	, joined_through_affiliate
	, paid_in_the_past	
	, paying_now		
 FROM #MembershipStats
ORDER BY loop_date

-- Drop the temporary table
DROP TABLE #MembershipStats

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE [admin_GraphMonthlyCreationDateStatsByYear]
@Year char(4) = ''

 AS

-- Declare a variable to hold the month to get results from...
declare @SearchYear datetime

-- Set the current search date to the most recent creation_date 
-- if the procedure was called without parameters...
if(@Year = '')
	begin
		select @SearchYear = ( select max(creation_date) from login_info )
	end
ELSE
	begin
		select @SearchYear = '1-1-' + @Year
	end

-- Declare a variable to represent the precious month to limith the lower bound of the selections...
-- Print all month variables for debugging...
print 'SearchYear = ' + convert(char(10), datepart(year, @SearchYear), 101)

-- Create temporary table
-- to hold the stats...
CREATE TABLE #MembershipStats 
(
	loop_date			VARCHAR(2)	NOT NULL
	, new_members		INT		NOT NULL
	, validated_email	INT		NOT NULL
	, added_photos		INT		NOT NULL
	, joined_through_affiliate	INT		NOT NULL
	, paid_in_the_past	INT		NOT NULL
	, paying_now		INT		NOT NULL
)

-- Populate a temporary table with login_info data for only the search MONTH's data...
INSERT INTO #MembershipStats
SELECT DATEPART( MONTH, creation_date )	-- loop_date
	, COUNT(*) 					-- new_members
	, SUM 	(
			CASE
				WHEN is_email_verified = '1' THEN 1
				ELSE 0
			END
		)					-- validated_email
	, SUM(photo_submitted) 			-- added_photos
	, SUM 	(
			CASE
				WHEN affiliate_tracking_id != '' THEN 1
				ELSE 0
			END
		)					-- joined_through_affiliate
	, SUM 	(
			CASE
				WHEN date_started_paying IS NOT NULL THEN 1
				ELSE 0
			END
		)					-- paid_in_the_past
	, SUM 	(
			CASE
				WHEN login_info.membership_type > 0 THEN 1
				ELSE 0
			END
		)					-- paying_now
FROM login_info
WHERE DATEPART( YEAR, creation_date ) = DATEPART( YEAR, @SearchYear )
AND email NOT IN 	(
				'jatlast@hotmail.com'
				, 'jatlast@yahoo.com'
				, 'jatlast@excite.com'
				, 'jubin@pejman.net' 
				, 'jubin_pejman@hotmail.com' 
				, 'baumbach@optonline.net' 
				, 'baumbach@bellatlantic.net' 
				, 'connectionsadmin@earthlink.net'
				, 'info@BibleMatch.com'
				, 'info@GayLoveMatch.com'
				, 'info@JewishLoveMatch.com'
				, 'info@IsraeliConnections.com'
				, 'info@NetLoveMatch.com'
				, 'info@ManhattanConnections.com'
				, 'info@PersianConnections.com'
				, 'info@PersonalsConnections.com'
				, 'info@UkLoveMatch.com'
			)
GROUP BY DATEPART( MONTH, creation_date )

-- Return the search_month and search_year
select datepart(year, @SearchYear) as 'search_year'

SELECT loop_date
	, new_members
	, validated_email	
	, added_photos		
	, joined_through_affiliate
	, paid_in_the_past	
	, paying_now		
 FROM #MembershipStats
ORDER BY loop_date

-- Drop the temporary table
DROP TABLE #MembershipStats

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE [admin_GraphYearlyCreationDateStats]
 AS

-- Create temporary table
-- to hold the stats...
CREATE TABLE #MembershipStats 
(
	loop_date		CHAR(4)	NOT NULL
	, new_members		INT		NOT NULL
	, validated_email	INT		NOT NULL
	, added_photos		INT		NOT NULL
	, joined_through_affiliate	INT		NOT NULL
	, paid_in_the_past	INT		NOT NULL
	, paying_now		INT		NOT NULL
)

-- Populate a temporary table with login_info data for only the search MONTH's data...
INSERT INTO #MembershipStats
SELECT DATEPART( YEAR, creation_date )		-- loop_date
	, COUNT(*) 					-- new_members
	, SUM 	(
			CASE
				WHEN is_email_verified = '1' THEN 1
				ELSE 0
			END
		)					-- validated_email
	, SUM(photo_submitted) 			-- added_photos
	, SUM 	(
			CASE
				WHEN affiliate_tracking_id != '' THEN 1
				ELSE 0
			END
		)					-- joined_through_affiliate
	, SUM 	(
			CASE
				WHEN date_started_paying IS NOT NULL THEN 1
				ELSE 0
			END
		)					-- paid_in_the_past
	, SUM 	(
			CASE
				WHEN login_info.membership_type > 0 THEN 1
				ELSE 0
			END
		)					-- paying_now
FROM login_info
WHERE email NOT IN 	(
				'jatlast@hotmail.com'
				, 'jatlast@yahoo.com'
				, 'jatlast@excite.com'
				, 'jubin@pejman.net' 
				, 'jubin_pejman@hotmail.com' 
				, 'baumbach@optonline.net' 
				, 'baumbach@bellatlantic.net' 
				, 'connectionsadmin@earthlink.net'
				, 'info@BibleMatch.com'
				, 'info@GayLoveMatch.com'
				, 'info@JewishLoveMatch.com'
				, 'info@IsraeliConnections.com'
				, 'info@NetLoveMatch.com'
				, 'info@ManhattanConnections.com'
				, 'info@PersianConnections.com'
				, 'info@PersonalsConnections.com'
				, 'info@UkLoveMatch.com'
			)
GROUP BY DATEPART( YEAR, creation_date )

-- Return the Weekday name AND number AS well AS the number of new members for that day...
SELECT loop_date
	, new_members
	, validated_email	
	, added_photos		
	, joined_through_affiliate
	, paid_in_the_past	
	, paying_now		
 FROM #MembershipStats
ORDER BY loop_date


-- Drop the temporary table
DROP TABLE #MembershipStats

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE [admin_TransactionsLogAudit]
@OrderBy 		CHAR(64)		= 'transactions_log.date_of_this_transaction'
, @AscDesc 		CHAR(4)		= 'DESC'
, @Limit 		INT			= 10
, @Index 		CHAR(6)		= '1'
, @UserName 		VARCHAR(32)		= '%'
, @FromDate 		SMALLDATETIME	= '1/1/1999'
, @ToDate 		SMALLDATETIME	= '1/1/2040'
, @XResponseCode 	VARCHAR(2)		= '1'
, @TransactionType 	VARCHAR(18)		= '%'

 AS

-- the SET string provides a slight performance gain for stored procedures
SET NOCOUNT ON

PRINT 'Order by ' + @OrderBy  + @AscDesc

-- If @FromDate = '' default to old date
IF (@FromDate = '')
BEGIN
	-- use SQL wildcard when searching 
	SELECT @FromDate = '1/1/1999'
END
-- If @ToDate = '' default to future date
IF (@ToDate = '')
BEGIN
	-- use SQL wildcard when searching 
	SELECT @ToDate = '1/1/2040'
END

-- If XResponseCode = '' default to wildcard
IF (@XResponseCode = '')
BEGIN
	-- use SQL wildcard when searching 
	SELECT @XResponseCode = '%'
END
-- If @TransactionType = '' default to wildcard
IF (@TransactionType = '')
BEGIN
	-- use SQL wildcard when searching 
	SELECT @TransactionType = '%'
END

-- If UserName != "%" the user entered data to search for 
IF (@UserName != '%')
BEGIN
	PRINT 'user entered a user_name'
	-- Pad with SQL wildcards for searching 
	SELECT @UserName = ( SELECT ( @UserName + '%') )
END

PRINT 'user_name = ' + @UserName

DECLARE @RowCount INT -- Used to set the rowcount based on index and limit
SELECT @RowCount = ( @Index + @Limit + 1 )

-- count the total number of rows in the login_info table...

print 'SELECT transactions_log.*
			, login_info.password
	FROM transactions_log
		, login_info
	WHERE transactions_log.user_name LIKE ''' + @UserName + '''
		AND transactions_log.date_of_this_transaction >= ''' + CONVERT(VARCHAR(10), @FromDate, 101)  + '''
		AND transactions_log.date_of_this_transaction <= ''' + CONVERT(VARCHAR(10), @ToDate, 101)  + '''
		AND transactions_log.x_response_code LIKE ''' + @XResponseCode + '''
		AND transactions_log.transaction_type LIKE ''' + @TransactionType + '''
		AND transactions_log.user_name = login_info.user_name
	ORDER BY ' + @OrderBy + @AscDesc

EXEC ( 'SQL:  SELECT COUNT(*) AS count_total
		, sum(amount) AS amount_total
	FROM transactions_log
	WHERE transactions_log.user_name LIKE ''' + @UserName + '''
		AND transactions_log.date_of_this_transaction >= ''' + @FromDate + '''
		AND transactions_log.date_of_this_transaction <= ''' + @ToDate + '''
		AND transactions_log.x_response_code LIKE ''' + @XResponseCode + '''
		AND transactions_log.transaction_type LIKE ''' + @TransactionType + '''
') -- end EXEC

SET ROWCOUNT @RowCount

EXEC ( 'SQL:  SELECT billing_info.is_membership_active
			, transactions_log.*
			, login_info.password
--			, country.choice as country
			, sex.choice as sex
	FROM billing_info
		, transactions_log
		, login_info
		, contact_info
		, country
		, sex
	WHERE transactions_log.user_name LIKE ''' + @UserName + '''
		AND transactions_log.date_of_this_transaction >= ''' + @FromDate + '''
		AND transactions_log.date_of_this_transaction <= ''' + @ToDate + '''
		AND transactions_log.x_response_code LIKE ''' + @XResponseCode + '''
		AND transactions_log.transaction_type LIKE ''' + @TransactionType + '''
		AND transactions_log.user_name = login_info.user_name
		AND billing_info.user_name = login_info.user_name
		AND login_info.user_name = contact_info.user_name
		AND contact_info.country = country.value
		AND login_info.sex = sex.value
	ORDER BY ' + @OrderBy + @AscDesc
) -- end EXEC
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE [advancedSearch]
@Search INT
, @IAm CHAR
, @Seeking CHAR
, @MaritalStatus VARCHAR(2)
, @City VARCHAR(32)
, @State VARCHAR(2)
, @Country VARCHAR(3)
, @Profession VARCHAR(2)
, @Income VARCHAR(2)
, @Education VARCHAR(2)
, @Religion VARCHAR(2)
, @MinAgeDesired VARCHAR(2)
, @MaxAgeDesired VARCHAR(2)
, @MinHeight VARCHAR(2)
, @MaxHeight VARCHAR(2)
, @MinWeight VARCHAR(2)
, @MaxWeight VARCHAR(2)
, @Eyes VARCHAR(2)
, @Hair VARCHAR(2)
, @Cook VARCHAR(2)
, @Smoke VARCHAR(2)
, @Drink VARCHAR(2)
, @Party VARCHAR(2)
, @Political VARCHAR(2)
, @HousingStatus VARCHAR(2)
, @Relationship VARCHAR(2)
, @TextSearch VARCHAR(64)
, @WhichFields VARCHAR(2)
, @Limit INT
, @Sort VARCHAR(16)
, @Index VARCHAR(6)
, @UserName VARCHAR(32)

 AS

-- START Verify Permissions
DECLARE @@ReturnValue char(4)

EXEC @@ReturnValue = verifyMembershipTypePermissions  @UserName, 'allow_search_advanced'
-- Check membership_type for permission
if ( @@ReturnValue != 1	)
	BEGIN--  DENIED
		print 'You must upgrade your membership to use this feature'
		return @@ReturnValue
	END
-- END Verify Permissions

-- Keep track of table usage...
DECLARE @DatabaseName VARCHAR(32)
SELECT @DatabaseName = DB_NAME()

-- used to hold table_access_log unique_id
DECLARE @@CurrentSearchUniqueId	INT

--IF(@UserName = '')
--	BEGIN
		EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName		-- database_name                         
								, 'AdvancedSearchQuery'	-- page_name                             
								, NULL				-- user_name                             
								, @IAm				-- sex                                   
								, @Seeking			-- used to determine sex_preference      
								, @City				-- city                                  
								, @State			-- state                                 
								, @Country			-- country                               
								, @Profession 			-- profession
								, @Income			-- income
								, @Education 			-- educaiton
								, @Religion 			-- religion
								, @MinAgeDesired		-- min_age_desired                       
								, @MaxAgeDesired		-- max_age_desired                       
--	END
--ELSE
--	BEGIN
--		EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'AdvancedSearch', @UserName
--	END
-- retrieve current unique_id from table_access_log...
SELECT @@CurrentSearchUniqueId = @@identity


-- the SET string provides a slight performance gain for stored procedures
SET NOCOUNT ON

declare @GlobalRowCount INT
SELECT @GlobalRowCount = 100;

declare @AlternativeMin INT
declare @AlternativeMax INT

-- hold the relationship types
declare @prefer_not_to_say CHAR
declare @any_relationship CHAR
declare @hang_out CHAR
declare @short_term CHAR
declare @long_term CHAR
declare @talk_email CHAR
declare @photo_exchange CHAR
declare @marriage CHAR
declare @other CHAR

-- set all relationship types to a non existant value
SELECT @prefer_not_to_say = 9
SELECT @any_relationship = 9
SELECT @hang_out = 9
SELECT @short_term = 9
SELECT @long_term = 9
SELECT @talk_email = 9
SELECT @photo_exchange = 9
SELECT @marriage = 9
SELECT @other = 9


IF (@IAm = @Seeking AND @IAm > "0")
BEGIN
	-- If the user is searching same sex set Alternative to true 
	PRINT 'same sex search'
	SELECT @AlternativeMin = 2
	SELECT @AlternativeMax = 4
END
else
BEGIN
	-- If the user is searching opposite sex OR all set Alternative to false 
	PRINT 'opposite sex search'
	SELECT @AlternativeMin = 0
	SELECT @AlternativeMax = 1
END

-- If MaritalStatus = 0 user is searching all types of status 
IF (@MaritalStatus = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @MaritalStatus = '%'
END

	-- If City != "" the user entered data to search for 
IF (@City != "")
BEGIN
	-- Pad with SQL wildcards for searching 
	SELECT @City = ( SELECT ('%' + @City + '%') )
END
	-- If City = "" the user did not narrow the search by city 
IF (@City = "")
BEGIN
	-- add an SQL wildcard for searching 
	SELECT @City = '%'
END
	-- If State = 0 the user did not narrow the search by state 
IF (@State = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @State = '%'
END

	-- If Country = 0 the user did not narrow the search by country 
IF (@Country = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Country = '%'
END

-- If Profession = 0 the user did not narrow the search by profession 
IF (@Profession = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Profession = '%'
END

-- If Income = 0 the user did not narrow the search by income 
IF (@Income = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Income = '0'
END

-- If Education = 0 the user did not narrow the search by education 
IF (@Education = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Education = '%'
END

-- If Religion = 0 the user did not narrow the search by religion 
IF (@Religion = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Religion = '%'
END

-- If Eyes = 0 the user did not narrow the search by eye color 
IF (@Eyes = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Eyes = '%'
END

-- If Hair = 0 the user did not narrow the search by hair color 
IF (@Hair = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Hair = '%'
END

-- If Cook = 0 the user did not narrow the search by cooking abilities 
IF (@Cook = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Cook = '%'
END

-- If Smoke = 0 the user did not narrow the search by smoking habits 
IF (@Smoke = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Smoke = '%'
END

-- If Drink = 0 the user did not narrow the search by Drinking habits 
IF (@Drink = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Drink = '%'
END

-- If Party = 0 the user did not narrow the search by the amount of partying 
IF (@Party = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Party = '%'
END

-- If Political = 0 the user did not narrow the search by political affiliation 
IF (@Political = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @Political = '%'
END

-- If HousingStatus = 0 the user did not narrow the search by housing status 
IF (@HousingStatus = "0")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @HousingStatus = '%'
END


--------------- Initialize the proper relationship types

IF (@Relationship = "1")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @prefer_not_to_say = 1

END

IF (@Relationship = "2")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @hang_out = 1

END

IF (@Relationship = "3")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @short_term = 1

END

IF (@Relationship = "4")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @long_term = 1

END

IF (@Relationship = "5")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @talk_email = 1

END

IF (@Relationship = "6")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @photo_exchange = 1

END

IF (@Relationship = "7")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @marriage = 1

END

IF (@Relationship = "8")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @other = 1

END
------------------------------------------------

-- If TextSearch != "" the user entered a text string to search for 
IF (@TextSearch != "")
BEGIN
	-- Pad with SQL wildcard for searching 
	SELECT @TextSearch = ( SELECT ('%' + @TextSearch + '%') )
END

-- If TextSearch = "" the euser did not enter a text string to search for 
IF (@TextSearch = "")
BEGIN
	-- Add an SQL wildcard for searching 
	SELECT @TextSearch = '%' 
END

-- Determin how the user whats the results ordered...
DECLARE @OrderBy CHAR(32) 	-- Holds the order by clause condition
IF( @Sort = 'user_name' )
	BEGIN
		SELECT @OrderBy = 'contact_info.user_name'
	END
ELSE
	IF( @Sort = 'state' )
		BEGIN
			SELECT @OrderBy = 'contact_info.state'
		END
	ELSE
		IF( @Sort = 'age' )
		BEGIN
			SELECT @OrderBy = 'personal_info.age'
		END
		ELSE
			IF( @Sort = 'creation_date' )
			BEGIN
				SELECT @OrderBy = 'login_info.creation_date DESC'
			END

PRINT 'Order by ' + @OrderBy

DECLARE @RowCount	INT -- Used to set the rowcount based on index and limit
SELECT @RowCount = ( @Index + @Limit + 2 )

-- the SET ROWCOUNT limits the number of rows affected
SET ROWCOUNT @GlobalRowCount


-- If WhichFields = 1 AND TextSearch != '%' the user is looking for a user_name
IF (@WhichFields = "1" AND @TextSearch != '%')
BEGIN
		PRINT 'Find a single user_name'
-- Start DO NOT limit search by relationship type
IF (@Relationship = 0)
BEGIN
	PRINT 'Any Relationship count'
	-- Select the raw information by joining just the personal_info and relationship tables... 
		SELECT CASE 
				WHEN COUNT(*) >= @GlobalRowCount THEN @GlobalRowCount
				ELSE COUNT(*)
			END 'Number of Rows 1'
			, @@CurrentSearchUniqueId AS 'search_unique_id'
		FROM login_info 
			, contact_info
			, personal_info
			, about_info
		WHERE login_info.user_name LIKE @TextSearch
		AND about_info.questionable = 0
		AND login_info.photo_submitted >= @Search
		AND login_info.sex LIKE @Seeking
		AND CONVERT (INT, personal_info.sex_preference) >= @AlternativeMin
		AND CONVERT (INT, personal_info.sex_preference) <= @AlternativeMax

		AND personal_info.marital_status LIKE @MaritalStatus
		AND contact_info.city LIKE @City
		AND contact_info.state LIKE @State
		AND contact_info.country LIKE @Country
		AND personal_info.profession LIKE @Profession
		AND CONVERT (INT, personal_info.income) >= @Income
		AND personal_info.education LIKE @Education
		AND personal_info.religion LIKE @Religion

		AND CONVERT (INT, personal_info.age) >= @MinAgeDesired
		AND CONVERT (INT, personal_info.age) <= @MaxAgeDesired

		AND CONVERT (INT, personal_info.height) >= @MinHeight
		AND CONVERT (INT, personal_info.height) <= @MaxHeight
		AND CONVERT (INT, personal_info.weight) >= @MinWeight
		AND CONVERT (INT, personal_info.weight) <= @MaxWeight

		AND personal_info.eyes LIKE @Eyes
		AND personal_info.hair LIKE @Hair
		AND personal_info.cook LIKE @Cook
		AND personal_info.smoke LIKE @Smoke
		AND personal_info.drink LIKE @Drink
		AND personal_info.party LIKE @Party
		AND personal_info.political LIKE @Political		
		AND personal_info.housing_status LIKE @HousingStatus

		AND login_info.user_name = contact_info.user_name
		AND login_info.user_name = personal_info.user_name
		AND login_info.user_name = about_info.user_name

		PRINT 'Any Relationship Sort by ' + @OrderBy
		
SET ROWCOUNT @RowCount
		-- Select the raw information by joining just the personal_info and relationship tables... 
		EXEC ('SELECT login_info.user_name AS "user_name"
			, contact_info.city AS "city"
			, state.choice AS "state"
			, country.choice AS "country"
			, personal_info.age AS "age"
			, about_info.screen_quote AS "screen_quote"
			, about_info.about_yourself AS "about_yourself"
			, pictures.photo_1 AS "pic 1"

		FROM login_info
			, contact_info
			, personal_info
			, about_info
			, state
			, country
			, pictures
		WHERE login_info.user_name LIKE ''' + @TextSearch + '''
			AND login_info.photo_submitted >= ''' + @Search + '''
			AND login_info.user_name = contact_info.user_name
			AND login_info.user_name = personal_info.user_name
			AND login_info.user_name = about_info.user_name
			AND login_info.user_name = pictures.user_name
			AND contact_info.state = state.value
			AND contact_info.country = country.value
			AND personal_info.user_name IN 
			(
			SELECT login_info.user_name
				FROM login_info
					, contact_info
					, personal_info
					, about_info
				WHERE login_info.sex LIKE ''' + @Seeking + '''
				AND about_info.questionable = 0
				AND CONVERT (INT, personal_info.sex_preference) >= ''' + @AlternativeMin + '''
				AND CONVERT (INT, personal_info.sex_preference) <= ''' + @AlternativeMax + '''
	
				AND personal_info.marital_status LIKE ''' + @MaritalStatus + '''
				AND contact_info.city LIKE ''' + @City + '''
				AND contact_info.state LIKE ''' + @State + '''
				AND contact_info.country LIKE ''' + @Country + '''
				AND personal_info.profession LIKE ''' + @Profession + '''
				AND CONVERT (INT, personal_info.income) >= ''' + @Income + '''
				AND personal_info.education LIKE ''' + @Education + '''
				AND personal_info.religion LIKE ''' + @Religion + '''
		
				AND CONVERT (INT, personal_info.age) >= ''' + @MinAgeDesired + '''
				AND CONVERT (INT, personal_info.age) <= ''' + @MaxAgeDesired + '''
		
				AND CONVERT (INT, personal_info.height) >= ''' + @MinHeight + '''
				AND CONVERT (INT, personal_info.height) <= ''' + @MaxHeight + '''
				AND CONVERT (INT, personal_info.weight) >= ''' + @MinWeight + '''
				AND CONVERT (INT, personal_info.weight) <= ''' + @MaxWeight + '''

	
				AND personal_info.eyes LIKE ''' + @Eyes + '''
				AND personal_info.hair LIKE ''' + @Hair + '''
				AND personal_info.cook LIKE ''' + @Cook + '''
				AND personal_info.smoke LIKE ''' + @Smoke + '''
				AND personal_info.drink LIKE ''' + @Drink + '''
				AND personal_info.party LIKE ''' + @Party + '''
				AND personal_info.political LIKE ''' + @Political + '''
				AND personal_info.housing_status LIKE ''' + @HousingStatus + '''
		
				AND login_info.user_name = contact_info.user_name
				AND login_info.user_name = personal_info.user_name
				AND login_info.user_name = about_info.user_name
			)
	ORDER BY ' + @OrderBy
	) -- end EXEC
SET ROWCOUNT 0
		RETURN 1
END -- Relationship = 0 "Any"


-- Start Limit search by relationship type
IF (@Relationship != 0)
BEGIN
PRINT 'Limit Relationship Count'
-- Select the raw information by joining just the personal_info and relationship tables... 

SELECT CASE 
		WHEN COUNT(*) >= @GlobalRowCount THEN @GlobalRowCount
		ELSE COUNT(*)
	END 'Number of Rows 2'
	, @@CurrentSearchUniqueId AS 'search_unique_id'
	FROM relationship 
	WHERE relationship.user_name LIKE @TextSearch
		AND
		(
		relationship.prefer_not_to_say = @prefer_not_to_say	
		OR relationship.hang_out = @hang_out
		OR relationship.short_term = @short_term		
		OR relationship.long_term = @long_term				
		OR relationship.talk_email = @talk_email		
		OR relationship.photo_exchange = @photo_exchange		
		OR relationship.marriage = @marriage				
		OR relationship.other = @other
		)
		AND relationship.user_name IN 
		(
		SELECT login_info.user_name
			FROM login_info
				, contact_info
				, personal_info
				, about_info
			WHERE login_info.sex LIKE @Seeking
			AND about_info.questionable = 0
			AND login_info.photo_submitted >= @Search
			AND CONVERT (INT, personal_info.sex_preference) >= @AlternativeMin
			AND CONVERT (INT, personal_info.sex_preference) <= @AlternativeMax
			AND personal_info.marital_status LIKE @MaritalStatus
			AND contact_info.city LIKE @City
			AND contact_info.state LIKE @State
			AND contact_info.country LIKE @Country
			AND personal_info.profession LIKE @Profession
			AND CONVERT (INT, personal_info.income) >= @Income
			AND personal_info.education LIKE @Education
			AND personal_info.religion LIKE @Religion
			AND CONVERT (INT, personal_info.age) >= @MinAgeDesired
			AND CONVERT (INT, personal_info.age) <= @MaxAgeDesired

			AND CONVERT (INT, personal_info.height) >= @MinHeight
			AND CONVERT (INT, personal_info.height) <= @MaxHeight
			AND CONVERT (INT, personal_info.weight) >= @MinWeight
			AND CONVERT (INT, personal_info.weight) <= @MaxWeight
			AND personal_info.eyes LIKE @Eyes
			AND personal_info.hair LIKE @Hair
			AND personal_info.cook LIKE @Cook
			AND personal_info.smoke LIKE @Smoke
			AND personal_info.drink LIKE @Drink
			AND personal_info.party LIKE @Party
			AND personal_info.political LIKE @Political
			AND personal_info.housing_status LIKE @HousingStatus
			AND login_info.user_name = contact_info.user_name
			AND login_info.user_name = personal_info.user_name
			AND login_info.user_name = about_info.user_name
			)

		PRINT 'Limit Relationship Sort by ' + @OrderBy

SET ROWCOUNT @RowCount
		-- Select the raw information by joining just the personal_info and relationship tables... 
		EXEC ('SELECT login_info.user_name AS "user_name"
			, contact_info.city AS "city"
			, state.choice AS "state"
			, country.choice AS "country"
			, personal_info.age AS "age"
			, about_info.screen_quote AS "screen_quote"
			, about_info.about_yourself AS "about_yourself"
			, pictures.photo_1 AS "pic 1"

		FROM login_info
			, contact_info
			, personal_info
			, about_info
			, state
			, country
			, pictures
		WHERE login_info.user_name LIKE ''' + @TextSearch + '''
			AND login_info.photo_submitted >= ''' + @Search + '''
			AND login_info.user_name = contact_info.user_name
			AND login_info.user_name = personal_info.user_name
			AND login_info.user_name = about_info.user_name
			AND login_info.user_name = pictures.user_name
			AND contact_info.state = state.value
			AND contact_info.country = country.value
			AND personal_info.user_name IN 
			(
			SELECT relationship.user_name
				FROM relationship 
			WHERE (
				relationship.prefer_not_to_say = ''' + @prefer_not_to_say + '''
				OR relationship.hang_out = ''' + @hang_out + '''
				OR relationship.short_term = ''' + @short_term + '''
				OR relationship.long_term = ''' + @long_term + '''
				OR relationship.talk_email = ''' + @talk_email + '''
				OR relationship.photo_exchange = ''' + @photo_exchange + '''
				OR relationship.marriage = ''' + @marriage + '''
				OR relationship.other = ''' + @other + '''
				)

			AND relationship.user_name IN 
					(
					SELECT login_info.user_name
						FROM login_info
							, contact_info
							, personal_info
							, about_info
						WHERE login_info.sex LIKE ''' + @Seeking + '''
						AND about_info.questionable = 0
						AND CONVERT (INT, personal_info.sex_preference) >= ''' + @AlternativeMin + '''
						AND CONVERT (INT, personal_info.sex_preference) <= ''' + @AlternativeMax + '''
						AND personal_info.marital_status LIKE ''' + @MaritalStatus + '''
						AND contact_info.city LIKE ''' + @City + '''
						AND contact_info.state LIKE ''' + @State + '''
						AND contact_info.country LIKE ''' + @Country + '''
						AND personal_info.profession LIKE ''' + @Profession + '''
						AND CONVERT (INT, personal_info.income) >= ''' + @Income + '''
						AND personal_info.education LIKE ''' + @Education + '''

						AND personal_info.religion LIKE ''' + @Religion + '''
						AND CONVERT (INT, personal_info.age) >= ''' + @MinAgeDesired + '''
						AND CONVERT (INT, personal_info.age) <= ''' + @MaxAgeDesired + '''
				
						AND CONVERT (INT, personal_info.height) >= ''' + @MinHeight + '''
						AND CONVERT (INT, personal_info.height) <= ''' + @MaxHeight + '''
						AND CONVERT (INT, personal_info.weight) >= ''' + @MinWeight + '''
						AND CONVERT (INT, personal_info.weight) <= ''' + @MaxWeight + '''
						AND personal_info.eyes LIKE ''' + @Eyes + '''
						AND personal_info.hair LIKE ''' + @Hair + '''
						AND personal_info.cook LIKE ''' + @Cook + '''
						AND personal_info.smoke LIKE ''' + @Smoke + '''
						AND personal_info.drink LIKE ''' + @Drink + '''
						AND personal_info.party LIKE ''' + @Party + '''
						AND personal_info.political LIKE ''' + @Political + '''
						AND personal_info.housing_status LIKE ''' + @HousingStatus + '''
						AND login_info.user_name = contact_info.user_name
						AND login_info.user_name = personal_info.user_name
						AND login_info.user_name = about_info.user_name
				)
			)
	ORDER BY ' + @OrderBy
	) -- end EXEC
SET ROWCOUNT 0
		RETURN 1
END -- Limit search by relationship type @Relationship != 0

END -- END find user_name

ELSE --------------------------- ALL OTHER SEARCHES ---------------------------------------------


BEGIN --------------------------- ALL OTHER SEARCHES ---------------------------------------------
-- Start DO NOT limit search by relationship type
IF (@Relationship = 0)
BEGIN
	PRINT 'Any Relationship count'
	-- Select the raw information by joining just the personal_info and relationship tables... 
SELECT CASE 
		WHEN COUNT(*) >= @GlobalRowCount THEN @GlobalRowCount
		ELSE COUNT(*)
	END 'Number of Rows 3'
	, @@CurrentSearchUniqueId AS 'search_unique_id'
		FROM login_info 
			, contact_info
			, personal_info
			, about_info
		WHERE login_info.sex LIKE @Seeking
		AND about_info.questionable = 0
		AND login_info.photo_submitted >= @Search
		AND CONVERT (INT, personal_info.sex_preference) >= @AlternativeMin
		AND CONVERT (INT, personal_info.sex_preference) <= @AlternativeMax

		AND personal_info.marital_status LIKE @MaritalStatus
		AND contact_info.city LIKE @City
		AND contact_info.state LIKE @State
		AND contact_info.country LIKE @Country
		AND personal_info.profession LIKE @Profession
		AND CONVERT (INT, personal_info.income) >= @Income
		AND personal_info.education LIKE @Education
		AND personal_info.religion LIKE @Religion

		AND CONVERT (INT, personal_info.age) >= @MinAgeDesired
		AND CONVERT (INT, personal_info.age) <= @MaxAgeDesired

		AND CONVERT (INT, personal_info.height) >= @MinHeight
		AND CONVERT (INT, personal_info.height) <= @MaxHeight
		AND CONVERT (INT, personal_info.weight) >= @MinWeight
		AND CONVERT (INT, personal_info.weight) <= @MaxWeight

		AND 
		(
		about_info.screen_quote LIKE @TextSearch
		OR about_info.about_yourself LIKE @TextSearch
		)

		AND personal_info.eyes LIKE @Eyes
		AND personal_info.hair LIKE @Hair
		AND personal_info.cook LIKE @Cook
		AND personal_info.smoke LIKE @Smoke
		AND personal_info.drink LIKE @Drink
		AND personal_info.party LIKE @Party
		AND personal_info.political LIKE @Political		
		AND personal_info.housing_status LIKE @HousingStatus

		AND login_info.user_name = contact_info.user_name
		AND login_info.user_name = personal_info.user_name
		AND login_info.user_name = about_info.user_name

		PRINT 'Any Relationship Sort by ' + @OrderBy
		PRINT @Search


SET ROWCOUNT @RowCount
		
		-- Select the raw information by joining just the personal_info AND relationship tables... 
		EXEC ('SELECT login_info.user_name AS "user_name"
			, contact_info.city AS "city"
			, state.choice AS "state"
			, country.choice AS "country"
			, personal_info.age AS "age"
			, about_info.screen_quote AS "screen_quote"
			, about_info.about_yourself AS "about_yourself"
			, pictures.photo_1 AS "pic 1"

		FROM login_info
			, contact_info
			, personal_info
			, about_info
			, state
			, country
			, pictures
		WHERE login_info.user_name = contact_info.user_name
			AND login_info.photo_submitted >= ''' + @Search + '''
			AND login_info.user_name = personal_info.user_name
			AND login_info.user_name = about_info.user_name
			AND login_info.user_name = pictures.user_name
			AND contact_info.state = state.value
			AND contact_info.country = country.value
			AND personal_info.user_name IN 
			(
			SELECT login_info.user_name
				FROM login_info
					, contact_info
					, personal_info
					, about_info
				WHERE login_info.sex LIKE ''' + @Seeking + '''
				AND about_info.questionable = 0
				AND CONVERT (INT, personal_info.sex_preference) >= ''' + @AlternativeMin + '''
				AND CONVERT (INT, personal_info.sex_preference) <= ''' + @AlternativeMax + '''
	
				AND personal_info.marital_status LIKE ''' + @MaritalStatus + '''
				AND contact_info.city LIKE ''' + @City + '''
				AND contact_info.state LIKE ''' + @State + '''
				AND contact_info.country LIKE ''' + @Country + '''
				AND personal_info.profession LIKE ''' + @Profession + '''
				AND CONVERT (INT, personal_info.income) >= ''' + @Income + '''
				AND personal_info.education LIKE ''' + @Education + '''
				AND personal_info.religion LIKE ''' + @Religion + '''
		
				AND CONVERT (INT, personal_info.age) >= ''' + @MinAgeDesired + '''
				AND CONVERT (INT, personal_info.age) <= ''' + @MaxAgeDesired + '''
		
				AND CONVERT (INT, personal_info.height) >= ''' + @MinHeight + '''
				AND CONVERT (INT, personal_info.height) <= ''' + @MaxHeight + '''
				AND CONVERT (INT, personal_info.weight) >= ''' + @MinWeight + '''
				AND CONVERT (INT, personal_info.weight) <= ''' + @MaxWeight + '''
	
				AND 
				(
				about_info.screen_quote LIKE ''' + @TextSearch + '''
				OR about_info.about_yourself LIKE ''' + @TextSearch + '''
				)

				AND personal_info.eyes LIKE ''' + @Eyes + '''
				AND personal_info.hair LIKE ''' + @Hair + '''
				AND personal_info.cook LIKE ''' + @Cook + '''
				AND personal_info.smoke LIKE ''' + @Smoke + '''
				AND personal_info.drink LIKE ''' + @Drink + '''
				AND personal_info.party LIKE ''' + @Party + '''
				AND personal_info.political LIKE ''' + @Political + '''
				AND personal_info.housing_status LIKE ''' + @HousingStatus + '''
		
				AND login_info.user_name = contact_info.user_name
				AND login_info.user_name = personal_info.user_name
				AND login_info.user_name = about_info.user_name
			)
	
	ORDER BY ' + @OrderBy
	) -- end EXEC
SET ROWCOUNT 0
		RETURN 1
END -- Relationship = 0 "Any"





-- Start Limit search by relationship type
IF (@Relationship != 0)
BEGIN
PRINT 'Limit Relationship Count'
-- Select the raw information by joining just the personal_info and relationship tables... 
SELECT CASE 
		WHEN COUNT(*) >= @GlobalRowCount THEN @GlobalRowCount
		ELSE COUNT(*)
	END 'Number of Rows 4'
	, @@CurrentSearchUniqueId AS 'search_unique_id'
	FROM relationship 
	WHERE (
			relationship.prefer_not_to_say = @prefer_not_to_say	
			OR relationship.hang_out = @hang_out
			OR relationship.short_term = @short_term		
			OR relationship.long_term = @long_term				
			OR relationship.talk_email = @talk_email		
			OR relationship.photo_exchange = @photo_exchange		
			OR relationship.marriage = @marriage				
			OR relationship.other = @other
		  )
						
		AND relationship.user_name IN 
		(
			SELECT login_info.user_name
				FROM login_info
					, contact_info
					, personal_info
					, about_info
				WHERE login_info.user_name = contact_info.user_name
				AND about_info.questionable = 0
				AND login_info.user_name = personal_info.user_name
				AND login_info.user_name = about_info.user_name

				AND login_info.sex LIKE @Seeking
				AND login_info.photo_submitted >= @Search
				AND CONVERT (INT, personal_info.sex_preference) >= @AlternativeMin
				AND CONVERT (INT, personal_info.sex_preference) <= @AlternativeMax
				AND contact_info.city LIKE @City
				AND contact_info.state LIKE @State
				AND contact_info.country LIKE @Country
				AND personal_info.marital_status LIKE @MaritalStatus
				AND personal_info.profession LIKE @Profession
				AND CONVERT (INT, personal_info.income) >= @Income
				AND personal_info.education LIKE @Education
				AND personal_info.religion LIKE @Religion

				AND CONVERT (INT, personal_info.age) >= @MinAgeDesired
				AND CONVERT (INT, personal_info.age) <= @MaxAgeDesired

				AND CONVERT (INT, personal_info.height) >= @MinHeight
				AND CONVERT (INT, personal_info.height) <= @MaxHeight
				AND CONVERT (INT, personal_info.weight) >= @MinWeight
				AND CONVERT (INT, personal_info.weight) <= @MaxWeight

				AND personal_info.eyes LIKE @Eyes
				AND personal_info.hair LIKE @Hair
				AND personal_info.cook LIKE @Cook
				AND personal_info.smoke LIKE @Smoke
				AND personal_info.drink LIKE @Drink
				AND personal_info.party LIKE @Party
				AND personal_info.political LIKE @Political
				AND personal_info.housing_status LIKE @HousingStatus
				AND 
				(
					about_info.screen_quote LIKE @TextSearch
					OR about_info.about_yourself LIKE @TextSearch
				)

		)
		PRINT 'Limit Relationship Sort by ' + @OrderBy

SET ROWCOUNT @RowCount

		-- Select the raw information by joining just the personal_info and relationship tables... 
		EXEC ('SELECT login_info.user_name AS "user_name"
			, contact_info.city AS "city"
			, state.choice AS "state"
			, country.choice AS "country"
			, personal_info.age AS "age"
			, about_info.screen_quote AS "screen_quote"
			, about_info.about_yourself AS "about_yourself"
			, pictures.photo_1 AS "pic 1"

		FROM login_info
			, contact_info
			, personal_info
			, about_info
			, state
			, country
			, pictures
		WHERE login_info.user_name = contact_info.user_name
			AND login_info.photo_submitted >= ''' + @Search + '''
			AND login_info.user_name = personal_info.user_name
			AND login_info.user_name = about_info.user_name
			AND login_info.user_name = pictures.user_name
			AND contact_info.state = state.value
			AND contact_info.country = country.value
			AND personal_info.user_name IN 
			(
			SELECT relationship.user_name
				FROM relationship 
			WHERE (
				relationship.prefer_not_to_say = ''' + @prefer_not_to_say + '''
				OR relationship.hang_out = ''' + @hang_out + '''
				OR relationship.short_term = ''' + @short_term + '''
				OR relationship.long_term = ''' + @long_term + '''				
				OR relationship.talk_email = ''' + @talk_email + '''		
				OR relationship.photo_exchange = ''' + @photo_exchange + '''
				OR relationship.marriage = ''' + @marriage + '''
				OR relationship.other = ''' + @other + '''
				)

			AND relationship.user_name IN 
					(
					SELECT login_info.user_name
						FROM login_info
							, contact_info
							, personal_info
							, about_info
						WHERE login_info.sex LIKE ''' + @Seeking + '''
						AND about_info.questionable = 0
						AND CONVERT (INT, personal_info.sex_preference) >= ''' + @AlternativeMin + '''
						AND CONVERT (INT, personal_info.sex_preference) <= ''' + @AlternativeMax + '''
						AND contact_info.city LIKE ''' + @City + '''
						AND contact_info.state LIKE ''' + @State + '''
						AND contact_info.country LIKE ''' + @Country + '''
						AND personal_info.marital_status LIKE ''' + @MaritalStatus + '''
						AND personal_info.profession LIKE ''' + @Profession + '''
						AND CONVERT (INT, personal_info.income) >= ''' + @Income + '''
						AND personal_info.education LIKE ''' + @Education + '''

						AND personal_info.religion LIKE ''' + @Religion + '''
						AND CONVERT (INT, personal_info.age) >= ''' + @MinAgeDesired + '''
						AND CONVERT (INT, personal_info.age) <= ''' + @MaxAgeDesired + '''
				
						AND CONVERT (INT, personal_info.height) >= ''' + @MinHeight + '''
						AND CONVERT (INT, personal_info.height) <= ''' + @MaxHeight + '''
						AND CONVERT (INT, personal_info.weight) >= ''' + @MinWeight + '''
						AND CONVERT (INT, personal_info.weight) <= ''' + @MaxWeight + '''

						AND 
						(
						about_info.screen_quote LIKE ''' + @TextSearch + '''
						OR about_info.about_yourself LIKE ''' + @TextSearch + '''
						)

						AND personal_info.eyes LIKE ''' + @Eyes + '''
						AND personal_info.hair LIKE ''' + @Hair + '''
						AND personal_info.cook LIKE ''' + @Cook + '''
						AND personal_info.smoke LIKE ''' + @Smoke + '''
						AND personal_info.drink LIKE ''' + @Drink + '''
						AND personal_info.party LIKE ''' + @Party + '''
						AND personal_info.political LIKE ''' + @Political + '''
						AND personal_info.housing_status LIKE ''' + @HousingStatus + '''
						AND login_info.user_name = contact_info.user_name
						AND login_info.user_name = personal_info.user_name
						AND login_info.user_name = about_info.user_name
				)
			)
	ORDER BY ' + @OrderBy
	) -- end EXEC
SET ROWCOUNT 0
		RETURN 1

END -- Limit search by relationship type @Relationship != 0

END	--- ALL OTHER SEARCHES ---
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE [cancel_paying_membership]
 @UserName 		VARCHAR(    32)
, @Password		 VARCHAR(   16)
, @ReasonForLeaving	VARCHAR(    96)
, @MembershipPrices	VARCHAR(    32)
, @WebsiteDesign 	VARCHAR(  256)
, @Suggestions 	VARCHAR(3000)

 AS

IF ( (SELECT password FROM login_info WHERE user_name = @UserName) = @Password)
BEGIN

	DECLARE @@DateStartedPaying 	DATETIME
	DECLARE @@DateCancelled		DATETIME
	DECLARE @@Email 			VARCHAR(64)
	DECLARE @@IsMembershipActive	CHAR(1)
	DECLARE @@MembershipType 	CHAR(4)
	
	DECLARE @@UniqueId		INT
	-- Get the maximum +1 unique_id number fron the membership_cancellation table 
	select @@UniqueId = max(unique_id + 1) from membership_cancellation
	--  If there are no user ids in the database this is the first and therefore #1 
	if @@UniqueId is NULL
	select @@UniqueId = 1
	
	-- Set the current date 
	SELECT @@DateCancelled = GETDATE()
	
	-- Get user info from billing_info table...
	SELECT @@IsMembershipActive = (SELECT is_membership_active from billing_info where user_name = @UserName)
	
	-- Get user info from login_info table...
	SELECT @@DateStartedPaying = (SELECT date_started_paying from login_info where user_name = @UserName)
	SELECT @@Email = (SELECT email from login_info where user_name = @UserName)
	
	-- Check if user is already a paying member...
	SELECT @@MembershipType = (SELECT membership_type FROM login_info WHERE user_name = @UserName)
	
	IF(@@IsMembershipActive != '0' AND @@MembershipType != '0')
		BEGIN
		
				print 'insert a row into the membership_cancellation table'
				insert into membership_cancellation (unique_id
									, user_name
									, email
									, date_started_paying
									, date_cancelled
									, reason_for_leaving
									, membership_prices
									, website_design
									, suggestions
								         ) 
								values (@@UniqueId
									, @UserName
									, @@Email
									, @@DateStartedPaying
									, @@DateCancelled
									, @ReasonForLeaving
									, @MembershipPrices
									, @WebsiteDesign
									, @Suggestions
									)
				print 'update is_membership_active in the billing_info table'
				UPDATE billing_info
					SET is_membership_active = '0'
					WHERE user_name = @UserName

				PRINT 'Removing (' + @UserName + ') from the recurring_transactions table'
				DELETE recurring_transactions
					WHERE user_name = @UserName

				-- Keep track of table usage...
				DECLARE @DatabaseName VARCHAR(32)
				SELECT @DatabaseName = DB_NAME()
				EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'CancelPayingMembership', @UserName

			RETURN 1
			
		END
	ELSE
		BEGIN
			PRINT 'ERROR:  User is not currently a paying member (' + @UserName + '):(' + @@IsMembershipActive + '):(' + @@MembershipType + ')'
			RETURN 206
		END
END
ELSE
	BEGIN-- Begin user_name and password DON'T match
		-- If the user_name does not exist, exit with a return value of 134
		print 'ERROR: User Name and Password did not match.'
		return 134
	END-- End user_name and password DON'T match

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO



CREATE PROCEDURE [changeEmailAddress]
@UserName varchar(32)
, @Password varchar(16)
, @Email varchar(64)
, @NewEmail varchar(64)
, @EmailVerificationCode varchar(20)

 AS

-- Determine if the user_name, email, and password match before updating email in login_info table...
IF ( (SELECT password FROM login_info WHERE user_name = @UserName AND email = @Email) = @Password)
	BEGIN
		-- Update email in login_info table
		print 'changing email for user (' + @UserName + ') from (' + @Email + ') to (' + @NewEmail + ')'
		update login_info 
			set email = @NewEmail
				, email_verification_code = @EmailVerificationCode
				, is_email_verified = '0'
			where user_name = @UserName
				AND password = @Password
				AND email = @Email

		-- Keep track of table usage...
		DECLARE @DatabaseName VARCHAR(32)
		SELECT @DatabaseName = DB_NAME()
		EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'ChangeEmailAddress', @UserName
		return 1
	END
ELSE
	BEGIN
		-- If the user_name, email and password do not match exit with a return value of 666 
		PRINT 'user_name and password did not match so we are unable to update email address for user (' + @UserName + ') from (' + @Email + ') to (' + @NewEmail + ')' -- the first part of this string must remain as "user_name and password did not match" because it is being checked for in "msg_handler" 
		RETURN 666
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO




CREATE PROCEDURE [checkUsernamePassword]
	@UserName varchar(32)
	, @Password varchar (16)

 AS

if ( (select password from login_info where user_name = @UserName) = @Password)
BEGIN
	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'Valid user_name and password combination'
return 0
END
else
BEGIN
	print 'user_name and password did not match.'
	return 666
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE [createLoginInfo]
@UserId int-- not used 
, @UserName varchar(32)
, @MembershipType char -- not used 
, @Password varchar(16)
, @PasswordHint varchar(64)
, @Email varchar(64)
, @Sex char
, @CreationDate varchar(32)-- not used 
, @LastLogin varchar(32) -- not used 
, @PhotoSubmitted int -- not used 
, @DateStartedPaying VARCHAR(32) = ''
, @EmailVerificationCode VARCHAR(17) = ''
, @IsEmilVerified VARCHAR(2) = ''
, @AffiliateTrackingId VARCHAR(44) = ''
, @AffiliateActionStatus SMALLINT = 0
, @CustomerIP CHAR(15) = ''

 AS
-- clean up database by removing all bad profiles
print 'Cleaning up Database'
EXEC admin_DeleteBadProfiles

-- UserId must be declared 
DECLARE @@UserId int
DECLARE @@return_status int
-- membership_type, creation_date, and last_login must be declared 
DECLARE @@membership_type char
DECLARE @@creation_date datetime
DECLARE @@last_login datetime

DECLARE @@WhichConnections varchar(32)
select @@WhichConnections = 'Administrator'

-- Get the maximum +1 user_id number fron the login_info table 
select @@UserId = max(user_id + 1) from login_info

--  If there are no user ids in the database this is the first and therefore #1 
if @@UserId is NULL
select @@UserId = 1

print 'Add a new IP address to the customer_IP table'
INSERT INTO customer_IP (user_name
				, user_id
				, IP_address
				) 
		VALUES (@UserName
			, @@UserID
			, @CustomerIP
			)

-- Set the default values 
select @@creation_date = getdate()
select @@last_login = getdate()

select @@membership_type = '0' -- 0 = basic
--select @@membership_type = '1' -- 0 = premium

-- Determine if the user_name is unique in the login_info table
if exists (select user_name from login_info where user_name = @UserName)
BEGIN
	-- If the user_name is not unique exit with a return value of 666 
	print 'user_name is not unique in login_info' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
	return 666
END
else
BEGIN
	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'user_name IS unique in login_info'
	insert into login_info (user_id
			, user_name
			, password
			, password_hint
			, email
			, sex
			, membership_type
			, creation_date
			, last_login
			, photo_submitted
			, date_started_paying
			, email_verification_code
			, is_email_verified
			, affiliate_tracking_id
			, affiliate_action_status
			) 
	values (@@UserId
		, @UserName
		, @Password
		, @PasswordHint
		, @Email
		, @Sex
		, @@membership_type
		, @@creation_date
		, @@last_login
		, 0
		, NULL
		, CONVERT( VARCHAR(10), CONVERT( INT, RAND() * 100000000 ) ) -- Create a random numerical character sequence no larger than 10 chars long
		, '0'
		, @AffiliateTrackingId
		, @AffiliateActionStatus
		)
END
-- Determine if the user_name is unique in the contact_info table
if exists (select user_name from contact_info where user_name = @UserName)
BEGIN
	-- If the user_name is not unique exit with a return value of 665
	print 'user_name is not unique in contact_info' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
	return 665
END
else
BEGIN
	-- If the user_name is unique add the user to the contact_info table and exit with a return value of 1 
	print 'user_name IS unique in contact_info'
	insert into contact_info (user_name
			, first_name
			, last_name
			, street_address
			, city
			, state
			, country
			, zip
			, telephone
			) 
	values (@UserName
		, ''
		, ''
		, ''
		, ''
		, '0'
		, '0'
		, ''
		, ''
		)
END

-- Determine if the user_name is unique in the relationship table
if exists (select user_name from relationship where user_name = @UserName)
BEGIN
	-- If the user_name is not unique exit with a return value of 664
	print 'user_name is not unique in relationship' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
	return 664
END
else
BEGIN
	-- If the user_name is unique add the user to the relationship table and exit with a return value of 1 
	print 'user_name IS unique in relationship'
		insert into relationship (user_name
				, prefer_not_to_say
				, any_relationship
				, hang_out
				, short_term
				, long_term
				, talk_email
				, photo_exchange
				, marriage
				, other
				) 
		values (@UserName
			, '1'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			)
END

-- Determine if the user_name is unique in the personal_info table
if exists (select user_name from personal_info where user_name = @UserName)
BEGIN
	-- If the user_name is not unique exit with a return value of 663
	print 'user_name is not unique in personal_info' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
	return 663
END
else
BEGIN
	-- If the user_name is unique add the user to the personal_info table and exit with a return value of 1 
	print 'user_name IS unique in personal_info'
		insert into personal_info(user_name
				, sex_preference
				, age
				, marital_status
				, profession
				, income
				, education
				, religion
				, height
				, weight
				, eyes
				, hair
				, min_age_desired
				, max_age_desired
				, cook
				, smoke
				, drink
				, party
				, political
				, housing_status
				) 
		values (@UserName
			, '1'
			, '18'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '18'
			, '99'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			, '0'
			)
END
-- Determine if the user_name is unique in the about_info table
if exists (select user_name from about_info where user_name = @UserName)
BEGIN
	-- If the user_name is not unique exit with a return value of 662 
	print 'user_name is not unique in about_info' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
	return 662
END
else
BEGIN
	-- If the user_name is unique add the user to the about_info table and exit with a return value of 1 
	print 'user_name IS unique in about_info'
	insert into about_info (user_name
			, screen_quote
			, about_yourself
			, questionable
			) 
	values (@UserName
		, ''
		, ''
		, '0'
		)
END

-- Determine if the user_name is unique in the about_info table
if exists (select user_name from pictures where user_name = @UserName)
BEGIN
	-- If the user_name is not unique exit with a return value of 662 
	print 'user_name is not unique in pictures' -- the first part of this string must remain as "user_name is not unique" because it is being checked for in "msg_handler" 
	return 661
END
else
BEGIN
	-- If the user_name is unique add the user to the pictures table and exit with a return value of 1 
print 'user_name IS unique in pictures'
insert into pictures (user_name
		, photo_1
		, photo_2
		, photo_3
		, photo_4
		, photo_5
		) 
values (@UserName
	, 'Nothing'
	, 'Nothing'
	, 'Nothing'
	, 'Nothing'
	, 'Nothing'
	)
END

exec @@return_status = mailSendNewUserWelcome @@WhichConnections, @UserName

if(@@return_status = 666)
	BEGIN
		print 'Mail could not be sent'
		return 666
	END
else
	BEGIN
		print 'Mail has been sent'
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO





CREATE PROCEDURE [deleteMail]
	@UserName varchar(32)
	, @Password varchar (16)
	, @MailId varchar (16)


 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	if ( (select sent_from from mail where mail_id = @MailId) = @UserName)
	BEGIN
		print 'Update sender_deleted in mail table'
		update mail
		set sender_deleted = 1
		where mail_id = @MailId
		and @UserName = sent_from
	END

	if ( (select sent_to from mail where mail_id = @MailId) = @UserName)
	BEGIN
		print 'Update receiver_deleted in mail table'
		update mail
		set receiver_deleted = 1
		where mail_id = @MailId
		and @UserName = sent_to

		print 'Update when_read in mail table'
		update mail
		set receiver_deleted = 1
		, when_read = getdate()
		where mail_id = @MailId
		and @UserName = sent_to
		and when_read = NULL
	return 0
	END
END

else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 666
END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE [func_GetProfileScore]
	@user_name	VARCHAR(32)
	, @score	TINYINT	OUTPUT
 AS
SET NOCOUNT ON

IF EXISTS ( SELECT user_name FROM login_info WHERE user_name = @user_name)
	BEGIN
		DECLARE @count 	TINYINT
			, @total 	TINYINT
		
		SELECT @count 		= 0
		SELECT @total 		= 0
		----------------
		-- login_info
		----------------
		-- 	sex 
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN sex in (1, 2) THEN 1
								ELSE 0
							END
						FROM login_info
						WHERE user_name = @user_name
					)
		----------------
		-- contact_info
		----------------
		-- 	first_name 
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN DATALENGTH(first_name) > 0 THEN 1
								ELSE 0
							END
						FROM contact_info
						WHERE user_name = @user_name
					)
		-- 	last_name 
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN DATALENGTH(last_name) > 0 THEN 1
								ELSE 0
							END
						FROM contact_info
						WHERE user_name = @user_name
					)
		-- 	street_address 
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN DATALENGTH(street_address) > 3 THEN 1
								ELSE 0
							END
						FROM contact_info
						WHERE user_name = @user_name
					)
		-- 	country 
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN country in (
										   14 -- Austria 		EU
										,  38 -- Canada
										,  21 -- Belgium		EU
										,  57 -- Denmark		EU
										,  72 -- Finland		EU
										,  73 -- France		EU
										,  80 -- Germany		EU
										,  83 -- Great Britain	EU
										,  84 -- Greece		EU
										, 103 -- Ireland		EU
										, 105 -- Italy		EU
										, 107 -- Japan
										, 124 -- Luxembourg	EU
										, 150 -- Netherlands	EU
										, 172 -- Portugal	EU
										, 196 -- Spain		EU
										, 190 -- Singapore
										, 204 -- Sweden		EU
										, 223 -- US
										) THEN 1
								ELSE 0
							END
						FROM contact_info
						WHERE user_name = @user_name
					)
		-- 	zip 
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN DATALENGTH(zip) > 3 THEN 1
								ELSE 0
							END
						FROM contact_info
						WHERE user_name = @user_name
					)
		----------------
		-- personal_info
		----------------
		--	sex_preference
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN sex_preference in (1, 2, 3, 4) THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	marital_status
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN marital_status > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	profession
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN profession > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	income
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN income > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	education
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN education > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	religion
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN religion > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	height
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN height > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	weight
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN weight > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	eyes
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN eyes > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	hair
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN hair > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	smoke
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN smoke > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	drink
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN drink > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	party
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN party > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	political
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN political > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		--	housing_status
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN housing_status > 0 THEN 1
								ELSE 0
							END
						FROM personal_info
						WHERE user_name = @user_name
					)
		----------------
		-- about_info
		----------------
		-- 	screen_quote 
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN DATALENGTH(screen_quote) >= 16 THEN 1
								ELSE 0
							END
						FROM about_info
						WHERE user_name = @user_name
					)
		-- 	about_yourself 
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN DATALENGTH(about_yourself) >= 100 THEN 1
								ELSE 0
							END
						FROM about_info
						WHERE user_name = @user_name
					)
		----------------
		-- relationship
		----------------
		SELECT @total = @total + 1
		SELECT @count = @count + (
						SELECT 
							case
								WHEN any_relationship 		!= 0
									OR hang_out 		!= 0
									OR short_term 		!= 0
									OR long_term 		!= 0
									OR talk_email 		!= 0
									OR photo_exchange 	!= 0
									OR marriage 		!= 0
									OR other	 	!= 0
								THEN 1
								ELSE 0
							END
						FROM relationship
						WHERE user_name = @user_name
					)
		
			SELECT @score =  ISNULL(CONVERT(INT, (@count / CONVERT(SMALLMONEY, @total) ) * 100), 0) 
		RETURN 1	
	END
ELSE
	BEGIN
		SELECT @score = 0
		RETURN 1	
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE [genAuthorizeNetFormCC]
	@user_name 		VARCHAR (32)
	, @password		VARCHAR (16)
	, @plan_unique_id	VARCHAR (38)
	, @is_this_batch	CHAR (1) 	= '0'
 AS

DECLARE @promo_code_status VARCHAR(8)
SELECT @promo_code_status = 'UNKNOWN'

--PRINT 'is this batch = (' + @is_this_batch + ')'

IF ( (SELECT password FROM login_info WHERE user_name = @user_name) = @password)
BEGIN
	IF  ( (
		SELECT unique_id 
		FROM membership_type 
		WHERE CONVERT(VARCHAR(38), unique_id) = @plan_unique_id
		AND	 (
				date_promotion_ended > GETDATE()
			OR
				@is_this_batch = '1'
			)
	) IS NULL)
	BEGIN
		IF (@plan_unique_id = '')
		BEGIN
			-- since @promo_code_status was empty consider this to be the first time the page was accessed
			SELECT @promo_code_status = 'UNKNOWN'
		END
		ELSE
		BEGIN
			-- since @promo_code_status was NOT empty consider that the user entered an invalid code
			SELECT @promo_code_status = 'FAILURE'
		END

		-- since @promo_code_status was either empty or invalid set it to the default membership type plan
		SELECT @plan_unique_id = (
						SELECT unique_id FROM membership_type 
						WHERE membership_type_id = '2'
					)
	END
	ELSE
	BEGIN
		SELECT @promo_code_status = 'SUCCESS'
	END

	IF  ( (SELECT user_name FROM billing_info WHERE user_name = @user_name) IS NOT NULL)
	BEGIN
		SELECT contact_info.user_name
				, contact_info.first_name
				, contact_info.last_name
				, contact_info.street_address
				, contact_info.city
				, contact_info.state
				, LTRIM(state.iso_name)	AS 'state_code'
				, contact_info.country
				, LTRIM(country.iso_name)	AS 'country_code'
				, contact_info.zip
				, LTRIM(contact_info.telephone) AS 'telephone'
				, billing_info.card_type
				, billing_info.name_on_card
				, billing_info.account_number
				, billing_info.expiration_month
				, billing_info.expiration_year
				, ISNULL(billing_info.cvv2_code, '') AS 'cvv2_code'
				, billing_info.bank_ABA_code
				, billing_info.bank_account_number
				, membership_type.membership_type_id
				, LTRIM(membership_type.membership_type_name) AS 'membership_type_name'
				, membership_type.membership_description
				, ISNULL(DATEDIFF(SECOND, duration_start, duration_end), '0') AS 'promotion_duration'
				, CASE 
					WHEN DATEDIFF(SECOND, duration_start, duration_end) IS NULL THEN membership_type.date_promotion_ended
					WHEN DATEDIFF(SECOND, duration_start, duration_end) IS NOT NULL THEN
															 DATEADD(SECOND
																	, DATEDIFF(SECOND, duration_start, duration_end)
																	, GETDATE()
																)
				END AS 'date_promotion_ended'
				, membership_type.months_1
				, membership_type.months_3
				, membership_type.months_6
				, membership_type.months_12
				, membership_type.months_240
				, membership_type.rebilled_1
				, membership_type.rebilled_3
				, membership_type.rebilled_6
				, membership_type.rebilled_12
				, @plan_unique_id		AS 'plan_unique_id'
				, @promo_code_status		AS 'promo_code_status'
		FROM contact_info
			, billing_info
			, membership_type
			, state
			, country
		WHERE contact_info.user_name = @user_name
		AND contact_info.user_name = billing_info.user_name
		AND contact_info.state = state.value
		AND contact_info.country = country.value
		AND CONVERT(VARCHAR(38), unique_id) = @plan_unique_id
	END
	ELSE
	BEGIN
		SELECT contact_info.user_name
				, contact_info.first_name
				, contact_info.last_name
				, contact_info.street_address
				, contact_info.city
				, contact_info.state
				, LTRIM(state.iso_name)	AS 'state_code'
				, contact_info.country
				, LTRIM(country.iso_name)	AS 'country_code'
				, contact_info.zip
				, LTRIM(contact_info.telephone) AS 'telephone'
				, '0'		AS 'card_type'
				, ''		AS 'name_on_card'
				, ''		AS 'account_number'
				, '01'		AS 'expiration_month'
				, '2003'		AS 'expiration_year'
				, ''		AS 'cvv2_code'
				, ''		AS 'bank_ABA_code'
				, ''		AS 'bank_account_number'
				, membership_type.membership_type_id
				, LTRIM(membership_type.membership_type_name) AS 'membership_type_name'
				, membership_type.membership_description
				, ISNULL(DATEDIFF(SECOND, duration_start, duration_end), '0') AS 'promotion_duration'
				, CASE 
					WHEN DATEDIFF(SECOND, duration_start, duration_end) IS NULL THEN membership_type.date_promotion_ended
					WHEN DATEDIFF(SECOND, duration_start, duration_end) IS NOT NULL THEN
															 DATEADD(SECOND
																	, DATEDIFF(SECOND, duration_start, duration_end)
																	, GETDATE()
																)
				END AS 'date_promotion_ended'
				, membership_type.months_1
				, membership_type.months_3
				, membership_type.months_6
				, membership_type.months_12
				, membership_type.months_240
				, membership_type.rebilled_1
				, membership_type.rebilled_3
				, membership_type.rebilled_6
				, membership_type.rebilled_12
				, @plan_unique_id		AS 'plan_unique_id'
				, @promo_code_status		AS 'promo_code_status'
		FROM contact_info
			, membership_type
			, state
			, country
		WHERE contact_info.user_name = @user_name
		AND contact_info.state = state.value
		AND contact_info.country = country.value
		AND CONVERT(VARCHAR(38), unique_id) = @plan_unique_id
	END

	RETURN 1
END
ELSE
BEGIN
	PRINT 'ERROR: User Name and Password did not match.'
	RETURN 666
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO





CREATE PROCEDURE [genBookMarks]
	@UserName varchar(32)
	, @Password varchar (16)
 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
	-- Keep track of table usage...
	DECLARE @DatabaseName VARCHAR(32)
	SELECT @DatabaseName = DB_NAME()
	EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'ViewBookMarks', @UserName
	-- used to hold table_access_log unique_id
	DECLARE @@CurrentSearchUniqueId	INT
	-- retrieve current unique_id from table_access_log...
	SELECT @@CurrentSearchUniqueId = @@identity

	print 'Get total count'
	SELECT COUNT (*) AS  "count"
		, @@CurrentSearchUniqueId AS 'search_unique_id'
	FROM login_info
	WHERE user_name IN
		(
		SELECT book_mark
			FROM book_marks
			WHERE user_name = @UserName
		)

	print 'Get  table information'
	SELECT login_info.user_name as "user_name"
		, contact_info.city as "city"
		, state.choice as "state"
		, country.choice as "country"
		, personal_info.age as "age"
		, about_info.screen_quote as "screen_quote"
		, about_info.about_yourself as "about_yourself"
		, pictures.photo_1 as "pic 1"
	FROM login_info
		, contact_info
		, personal_info
		, about_info
		, state
		, country
		, pictures
	WHERE login_info.user_name = contact_info.user_name
		AND login_info.user_name = personal_info.user_name
		AND login_info.user_name = about_info.user_name
		AND login_info.user_name = pictures.user_name
		AND contact_info.state = state.value
		AND contact_info.country = country.value
		AND login_info.user_name in 
		(
		SELECT book_mark
			FROM book_marks
			WHERE user_name = @UserName
		)

	return 0
END
else
BEGIN
	print 'ERROR: User Name and Password did not match genBookMarks.'
	return 666
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO




CREATE PROCEDURE [genInbox]
	@UserName varchar(32)
	, @Password varchar (16)


 AS

-- START Verify Permissions
DECLARE @@ReturnValue char(4)

EXEC @@ReturnValue = verifyMembershipTypePermissions  @UserName, 'allow_mail_read'
-- Check membership_type for permission
if ( @@ReturnValue != 1	)
	BEGIN--  DENIED
		print 'You must upgrade your membership to use this feature'
		return @@ReturnValue
	END
-- END Verify Permissions

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN

	-- Keep track of table usage...
	DECLARE @DatabaseName VARCHAR(32)
	SELECT @DatabaseName = DB_NAME()
	EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'ViewInbox', @UserName
	-- used to hold table_access_log unique_id
	DECLARE @@CurrentSearchUniqueId	INT
	-- retrieve current unique_id from table_access_log...
	SELECT @@CurrentSearchUniqueId = @@identity

	print 'Get message count sent to the user'	
	select count(login_info.user_name) as "count"
		, @@CurrentSearchUniqueId AS 'search_unique_id'
	from login_info
		, mail
		, pictures
	where login_info.user_name = @UserName
		and login_info.password = @Password
		and login_info.user_name = mail.sent_to
		and mail.receiver_deleted != 1
		and pictures.user_name = mail.sent_from

	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'Get messages sent to the user'
	select login_info.user_name
		, login_info.membership_type
		, mail.mail_id
		, mail.sent_to
		, mail.sent_from
		, mail.subject
		, mail.message_text
		, mail.when_sent
		, mail.when_read
		, mail.sender_deleted
		, mail.receiver_deleted
		, pictures.photo_1
	from login_info
		, mail
		, pictures
	where login_info.user_name = @UserName
		and login_info.password = @Password
		and login_info.user_name = mail.sent_to
		and mail.receiver_deleted != 1
		and pictures.user_name = mail.sent_from
	order by mail.when_sent desc

return 0

END

else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 666
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO



CREATE PROCEDURE [genMemberHome]
	@UserName			 varchar(32)
	, @Password 			varchar (16)
	, @CustomerIP 			varchar(15)	= ' '
	, @AffiliateTrackingId		varchar(44)	= ' '
	, @AffiliateActionStatus		smallint	 	= 0
 AS

DECLARE @@PromoDaysRemaining		CHAR(8)
DECLARE @@PremiumDaysRemaining	CHAR(8)
DECLARE @@MembershipType 		CHAR(4)
DECLARE @@IsMembershipActive		CHAR(1)
DECLARE @@DateMembershipExpires	DATETIME
DECLARE @@UserID				CHAR(10)

-- Get membership_type from login_info table...
SELECT @@MembershipType = (SELECT membership_type FROM login_info WHERE user_name = @UserName)
-- Get is_membership_active from billing_info table...
SELECT @@IsMembershipActive = (SELECT is_membership_active from billing_info where user_name = @UserName)
-- Get date_membership_expires from billing_info table...
SELECT @@DateMembershipExpires = (SELECT date_membership_expires from billing_info where user_name = @UserName)
-- Get user_id from login_info table...
SELECT @@UserID = (SELECT user_id FROM login_info WHERE user_name = @UserName)

-- Only change the default value of @PromoDaysRemaining if the membership_type_id is promotional...
if (
	select datediff(day, getdate(), membership_type.date_promotion_ended) 
	from membership_type
		, login_info
	where login_info.user_name = @UserName
	and login_info.membership_type = membership_type.membership_type_id
  ) != NULL
	BEGIN
		print 'Get PromoDaysRemaining'
		select @@PromoDaysRemaining = (
							select datediff(day, getdate(), billing_info.date_membership_expires) 
							from membership_type
								, login_info
								, billing_info
							where login_info.user_name = @UserName
							and login_info.user_name = billing_info.user_name
							and login_info.membership_type = membership_type.membership_type_id
						    )
	END
ELSE
	BEGIN
		print 'Dont get PromoDaysRemaining'
	END

select @@PremiumDaysRemaining = ''
IF(@@IsMembershipActive = '0' AND( @@MembershipType = '1' OR  @@MembershipType = '2') )
	BEGIN
		print 'Get PremiumDaysRemaining'
		select @@PremiumDaysRemaining = (
							select datediff(day, getdate(), @@DateMembershipExpires) 
							from billing_info
							where billing_info.user_name = @UserName
						    )
	END
ELSE
	BEGIN
		print 'Dont get PremiumDaysRemaining'
	END


if ( (select password from login_info where user_name = @UserName) = @Password)
	BEGIN
		-- Determine if the x_customer_IP is present in the restricted_IP table
		IF EXISTS (select IP_address from customer_IP where  IP_address = @CustomerIP AND  user_name = @UserName AND  user_id = @@UserID)
			BEGIN
				PRINT 'IP address already exists(' + @UserName + '):(' + @CustomerIP + ')'
			END
		ELSE
			BEGIN
				-- If the IP_address does not already exist for this user add it to the customer_IP table
				print 'Add a new IP address to the customer_IP table'
				insert into customer_IP (user_name
						, user_id
						, IP_address
						) 
				values (@UserName
					, @@UserID
					, @CustomerIP
					)
			END
			
		-- Keep track of table usage...
		DECLARE @DatabaseName VARCHAR(32)
		SELECT @DatabaseName = DB_NAME()
		EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'MemberHome', @UserName
		-- used to hold table_access_log unique_id
		DECLARE @@CurrentSearchUniqueId	INT
		-- retrieve current unique_id from table_access_log...
		SELECT @@CurrentSearchUniqueId = @@identity

		-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
		print 'Get login_info table information'
		select login_info.user_name
			, login_info.membership_type
			, membership_type.membership_type_name
			, login_info.photo_submitted
			, login_info.email_verification_code
			, login_info.is_email_verified
			, login_info.affiliate_tracking_id
			, login_info.affiliate_action_status
			, about_info.questionable
			, @@PromoDaysRemaining AS 'PromoDaysRemaining'
			, @@IsMembershipActive AS 'IsMembershipActive'
			, @@PremiumDaysRemaining AS 'PremiumDaysRemaining'
			, @@CurrentSearchUniqueId AS 'search_unique_id'
		from login_info
			, about_info
			, membership_type
		where login_info.user_name = @UserName
			and login_info.password = @Password
			and login_info.user_name = about_info.user_name
			and login_info.membership_type = membership_type.membership_type_id
	
		print 'Get messages sent to the user'
		select mail.mail_id
			, mail.sent_to
			, mail.sent_from
			, mail.subject
			, mail.message_text
			, mail.when_sent
			, mail.when_read
			, mail.sender_deleted
			, mail.receiver_deleted
		from mail
		where mail.sent_to = @UserName
	
		PRINT 'Update last_login'
		UPDATE login_info
		SET last_login =  GETDATE()
		WHERE user_name = @UserName

	return 0
	END
ELSE
	BEGIN
		print 'ERROR: User Name and Password did not match.'
		return 666
	END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE [genOutbox]
	@UserName varchar(32)
	, @Password varchar (16)
 AS

-- START Verify Permissions
DECLARE @@ReturnValue char(4)

EXEC @@ReturnValue = verifyMembershipTypePermissions  @UserName, 'allow_mail_read'
-- Check membership_type for permission
if ( @@ReturnValue != 1	)
	BEGIN--  DENIED
		print 'You must upgrade your membership to use this feature'
		return @@ReturnValue
	END
-- END Verify Permissions

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN

	-- Keep track of table usage...
	DECLARE @DatabaseName VARCHAR(32)
	SELECT @DatabaseName = DB_NAME()
	EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'ViewOutbox', @UserName
	-- used to hold table_access_log unique_id
	DECLARE @@CurrentSearchUniqueId	INT
	-- retrieve current unique_id from table_access_log...
	SELECT @@CurrentSearchUniqueId = @@identity

	print 'Get message cound sent to the user'	
	select count(login_info.user_name) 	AS 'count'
		, @@CurrentSearchUniqueId	AS 'search_unique_id'
	from login_info
		, mail
	where login_info.user_name = @UserName
		and login_info.password = @Password
		and mail.sender_deleted != 1
		and login_info.user_name = mail.sent_from


	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'Get messages sent to the user'
	select login_info.user_name
		, login_info.membership_type
		, mail.mail_id
		, mail.sent_to
		, mail.sent_from
		, mail.subject
		, mail.message_text
		, mail.when_sent
		, mail.when_read
		, mail.sender_deleted
		, mail.receiver_deleted
		, pictures.photo_1
	from login_info
		, mail
		, pictures
	where login_info.user_name = @UserName
		and login_info.password = @Password
		and mail.sender_deleted != 1
		and login_info.user_name = mail.sent_from
		and pictures.user_name = mail.sent_to
	order by mail.when_sent desc

return 0

END

else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 666
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO





CREATE PROCEDURE [genPicUpload]
	@UserName varchar(32)
	, @Password varchar (16)


 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
	-- Keep track of table usage...
	DECLARE @DatabaseName VARCHAR(32)
	SELECT @DatabaseName = DB_NAME()
	EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'ViewPicUpload', @UserName
	-- used to hold table_access_log unique_id
	DECLARE @@CurrentSearchUniqueId	INT
	-- retrieve current unique_id from table_access_log...
	SELECT @@CurrentSearchUniqueId = @@identity

	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'Get picture table information'
	select pictures.user_name
		, pictures.photo_1
		, pictures.photo_2
		, pictures.photo_3
		, pictures.photo_4
		, pictures.photo_5
		, @@CurrentSearchUniqueId
	from pictures
	where pictures.user_name = @UserName
return 0

END

else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 666
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO




CREATE PROCEDURE [genSendMail]
@UserNameBeingSearched varchar(32)
, @UserNameSearching varchar(32)

 AS

-- START Verify Permissions
DECLARE @@AllowSend char(4)
DECLARE @@AllowReply char(4)

EXEC @@AllowSend = verifyMembershipTypePermissions  @UserNameSearching, 'allow_mail_send'
EXEC @@AllowReply = verifyMembershipTypePermissions  @UserNameSearching, 'allow_mail_reply'

if ( @@AllowReply != 1)
	BEGIN--  DENIED
		print 'You must upgrade your membership to use this feature'
		return @@AllowReply
	END
-- END Verify Permissions

-- Keep track of table usage...
DECLARE @DatabaseName VARCHAR(32)
SELECT @DatabaseName = DB_NAME()
EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'GenSendMail', @UserNameSearching
-- used to hold table_access_log unique_id
DECLARE @@CurrentSearchUniqueId	INT
-- retrieve current unique_id from table_access_log...
SELECT @@CurrentSearchUniqueId = @@identity


if (@@AllowSend = 1)
BEGIN
print 'user has send permission'
	/* Select the raw information by joining just the personal_info and relationship tables... */
	print 'select all the info to generate the single profile information'
	select login_info.user_id as "user_id"
		, login_info.user_name as "user_name"
		, login_info.membership_type as "membership_type"
		, sex.choice as "sex"
		, login_info.creation_date as "creation_date"
		, login_info.last_login as "last_login"
		, contact_info.city as "city"
		, state.choice as "state"
		, country.choice as "country"
		, sex_preference.choice as "sex_preference"
		, personal_info.age as "age"
		, marital_status.choice as "marital_status"
		, profession.choice as "profession"
		, education.choice as "education"
		, religion.choice as "religion"
		, height.choice as "height"
		, weight.choice  as "weight"
		, eyes.choice as "eyes"
		, hair.choice as "hair"
		, personal_info.min_age_desired
		, personal_info.max_age_desired
		, cook.choice as "cook"
		, smoke.choice as "smoke"
		, drink.choice as "drink"
		, party.choice as "party"
		, political.choice as "political"
		, housing_status.choice as "housing_status"
		, relationship.prefer_not_to_say as "prefer_not_to_say"
		, relationship.any_relationship as "any_relationship"
		, relationship.hang_out as "hang_out"
		, relationship.short_term as "short_term"
		, relationship.long_term as "long_term"
		, relationship.talk_email as "talk_email"
		, relationship.photo_exchange as "photo_exchange"
		, relationship.marriage as "marriage"
		, relationship.other as "other"
		, about_info.screen_quote as "screen_quote"
		, about_info.about_yourself as "about_yourself"
		, pictures.photo_1 as "pic 1"
		, pictures.photo_2 as "pic 2"
		, pictures.photo_3 as "pic 3"
		, pictures.photo_4 as "pic 4"
		, pictures.photo_5 as "pic 5"
		, @@CurrentSearchUniqueId AS 'search_unique_id'
	from login_info
		, contact_info
		, personal_info
		, relationship
		, about_info
		, sex_preference
		, marital_status
		, profession
		, education
		, religion
		, height
		, weight
		, eyes
		, hair
		, cook
		, smoke
		, drink
		, party
		, political
		, housing_status
		, sex
		, state
		, country
		, pictures
	where login_info.user_name = contact_info.user_name
		and login_info.user_name = personal_info.user_name
		and login_info.user_name = relationship.user_name
		and login_info.user_name = about_info.user_name
		and login_info.user_name = pictures.user_name
		and login_info.sex = sex.value
		and contact_info.state = state.value
		and contact_info.country = country.value
		and personal_info.sex_preference = sex_preference.value
		and personal_info.marital_status = marital_status.value
		and personal_info.profession = profession.value
		and personal_info.education = education.value
		and personal_info.religion = religion.value
		and personal_info.height = height.value
		and personal_info.weight = weight.value
		and personal_info.eyes = eyes.value
		and personal_info.hair = hair.value
		and personal_info.cook = cook.value
		and personal_info.smoke = smoke.value
		and personal_info.drink = drink.value
		and personal_info.party = party.value
		and personal_info.political = political.value
		and personal_info.housing_status = housing_status.value
		and personal_info.user_name = @UserNameBeingSearched
END
else
if (@@AllowReply = 1)
BEGIN
print 'user has reply permission'
	if (
	 exists (select user_name from login_info where user_name = @UserNameBeingSearched)
	and exists (select sent_from from mail where sent_to = @UserNameSearching AND sent_from = @UserNameBeingSearched)
	)
	BEGIN
		/* Select the raw information by joining just the personal_info and relationship tables... */
		print 'select all the info to generate the single profile information'
		select login_info.user_id as "user_id"
			, login_info.user_name as "user_name"
			, login_info.membership_type as "membership_type"
			, sex.choice as "sex"
			, login_info.creation_date as "creation_date"
			, login_info.last_login as "last_login"
			, contact_info.city as "city"
			, state.choice as "state"
			, country.choice as "country"
			, sex_preference.choice as "sex_preference"
			, personal_info.age as "age"
			, marital_status.choice as "marital_status"
			, profession.choice as "profession"
			, education.choice as "education"
			, religion.choice as "religion"
			, height.choice as "height"
			, weight.choice  as "weight"
			, eyes.choice as "eyes"
			, hair.choice as "hair"
			, personal_info.min_age_desired
			, personal_info.max_age_desired
			, cook.choice as "cook"
			, smoke.choice as "smoke"
			, drink.choice as "drink"
			, party.choice as "party"
			, political.choice as "political"
			, housing_status.choice as "housing_status"
			, relationship.prefer_not_to_say as "prefer_not_to_say"
			, relationship.any_relationship as "any_relationship"
			, relationship.hang_out as "hang_out"
			, relationship.short_term as "short_term"
			, relationship.long_term as "long_term"
			, relationship.talk_email as "talk_email"
			, relationship.photo_exchange as "photo_exchange"
			, relationship.marriage as "marriage"
			, relationship.other as "other"
			, about_info.screen_quote as "screen_quote"
			, about_info.about_yourself as "about_yourself"
			, pictures.photo_1 as "pic 1"
			, pictures.photo_2 as "pic 2"
			, pictures.photo_3 as "pic 3"
			, pictures.photo_4 as "pic 4"
			, pictures.photo_5 as "pic 5"
			, @@CurrentSearchUniqueId AS 'search_unique_id'
		from login_info
			, contact_info
			, personal_info
			, relationship
			, about_info
			, sex_preference
			, marital_status
			, profession
			, education
			, religion
			, height
			, weight
			, eyes
			, hair
			, cook
			, smoke
			, drink
			, party
			, political
			, housing_status
			, sex
			, state
			, country
			, pictures
		where login_info.user_name = contact_info.user_name
			and login_info.user_name = personal_info.user_name
			and login_info.user_name = relationship.user_name
			and login_info.user_name = about_info.user_name
			and login_info.user_name = pictures.user_name
			and login_info.sex = sex.value
			and contact_info.state = state.value
			and contact_info.country = country.value
			and personal_info.sex_preference = sex_preference.value
			and personal_info.marital_status = marital_status.value
			and personal_info.profession = profession.value
			and personal_info.education = education.value
			and personal_info.religion = religion.value
			and personal_info.height = height.value
			and personal_info.weight = weight.value
			and personal_info.eyes = eyes.value
			and personal_info.hair = hair.value
			and personal_info.cook = cook.value
			and personal_info.smoke = smoke.value
			and personal_info.drink = drink.value
			and personal_info.party = party.value
			and personal_info.political = political.value
			and personal_info.housing_status = housing_status.value
			and personal_info.user_name = @UserNameBeingSearched
	END
	else
	BEGIN
		-- If the user_name does not exist exit with a return value of 666 
		print 'user_name does not exist or not a reply'
		return 665
	END
END
else
BEGIN--  DENIED
	print 'You must upgrade your membership to use this feature 2'
	return @@AllowReply
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE [getAboutInfoByNamePassword]
	@UserName varchar(32)
	, @Password varchar (16)
 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
/* Get raw info */
	select user_name
		, screen_quote
		, about_yourself
		, questionable
	from about_info
	where user_name = @UserName

/* this is only needed to conform with the common database call that expects two result sets*/
	select user_name
		, screen_quote
		, about_yourself
		, questionable
	from about_info
	where user_name = @UserName

	return 1
END

else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 666
END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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
				, cvv2_code
				, bank_ABA_code
				, bank_account_number
		FROM billing_info
		WHERE user_name = @UserName
		
		SELECT billing_info.user_name
				, @@CardType as 'card_type'
				, billing_info.name_on_card
				, billing_info.account_number
				, billing_info.expiration_month
				, billing_info.expiration_year
				, billing_info.cvv2_code
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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE [getContactInfoByNamePassword]
	@UserName varchar(32)
	, @Password varchar (16)
 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
select user_name
		, first_name
		, last_name
		, street_address
		, city
		, state
		, country
		, zip
		, telephone
from contact_info
where user_name = @UserName

select contact_info.user_name
		, contact_info.first_name
		, contact_info.last_name
		, contact_info.street_address
		, contact_info.city
		, state.choice as "state"
		, country.choice as "country"
		, contact_info.zip
		, contact_info.telephone
from contact_info, state, country
where user_name = @UserName
	and contact_info.state = state.value 
	and contact_info.country = country.value 

	return 1
END

else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 666
END






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO




CREATE PROCEDURE [getEmailByUserName]
	@UserName varchar(32)
 AS

BEGIN
/* Get raw login_info data */
	select email as 'email'
	from login_info
	where user_name = @UserName
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE [getLoginInfoByEmailMaidenName]
	@Email varchar(32)
	, @MaidenName varchar (32)

 AS

if ( (select password_hint from login_info where email = @Email) = @MaidenName)
BEGIN
/* Get raw login_info data */
	select	user_id
		, user_name
		, membership_type
		, password
		, password_hint
		, email
		, sex
		, creation_date
		, last_login
		, photo_submitted
		, date_started_paying
		, email_verification_code
		, is_email_verified
		, affiliate_tracking_id
		, affiliate_action_status
	from login_info
	where email = @Email
		and password_hint = @MaidenName

/* Get textual login_info data using a join */
	select	user_id
		, user_name
		, membership_type
		, password
		, password_hint
		, email
		, sex.choice as "sex"
		, creation_date
		, last_login
		, photo_submitted
		, date_started_paying
		, email_verification_code
		, is_email_verified
		, affiliate_tracking_id
		, affiliate_action_status
	from login_info
		, sex
	where login_info.email = @Email
		and login_info.password_hint = @MaidenName
			and login_info.sex = sex.value
	return 1
END

else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 666
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE [getLoginInfoByNamePassword]
	@UserName varchar(32)
	, @Password varchar (16)
 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
/* Get raw login_info data */
	select	user_id
		, user_name
		, membership_type
		, password
		, password_hint
		, email
		, sex
		, creation_date
		, last_login
		, photo_submitted
		, date_started_paying
		, email_verification_code
		, is_email_verified
		, affiliate_tracking_id
		, affiliate_action_status
	from login_info
	where user_name = @UserName
			and password = @Password

/* Get textual login_info data using a join */
	select	user_id
		, user_name
		, membership_type
		, password
		, password_hint
		, email
		, sex.choice as "sex"
		, creation_date
		, last_login
		, photo_submitted
		, date_started_paying
		, email_verification_code
		, is_email_verified
		, affiliate_tracking_id
		, affiliate_action_status
	from login_info, sex
	where user_name = @UserName
			and password = @Password
			and login_info.sex = sex.value
	return 1
END

else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 666
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE [getLoginInfoByUserNameMaidenName]
	@UserName varchar(32)
	, @MaidenName varchar (16)

 AS

if ( (select password_hint from login_info where user_name = @UserName) = @MaidenName)
BEGIN
/* Get raw login_info data */
	select	user_id
		, user_name
		, membership_type
		, password
		, password_hint
		, email
		, sex
		, creation_date
		, last_login
		, photo_submitted
		, date_started_paying
		, email_verification_code
		, is_email_verified
		, affiliate_tracking_id
		, affiliate_action_status
	from login_info
	where user_name = @UserName
		and password_hint = @MaidenName

/* Get textual login_info data using a join */
	select	user_id
		, user_name
		, membership_type
		, password
		, password_hint
		, email
		, sex.choice as "sex"
		, creation_date
		, last_login
		, photo_submitted
		, date_started_paying
		, email_verification_code
		, is_email_verified
		, affiliate_tracking_id
		, affiliate_action_status
	from login_info
		, sex
	where login_info.user_name = @UserName
		and login_info.password_hint = @MaidenName
			and login_info.sex = sex.value
	return 1
END

else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 666
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





CREATE PROCEDURE [getPersonalInfoByNamePassword]
	@UserName varchar(32)
	, @Password varchar (16)


 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
print 'get raw info from personal_info and relationship tables'
/* Select the raw information by joining just the personal_info and relationship tables... */
	select personal_info.user_name			as "user_name"
 		, personal_info.sex_preference		as "sex_preference"
		, personal_info.age			as "age"
		, personal_info.marital_status		as "marital_status"
		, personal_info.profession		as "profession"
		, personal_info.income			as "income"
		, personal_info.education		as "education"
		, personal_info.religion			as "religion"
		, personal_info.height			as "height"
 		, personal_info.weight			as "weight"
		, personal_info.eyes			as "eyes"
		, personal_info.hair			as "hair"
		, personal_info.min_age_desired 	as "min_age_desired"
		, personal_info.max_age_desired	as "max_age_desired"
		, personal_info.cook			as "cook"
		, personal_info.smoke			as "smoke"
		, personal_info.drink			as "drink"
		, personal_info.party			as "party"
		, personal_info.political			as "political"
		, personal_info.housing_status		as "housing_status"
		, relationship.prefer_not_to_say 		as "prefer_not_to_say"
		, relationship.any_relationship 		as "any_relationship"
		, relationship.hang_out			as "hang_out"
		, relationship.short_term			as "short_term"
		, relationship.long_term			as "long_term"
		, relationship.talk_email			as "talk_email"
		, relationship.photo_exchange		as "photo_exchange"
		, relationship.marriage			as "marriage"
		, relationship.other			as "other"

	from personal_info
		, relationship

	where personal_info.user_name = @UserName
	and personal_info.user_name = relationship.user_name

/* Select the textual information via a join... */
print 'get text info from personal_info and relationship tables'
	select personal_info.user_name 
 		, sex_preference.choice as "sex_preference"
		, personal_info.age as "age"
		, marital_status.choice as "marital_status"
		, profession.choice as "profession"
		, income.choice as "income"
		, education.choice as "education"
		, religion.choice as "religion"
		, height.choice as "height"
 		, weight.choice  as "weight"
		, eyes.choice as "eyes"
		, hair.choice as "hair"
		, personal_info.min_age_desired
		, personal_info.max_age_desired
		, cook.choice as "cook"
		, smoke.choice as "smoke"
		, drink.choice as "drink"
		, party.choice as "party"
		, political.choice as "political"
		, housing_status.choice as "housing_status"
		, relationship.prefer_not_to_say as "prefer_not_to_say"
		, relationship.any_relationship as "any_relationship"
		, relationship.hang_out as "hang_out"
		, relationship.short_term as "short_term"
		, relationship.long_term as "long_term"
		, relationship.talk_email as "talk_email"
		, relationship.photo_exchange as "photo_exchange"
		, relationship.marriage as "marriage"
		, relationship.other as "other"

	from personal_info
		, sex_preference
		, marital_status
		, profession
		, income
		, education
		, religion
		, height
		, weight
		, eyes
		, hair
		, cook
		, smoke
		, drink
		, party
		, political
		, housing_status
		, relationship

	where personal_info.user_name = @UserName
	and personal_info.sex_preference = sex_preference.value
	and personal_info.marital_status = marital_status.value
	and personal_info.profession = profession.value
	and personal_info.income = income.value
	and personal_info.education = education.value
	and personal_info.religion = religion.value
	and personal_info.height = height.value
	and personal_info.weight = weight.value
	and personal_info.eyes = eyes.value
	and personal_info.hair = hair.value
	and personal_info.cook = cook.value
	and personal_info.smoke = smoke.value
	and personal_info.drink = drink.value
	and personal_info.party = party.value
	and personal_info.political = political.value
	and personal_info.housing_status = housing_status.value
	and personal_info.user_name = relationship.user_name

	return 1
END

else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 666
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE [hideUnhideProfile]
	@UserName varchar(32)
	, @Password varchar (16)

 AS

if ( (select password from login_info where user_name = @UserName) = @Password)
BEGIN
	if ( (select questionable from about_info where user_name = @UserName) = 0)
	BEGIN
		print 'Hide user profile'
		update about_info
		set questionable = 1
		where user_name = @UserName
	END
	else
	if ( (select questionable from about_info where user_name = @UserName) = 1)
	BEGIN
		print 'Unhide user profile'
		update about_info
		set questionable = 0
		where user_name = @UserName
	END

	-- Keep track of table usage...
	DECLARE @DatabaseName VARCHAR(32)
	SELECT @DatabaseName = DB_NAME()
	EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'HideUnhideProfile', @UserName

END
else
BEGIN
	print 'ERROR: User Name and Password did not match.'
	return 137
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO




CREATE PROCEDURE [insert_membership_cancellation]
@UserName VARCHAR(32)
, @ReasonForLeaving VARCHAR(128)
, @MembershipPrices VARCHAR(16)
, @WebsiteDesign VARCHAR(16)
, @Suggestions TEXT

 AS

DECLARE @@Email VARCHAR(64)
DECLARE @@DateStartedPaying DATETIME
DECLARE @@DateCancelled DATETIME

-- Set the current date 
SELECT @@Email = (SELECT email FROM login_info WHERE user_name = @UserName)
SELECT @@DateStartedPaying = (SELECT date_started_paying FROM login_info WHERE user_name = @UserName)
SELECT @@DateCancelled = GETDATE()

-- Add @MonthsJoined to the DateOfThisTransaction to initialize the DateOfNextTransaction

-- If the user_name is unique add the user to the billing_info table
print 'insert cancellation information into membership_cancellation table'
insert into membership_cancellation (user_name
					, email
					, date_started_paying
					, date_cancelled
					, reason_for_leaving
					, membership_prices
					, website_design
					, suggestions
					) 
				values (@UserName
					, @@Email
					, @@DateStartedPaying
					, @@DateCancelled
					, @ReasonForLeaving
					, @MembershipPrices
					, @WebsiteDesign
					, @Suggestions
					)

-- update billing_info table to reflect the cancellation
print 'update is_membership_active to NO "0" in billing_info table'
UPDATE billing_info 
SET is_membership_active = '0'
WHERE user_name = @UserName

RETURN 1



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO





CREATE PROCEDURE [mailSend]
@MailId int -- not used
, @SentTo varchar(32)
, @SentFrom varchar(32)
, @Subject varchar(128)
, @MessageText varchar(3000)
, @WhenSent datetime
, @WhenRead datetime
, @SenderDeleted int --not used
, @ReceiverDeleted int --not used

 AS

-- Verify Permissions
DECLARE @@AllowSend char(4)
DECLARE @@AllowReply char(4)

--Used to Keep track of table usage...
DECLARE @DatabaseName VARCHAR(32)
SELECT @DatabaseName = DB_NAME()

EXEC @@AllowSend = verifyMembershipTypePermissions  @SentFrom, 'allow_mail_send'
EXEC @@AllowReply = verifyMembershipTypePermissions  @SentFrom, 'allow_mail_reply'

--if ( @@AllowSend != 1 OR @@AllowReply != 1)
--	BEGIN--  DENIED
--		print 'You must upgrade your membership to use this feature 1'
--		return @@AllowReply
--	END

-- UserId must be declared 
DECLARE @@MailId int
-- Get the maximum +1 mail_id number fron the mail table 
select @@MailId = max(mail_id + 1) from mail

--  If there are no mail ids in the database this is the first and therefore #1 
if @@MailId is NULL
select @@MailId = 1

DECLARE @@MembershipType int
-- Set the default values 
select @WhenSent = getdate()
select @@MembershipType = (select membership_type from login_info where user_name = @SentFrom)

-- Determine if the user_name has mailing permission in the login_info table
if (@@AllowSend = 1 or @SentFrom = 'Administrator')
BEGIN
print 'user has send permission'
	if exists (select user_name from login_info where user_name = @SentTo)
	BEGIN
		-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
		print 'Posting new mail message to mail table'
		insert into mail ( mail_id
				, sent_to
				, sent_from
				, subject
				, message_text
				, when_sent
				, sender_deleted
				, receiver_deleted
				) 
		values ( @@MailId
			, @SentTo
			, @SentFrom
			, @Subject
			, @MessageText
			, @WhenSent
			, 0	
			, 0	
			)

	-- Keep track of table usage...
	EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'SendNewMail', @SentFrom

	return 0

	END
	else
	BEGIN
		-- If the user_name does not exist exit with a return value of 666 
		print 'user_name does not exist'
		return 665
	END
END
else
if (@@AllowReply = 1)
BEGIN
print 'user has reply permission'
	if (
	 exists (select user_name from login_info where user_name = @SentTo)
	and exists (select sent_from from mail where sent_to = @SentFrom AND sent_from = @SentTo)
	)
	BEGIN
		-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
		print 'Posting new mail message to mail table'
		insert into mail ( mail_id
				, sent_to
				, sent_from
				, subject
				, message_text
				, when_sent
				, sender_deleted
				, receiver_deleted
				) 
		values ( @@MailId
			, @SentTo
			, @SentFrom
			, @Subject
			, @MessageText
			, @WhenSent
			, 0	
			, 0	
			)

	-- Keep track of table usage...
	EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'SendReplyMail', @SentFrom

	return 0
	END
	else
	BEGIN
		-- If the user_name does not exist exit with a return value of 666 
		print 'user_name does not exist or not a reply'
		return 665
	END
END
else
BEGIN--  DENIED
	print 'You must upgrade your membership to use this feature 2'
	return @@AllowReply
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE [mailSendNewUserWelcome]
@SentFrom varchar(32)
, @SentTo varchar(32)

 AS

DECLARE @@WhenSent datetime
DECLARE @@MessageText VARCHAR(3000)
-- UserId must be declared 
DECLARE @@MailId int
-- Get the maximum +1 mail_id number fron the mail table 
select @@MailId = max(mail_id + 1) from mail

SELECT @@MessageText =  'Thank you for filling out your profile and becoming a Basic member!

Below you will find information about what features are available to our members.

As you may have noticed before you became a member you were able to execute a Simple Search.  This is the only feature a non-member is allowed to use.  But now that you have become a Basic member, simply by filling out your profile, you are given access to many of the more advanced features.  As a Basic member you are given access to the additional features:

<UL>
	<LI><A HREF="GenInbox.exe">Receive Mail</A>
	<LI><A HREF="GenBookmarks.exe">Bookmarks</A>
	<LI>Hide / Unhide Profile
	<LI><A HREF="GenOutbox.exe">View Sent Mail</A>
	<LI><A HREF="SingleProfile.exe?user_name=' + @SentTo + '">View Your Profile</A>
	<LI><A HREF="UpdateLogin.exe">Update Your Profile</A>
	<LI><A HREF="GenPicUpload.exe">Upload Pictures</A>
</UL>	

If you decide you would like access to every feature we provide simply <A HREF="../PaymentOptions.html">become a Premium member</A> and receive access to the additional features:

<UL>
	<LI>Send Mail To Any Member
	<LI>Reply To Received Mail
	<LI>Advanced Search
	<LI>View Detailed Profiles
	<LI>View Enlarged Pictures
</UL>	

If you have any questions please reply to this mail and we will gladly do what we can to make your time with us as enjoyable as we can.

Thank you again and we hope you enjoy your time with us.

Administrator
'
--  If there are no mail ids in the database this is the first and therefore #1 
if @@MailId is NULL
select @@MailId = 1

-- Set the default values 
select @@WhenSent = getdate()



if exists (select user_name from login_info where user_name = @SentTo)
BEGIN
	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'Posting new mail message to mail table'
	insert into mail (mail_id
			, sent_to
			, sent_from
			, subject
			, message_text
			, when_sent
			, sender_deleted
			, receiver_deleted
			) 
	values ( @@MailId
		, @SentTo
		, @SentFrom
		, 'Welcome!'
		, @@MessageText
		, @@WhenSent
		, 0	
		, 0	
		)
return 0
END
else
BEGIN
	-- If the user_name does not exist exit with a return value of 666 
	print 'user_name does not exist'
	return 666
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO





CREATE PROCEDURE [readReceivedMail]
	@UserName varchar(32)
	, @Password varchar (16)
	, @MailId varchar (16)
 AS

-- START Verify Permissions
DECLARE @@ReturnValue char(4)

EXEC @@ReturnValue = verifyMembershipTypePermissions  @UserName, 'allow_mail_read'
-- Check membership_type for permission
if ( @@ReturnValue != 1	)
	BEGIN--  DENIED
		print 'You must upgrade your membership to use this feature'
		return @@ReturnValue
	END
-- END Verify Permissions

-- Keep track of table usage...
DECLARE @DatabaseName VARCHAR(32)
SELECT @DatabaseName = DB_NAME()
EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'ReadReceivedMail', @UserName
-- used to hold table_access_log unique_id
DECLARE @@CurrentSearchUniqueId	INT
-- retrieve current unique_id from table_access_log...
SELECT @@CurrentSearchUniqueId = @@identity



if ( (select password from login_info where user_name = @UserName) = @Password)
	BEGIN-- Begin user_name and password match
		-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
		print 'Retrieving actual mail message from mail table'
		select mail.mail_id
			, mail.sent_to
			, mail.sent_from
			, mail.subject
			, mail.message_text
			, mail.when_sent
			, mail.when_read
			, mail.sender_deleted
			, mail.receiver_deleted
			, contact_info.city
			, contact_info.state
			, personal_info.age
			, pictures.photo_1
			, @@CurrentSearchUniqueId AS 'search_unique_id'
		from mail
		, contact_info
		, personal_info
		, state
		, pictures
		where @MailId like mail.mail_id
		and state.value = contact_info.state
		and contact_info.user_name = mail.sent_from
		and personal_info.user_name = mail.sent_from
		and mail.sent_to = @UserName
		and pictures.user_name = mail.sent_from

		print 'Retrieving data mail message from mail table'
		select mail.mail_id
			, mail.sent_to
			, mail.sent_from
			, mail.subject
			, mail.message_text
			, mail.when_sent
			, mail.when_read
			, mail.sender_deleted
			, mail.receiver_deleted
			, contact_info.city
			, state.choice as "state"
			, personal_info.age
			, pictures.photo_1
			, @@CurrentSearchUniqueId AS 'search_unique_id'
		from mail
		, contact_info
		, personal_info
		, state
		, pictures
		where @MailId like mail.mail_id
		and state.value = contact_info.state
		and contact_info.user_name = mail.sent_from
		and personal_info.user_name = mail.sent_from
		and mail.sent_to = @UserName
		and pictures.user_name = mail.sent_from

		print 'Updating when_read mail field'
		update mail
		set when_read= getdate()
		where @MailId like mail.mail_id

	return 0
	END-- End user_name and password match
ELSE
	BEGIN-- Begin user_name and password DON'T match
		-- If the user_name does not exist exit with a return value of 666 
		print 'ERROR: User Name and Password did not match.'
		return 134
	END-- End user_name and password DON'T match

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO





CREATE PROCEDURE [readSentMail]
	@UserName varchar(32)
	, @Password varchar (16)
	, @MailId varchar (16)


 AS

-- START Verify Permissions
DECLARE @@ReturnValue char(4)

EXEC @@ReturnValue = verifyMembershipTypePermissions  @UserName, 'allow_mail_read'
-- Check membership_type for permission
if ( @@ReturnValue != 1	)
	BEGIN--  DENIED
		print 'You must upgrade your membership to use this feature'
		return @@ReturnValue
	END
-- END Verify Permissions

-- Keep track of table usage...
DECLARE @DatabaseName VARCHAR(32)
SELECT @DatabaseName = DB_NAME()
EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'ReadSentMail', @UserName
-- used to hold table_access_log unique_id
DECLARE @@CurrentSearchUniqueId	INT
-- retrieve current unique_id from table_access_log...
SELECT @@CurrentSearchUniqueId = @@identity

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
	-- If the user_name is unique add the user to the login_info table and exit with a return value of 1 
	print 'Retrieving actual mail message from mail table'
	select mail.mail_id
		, mail.sent_to
		, mail.sent_from
		, mail.subject
		, mail.message_text
		, mail.when_sent
		, mail.when_read
		, mail.sender_deleted
		, mail.receiver_deleted
		, contact_info.city
		, contact_info.state
		, personal_info.age
		, pictures.photo_1
		, @@CurrentSearchUniqueId AS 'search_unique_id'
	from mail
	, contact_info
	, personal_info
	, state
	, pictures
	where @MailId = mail.mail_id
	and state.value = contact_info.state
	and contact_info.user_name = mail.sent_from
	and personal_info.user_name = mail.sent_from
	and mail.sent_from = @UserName
	and pictures.user_name = mail.sent_from

	print 'Retrieving data mail message from mail table'
	select mail.mail_id
		, mail.sent_to
		, mail.sent_from
		, mail.subject
		, mail.message_text
		, mail.when_sent
		, mail.when_read
		, mail.sender_deleted
		, mail.receiver_deleted
		, contact_info.city
		, state.choice as "state"
		, personal_info.age
		, pictures.photo_1
		, @@CurrentSearchUniqueId AS 'search_unique_id'
	from mail
	, contact_info
	, personal_info
	, state
	, pictures
	where @MailId = mail.mail_id
	and state.value = contact_info.state
	and contact_info.user_name = mail.sent_from
	and personal_info.user_name = mail.sent_from
	and mail.sent_from = @UserName
	and pictures.user_name = mail.sent_from

return 0
END
else
BEGIN
	-- If the user_name does not exist exit with a return value of 666 
	print 'ERROR: User Name and Password did not match.'
	return 666
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [simpleSearch]
 @Search int
, @IAm char(1)
, @Seeking char(1)
, @City varchar(32)
, @State varchar(2)
, @Country varchar(3)
, @MinAgeDesired varchar(2)
, @MaxAgeDesired varchar(2)
, @Limit int
, @Sort varchar(16)
, @Index varchar(6)
, @UserName VARCHAR(32)

 AS

-- Keep track of table usage...
DECLARE @DatabaseName VARCHAR(32)
SELECT @DatabaseName = DB_NAME()

-- Only allow simple search on Persian_Connecitons...
IF(@DatabaseName != 'Persian_Connections' 
	AND @DatabaseName != 'Test_Connections'
	AND @DatabaseName != 'Israeli_Connections'
	)
	BEGIN
		-- START Verify Permissions
		DECLARE @@ReturnValue char(4)
		
		EXEC @@ReturnValue = verifyMembershipTypePermissions  @UserName, 'allow_search_simple'
		-- Check membership_type for permission
		if ( @@ReturnValue != 1	)
			BEGIN--  DENIED
				print 'You must upgrade your membership to use this feature'
				return @@ReturnValue
			END
		-- END Verify Permissions
	END

-- used to hold table_access_log unique_id
DECLARE @@CurrentSearchUniqueId	INT

--IF(@UserName = '')
--	BEGIN
		EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName		-- database_name                         
								, 'SimpleSearchQuery'		-- page_name                             
								, NULL				-- user_name                             
								, @IAm				-- sex                                   
								, @Seeking			-- used to determine sex_preference      
								, @City				-- city                                  
								, @State			-- state                                 
								, @Country			-- country                               
								, NULL				-- profession                            
								, NULL				-- income                                
								, NULL				-- educaiton                             
								, NULL 				-- religion                              
								, @MinAgeDesired		-- min_age_desired                       
								, @MaxAgeDesired		-- max_age_desired                       
--	END
--ELSE
--	BEGIN
--		EXEC Advertising_Test.dbo.adv_InsertTableUsage @DatabaseName, 'SimpleSearch', @UserName
--	END
	-- retrieve current unique_id from table_access_log...
	SELECT @@CurrentSearchUniqueId = @@identity

-- the SET string provides a slight performance gain for stored procedures
SET NOCOUNT ON

declare @GlobalRowCount INT
SELECT @GlobalRowCount = 500;

DECLARE @AlternativeMin	INT		-- Used as lower bound for sex_preference searches
DECLARE @AlternativeMax 	INT		-- Used as upper bound for sex_preference searches

-- Determine what sexual preference search needs to be performed...
IF (@IAm = @Seeking AND @IAm > "0")
BEGIN
	-- Same sex search...
	PRINT 'same sex search'
	SELECT @AlternativeMin = 2
	SELECT @AlternativeMax = 4
END
ELSE
	BEGIN
		-- Opposite sex search...
		PRINT 'opposite sex search'
		SELECT @AlternativeMin = 0
		SELECT @AlternativeMax = 1
	END

-- Check for city variable...
IF (@City = "")
BEGIN
	-- If no city has been entered then default to the match any string wildcard...
	SELECT @City = '%'
	PRINT 'City = ' + @City
END

-- Check for city variable...
IF (@State = "0")
BEGIN
	-- If no state has been entered then default to the match any string wildcard...
	SELECT @State = '%'
	PRINT 'State = ' + @State
END

-- Check for country variable...
IF (@Country = "0")
BEGIN
	-- If no country has been entered then default to the match any string wildcard...
	SELECT @Country = '%'
	PRINT 'Country = ' + @Country
END

-- Determin how the user whats the results ordered...
DECLARE @OrderBy CHAR(32) 	-- Holds the order by clause condition
IF( @Sort = 'user_name' )
	BEGIN
		SELECT @OrderBy = 'contact_info.user_name'
	END
ELSE
	IF( @Sort = 'state' )
		BEGIN
			SELECT @OrderBy = 'contact_info.state'
		END
	ELSE
		IF( @Sort = 'age' )
		BEGIN
			SELECT @OrderBy = 'personal_info.age'
		END
		ELSE
			IF( @Sort = 'creation_date' )
			BEGIN
				SELECT @OrderBy = 'login_info.creation_date DESC'
			END

PRINT 'Order by ' + @OrderBy

-- the SET ROWCOUNT limits the number of rows affected
SET ROWCOUNT @GlobalRowCount

/* Select the raw information by joining just the personal_info and relationship tables... */
SELECT CASE 
		WHEN COUNT(*) >= @GlobalRowCount THEN @GlobalRowCount
		ELSE COUNT(*)
	END 'Number of Rows'
	, @@CurrentSearchUniqueId AS 'search_unique_id'
	FROM login_info
		, contact_info
		, personal_info
		, about_info
	WHERE login_info.sex like @Seeking
	AND login_info.photo_submitted >= @Search
	AND personal_info.sex_preference >= @AlternativeMin
	AND personal_info.sex_preference <= @AlternativeMax
	AND contact_info.city like @City
	AND contact_info.state like @State
	AND contact_info.country like @Country
	AND personal_info.age >= @MinAgeDesired
	AND personal_info.age <= @MaxAgeDesired
	AND about_info.questionable = 0
	AND login_info.user_name = contact_info.user_name
	AND login_info.user_name = personal_info.user_name
	AND login_info.user_name = about_info.user_name

DECLARE @RowCount	INT -- Used to set the rowcount based on index and limit
SELECT @RowCount = ( @Index + @Limit + 2 )

SET ROWCOUNT @RowCount

-- Select the all the information by joining the tables... 
EXEC ('SELECT login_info.user_name as "user_name"
	, contact_info.city as "city"
	, state.choice as "state"
	, country.choice as "country"
	, personal_info.age as "age"
	, about_info.screen_quote as "screen_quote"
	, about_info.about_yourself as "about_yourself"
	, pictures.photo_1 as "pic 1"

FROM login_info
	, contact_info
	, personal_info
	, about_info
	, state
	, country
	, pictures
WHERE login_info.user_name = contact_info.user_name
	AND login_info.user_name = personal_info.user_name
	AND login_info.user_name = about_info.user_name
	AND login_info.user_name = pictures.user_name
	AND contact_info.state = state.value
	AND contact_info.country = country.value
	AND login_info.user_name in 
	(
	SELECT login_info.user_name

		FROM login_info
			, contact_info
			, personal_info
			, about_info
		WHERE login_info.sex LIKE ''' + @Seeking +'''
		AND login_info.photo_submitted >= '''+ @Search + '''
		AND personal_info.sex_preference >= ''' + @AlternativeMin + '''
		AND personal_info.sex_preference <= ''' + @AlternativeMax + '''
		AND contact_info.city LIKE ''' + @City + '''
		AND contact_info.state LIKE ''' + @State + '''
		AND contact_info.country LIKE ''' + @Country + '''
		AND personal_info.age >= ''' + @MinAgeDesired + '''
		AND personal_info.age <= ''' + @MaxAgeDesired + '''
		AND about_info.questionable = 0
		AND login_info.user_name = contact_info.user_name
		AND login_info.user_name = personal_info.user_name
		AND login_info.user_name = about_info.user_name
	)

ORDER BY ' + @OrderBy
)

SET ROWCOUNT 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [singleProfile]
@UserNameBeingSearched varchar(32)
, @UserNameSearching varchar(32)

 AS

-- START Verify Permissions
DECLARE @@ReturnValue SMALLINT
DECLARE @@ViewMyOwnProfile char(2)

-- Used to keep track of table usage...
DECLARE @DatabaseName VARCHAR(32)
SELECT @DatabaseName = DB_NAME()
-- used to hold table_access_log unique_id
DECLARE @@CurrentSearchUniqueId	INT

IF(@UserNameBeingSearched = @UserNameSearching )
	BEGIN
		SELECT @@ViewMyOwnProfile = '1'
	END
ELSE
	BEGIN
		SELECT @@ViewMyOwnProfile = '0'
	END

IF(@UserNameBeingSearched = 'administrator' OR @@ViewMyOwnProfile = '1')
	BEGIN
		-- Keep track of table usage...
		EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'ViewOwnProfile', @UserNameSearching
		-- retrieve current unique_id from table_access_log...
		SELECT @@CurrentSearchUniqueId = @@identity

		/* Select the raw information by joining just the personal_info and relationship tables... */
		print 'select all the info to generate the single profile information'
		select login_info.user_id as "user_id"
			, login_info.user_name as "user_name"
			, login_info.membership_type as "membership_type"
			, sex.choice as "sex"
			, login_info.creation_date as "creation_date"
			, login_info.last_login as "last_login"
			, contact_info.city as "city"
			, state.choice as "state"
			, country.choice as "country"
			, sex_preference.choice as "sex_preference"
			, personal_info.age as "age"
			, marital_status.choice as "marital_status"
			, profession.choice as "profession"
			, income.choice as "income"
			, education.choice as "education"
			, religion.choice as "religion"
			, height.choice as "height"
			, weight.choice  as "weight"
			, eyes.choice as "eyes"
			, hair.choice as "hair"
			, personal_info.min_age_desired
			, personal_info.max_age_desired
			, cook.choice as "cook"
			, smoke.choice as "smoke"
			, drink.choice as "drink"
			, party.choice as "party"
			, political.choice as "political"
			, housing_status.choice as "housing_status"
			, relationship.prefer_not_to_say as "prefer_not_to_say"
			, relationship.any_relationship as "any_relationship"
			, relationship.hang_out as "hang_out"
			, relationship.short_term as "short_term"
			, relationship.long_term as "long_term"
			, relationship.talk_email as "talk_email"
			, relationship.photo_exchange as "photo_exchange"
			, relationship.marriage as "marriage"
			, relationship.other as "other"
			, about_info.screen_quote as "screen_quote"
			, about_info.about_yourself as "about_yourself"
			, pictures.photo_1 as "pic 1"
			, pictures.photo_2 as "pic 2"
			, pictures.photo_3 as "pic 3"
			, pictures.photo_4 as "pic 4"
			, pictures.photo_5 as "pic 5"
			, @@CurrentSearchUniqueId AS 'search_unique_id'
		from login_info
			, contact_info
			, personal_info
			, relationship
			, about_info
			, sex_preference
			, marital_status
			, profession
			, income
			, education
			, religion
			, height
			, weight
			, eyes
			, hair
			, cook
			, smoke
			, drink
			, party
			, political
			, housing_status
			, sex
			, state
			, country
			, pictures
		where login_info.user_name = contact_info.user_name
			and login_info.user_name = personal_info.user_name
			and login_info.user_name = relationship.user_name
			and login_info.user_name = about_info.user_name
			and login_info.user_name = pictures.user_name
			and login_info.sex = sex.value
			and ( 
				about_info.questionable = 0 
				OR 
				@@ViewMyOwnProfile = '1' 
			         )
			and contact_info.state = state.value
			and contact_info.country = country.value
			and personal_info.sex_preference = sex_preference.value
			and personal_info.marital_status = marital_status.value
			and personal_info.profession = profession.value
			and personal_info.income = income.value
			and personal_info.education = education.value
			and personal_info.religion = religion.value
			and personal_info.height = height.value
			and personal_info.weight = weight.value
			and personal_info.eyes = eyes.value
			and personal_info.hair = hair.value
			and personal_info.cook = cook.value
			and personal_info.smoke = smoke.value
			and personal_info.drink = drink.value
			and personal_info.party = party.value
			and personal_info.political = political.value
			and personal_info.housing_status = housing_status.value
			and personal_info.user_name = @UserNameBeingSearched

		return 1
	END
ELSE
	BEGIN
		EXEC @@ReturnValue = verifyMembershipTypePermissions @UserNameSearching, 'allow_view_profiles'
		-- Check membership_type for permission
		IF ( @@ReturnValue != 1 AND  @@ViewMyOwnProfile = '0' )
			BEGIN--  DENIED
				IF (@@ReturnValue > 699)
					BEGIN
						print 'You must upload a photo to use this feature'
					END
				ELSE
					BEGIN
						print 'You must upgrade your membership to use this feature'
					END
				RETURN @@ReturnValue
			END
		-- END Verify Permissions
		
		-- Check if the UserNameBeingSearched is hidden...
		SELECT @@ReturnValue = (select questionable from about_info where user_name = @UserNameBeingSearched)
		if ( @@ReturnValue = 1 AND @@ViewMyOwnProfile = '0' )
			BEGIN--  DENIED
				print 'The user you are trying to view currently has a hidden profile'
				return 205
			END
		
		-- Keep track of table usage...
		EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'ViewSingleProfile', @UserNameSearching
		-- retrieve current unique_id from table_access_log...
		SELECT @@CurrentSearchUniqueId = @@identity

		/* Select the raw information by joining just the personal_info and relationship tables... */
		print 'select all the info to generate the single profile information'
		select login_info.user_id as "user_id"
			, login_info.user_name as "user_name"
			, login_info.membership_type as "membership_type"
			, sex.choice as "sex"
			, login_info.creation_date as "creation_date"
			, login_info.last_login as "last_login"
			, contact_info.city as "city"
			, state.choice as "state"
			, country.choice as "country"
			, sex_preference.choice as "sex_preference"
			, personal_info.age as "age"
			, marital_status.choice as "marital_status"
			, profession.choice as "profession"
			, income.choice as "income"
			, education.choice as "education"
			, religion.choice as "religion"
			, height.choice as "height"
			, weight.choice  as "weight"
			, eyes.choice as "eyes"
			, hair.choice as "hair"
			, personal_info.min_age_desired
			, personal_info.max_age_desired
			, cook.choice as "cook"
			, smoke.choice as "smoke"
			, drink.choice as "drink"
			, party.choice as "party"
			, political.choice as "political"
			, housing_status.choice as "housing_status"
			, relationship.prefer_not_to_say as "prefer_not_to_say"
			, relationship.any_relationship as "any_relationship"
			, relationship.hang_out as "hang_out"
			, relationship.short_term as "short_term"
			, relationship.long_term as "long_term"
			, relationship.talk_email as "talk_email"
			, relationship.photo_exchange as "photo_exchange"
			, relationship.marriage as "marriage"
			, relationship.other as "other"
			, about_info.screen_quote as "screen_quote"
			, about_info.about_yourself as "about_yourself"
			, pictures.photo_1 as "pic 1"
			, pictures.photo_2 as "pic 2"
			, pictures.photo_3 as "pic 3"
			, pictures.photo_4 as "pic 4"
			, pictures.photo_5 as "pic 5"
			, @@CurrentSearchUniqueId AS 'search_unique_id'
		from login_info
			, contact_info
			, personal_info
			, relationship
			, about_info
			, sex_preference
			, marital_status
			, profession
			, income
			, education
			, religion
			, height
			, weight
			, eyes
			, hair
			, cook
			, smoke
			, drink
			, party
			, political
			, housing_status
			, sex
			, state
			, country
			, pictures
		where login_info.user_name = contact_info.user_name
			and login_info.user_name = personal_info.user_name
			and login_info.user_name = relationship.user_name
			and login_info.user_name = about_info.user_name
			and login_info.user_name = pictures.user_name
			and login_info.sex = sex.value
			and ( 
				about_info.questionable = 0 
				OR 
				@@ViewMyOwnProfile = '1' 
			         )
			and contact_info.state = state.value
			and contact_info.country = country.value
			and personal_info.sex_preference = sex_preference.value
			and personal_info.marital_status = marital_status.value
			and personal_info.profession = profession.value
			and personal_info.income = income.value
			and personal_info.education = education.value
			and personal_info.religion = religion.value
			and personal_info.height = height.value
			and personal_info.weight = weight.value
			and personal_info.eyes = eyes.value
			and personal_info.hair = hair.value
			and personal_info.cook = cook.value
			and personal_info.smoke = smoke.value
			and personal_info.drink = drink.value
			and personal_info.party = party.value
			and personal_info.political = political.value
			and personal_info.housing_status = housing_status.value
			and personal_info.user_name = @UserNameBeingSearched
		
		return 1
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE [transaction_credit_card_receive]
@TransactionID		CHAR(52)
, @XResponseCode		CHAR(1)
, @XCVV2RespCode		CHAR(1)
, @XResponseSubcode	CHAR(6)
, @XResponseReasonCode	CHAR(2)
, @XResponseReasonText	VARCHAR(320)
, @XAuthCode			CHAR(8)
, @XAvsCode			CHAR(1)
, @XTransID			CHAR(9)
, @XMd5Hash			VARCHAR(50)

 AS

-- Declare and initialize variables from the existing transaction in the transactions_log...
DECLARE @@UserName		VARCHAR(32)
DECLARE @@TransactionType	VARCHAR(18)
DECLARE @@CardType		CHAR(1)
DECLARE @@NameOnCard		VARCHAR(64)
DECLARE @@CVV2Code		VARCHAR(4)
DECLARE @@AccountNumber		VARCHAR(32)
DECLARE @@ExpirationMonth		CHAR(2)
DECLARE @@ExpirationYear		CHAR(4)
DECLARE @@BankABACode		VARCHAR(9)
DECLARE @@BankAccountNumber	VARCHAR(32)
DECLARE @@BankAccountType	VARCHAR(9)
DECLARE @@BankName		VARCHAR(51)
DECLARE @@NameOnBankAccount	VARCHAR(64)
DECLARE @@EcheckType		VARCHAR(8)
DECLARE @@RebillingAmount	SMALLMONEY
DECLARE @@PlanUniqueId		VARCHAR(38)
DECLARE @@StreetAddress		VARCHAR(96)
DECLARE @@City			VARCHAR(32)
DECLARE @@State			VARCHAR(32)
DECLARE @@Zip			VARCHAR(20)
DECLARE @@Country			VARCHAR(32)
DECLARE @@Telephone		VARCHAR(28)
DECLARE @@DateOfThisTransaction	DATETIME
DECLARE @@DateOfNextTransaction	DATETIME
DECLARE @@XMethod		VARCHAR(18)

DECLARE @membership_type_id	TINYINT
DECLARE @can_membership_recur	CHAR(1)

SELECT @@UserName		= (SELECT user_name			from transactions_log WHERE transaction_id = @TransactionID)
	, @@TransactionType		= (SELECT transaction_type		from transactions_log WHERE transaction_id = @TransactionID)
	, @@CardType			= (SELECT card_type			from transactions_log WHERE transaction_id = @TransactionID)
	, @@NameOnCard		= (SELECT name_on_card		from transactions_log WHERE transaction_id = @TransactionID)
	, @@CVV2Code		= (SELECT cvv2_code			from transactions_log WHERE transaction_id = @TransactionID)
	, @@AccountNumber		= (SELECT account_number		from transactions_log WHERE transaction_id = @TransactionID)
	, @@ExpirationMonth		= (SELECT expiration_month		from transactions_log WHERE transaction_id = @TransactionID)
	, @@ExpirationYear		= (SELECT expiration_year		from transactions_log WHERE transaction_id = @TransactionID)
	, @@BankABACode		= (SELECT bank_ABA_code		from transactions_log WHERE transaction_id = @TransactionID)
	, @@BankAccountNumber	= (SELECT bank_account_number	from transactions_log WHERE transaction_id = @TransactionID)
	, @@BankAccountType	= (SELECT bank_account_type		from transactions_log WHERE transaction_id = @TransactionID)
	, @@BankName		= (SELECT bank_name			from transactions_log WHERE transaction_id = @TransactionID)
	, @@NameOnBankAccount	= (SELECT bank_account_name	from transactions_log WHERE transaction_id = @TransactionID)
	, @@EcheckType		= (SELECT echeck_type		from transactions_log WHERE transaction_id = @TransactionID)
	, @@RebillingAmount		= (SELECT rebilling_amount		from transactions_log WHERE transaction_id = @TransactionID)
	, @@PlanUniqueId		= (SELECT plan_unique_id		from transactions_log WHERE transaction_id = @TransactionID)
	, @@StreetAddress		= (SELECT street_address		from transactions_log WHERE transaction_id = @TransactionID)
	, @@City			= (SELECT city				from transactions_log WHERE transaction_id = @TransactionID)
	, @@State			= (SELECT state			from transactions_log WHERE transaction_id = @TransactionID)
	, @@Zip			= (SELECT zip				from transactions_log WHERE transaction_id = @TransactionID)
	, @@Country			= (SELECT country			from transactions_log WHERE transaction_id = @TransactionID)
	, @@Telephone		= (SELECT telephone			from transactions_log WHERE transaction_id = @TransactionID)
	, @@DateOfThisTransaction	= (SELECT date_of_this_transaction	from transactions_log WHERE transaction_id = @TransactionID)
	, @@DateOfNextTransaction	= (SELECT date_of_next_transaction	from transactions_log WHERE transaction_id = @TransactionID)
	, @@XMethod			= (SELECT x_method			from transactions_log WHERE transaction_id = @TransactionID)

SELECT @membership_type_id	= (SELECT membership_type_id	from membership_type WHERE CONVERT(VARCHAR(38), unique_id) = @@PlanUniqueId)
	, @can_membership_recur	= (SELECT can_membership_recur	from membership_type WHERE CONVERT(VARCHAR(38), unique_id) = @@PlanUniqueId)

	PRINT 'PlanUniqueId = (' + @@PlanUniqueId + ')'
--	PRINT 'membership_type_id = (' + convert(varchar(4), @membership_type_id) + ')'
--	PRINT 'RebillingAmount = (' + CONVERT(VARCHAR(8), @@RebillingAmount) + ')'
--	PRINT 'can_membership_recur = (' + @can_membership_recur + ')'
--	PRINT 'State = (' + @@State + ')'

-- update the transactions_log table with the fields returned from Authorize.Net
UPDATE transactions_log 
	SET x_response_code  	= @XResponseCode
	        , x_cvv2_resp_code		= @XCVV2RespCode
	        , x_response_subcode	= @XResponseSubcode
	        , x_response_reason_code	= @XResponseReasonCode
	        , x_response_reason_text	= @XResponseReasonText
	        , x_auth_code 		= @XAuthCode
	        , x_avs_code 		= @XAvsCode
	        , x_trans_id 			= @XTransID
	        , x_md5_hash 		= @XMd5Hash
	WHERE transaction_id = @TransactionID

-- If @XResponseCode = 1 update the membership type to 1 only if this is not a CREDIT or VOID
IF (
	@XResponseCode = '1'
	AND @@TransactionType != 'CREDIT' 
	AND @@TransactionType != 'VOID'
   )-- VOID not currently supported!!!
	BEGIN
		IF( (SELECT date_started_paying FROM login_info where user_name = @@UserName) = NULL)
			BEGIN
				-- update login_info table to reflect the successful transaction
				UPDATE login_info 
					SET membership_type 	= @membership_type_id
						, date_started_paying =  (SELECT date_of_this_transaction from transactions_log WHERE transaction_id = @TransactionID)
					WHERE user_name = @@UserName
			END
		ELSE
			BEGIN
				-- update login_info table to reflect the successful transaction
				UPDATE login_info 
					SET membership_type 	= @membership_type_id
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
								, cvv2_code = @@CVV2Code
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
							set bank_ABA_code 			= @@BankABACode
								, bank_account_number 	= @@BankAccountNumber
								, bank_account_type		= @@BankAccountType
								, bank_name			= @@BankName
								, name_on_bank_account	= @@NameOnBankAccount
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
						, cvv2_code
						, account_number
						, expiration_month
						, expiration_year
						, is_membership_active
						, date_membership_expires
						, bank_ABA_code
						, bank_account_number
						, bank_account_type
						, bank_name
						, name_on_bank_account
						) 
				values (@@UserName
					, @@CardType
					, @@NameOnCard
					, @@CVV2Code
					, @@AccountNumber
					, @@ExpirationMonth
					, @@ExpirationYear
					, '1'
					, @@DateOfNextTransaction
					, @@BankABACode
					, @@BankAccountNumber
					, @@BankAccountType
					, @@BankName
					, @@NameOnBankAccount
					)
			END

---------------------------------------
-- recurring_transactions
---------------------------------------
		if (@can_membership_recur = '1')
			BEGIN
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
									, transaction_type 		= @@TransactionType
									, date_of_this_transaction 	= @@DateOfThisTransaction
									, date_of_next_transaction	= @@DateOfNextTransaction
									, card_type 			= @@CardType
									, cvv2_code 			= @@CVV2Code
									, account_number 		= @@AccountNumber
									, name_on_card 		= @@NameOnCard
									, expiration_month 		= @@ExpirationMonth
									, expiration_year 		= @@ExpirationYear
									, x_method 			= @@XMethod
									, bank_ABA_code 		= @@BankABACode
									, bank_account_number 	= @@BankAccountNumber
									, bank_account_type		= @@BankAccountType     
									, bank_name	   		= @@BankName		
									, name_on_bank_account	= @@NameOnBankAccount	
									, echeck_type	   		= @@EcheckType		
									, rebilling_amount   		= @@RebillingAmount	
									, plan_unique_id   		= @@PlanUniqueId
									, street_address   		= @@StreetAddress	
									, city		   		= @@City		
									, state		   		= @@State		
									, zip		   		= @@Zip			
									, country	   		= @@Country		
									, telephone	   		= @@Telephone	
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
									, cvv2_code
									, account_number
									, expiration_month
									, expiration_year
									, x_method
									, bank_ABA_code
									, bank_account_number
									, bank_account_type
									, bank_name
									, name_on_bank_account
									, echeck_type
									, rebilling_amount
									, plan_unique_id
									, street_address
									, city
									, state
									, zip
									, country
									, telephone
									) 
							values (@@UserName
								, '1' -- 1 = this is ok to process
								, @@TransactionType
								, @@DateOfThisTransaction
								, @@DateOfNextTransaction
								, @@CardType
								, @@NameOnCard
								, @@CVV2Code
								, @@AccountNumber
								, @@ExpirationMonth
								, @@ExpirationYear
								, @@XMethod
								, @@BankABACode
								, @@BankAccountNumber
								, @@BankAccountType
								, @@BankName			
								, @@NameOnBankAccount		
								, @@EcheckType			
								, @@RebillingAmount
								, @@PlanUniqueId		
								, @@StreetAddress		
								, @@City			
								, @@State			
								, @@Zip				
								, @@Country		
								, @@Telephone		
								)
				END
			END
		PRINT 'login_info and billing_info were updated:   x_response_code = (' + @XResponseCode + ')'

		-- check to make sure the affiliate_tracking_id has alredy been set to a valid value (CreateLogin.exe sets it for new profiles)...
		IF( (SELECT DATALENGTH(affiliate_tracking_id) FROM login_info WHERE user_name = @@UserName)  > 10) 
			BEGIN
				-- get the existing affiliate_aciton_status...
				DECLARE @affiliate_tracking_id		VARCHAR(44)
						, @affiliate_action_status 	SMALLINT

				SELECT @affiliate_tracking_id = 	(
										SELECT affiliate_tracking_id
										FROM login_info
										WHERE user_name = @@UserName
									)
				SELECT @affiliate_action_status = 	(
										SELECT affiliate_action_status
										FROM login_info
										WHERE user_name = @@UserName
									)

					DECLARE @months_joined	VARCHAR(3)
						, @amount 		SMALLMONEY
						, @db_name 		SYSNAME
						, @plan_unique_id	INT

					SELECT @db_name = DB_NAME()

					SELECT @months_joined = 	(
										SELECT months_joined
										FROM transactions_log
										WHERE transaction_id = @TransactionID
									)
					
					SELECT @amount = 	(
									SELECT amount
									FROM transactions_log
									WHERE transaction_id = @TransactionID
								)
					
					SELECT @plan_unique_id =(
									CASE
										WHEN @db_name = 'Bible_Match' 			THEN 	(
																		CASE
																			WHEN @months_joined = '1' 	THEN -1	--     1 Month
																			WHEN @months_joined = '3' 	THEN -1	--     3 Month
																			WHEN @months_joined = '6' 	THEN -1	--     6 Month
																			WHEN @months_joined = '12' 	THEN -1	--   12 Month
																			WHEN @months_joined = '240'	THEN -1	-- 240 Month
																			ELSE -1
																		END
																	)
					
										WHEN @db_name = 'Gay_Love_Match' 		THEN 	(
																		CASE
																			WHEN @months_joined = '1' 	THEN -1	--     1 Month
																			WHEN @months_joined = '3' 	THEN -1	--     3 Month
																			WHEN @months_joined = '6' 	THEN -1	--     6 Month
																			WHEN @months_joined = '12' 	THEN -1	--   12 Month
																			WHEN @months_joined = '240'	THEN -1	-- 240 Month
																			ELSE -1
																		END
																	)
					
										WHEN @db_name = 'Israeli_Connections' 		THEN 	(
																		CASE
																			WHEN @months_joined = '1' 	THEN 10451	--     1 Month
																			WHEN @months_joined = '3' 	THEN 10470	--     3 Month
																			WHEN @months_joined = '6' 	THEN 10489	--     6 Month
																			WHEN @months_joined = '12' 	THEN 10508	--   12 Month
																			WHEN @months_joined = '240'	THEN 10527	-- 240 Month
																			ELSE -1
																		END
																	)
					
										WHEN @db_name = 'Manhattan_Connections' 	THEN 	(
																		CASE
																			WHEN @months_joined = '1' 	THEN 10166	--     1 Month
																			WHEN @months_joined = '3' 	THEN 10185	--     3 Month
																			WHEN @months_joined = '6' 	THEN 10204 	--     6 Month
																			WHEN @months_joined = '12' 	THEN 10223	--   12 Month
																			WHEN @months_joined = '240'	THEN 10242	-- 240 Month
																			ELSE -1
																		END
																	)
					
										WHEN @db_name = 'Persian_Connections' 		THEN	(
																		CASE
																			WHEN @months_joined = '1' 	THEN 10033	--     1 Month
																			WHEN @months_joined = '3' 	THEN 10052	--     3 Month
																			WHEN @months_joined = '6' 	THEN 10071	--     6 Month
																			WHEN @months_joined = '12' 	THEN 10090	--   12 Month
																			WHEN @months_joined = '240'	THEN 10109	-- 240 Month
																			ELSE -1
																		END
																	)
					
										WHEN @db_name = 'Personals_Connections' 	THEN	(
																		CASE
																			WHEN @months_joined = '1' 	THEN -1	--     1 Month
																			WHEN @months_joined = '3' 	THEN -1	--     3 Month
																			WHEN @months_joined = '6' 	THEN -1	--     6 Month
																			WHEN @months_joined = '12' 	THEN -1	--   12 Month
																			WHEN @months_joined = '240'	THEN -1	-- 240 Month
																			ELSE -1
																		END
																	)
					
										WHEN @db_name = 'Test_Connections' 		THEN 	(
																		CASE
																			WHEN @months_joined = '1' 	THEN -1	--     1 Month
																			WHEN @months_joined = '3' 	THEN -1	--     3 Month
																			WHEN @months_joined = '6' 	THEN -1 	--     6 Month
																			WHEN @months_joined = '12' 	THEN -1	--   12 Month
																			WHEN @months_joined = '240'	THEN -1	-- 240 Month
																			ELSE -1
																		END
																	)
										WHEN @db_name = 'UK_Love_Match' 		THEN 	(
																		CASE
																			WHEN @months_joined = '1' 	THEN 10546	--     1 Month
																			WHEN @months_joined = '3' 	THEN 10565	--     3 Month
																			WHEN @months_joined = '6' 	THEN 10584	--     6 Month
																			WHEN @months_joined = '12' 	THEN 10603	--   12 Month
																			WHEN @months_joined = '240'	THEN 10622	-- 240 Month
																			ELSE -1
																		END
																	)
					
										ELSE -1
									END
								)
					PRINT 'plan_unique_id = (' + CONVERT(VARCHAR(6), @plan_unique_id) + ')'

				-- make sure the existing affiliate_action_status < 1... 	0 = No Action | -1 = Action Failed | <= 1 = Action Success
				IF(@affiliate_action_status > 0)
					BEGIN
						PRINT 'PASSED -- Action 2 -- credit the publisher'
						UPDATE login_info
							SET affiliate_action_status = 2
							WHERE user_name = @@UserName
			
						SELECT @affiliate_tracking_id	AS 'affiliate_tracking_id'
							, @plan_unique_id	AS 'plan_unique_id'
							, @amount		AS 'transaction_amount'
					END
				ELSE
					BEGIN
						PRINT 'affiliate_action_status indicates action previously completed or plan_unique_id (' + @plan_unique_id + ') is invalid.'
					END
			END
		ELSE
			BEGIN
				PRINT 'No ckuid found for this user'
			END

	END -- END If @XResponseCode = 1 and not (CREDIT and VOID)
ELSE
	BEGIN	-- If @XResponseCode = 1 and transaction_type = CREDIT or VOID update the membership type to 0 to cancel the user's membership
		IF (
			@XResponseCode = '1'
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
								, cvv2_code
								, account_number
								, expiration_month
								, expiration_year
								, is_membership_active
								, date_membership_expires
								, bank_ABA_code
								, bank_account_number
								, bank_account_type
								, bank_name
								, name_on_bank_account
								) 
						values (@@UserName
							, @@CardType
							, @@NameOnCard
							, @@CVV2Code
							, @@AccountNumber
							, @@ExpirationMonth
							, @@ExpirationYear
							, '0'
							, @@DateOfNextTransaction
							, @@BankABACode
							, @@BankAccountNumber
							, @@BankAccountType
							, @@BankName
							, @@NameOnBankAccount
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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE [transaction_credit_card_send]
@TransactionID 		CHAR(52)
, @BatchTransactionID 		VARCHAR(60)
, @UserName			VARCHAR(32)
, @XCustomerIP		VARCHAR(15)
, @MonthsJoined		VARCHAR(3)
, @Amount			VARCHAR(8)
, @RebillingAmount		VARCHAR(8)
, @PlanUniqueId		VARCHAR(38)
, @NameOnCard		VARCHAR(64)
, @CardType			CHAR(1)
, @CVV2Code			CHAR(4)
, @AccountNumber		VARCHAR(32)
, @ExpirationMonth		CHAR(2)
, @ExpirationYear		CHAR(4)
, @TransactionType		VARCHAR(18)
, @XTransID			CHAR(9)
, @XDescription		VARCHAR(256)
, @XMethod			VARCHAR(18)
, @BankABACode		VARCHAR(9)
, @BankAccountNumber	VARCHAR(32)
, @BankAccountType		VARCHAR(9)
, @BankName			VARCHAR(51)
, @BankAccountName		VARCHAR(64)
, @EcheckType		VARCHAR(8)
, @StreetAddress		VARCHAR(96)
, @City				VARCHAR(32)
, @State			VARCHAR(32)
, @Zip				VARCHAR(20)
, @Country			VARCHAR(32)
, @Telephone			VARCHAR(28)
, @x_FP_Hash			VARCHAR(36)

 AS

-- Check email has been verified
if ( (SELECT is_email_verified FROM login_info WHERE user_name = @UserName) = '0' )
	BEGIN--  DENIED
		print 'email address has not been verified'
		return 201
	END
-- END Verify Permissions

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
		SELECT @@DateOfNextTransaction = (select CASE 
								WHEN DATEDIFF(SECOND, duration_start, duration_end) IS NULL THEN DATEADD(MONTH, CONVERT (INT, @MonthsJoined), @@DateOfThisTransaction)
								WHEN DATEDIFF(SECOND, duration_start, duration_end) IS NOT NULL THEN
																 DATEADD(SECOND
																		, DATEDIFF(SECOND, duration_start, duration_end)
																		, GETDATE()
																	)
							END AS 'date_promotion_ended'
		
							FROM membership_type
							WHERE CONVERT(VARCHAR(38), unique_id) = @PlanUniqueId
						)

---------------------------------------
-- transactions_log
---------------------------------------
		PRINT 'Enter new transaction into transactions_log table'
		INSERT INTO transactions_log (transaction_id
				, batch_transaction_id
				, user_id
				, user_name
				, x_customer_IP
				, card_type
				, name_on_card
				, cvv2_code
				, account_number
				, expiration_month
				, expiration_year
				, transaction_type
				, x_response_code
				, months_joined
				, amount
				, rebilling_amount
				, plan_unique_id
				, date_of_this_transaction
				, date_of_next_transaction
				, x_response_reason_text
				, x_trans_id
				, x_description
				, x_method
				, bank_ABA_code
				, bank_account_number
				, bank_account_type
				, bank_name
				, bank_account_name
				, echeck_type
				, street_address
				, city
				, state
				, zip
				, country
				, telephone
				, x_FP_Hash
				) 
		VALUES ( @TransactionID
			, @BatchTransactionID
			, @@UserId
			, @UserName
			, @XCustomerIP
			, @CardType
			, @NameOnCard
			, @CVV2Code
			, @AccountNumber
			, @ExpirationMonth
			, @ExpirationYear
			, @TransactionType
			, '0' -- @XResponseCode
			, @MonthsJoined
			, CONVERT (SMALLMONEY, @Amount)
			, CONVERT (SMALLMONEY, @RebillingAmount)
			, @PlanUniqueId
			, @@DateOfThisTransaction
			, @@DateOfNextTransaction
			, 'ERROR: No Response From Server' -- @XResponseReasonText
			, @XTransID
			, @XDescription
			, @XMethod
			, @BankABACode
			, @BankAccountNumber
			, @BankAccountType
			, @BankName
			, @BankAccountName
			, @EcheckType
			, @StreetAddress
			, @City
			, @State
			, @Zip
			, @Country
			, @Telephone
			, @x_FP_Hash
			)

		-- Determine if the current user has ever used a restricted IP...
		IF EXISTS (SELECT IP_address FROM restricted_IP
				WHERE IP_address IN (SELECT IP_address FROM customer_IP WHERE user_name = @UserName AND user_id = @@UserId)
			     )
			BEGIN
				-- update the transactions_log table with the fields returned from Authorize.Net
				PRINT 'ERROR:  Restricted IP address (' + @UserName + ')'
				UPDATE transactions_log 
					SET x_response_code = '9' -- a value of '9' indicates that the user has used a restricted IP in the past
					WHERE transaction_id = @TransactionID
				RETURN 666
			END
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

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
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

-- Check email has been verified
if ( (SELECT is_email_verified FROM login_info WHERE user_name = @UserName) = '0' )
	BEGIN--  DENIED
		print 'email address has not been verified'
		return 201
	END
-- END Verify Permissions

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
					, @@DateOfNextTransaction
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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE [updateAboutInfo]
@UserName varchar(32)
, @ScreenQuote varchar(128)
, @AboutYourself varchar(3000)
, @Questionable char

 AS

	/* update the about_info table and exit with a return value of 1 */
	
update about_info 
	set user_name =	@UserName
		, screen_quote = @ScreenQuote
		, about_yourself = @AboutYourself
		, questionable = @Questionable
	where user_name = @UserName

return 1



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO


CREATE PROCEDURE [updateBillingInfo]
@UserName		VARCHAR(32)
, @CardType		CHAR(1)
, @NameOnCard	VARCHAR(64)
, @AccountNumber	VARCHAR(32)
, @ExpirationMonth	CHAR(2)
, @ExpirationYear	CHAR(4)
, @Cvv2Code		VARCHAR(4)
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
		, cvv2_code = @Cvv2Code
		, bank_ABA_code = @BankABACode
		, bank_account_number = @BankAccountNumber
	WHERE user_name = @UserName
RETURN 1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO





CREATE PROCEDURE [updateBookMarks]
@UserName char(32)
, @Password char(32)
, @BookMark char(32)
, @AddRemove char(8)

 AS

-- Used to keep track of table usage...
DECLARE @DatabaseName VARCHAR(32)
SELECT @DatabaseName = DB_NAME()

if (@AddRemove = 'Add')
BEGIN
	print 'Add book_mark to book_marks table'
	if exists (select user_name from book_marks where user_name = @UserName AND book_mark = @BookMark)
	BEGIN
		print 'book_mark already exists.'
		return 1
	END
	else
	BEGIN
		print 'book_mark does not exist in book_marks'
			print 'insert user_name and book_mark into the book_marks table'
			insert into book_marks (user_name
					, book_mark
					) 
			values (@UserName
				, @BookMark
				)

		-- Keep track of table usage...
		EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'AddBookMark', @UserName

		return 1
	END
END
else
if (@AddRemove = 'Remove')
BEGIN
	print 'Remove book_mark from book_marks table'
	DELETE book_marks
		WHERE user_name = @UserName
		AND book_mark = @BookMark

		-- Keep track of table usage...
		EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'RemoveBookMark', @UserName
	return 1
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE PROCEDURE [updateContactInfo]
@UserName varchar(32)
, @FirstName varchar(32)
, @LastName varchar(32)
, @StreetAddress varchar(64)
, @City varchar(32)
, @State varchar(4)
, @Country varchar(4)
, @Zip nchar(5)
, @Telephone varchar(16)

 AS
/* If the user_name is unique add the user to the login_info table and exit with a return value of 1 */
update contact_info 
	set first_name = @FirstName
		, last_name = @LastName
		, street_address = @StreetAddress
		, city = @City
		, state = @State
		, country = @Country
		, zip = @Zip
		, telephone = @Telephone

	where user_name = @UserName
return 1



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
, @DateStartedPaying VARCHAR(32) = ''
, @EmailVerificationCode VARCHAR(17) = ''
, @IsEmilVerified VARCHAR(2) = ''
, @WhereDidYouHearAboutUs VARCHAR(128) = ''
, @AdvertisingCampaignCode VARCHAR(32) = ''

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
--			, email = @Email	-- The user is no longer allowed to change their email using this page since 3-30-2002
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
--				, email = @Email	-- The user is no longer allowed to change their email using this page since 3-30-2002
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

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





CREATE PROCEDURE [updatePersonalInfo]
@UserName varchar(32)
, @SexPreference char
, @Age varchar(4)
, @MaritalStatus varchar(2)
, @Professioin varchar(2)
, @Income varchar(2)
, @Educatioin varchar(2)
, @Religioin varchar(2)
, @Height varchar(2)
, @Weight varchar(2)
, @Eyes varchar(2)
, @Hair varchar(2)
, @MinAgeDesired varchar(4)
, @MaxAgeDesired varchar(4)
, @Cook varchar(2)
, @Smoke varchar(2)
, @Drink varchar(2)
, @Party varchar(2)
, @Political varchar(2)
, @HousingStatus varchar(2)
, @PreferNotToSay char
, @AnyRelationship char
, @HangOut char
, @ShortTerm char
, @LongTerm char
, @TalkEmail char
, @PhotoExchange char
, @Marriage char
, @Other char

 AS
/* If the user_name is unique update the relationship table and the personal_info table then exit with a return value of 1 */
print 'update relationship table'
update relationship
	set user_name = @UserName
		, prefer_not_to_say = @PreferNotToSay
		, any_relationship = @AnyRelationship
		, hang_out = @HangOut
		, short_term = @ShortTerm
		, long_term = @LongTerm
		, talk_email = @TalkEmail
		, photo_exchange = @PhotoExchange
		, marriage = @Marriage
		, other = @Other
where user_name = @UserName

print 'update personal_info table'
update personal_info 
	set user_name = @UserName
		, age = @Age
		, sex_preference = @SexPreference
		, marital_status = @MaritalStatus
		, profession = @Professioin
		, income = @Income
		, education = @Educatioin
		, religion = @Religioin
		, height = @Height
		, weight = @Weight
		, eyes = @Eyes
		, hair = @Hair
		, min_age_desired = @MinAgeDesired
		, max_age_desired = @MaxAgeDesired
		, cook = @Cook
		, smoke = @Smoke
		, drink = @Drink
		, party = @Party
		, political = @Political
		, housing_status = @HousingStatus
	where user_name = @UserName
return 1



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO





CREATE PROCEDURE [updatePicture]
@UserName varchar(32)
, @Password varchar(16)
, @PictureNumber int
, @PictureName varchar(32)

 AS

-- Update the pictures table by adding the new picture_name to the existing user
if exists (select user_name from pictures where user_name = @UserName)
BEGIN
	if ( (select password from login_info where user_name = @UserName) = @Password)
	BEGIN
		if(@PictureNumber = 1)
		BEGIN
			print 'update photo_1 in the pictures table'
			update pictures 
				set photo_1 = @PictureName
				where user_name = @UserName
		END
		else if(@PictureNumber = 2)
		BEGIN
			print 'update photo_2 in the pictures table'
			update pictures 
				set photo_2 = @PictureName
				where user_name = @UserName
		END
		else if(@PictureNumber = 3)
		BEGIN
			print 'update photo_3 in the pictures table'
			update pictures 
				set photo_3 = @PictureName
				where user_name = @UserName
		END
		else if(@PictureNumber = 4)
		BEGIN
			print 'update photo_4 in the pictures table'
			update pictures 
				set photo_4 = @PictureName
				where user_name = @UserName
		END
		else if(@PictureNumber = 5)
		BEGIN
			print 'update photo_5 in the pictures table'
			update pictures 
				set photo_5 = @PictureName
				where user_name = @UserName
		END
		print 'update photo_submitted in the login_info table'
		update login_info 
			set photo_submitted = 1
			where user_name = @UserName

		-- Keep track of table usage...
		DECLARE @DatabaseName VARCHAR(32)
		SELECT @DatabaseName = DB_NAME()
		EXEC Advertising.dbo.adv_InsertTableUsage @DatabaseName, 'UpdatePics', @UserName

		return 1
	END
	else
	BEGIN
		print 'user_name & password did not match.'
		return 666
	END

END
-- Insert the user_name and picture_name into the pictures table if the user_name does not already exist
else
BEGIN
	print 'user_name does not exist'
	if(@PictureNumber = 1)
	BEGIN
		print 'insert photo_1 in the pictures table'
		insert into pictures (user_name
				, photo_1
				) 
		values (@UserName
			, @PictureName
			)
	END
	else if(@PictureNumber = 2)
	BEGIN
		print 'insert photo_2 in the pictures table'
		insert into pictures (user_name
				, photo_2
				) 
		values (@UserName
			, @PictureName
			)
	END
	else if(@PictureNumber = 3)
	BEGIN
		print 'insert photo_3 in the pictures table'
		insert into pictures (user_name
				, photo_3
				) 
		values (@UserName
			, @PictureName
			)
	END
	else if(@PictureNumber = 4)
	BEGIN
		print 'insert photo_4 in the pictures table'
		insert into pictures (user_name
				, photo_4
				) 
		values (@UserName
			, @PictureName
			)
	END
	else if(@PictureNumber = 5)
	BEGIN
		print 'insert photo_5 in the pictures table'
		insert into pictures (user_name
				, photo_5
				) 
		values (@UserName
			, @PictureName
			)
	END
	print 'update photo_submitted in the login_info table'
	update login_info 
		set photo_submitted = 1
		where user_name = @UserName
	return 1
END

-- clean up all pictures table entries that no longer have pictures...
UPDATE login_info
SET photo_submitted = '0'
WHERE user_name IN ( SELECT login_info.user_name
 FROM login_info
	, pictures
WHERE pictures.user_name = login_info.user_name
AND pictures.photo_1 = 'Nothing'
AND pictures.photo_2 = 'Nothing'
AND pictures.photo_3 = 'Nothing'
AND pictures.photo_4 = 'Nothing'
AND pictures.photo_5 = 'Nothing'
AND login_info.photo_submitted = '1'
)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE [verifyEmailAddress]
@UserName 			VARCHAR(32)
, @Password 			VARCHAR(16)
, @Email 			VARCHAR(64)
, @EmailVerificationCode 	VARCHAR(20)

 AS

-- Determine if the user_name, email, password and email_verification_code match before validating email address...
IF ( (SELECT password FROM login_info WHERE user_name = @UserName AND email = @Email AND email_verification_code = @EmailVerificationCode) = @Password)
	BEGIN
		-- Update email in login_info table
		PRINT 'Updating email_verification_code for user (' + @UserName + ')'
		UPDATE login_info 
			SET is_email_verified = '1'
			WHERE user_name = @UserName
				AND password = @Password
				AND email = @Email
				AND email_verification_code = @EmailVerificationCode

			-- check to make sure the affiliate_tracking_id has alredy been set to a valid value (CreateLogin.exe sets it for new profiles)...
			IF( (SELECT DATALENGTH(affiliate_tracking_id) FROM login_info WHERE user_name = @UserName)  > 10) 
				BEGIN
					-- get the existing affiliate_aciton_status...
					DECLARE @affiliate_tracking_id		VARCHAR(44)
							, @affiliate_action_status 	SMALLINT
					SELECT @affiliate_tracking_id = 	(
											SELECT affiliate_tracking_id
											FROM login_info
											WHERE user_name = @UserName
										)
					SELECT @affiliate_action_status = 	(
											SELECT affiliate_action_status
											FROM login_info
											WHERE user_name = @UserName
										)

						DECLARE @score 		TINYINT
							, @db_name 		SYSNAME
							, @plan_unique_id	INT
							, @gender		CHAR	

						SELECT @db_name = DB_NAME()

						SELECT @gender = 	(
										SELECT sex
										FROM login_info
										WHERE user_name = @UserName
									)
						
						SELECT @plan_unique_id =(
										CASE
											WHEN @db_name = 'Bible_Match' 			THEN 	(
																			CASE
																				WHEN @gender = '1' THEN 10356	-- Male
																				WHEN @gender = '2' THEN 10337	-- Female
																				ELSE -1
																			END
																		)
						
											WHEN @db_name = 'Gay_Love_Match' 		THEN 	(
																			CASE
																				WHEN @gender = '1' THEN 10432	-- Male
																				WHEN @gender = '2' THEN 10413	-- Female
																				ELSE -1
																			END
																		)
						
											WHEN @db_name = 'Israeli_Connections' 		THEN 	(
																			CASE
																				WHEN @gender = '1' THEN 10318	-- Male
																				WHEN @gender = '2' THEN 10299	-- Female
																				ELSE -1
																			END
																		)
						
											WHEN @db_name = 'Manhattan_Connections' 	THEN 	(
																			CASE
																				WHEN @gender = '1' THEN 10280	-- Male
																				WHEN @gender = '2' THEN 10261	-- Female
																				ELSE -1
																			END
																		)
						
											WHEN @db_name = 'Persian_Connections' 		THEN	(
																			CASE
																				WHEN @gender = '1' THEN 10147	-- Male
																				WHEN @gender = '2' THEN 10128	-- Female
																				ELSE -1
																			END
																		)
						
											WHEN @db_name = 'Personals_Connections' 	THEN	(
																			CASE
																				WHEN @gender = '1' THEN 0	-- Male
																				WHEN @gender = '2' THEN 0	-- Female
																				ELSE -1
																			END
																		)
						
											WHEN @db_name = 'Test_Connections' 		THEN 	(
																			CASE
																				WHEN @gender = '1' THEN 10147	-- Male
																				WHEN @gender = '2' THEN 10128	-- Female
																				ELSE -1
																			END
																		)
											WHEN @db_name = 'UK_Love_Match' 		THEN 	(
																			CASE
																				WHEN @gender = '1' THEN 10394	-- Male
																				WHEN @gender = '2' THEN 10375	-- Female
																				ELSE -1
																			END
																		)
						
											ELSE -1
										END
									)
						PRINT 'plan_unique_id = (' + CONVERT(VARCHAR(6), @plan_unique_id) + ')'

					-- make sure the existing affiliate_action_status < 1... 	0 = No Action | -1 = Action Failed | <= 1 = Action Success
					IF(@affiliate_action_status < 1 AND @plan_unique_id != -1)
						BEGIN
							-- execute the funciton to determine the current status of the member's profile...
							EXEC func_GetProfileScore @UserName, @score OUTPUT
							-- check if the status of the member's profile is >= 75% completed...
							IF(@score >= 75)
								BEGIN
									PRINT 'PASSED -- Action 1 -- credit the publisher'
									UPDATE login_info
										SET affiliate_action_status = 1
										WHERE user_name = @UserName
						
									SELECT @affiliate_tracking_id	AS 'affiliate_tracking_id'
										, @plan_unique_id	AS 'plan_unique_id'
										, @score 		AS 'profile_score'
										, 1			AS 'credit_publisher'
								END
							ELSE
								BEGIN
									PRINT 'FAILED -- Action 1 -- DO NOT credit the publisher'
									UPDATE login_info
										SET affiliate_action_status = -1
										WHERE user_name = @UserName

									SELECT @affiliate_tracking_id	AS 'affiliate_tracking_id'
										, @plan_unique_id	AS 'plan_unique_id'
										, @score 		AS 'profile_score'
										, 0			AS 'credit_publisher'
								END
						END
					ELSE
						BEGIN
							PRINT 'affiliate_action_status indicates action previously completed or plan_unique_id (' + CONVERT(VARCHAR(6), @plan_unique_id) + ') is invalid.'
						END
				END
			ELSE
				BEGIN
					PRINT 'No ckuid found for this user'
				END
		RETURN 1
	END
ELSE
	BEGIN
		-- If the user_name, email and password do not match exit with a return value of 666 
		PRINT 'user_name and password did not match or Email Verification Code is incorrect so we are unable to verify that (' + @Email + ') is the correct email address for user (' + @UserName + ')' -- the first part of this string must remain as "user_name and password did not match" because it is being checked for in "msg_handler" 
		RETURN 666
	END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE [verifyMembershipTypePermissions]
	@UserName varchar(32)
	, @FeatureRequested varchar (32)
 AS

-- Check user_name is blank
if ( @UserName = '' )
	BEGIN--  DENIED
		print 'user_name does not exist'
		return 140
	END
-- END Verify Permissions

-- Check email has been verified
if ( (SELECT is_email_verified FROM login_info WHERE user_name = @UserName) != 1 )
	BEGIN--  DENIED
		print 'email address has not been verified'
		return 201
	END
-- END Verify Permissions

/*
-- Check if this is a promotional membership_type
if (
	 (select membership_type.date_promotion_ended
		from login_info
		  , membership_type
		where login_info.membership_type = membership_type_id
		and login_info.user_name = @UserName
	) != NULL
   )
BEGIN
	print 'Promotional Membership'
	print 'Must check Promotion Date'
	if (
		 (select membership_type.date_promotion_ended
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) > getdate()
	   )
	BEGIN
		print 'Promotion is active'
	END
	else
	BEGIN
		print 'Promotion Expired'
		return 600
	END	
END
else
BEGIN
	print 'Non-Promotional Membership'
END
*/
if ( @FeatureRequested = 'allow_search_simple' )
BEGIN
	print 'Check allow_search_simple permissions'
	if (
		 (select membership_type.allow_search_simple
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_search_simple'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_search_simple'
		return 601
	END
END
if ( @FeatureRequested = 'allow_search_advanced' )
BEGIN
	print 'Check allow_search_advanced permissions'
	if (
		 (select membership_type.allow_search_advanced
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_search_advanced'
		print 'Check force_pic_upload...'
		IF (
			 (
				SELECT 
					CASE 
						WHEN membership_type.force_pic_upload = 1
							THEN login_info.photo_submitted
						WHEN membership_type.force_pic_upload = 0
							THEN 1
					END
				FROM login_info
				 	 , membership_type
				WHERE login_info.membership_type = membership_type_id
				AND login_info.user_name = @UserName
			) = 1
		   )
		BEGIN
			print 'Permission GRANTED for allow_search_advanced'
			return 1
		END
		ELSE
		BEGIN
			print 'Permission DENIED for allow_search_advanced -- no photo submitted'
			return 702
		END
	END
	else
	BEGIN
		print 'Permission DENIED for allow_search_advanced'
		return 602
	END
END

if ( @FeatureRequested = 'allow_view_profiles' )
BEGIN
	print 'Check allow_view_profiles permissions'
	if (
		 (select membership_type.allow_view_profiles
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_view_profiles'
		print 'Check force_pic_upload...'
		IF (
			 (
				SELECT 
					CASE 
						WHEN membership_type.force_pic_upload = 1
							THEN login_info.photo_submitted
						WHEN membership_type.force_pic_upload = 0
							THEN 1
					END
				FROM login_info
				 	 , membership_type
				WHERE login_info.membership_type = membership_type_id
				AND login_info.user_name = @UserName
			) = 1
		   )
		BEGIN
			print 'Permission GRANTED for allow_search_advanced'
			return 1
		END
		ELSE
		BEGIN
			print 'Permission DENIED for allow_search_advanced -- no photo submitted'
			return 703
		END
	END
	else
	BEGIN
		print 'Permission DENIED for allow_view_profiles'
		return 603
	END
END
if ( @FeatureRequested = 'allow_mail_receive' )
BEGIN
	print 'Check allow_mail_receive permissions'
	if (
		 (select membership_type.allow_mail_receive
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_mail_receive'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_mail_receive'
		return 604
	END
END
if ( @FeatureRequested = 'allow_mail_read' )
BEGIN
	print 'Check allow_mail_read permissions'
	if (
		 (select membership_type.allow_mail_read
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_mail_read'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_mail_read'
		return 605
	END
END
if ( @FeatureRequested = 'allow_mail_send' )
BEGIN
	print 'Check allow_mail_send permissions'
	if (
		 (select membership_type.allow_mail_send
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_mail_send'
		print 'Check force_pic_upload...'
		IF (
			 (
				SELECT 
					CASE 
						WHEN membership_type.force_pic_upload = 1
							THEN login_info.photo_submitted
						WHEN membership_type.force_pic_upload = 0
							THEN 1
					END
				FROM login_info
				 	 , membership_type
				WHERE login_info.membership_type = membership_type_id
				AND login_info.user_name = @UserName
			) = 1
		   )
		BEGIN
			print 'Permission GRANTED for allow_search_advanced'
			return 1
		END
		ELSE
		BEGIN
			print 'Permission DENIED for allow_search_advanced -- no photo submitted'
			return 706
		END
	END
	else
	BEGIN
		print 'Permission DENIED for allow_mail_send'
		return 606
	END
END
if ( @FeatureRequested = 'allow_mail_reply' )
BEGIN
	print 'Check allow_mail_reply permissions'
	if (
		 (select membership_type.allow_mail_reply
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_mail_reply'
		print 'Check force_pic_upload...'
		IF (
			 (
				SELECT 
					CASE 
						WHEN membership_type.force_pic_upload = 1
							THEN login_info.photo_submitted
						WHEN membership_type.force_pic_upload = 0
							THEN 1
					END
				FROM login_info
				 	 , membership_type
				WHERE login_info.membership_type = membership_type_id
				AND login_info.user_name = @UserName
			) = 1
		   )
		BEGIN
			print 'Permission GRANTED for allow_search_advanced'
			return 1
		END
		ELSE
		BEGIN
			print 'Permission DENIED for allow_search_advanced -- no photo submitted'
			return 707
		END
	END
	else
	BEGIN
		print 'Permission DENIED for allow_mail_reply'
		return 607
	END
END
if ( @FeatureRequested = 'allow_romance_wizard' )
BEGIN
	print 'Check allow_romance_wizard permissions'
	if (
		 (select membership_type.allow_romance_wizard
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_romance_wizard'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_romance_wizard'
		return 608
	END
END
if ( @FeatureRequested = 'allow_chat_view' )
BEGIN
	print 'Check allow_chat_view permissions'
	if (
		 (select membership_type.allow_chat_view
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_chat_view'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_chat_view'
		return 609
	END
END
if ( @FeatureRequested = 'allow_chat_use' )
BEGIN
	print 'Check allow_chat_use permissions'
	if (
		 (select membership_type.allow_chat_use
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_chat_use'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_chat_use'
		return 610
	END
END
if ( @FeatureRequested = 'allow_view_stats' )
BEGIN
	print 'Check allow_view_stats permissions'
	if (
		 (select membership_type.allow_view_stats
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_view_stats'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_view_stats'
		return 611
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

