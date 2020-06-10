SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_GetMembershipCancellations]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_GetMembershipCancellations]
GO


CREATE PROCEDURE [admin_GetMembershipCancellations]
@OrderBy VARCHAR(64)	= 'membership_cancellation.date_cancelled'
, @AscDesc CHAR(4)		= 'DESC'
, @Limit INT			= 100
, @Index CHAR(6)		= '1'
, @UserName VARCHAR(32)	= '%'

 AS

-- the SET string provides a slight performance gain for stored procedures
SET NOCOUNT ON

PRINT 'Order by ' + @OrderBy  + @AscDesc

-- If UserName != "%" the user entered data to search for 
IF (@UserName != "%")
BEGIN
	PRINT 'user entered a user_name'
	-- Pad with SQL wildcards for searching 
	SELECT @UserName = ( SELECT ( @UserName + '%') )
END

PRINT 'user_name = ' + @UserName

DECLARE @RowCount INT -- Used to set the rowcount based on index and limit
SELECT @RowCount = ( @Index + @Limit + 1 )

-- count the total number of rows in the login_info table...
EXEC ('SQL:  SELECT COUNT(*) as count
	FROM membership_cancellation
	WHERE membership_cancellation.user_name LIKE ''' + @UserName + '''
') -- end EXEC

SET ROWCOUNT @RowCount

PRINT 'SQL:  SELECT membership_cancellation.* 
	FROM membership_cancellation
	WHERE membership_cancellation.user_name LIKE ''' + @UserName + '''
	ORDER BY ' + @OrderBy + ' ' + @AscDesc

EXEC ('SQL:  SELECT membership_cancellation.* 
	FROM membership_cancellation
	WHERE membership_cancellation.user_name LIKE ''' + @UserName + '''
	ORDER BY ' + @OrderBy + ' ' + @AscDesc
) -- end EXEC

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

