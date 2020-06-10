SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GraphMonthlyCreationDateStatsByMonthYear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GraphMonthlyCreationDateStatsByMonthYear]
GO




CREATE PROCEDURE [admin_GraphMonthlyCreationDateStatsByMonthYear]
@Day char(1) = '1'
 , @Month char(3) = '1'
,  @Year char(4) = '1999'

 AS

-- Declare a variable to hold the month to get results from...
declare @SearchMonth datetime

-- Set the current search date to the most recent creation_date 
-- if the procedure was called without parameters...
if(@Year = '1999')
	begin
		select @SearchMonth = ( select max(creation_date) from login_info )
	end
ELSE
	begin
		select @SearchMonth = @Month + '-' + @Day + '-' + @Year
	end

-- Declare a variable to represent the precious month to limith the lower bound of the selections...
declare @PreviousMonth datetime
-- Subtract one month from the search month to initialize the PreviousMonth
select @PreviousMonth = dateadd(month, -1, @SearchMonth)

-- Declare a variable to represent the next month to limith the upper bound of the selections...
declare @NextMonth datetime
-- Add one month to the search month to initialize the NextMonth
select @NextMonth = dateadd(month, 1, @SearchMonth)

-- Print all month variables for debugging...
print 'PreviousMonth	= ' + convert(char(10), @PreviousMonth, 101)
print 'SearchMonth	= ' + convert(char(10), @SearchMonth, 101)
print 'NextMonth	= ' + convert(char(10), @NextMonth	, 101)

-- Populate a temporary table with only the search month's data...
select convert(char(10), creation_date, 101) as 'creation_date'
	, count(*) as 'new_members'
INTO #CreationDate
from login_info
where datepart(month, creation_date) = datepart(month, @SearchMonth)
and datepart(year, creation_date) = datepart(year, @SearchMonth)
group by convert(char(10), creation_date, 101)

---------------------------------------------------------
-- Return the maximum number of days in the search month
-- So the DB takes care of figuring out leap year crap
---------------------------------------------------------
-- First: set the @Day variable to 1 and the rest equal to the current search date
-- and reset the current month search to those fields (last day of that month and year)...
select @Day = '1'
select @Month = datepart(month, @SearchMonth)
select @Year = datepart(year, @SearchMonth)
-- Declare a variable to represent the last day of the search month/day/year...
select @SearchMonth = @Month + '-' + @Day + '-' + @Year
-- Second: Add a month so we are on the first of next month...
select @SearchMonth = dateadd(month, 1, @SearchMonth)
-- Third: Subtract a single day to return the last day of the search month...
select @SearchMonth = dateadd(day, -1, @SearchMonth)
-- Finally: Select the day...
select datepart( day, @SearchMonth ) as 'days_in_month'
print 'SearchMonth = ' 	+ convert(char(10), @SearchMonth, 101)
-----------------------------------------------------------------------

-- Return the search_month and search_year
select datepart(month, @SearchMonth) as 'search_month'
	, datepart(year, @SearchMonth) as 'search_year'

-- Return the Weekday name and number as well as the number of new members for that day...
select datename(weekday, creation_date) as 'week_day'
	, datepart(day, creation_date) as 'day_number'
	, new_members
 from #CreationDate
order by creation_date

-- Drop the temporary table
drop table #CreationDate

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

