SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[insert_membership_cancellation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[insert_membership_cancellation]
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

