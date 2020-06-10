SET NOCOUNT ON
PRINT '----------------------------------------------------------'
PRINT '-- This is a script designed to generate the necessary SQL'
PRINT '--   for populating all of the required lookup tables.    '
PRINT ''
PRINT '----------------------------------------------------------'

PRINT ''
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "cook" table...'
declare @max_value smallint
select  @max_value = (select max(value) from cook)
print 'TRUNCATE TABLE cook' 
select 'INSERT INTO cook (choice, value) VALUES (' 
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from cook
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "country" table...'
print 'TRUNCATE TABLE country' 
select  @max_value = (select max(value) from country)
select 'INSERT INTO country (choice, value, iso_name) VALUES (' 
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ',' + '''' + RTRIM(iso_name) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from country
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "credit_card_type" table...'
print 'TRUNCATE TABLE credit_card_type' 
select  @max_value = (select max(value) from credit_card_type)
select 'INSERT INTO credit_card_type (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from credit_card_type
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "drink" table...'
print 'TRUNCATE TABLE drink' 
select  @max_value = (select max(value) from drink)
select 'INSERT INTO drink (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from drink
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "education" table...'
print 'TRUNCATE TABLE education' 
select  @max_value = (select max(value) from education)
select 'INSERT INTO education (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from education
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "eyes" table...'
print 'TRUNCATE TABLE eyes' 
select  @max_value = (select max(value) from eyes)
select 'INSERT INTO eyes (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from eyes
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "hair" table...'
print 'TRUNCATE TABLE hair' 
select  @max_value = (select max(value) from hair)
select 'INSERT INTO hair (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from hair
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "height" table...'
print 'TRUNCATE TABLE height' 
select  @max_value = (select max(value) from height)
select 'INSERT INTO height (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from height
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "housing_status" table...'
print 'TRUNCATE TABLE housing_status' 
select  @max_value = (select max(value) from housing_status)
select 'INSERT INTO housing_status (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from housing_status
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "marital_status" table...'
print 'TRUNCATE TABLE marital_status' 
select  @max_value = (select max(value) from marital_status)
select 'INSERT INTO marital_status (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from marital_status
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "membership_type" table...'
print 'TRUNCATE TABLE membership_type' 
select  @max_value = (select max(membership_type_id) from membership_type)
select 'INSERT INTO membership_type (membership_type_id, can_membership_recur, membership_type_name, membership_description, duration_start, duration_end, date_promotion_started, date_promotion_ended, months_1, months_3, months_6, months_12, months_240, rebilled_1, rebilled_3, rebilled_6, rebilled_12, force_pic_upload, allow_search_simple, allow_search_advanced, allow_view_profiles, allow_mail_receive, allow_mail_read, allow_mail_send, allow_mail_reply, allow_romance_wizard, allow_chat_view, allow_chat_use, allow_view_stats) VALUES (' 
					+ '''' + RTRIM(membership_type_id) + '''' 
					+ ',' + '''' + RTRIM(can_membership_recur) + '''' 
					+ ',' + '''' + RTRIM(membership_type_name) + '''' 
					+ ',' + '''' + RTRIM(membership_description) + '''' 
					+ CASE 
						WHEN duration_start IS NULL THEN ', NULL'
						ELSE ',' + '''' + CONVERT(varchar(20), duration_start) + ''''
					  END
					+ CASE 
						WHEN duration_end IS NULL THEN ', NULL'
						ELSE ',' + '''' + CONVERT(varchar(20), duration_end) + ''''
					  END
					+ CASE 
						WHEN date_promotion_started IS NULL THEN ', NULL'
						ELSE ',' + '''' + CONVERT(varchar(20), date_promotion_started) + ''''
					  END
					+ CASE 
						WHEN date_promotion_ended IS NULL THEN ', NULL'
						ELSE ',' + '''' + CONVERT(varchar(20), date_promotion_ended) + ''''
					  END
					+ ',' + CONVERT(varchar(8), months_1)
					+ ',' + CONVERT(varchar(8), months_3)
					+ ',' + CONVERT(varchar(8), months_6)
					+ ',' + CONVERT(varchar(8), months_12)
					+ ',' + CONVERT(varchar(8), months_240)
					+ ',' + CONVERT(varchar(8), rebilled_1)
					+ ',' + CONVERT(varchar(8), rebilled_3)
					+ ',' + CONVERT(varchar(8), rebilled_6)
					+ ',' + CONVERT(varchar(8), rebilled_12) 
					+ ',' + '''' + RTRIM(force_pic_upload) + '''' 
					+ ',' + '''' + RTRIM(allow_search_simple) + '''' 
					+ ',' + '''' + RTRIM(allow_search_advanced) + '''' 
					+ ',' + '''' + RTRIM(allow_view_profiles) + '''' 
					+ ',' + '''' + RTRIM(allow_mail_receive) + '''' 
					+ ',' + '''' + RTRIM(allow_mail_read) + '''' 
					+ ',' + '''' + RTRIM(allow_mail_send) + '''' 
					+ ',' + '''' + RTRIM(allow_mail_reply) + '''' 
					+ ',' + '''' + RTRIM(allow_romance_wizard) + '''' 
					+ ',' + '''' + RTRIM(allow_chat_view) + '''' 
					+ ',' + '''' + RTRIM(allow_chat_use) + '''' 
					+ ',' + '''' + RTRIM(allow_view_stats) + '''' 
					+ ')' 
	, CASE 
		when membership_type_id = @max_value then '/*'
		else ''
	end
from membership_type
order by membership_type_id

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "party" table...'
print 'TRUNCATE TABLE party' 
select  @max_value = (select max(value) from party)
select 'INSERT INTO party (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from party
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "political" table...'
print 'TRUNCATE TABLE political' 
select  @max_value = (select max(value) from political)
select 'INSERT INTO political (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from political
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "profession" table...'
print 'TRUNCATE TABLE profession' 
select  @max_value = (select max(value) from profession)
select 'INSERT INTO profession (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from profession
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "income" table...'
print 'TRUNCATE TABLE income' 
select  @max_value = (select max(value) from income)
select 'INSERT INTO income (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from income
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "religion" table...'
print 'TRUNCATE TABLE religion' 
select  @max_value = (select max(value) from religion)
select 'INSERT INTO religion (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from religion
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "sex" table...'
print 'TRUNCATE TABLE sex' 
select  @max_value = (select max(value) from sex)
select 'INSERT INTO sex (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from sex
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "sex_preference" table...'
print 'TRUNCATE TABLE sex_preference' 
select  @max_value = (select max(value) from sex_preference)
select 'INSERT INTO sex_preference (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from sex_preference
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "smoke" table...'
print 'TRUNCATE TABLE smoke' 
select  @max_value = (select max(value) from smoke)
select 'INSERT INTO smoke (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from smoke
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "state" table...'
print 'TRUNCATE TABLE state' 
select  @max_value = (select max(value) from state)
select 'INSERT INTO state (choice, value, iso_name) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ',' + '''' + RTRIM(iso_name) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from state
order by value

PRINT '*/'
PRINT 'SET NOCOUNT ON'
PRINT '----------- Populating "weight" table...'
print 'TRUNCATE TABLE weight' 
select  @max_value = (select max(value) from weight)
select 'INSERT INTO weight (choice, value) VALUES ('
	+ CASE 
		WHEN CHARINDEX('''', choice) = 0 THEN '''' + RTRIM(choice) + '''' 
		ELSE '''' + RTRIM(STUFF(choice, CHARINDEX('''', choice), 0, '''')) + '''' 
	  END
	+ ',' + '''' + RTRIM(value) + '''' 
	+ ')' 
	+ CASE 
		WHEN value = @max_value THEN '/*'
		ELSE ''
	  END
from weight
order by value

PRINT '*/'
SET NOCOUNT OFF