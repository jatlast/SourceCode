SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin_TransactionsLogAudit]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[admin_TransactionsLogAudit]
GO


CREATE PROCEDURE [admin_TransactionsLogAudit]
@OrderBy CHAR(64)		= 'transactions_log.date_of_this_transaction'
, @AscDesc CHAR(4)		= 'DESC'
, @Limit INT			= 100
, @Index CHAR(6)		= '1'
, @UserName VARCHAR(32)	= '%'
, @FromDate DATETIME	= '1/1/1999'
, @ToDate DATETIME		= '1/1/3000'
, @XResponseCode VARCHAR(2)= '1'
, @TransactionType VARCHAR(18)= '%'

 AS

-- the SET string provides a slight performance gain for stored procedures
SET NOCOUNT ON

PRINT 'Order by ' + @OrderBy  + @AscDesc

-- If @FromDate = '' default to old date
IF (@FromDate = "")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @FromDate = '1/1/1999'
END
-- If @ToDate = '' default to future date
IF (@ToDate = "")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @ToDate = '1/1/3000'
END
-- If XResponseCode = '' default to wildcard
IF (@XResponseCode = "")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @XResponseCode = '%'
END
-- If @TransactionType = '' default to wildcard
IF (@TransactionType = "")
BEGIN
	-- use SQL wildcard when searching 
	SELECT @TransactionType = '%'
END

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


print 'SELECT transactions_log.*
			, login_info.password
	FROM transactions_log
		, login_info
	WHERE transactions_log.user_name LIKE ''' + @UserName + '''
		AND transactions_log.date_of_this_transaction >= ''' + convert(char(10), @FromDate, 101)  + '''
		AND transactions_log.date_of_this_transaction <= ''' + convert(char(10), @ToDate, 101)  + '''
		AND transactions_log.x_response_code LIKE ''' + @XResponseCode + '''
		AND transactions_log.transaction_type LIKE ''' + @TransactionType + '''
		AND transactions_log.user_name = login_info.user_name
	ORDER BY ' + @OrderBy + @AscDesc

EXEC ( 'SQL:  SELECT COUNT(*) AS count_total
		, sum(amount) AS amount_total
	FROM transactions_log
	WHERE transactions_log.user_name LIKE ''' + @UserName + '''
		AND transactions_log.date_of_this_transaction >= ''' + @FromDate + '''
		AND transactions_log.date_of_this_transaction <= ''' + @ToDate + '''
		AND transactions_log.x_response_code LIKE ''' + @XResponseCode + '''
		AND transactions_log.transaction_type LIKE ''' + @TransactionType + '''
') -- end EXEC

SET ROWCOUNT @RowCount

EXEC ( 'SQL:  SELECT billing_info.is_membership_active
			, transactions_log.*
			, login_info.password
			, country.choice as country
			, sex.choice as sex
	FROM billing_info
		, transactions_log
		, login_info
		, contact_info
		, country
		, sex
	WHERE transactions_log.user_name LIKE ''' + @UserName + '''
		AND transactions_log.date_of_this_transaction >= ''' + @FromDate + '''
		AND transactions_log.date_of_this_transaction <= ''' + @ToDate + '''
		AND transactions_log.x_response_code LIKE ''' + @XResponseCode + '''
		AND transactions_log.transaction_type LIKE ''' + @TransactionType + '''
		AND transactions_log.user_name = login_info.user_name
		AND billing_info.user_name = login_info.user_name
		AND login_info.user_name = contact_info.user_name
		AND contact_info.country = country.value
		AND login_info.sex = sex.value
	ORDER BY ' + @OrderBy + @AscDesc
) -- end EXEC

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

