SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GetIndividualTableInfoByUserName]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GetIndividualTableInfoByUserName]
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

