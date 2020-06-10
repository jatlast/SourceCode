SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GraphMonthlyCreationDateStatsByYear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GraphMonthlyCreationDateStatsByYear]
GO



CREATE PROCEDURE [admin_GraphMonthlyCreationDateStatsByYear]
@Year char(4) = ''

 AS

-- Declare a variable to hold the month to get results from...
declare @SearchYear datetime

-- Set the current search date to the most recent creation_date 
-- if the procedure was called without parameters...
if(@Year = '')
	begin
		select @SearchYear = ( select max(creation_date) from login_info )
	end
ELSE
	begin
		select @SearchYear = '1-1-' + @Year
	end

-- Declare a variable to represent the precious month to limith the lower bound of the selections...
-- Print all month variables for debugging...
print 'SearchYear = ' + convert(char(10), datepart(year, @SearchYear), 101)

-- Populate a temporary table with only the search month's data...
select datepart( month, creation_date ) as 'creation_month'
	, count(*) as 'new_members'
INTO #CreationDate
from login_info
where datepart( year, creation_date ) = datepart( year, @SearchYear )
group by datepart( month, creation_date )

-- Return the search_month and search_year
select datepart(year, @SearchYear) as 'search_year'

-- Return the Weekday name and number as well as the number of new members for that day...
select creation_month as 'creation_month'
	, new_members
 from #CreationDate
order by creation_month

-- Drop the temporary table
drop table #CreationDate


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

