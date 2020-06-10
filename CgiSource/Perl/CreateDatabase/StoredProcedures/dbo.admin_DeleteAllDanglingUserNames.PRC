SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_DeleteAllDanglingUserNames]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_DeleteAllDanglingUserNames]
GO



CREATE PROCEDURE [admin_DeleteAllDanglingUserNames]

 AS

CREATE TABLE #DanglingUserNames( user_name VARCHAR(32) COLLATE database_default NOT NULL )
CREATE TABLE #IndividualUserNames( user_name VARCHAR(32) COLLATE database_default NOT NULL )

---------------- login_info ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from login_info 
	where user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from relationship)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- contact_info ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from contact_info 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from relationship)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- personal_info ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from personal_info 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from relationship)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- about_info ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from about_info 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from relationship)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- relationship ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from relationship 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from pictures)

INSERT #DanglingUserNames
select user_name from #IndividualUserNames 
	where user_name not in (select user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- pictures ----------------------------------------------
INSERT #IndividualUserNames
SELECT user_name from pictures 
	where user_name not in (SELECT user_name from login_info)
		or user_name not in (SELECT user_name from contact_info)
		or user_name not in (SELECT user_name from personal_info)
		or user_name not in (SELECT user_name from about_info)
		or user_name not in (SELECT user_name from relationship)

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

---------------- sent_from ----------------------------------------------
INSERT #IndividualUserNames

	select sent_from from mail 
		where sent_from not in (select user_name from login_info)
		or sent_from not in (select user_name from contact_info)
		or sent_from not in (select user_name from personal_info)
		or sent_from not in (select user_name from about_info)
		or sent_from not in (select user_name from relationship)
		or sent_from not in (select user_name from pictures)
	group by sent_from

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

delete #IndividualUserNames

---------------- sent_to ----------------------------------------------
INSERT #IndividualUserNames
	select sent_to from mail 
		where sent_to not in (select user_name from login_info)
		or sent_to not in (select user_name from contact_info)
		or sent_to not in (select user_name from personal_info)
		or sent_to not in (select user_name from about_info)
		or sent_to not in (select user_name from relationship)
		or sent_to not in (select user_name from pictures)
	group by sent_to

INSERT #DanglingUserNames
SELECT user_name from #IndividualUserNames 
	where user_name not in (SELECT user_name from #DanglingUserNames)

-- Drop both the tempory tables
drop table #IndividualUserNames

-- delete dangling profiles found using the login_info table...
PRINT 'Deleting dangling user_names found while running the stored procedure admin_GetDanglingUserNames'
DECLARE @UserName VARCHAR(32)
WHILE ( SELECT COUNT(*) FROM #DanglingUserNames ) > 370
BEGIN
	SELECT @UserName = (SELECT MAX(user_name) FROM #DanglingUserNames )
	PRINT 'Deleting User Name = (' + @UserName + ') based on stored procedure admin_GetDanglingUserNames'
	EXEC admin_DeleteEntireProfileByUserName @UserName
	PRINT 'Deleting User Name = (' + @UserName + ') from temp table'
	DELETE #DanglingUserNames WHERE user_name = @UserName
END

-- Drop the tempory table...
drop table #DanglingUserNames


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

