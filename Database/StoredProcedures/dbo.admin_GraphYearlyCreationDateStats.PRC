SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GraphYearlyCreationDateStats]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GraphYearlyCreationDateStats]
GO



CREATE PROCEDURE [admin_GraphYearlyCreationDateStats]
 AS

-- Populate a temporary table with only the search month's data...
select datepart( year, creation_date ) as 'creation_year'
	, count(*) as 'new_members'
INTO #CreationDate
from login_info
group by datepart( year, creation_date )

--select distinct(creation_year) as 'distinct_years' 
--from #CreationDate

-- Return the Weekday name and number as well as the number of new members for that day...
select creation_year as 'creation_year'
	, new_members
 from #CreationDate
order by creation_year

-- Drop the temporary table
drop table #CreationDate


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

