SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[genSendMail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[genSendMail]
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

