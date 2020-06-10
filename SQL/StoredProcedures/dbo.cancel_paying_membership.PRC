SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cancel_paying_membership]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[cancel_paying_membership]
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

