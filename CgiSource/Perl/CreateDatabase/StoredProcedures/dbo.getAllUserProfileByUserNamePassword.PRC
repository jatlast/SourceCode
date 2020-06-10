SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getAllUserProfileByUserNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getAllUserProfileByUserNamePassword]
GO


CREATE PROCEDURE [getAllUserProfileByUserNamePassword]
	@UserName varchar(32)
	, @Password varchar (16)
 AS

if ( (select password from login_info where user_name = @UserName) = @Password)

BEGIN
	select users.screen_quote
		, users.sex
		, users.user_name
		, users.first_name
		, users.last_name
		, users.email
		, users.password
		, users.hint
		, users.age
		, marital_status.choice
		, region.choice
		, users.profession
		, education.choice
		, religion.choice
		, height.choice
		, weight.choice
		, eyes.choice
		, hair.choice
		, users.min_age_desired
		, users.max_age_desired
		, cook.choice
		, smoke.choice
		, drink.choice
		, party.choice
		, political.choice
		, housing_status.choice
		, users.about_yourself
		, relationship.prefer_not_to_say
		, relationship.any_relationship
		, relationship.hang_out
		, relationship.short_term
		, relationship.long_term
		, relationship.talk_email
		, relationship.photo_exchange
		, relationship.other

	from users
		, marital_status
		, region
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
	where users.user_name = @UserName
	and users.password = @Password
	and users.marital_status = marital_status.value
	and users.region = region.value
	and users.education = education.value
	and users.religion = religion.value
	and users.height = height.value
	and users.weight = weight.value
	and users.eyes = eyes.value
	and users.hair = hair.value
	and users.cook = cook.value
	and users.smoke = smoke.value
	and users.drink = drink.value
	and users.party = party.value
	and users.political = political.value
	and users.housing_status = housing_status.value
	and users.user_name = relationship.user_name
	and relationship.user_name = @UserName

	exec getRawUserProfileByUserNamePassword @UserName, @Password
	
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

