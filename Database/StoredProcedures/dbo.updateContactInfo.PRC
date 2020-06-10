SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updateContactInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updateContactInfo]
GO



CREATE PROCEDURE [updateContactInfo]
@UserName varchar(32)
, @FirstName varchar(32)
, @LastName varchar(32)
, @StreetAddress varchar(64)
, @City varchar(32)
, @State varchar(4)
, @Country varchar(4)
, @Zip nchar(5)
, @Telephone varchar(16)

 AS
/* If the user_name is unique add the user to the login_info table and exit with a return value of 1 */
update contact_info 
	set first_name = @FirstName
		, last_name = @LastName
		, street_address = @StreetAddress
		, city = @City
		, state = @State
		, country = @Country
		, zip = @Zip
		, telephone = @Telephone

	where user_name = @UserName
return 1


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

