SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[singleProfile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[singleProfile]
GO





CREATE PROCEDURE [singleProfile]
@UserNameBeingSearched varchar(32)
, @UserNameSearching varchar(32)

 AS

-- START Verify Permissions
DECLARE @@ReturnValue char(4)
DECLARE @@ViewMyOwnProfile char(2)

IF(@UserNameBeingSearched = @UserNameSearching )
	BEGIN
		SELECT @@ViewMyOwnProfile = '1'
	END
ELSE
	BEGIN
		SELECT @@ViewMyOwnProfile = '0'
	END

EXEC @@ReturnValue = verifyMembershipTypePermissions  @UserNameSearching, 'allow_view_profiles'
-- Check membership_type for permission
IF ( @@ReturnValue != 1 AND  @@ViewMyOwnProfile = '0' )
	BEGIN--  DENIED
		print 'You must upgrade your membership to use this feature'
		return @@ReturnValue
	END
-- END Verify Permissions

-- Check if the UserNameBeingSearched is hidden...
SELECT @@ReturnValue = (select questionable from about_info where user_name = @UserNameBeingSearched)
if ( @@ReturnValue = 1 AND @@ViewMyOwnProfile = '0' )
	BEGIN--  DENIED
		print 'The user you are trying to view currently has a hidden profile'
		return 205
	END

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


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

