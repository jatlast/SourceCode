SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updatePersonalInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updatePersonalInfo]
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

