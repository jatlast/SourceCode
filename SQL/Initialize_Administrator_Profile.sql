PRINT 'Populating all tables to create the Administrator internal profile...'

PRINT 'Removing Administrator from about_info table...'
DELETE about_info WHERE user_name = 'Administrator'

SET NOCOUNT ON
PRINT 'Populating about_info...'
INSERT INTO about_info (user_name,screen_quote,about_yourself,questionable) VALUES ('Administrator','Welcome!','Hello!
As a new user you have access to a everything our web site has to offer. All you have to do id upload a picture of yourself.  We will keep you posted as to all new developments and enhancements to the site.
If you have any questions please respond to this mail.
We look forward to seeing you online!
Thank you','0')

PRINT 'Removing Administrator from billing_info table...'
DELETE billing_info WHERE user_name = 'Administrator'

SET NOCOUNT ON
PRINT 'Populating billing_info...'
INSERT INTO billing_info (user_name,card_type,name_on_card,account_number,expiration_month,expiration_year,is_membership_active,date_membership_expires,bank_ABA_code,bank_account_number) VALUES ('Administrator','4','Administrator','5081810004808146','08','2003','1',DATEADD(YEAR, 20, GETDATE()),'','')

PRINT 'Removing Administrator from contact_info table...'
DELETE contact_info WHERE user_name = 'Administrator'

SET NOCOUNT ON
PRINT 'Populating contact_info...'
INSERT INTO contact_info (user_name,first_name,last_name,street_address,city,state,country,zip,telephone) VALUES ('Administrator','Connections','Admin','1 Main St.','Hoboken','35','223','07030','201-792-8860')

PRINT 'Removing Administrator from login_info table...'
DELETE login_info WHERE user_name = 'Administrator'

SET NOCOUNT ON
PRINT 'Populating login_info...'
INSERT INTO login_info (user_id,user_name,membership_type,password,password_hint,email,sex,creation_date,last_login,photo_submitted,date_started_paying,email_verification_code,is_email_verified,affiliate_tracking_id,affiliate_action_status) VALUES ('1','Administrator',1,'janesays','Anderson','connectionsadmin@earthlink.net','1',GETDATE(),GETDATE(),0,GETDATE(),'0000000000','0',NULL,NULL)

PRINT 'Removing Administrator from personal_info table...'
DELETE personal_info WHERE user_name = 'Administrator'

SET NOCOUNT ON
PRINT 'Populating personal_info...'
INSERT INTO personal_info (user_name,sex_preference,age,marital_status,profession,income,education,religion,height,weight,eyes,hair,min_age_desired,max_age_desired,cook,smoke,drink,party,political,housing_status) VALUES ('Administrator','1','25','0','0','0','0','0','0','0','0','0','18','99','0','0','0','0','0','0')

PRINT 'Removing Administrator from pictures table...'
DELETE pictures WHERE user_name = 'Administrator'

SET NOCOUNT ON
PRINT 'Populating pictures...'
INSERT INTO pictures (user_name,photo_1,photo_2,photo_3,photo_4,photo_5) VALUES ('Administrator','Nothing','Nothing','Nothing','Nothing','Nothing')

PRINT 'Removing Administrator from relationship table...'
DELETE relationship WHERE user_name = 'Administrator'

SET NOCOUNT ON
PRINT 'Populating relationship...'
INSERT INTO relationship (user_name,prefer_not_to_say,any_relationship,hang_out,short_term,long_term,talk_email,photo_exchange,marriage,other) VALUES ('Administrator','0','1','0','0','0','0','0','0','0')












