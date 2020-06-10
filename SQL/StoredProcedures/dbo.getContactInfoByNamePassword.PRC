SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[getContactInfoByNamePassword]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[getContactInfoByNamePassword]
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

