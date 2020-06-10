SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GraphHourlyCreationDateStatsByDayMonthYear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GraphHourlyCreationDateStatsByDayMonthYear]
GO



CREATE PROCEDURE [admin_GraphHourlyCreationDateStatsByDayMonthYear]
@Day char(2) = '1'
 , @Month char(2) = ''
,  @Year char(4) = '2001'

 AS

-- Declare a variable to hold the month to get results from...
declare @SearchDay datetime

-- Set the current search date to the most recent creation_date 
-- if the procedure was called without parameters...
if(@Month = '')
	begin
		select @SearchDay = ( select max(creation_date) from login_info )
	end
ELSE
	begin
		select @SearchDay = @Month + '-' + @Day + '-' + @Year
	end

-- Print all month variables for debugging...
print 'SearchDay = '  + convert(char(25), @SearchDay , 113)

-- Populate a temporary table with only the search month's data...
select datepart( hour, creation_date ) as 'creation_hour'
	, count(*) as 'new_members'
INTO #CreationDay
from login_info
where datepart( day, creation_date ) = datepart(day, @SearchDay)
and datepart( month, creation_date ) = datepart(month, @SearchDay)
and datepart( year, creation_date ) = datepart(year, @SearchDay)
and datepart( hour, creation_date ) < 24
group by datepart( hour, creation_date )

---------------------------------------------------------
-- Return the maximum number of days in the search month
-- So the DB takes care of figuring out leap year crap
---------------------------------------------------------
declare @TempSearchDay datetime
-- First: set the @Day variable to 1 and the rest equal to the current search date
-- and reset the current month search to those fields (last day of that month and year)...
select @Day = '1'
select @Month = datepart(month, @SearchDay)
select @Year = datepart(year, @SearchDay)
-- Declare a variable to represent the last day of the search month/day/year...
select @TempSearchDay = @Month + '-' + @Day + '-' + @Year
-- Second: Add a month so we are on the first of next month...
select @TempSearchDay = dateadd(month, 1, @TempSearchDay)
-- Third: Subtract a single day to return the last day of the search month...
select @TempSearchDay = dateadd(day, -1, @TempSearchDay)
-- Finally: Select the day...
select datepart( day, @TempSearchDay ) as 'days_in_month'
print 'SearchDay = ' + convert(char(10), @TempSearchDay, 101)
-----------------------------------------------------------------------


-- Return the search_month and search_year
select datepart(day, @SearchDay) as 'search_day'
	, datepart(month, @SearchDay) as 'search_month'
	, datepart(year, @SearchDay) as 'search_year'

-- Return the Weekday name and number as well as the number of new members for that day...
select creation_hour as 'hour'
	, new_members
 from #CreationDay
order by creation_hour

-- Drop the temporary table
drop table #CreationDay

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

