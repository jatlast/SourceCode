SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_BatchNightlyTransactionSend]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_BatchNightlyTransactionSend]
GO


-- This script should be run NIGHTLY
-- It does the following:
--	1. cleans up  the mail table
--	2. resets  the login_info.photo_submitted field
--	3. retrieves the user_names of the members who should be re-charged their monthly fee...
CREATE PROCEDURE [admin_BatchNightlyTransactionSend]

 AS

-- clean up mail table
print 'Cleaning up mail'
delete mail where sender_deleted = 1 and receiver_deleted = 1

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

-- change the user's membership_type to "0" (basic) if the promotion has ended or 
-- they have canceled their paying membership...
print 'Cleaning up membership status'
UPDATE login_info
	SET membership_type = 0 -- 0 = Basic Membership
	WHERE membership_type 
				IN
					(
					-- find all expired promotional membership_type_id's...
						SELECT membership_type_id
							FROM membership_type
							WHERE DATEDIFF( DAY, GETDATE(), date_promotion_ended ) < 0
							AND membership_type_id != 0
					)
				OR	
					(
					-- find all user_names with canceled paying memberships...
					membership_type 
							IN
								(
								-- find all NON promotional membership_type_id's...
									SELECT membership_type_id
										FROM membership_type
										WHERE date_promotion_ended IS NULL
										AND membership_type_id != 0
								)
					AND	user_name 
							IN 
								(
								-- find all user_names with inactive memberships 
								 -- past the date of membership expiration...
									SELECT user_name
										FROM billing_info
										WHERE is_membership_active = 1
										and DATEDIFF( DAY, GETDATE(), date_membership_expires ) < 0
								)
					)


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

