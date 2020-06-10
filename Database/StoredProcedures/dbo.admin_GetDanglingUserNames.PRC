SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GetDanglingUserNames]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GetDanglingUserNames]
GO



CREATE PROCEDURE [admin_GetDanglingUserNames]

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


-- Return the number of dangling user_names...
SELECT count(*) AS 'count'
FROM #DanglingUserNames

-- Return the actual dangling user_names...
SELECT user_name FROM #DanglingUserNames
ORDER BY user_name

-- Drop both the tempory tables
drop table #IndividualUserNames
drop table #DanglingUserNames


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

