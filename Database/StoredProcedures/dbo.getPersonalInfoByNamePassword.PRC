SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getPersonalInfoByNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getPersonalInfoByNamePassword]
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

