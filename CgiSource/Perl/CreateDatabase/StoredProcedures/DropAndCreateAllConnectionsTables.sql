if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[about_info]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[about_info]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[billing_info]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[billing_info]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[book_marks]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[book_marks]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[contact_info]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[contact_info]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[cook]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[cook]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[country]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[country]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[credit_card_type]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[credit_card_type]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[drink]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[drink]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[education]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[education]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[eyes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[eyes]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[hair]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[hair]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[height]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[height]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[housing_status]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[housing_status]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[login_info]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[login_info]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[mail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[mail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[marital_status]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[marital_status]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[membership_cancellation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[membership_cancellation]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[membership_type]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[membership_type]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[party]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[party]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[personal_info]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[personal_info]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pictures]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[pictures]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[political]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[political]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[profession]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[profession]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[income]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[income]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[recurring_transactions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[recurring_transactions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[relationship]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[relationship]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[religion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[religion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sex]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[sex]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sex_preference]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[sex_preference]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[smoke]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[smoke]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[state]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[state]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[transactions_log]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[transactions_log]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[weight]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[weight]
GO

CREATE TABLE [dbo].[about_info] (
	[user_name] [varchar] (32) NOT NULL ,
	[screen_quote] [text] NULL ,
	[about_yourself] [text] NULL ,
	[questionable] [char] (1) NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[billing_info] (
	[user_name] [varchar] (32) NOT NULL ,
	[card_type] [char] (1) NOT NULL ,
	[name_on_card] [varchar] (64) NOT NULL ,
	[account_number] [varchar] (32) NOT NULL ,
	[expiration_month] [char] (2) NOT NULL ,
	[expiration_year] [char] (4) NOT NULL ,
	[is_membership_active] [char] (1) NOT NULL ,
	[date_membership_expires] [datetime] NULL ,
	[bank_ABA_code] [varchar] (9) NULL ,
	[bank_account_number] [varchar] (32) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[book_marks] (
	[user_name] [varchar] (32) NULL ,
	[book_mark] [varchar] (32) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[contact_info] (
	[user_name] [varchar] (32) NOT NULL ,
	[first_name] [varchar] (32) NOT NULL ,
	[last_name] [varchar] (32) NULL ,
	[street_address] [varchar] (96) NULL ,
	[city] [varchar] (32) NULL ,
	[state] [varchar] (32) NULL ,
	[country] [varchar] (32) NULL ,
	[zip] [char] (5) NOT NULL ,
	[telephone] [char] (16) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[cook] (
	[choice] [varchar] (32) NULL ,
	[value] [char] (1) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[country] (
	[choice] [char] (32) NOT NULL ,
	[value] [char] (4) NOT NULL ,
	[iso_name] [char] (4) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[credit_card_type] (
	[choice] [varchar] (16) NOT NULL ,
	[value] [char] (1) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[drink] (
	[choice] [varchar] (32) NULL ,
	[value] [char] (1) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[education] (
	[choice] [varchar] (32) NULL ,
	[value] [char] (1) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[eyes] (
	[choice] [varchar] (32) NULL ,
	[value] [char] (1) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[hair] (
	[choice] [varchar] (32) NULL ,
	[value] [char] (1) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[height] (
	[choice] [varchar] (32) NULL ,
	[value] [char] (4) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[housing_status] (
	[choice] [varchar] (32) NULL ,
	[value] [char] (1) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[login_info] (
	[user_id] [char] (10) NOT NULL ,
	[user_name] [varchar] (32) NOT NULL ,
	[membership_type] [int] NOT NULL ,
	[password] [varchar] (16) NOT NULL ,
	[password_hint] [varchar] (32) NOT NULL ,
	[email] [varchar] (64) NOT NULL ,
	[sex] [char] (1) NOT NULL ,
	[creation_date] [datetime] NOT NULL ,
	[last_login] [datetime] NOT NULL ,
	[photo_submitted] [int] NULL ,
	[date_started_paying] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[mail] (
	[mail_id] [varchar] (16) NOT NULL ,
	[sent_to] [varchar] (32) NOT NULL ,
	[sent_from] [varchar] (32) NOT NULL ,
	[subject] [varchar] (128) NULL ,
	[message_text] [text] NULL ,
	[when_sent] [datetime] NOT NULL ,
	[when_read] [datetime] NULL ,
	[sender_deleted] [int] NULL ,
	[receiver_deleted] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[marital_status] (
	[choice] [varchar] (32) NULL ,
	[value] [char] (1) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[membership_cancellation] (
	[unique_id] [char] (16) NOT NULL ,
	[user_name] [varchar] (32) NOT NULL ,
	[email] [varchar] (64) NOT NULL ,
	[date_started_paying] [datetime] NOT NULL ,
	[date_cancelled] [datetime] NOT NULL ,
	[reason_for_leaving] [varchar] (128) NOT NULL ,
	[membership_prices] [varchar] (16) NOT NULL ,
	[website_design] [varchar] (16) NOT NULL ,
	[suggestions] [text] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[membership_type] (
	[membership_type_id] [char] (4) NOT NULL ,
	[membership_type_name] [char] (16) NOT NULL ,
	[date_promotion_started] [datetime] NULL ,
	[date_promotion_ended] [datetime] NULL ,
	[allow_search_simple] [char] (1) NOT NULL ,
	[allow_search_advanced] [char] (1) NOT NULL ,
	[allow_view_profiles] [char] (1) NOT NULL ,
	[allow_mail_receive] [char] (1) NOT NULL ,
	[allow_mail_read] [char] (1) NOT NULL ,
	[allow_mail_send] [char] (1) NOT NULL ,
	[allow_mail_reply] [char] (1) NULL ,
	[allow_romance_wizard] [char] (1) NOT NULL ,
	[allow_chat_view] [char] (1) NOT NULL ,
	[allow_chat_use] [char] (1) NOT NULL ,
	[allow_view_stats] [char] (1) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[party] (
	[choice] [varchar] (64) NULL ,
	[value] [char] (1) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[personal_info] (
	[user_name] [varchar] (32) NULL ,
	[sex_preference] [char] (2) NULL ,
	[age] [char] (4) NULL ,
	[marital_status] [char] (2) NULL ,
	[profession] [char] (3) NULL ,
	[income] [char] (2) NULL ,
	[education] [char] (2) NULL ,
	[religion] [char] (2) NULL ,
	[height] [char] (4) NULL ,
	[weight] [char] (4) NULL ,
	[eyes] [char] (4) NULL ,
	[hair] [char] (2) NULL ,
	[min_age_desired] [char] (4) NULL ,
	[max_age_desired] [char] (4) NULL ,
	[cook] [char] (2) NULL ,
	[smoke] [char] (2) NULL ,
	[drink] [char] (2) NULL ,
	[party] [char] (2) NULL ,
	[political] [char] (2) NULL ,
	[housing_status] [char] (2) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[pictures] (
	[user_name] [varchar] (32) NOT NULL ,
	[photo_1] [varchar] (32) NULL ,
	[photo_2] [varchar] (32) NULL ,
	[photo_3] [varchar] (32) NULL ,
	[photo_4] [varchar] (32) NULL ,
	[photo_5] [varchar] (32) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[political] (
	[choice] [char] (64) NULL ,
	[value] [char] (1) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[profession] (
	[choice] [char] (48) NULL ,
	[value] [char] (3) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[income] (
	[choice] [char] (32) NULL ,
	[value] [char] (2) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[recurring_transactions] (
	[user_name] [varchar] (32) NOT NULL ,
	[sendable] [char] (1) NOT NULL ,
	[transaction_type] [varchar] (18) NOT NULL ,
	[date_of_this_transaction] [datetime] NOT NULL ,
	[date_of_next_transaction] [datetime] NOT NULL ,
	[card_type] [char] (1) NOT NULL ,
	[name_on_card] [varchar] (64) NULL ,
	[account_number] [varchar] (32) NULL ,
	[expiration_month] [char] (2) NULL ,
	[expiration_year] [char] (4) NULL ,
	[x_method] [varchar] (18) NOT NULL ,
	[bank_ABA_code] [varchar] (9) NULL ,
	[bank_account_number] [varchar] (32) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[relationship] (
	[user_name] [varchar] (32) NOT NULL ,
	[prefer_not_to_say] [char] (1) NOT NULL ,
	[any_relationship] [char] (1) NOT NULL ,
	[hang_out] [char] (1) NOT NULL ,
	[short_term] [char] (1) NOT NULL ,
	[long_term] [char] (1) NOT NULL ,
	[talk_email] [char] (1) NOT NULL ,
	[photo_exchange] [char] (1) NOT NULL ,
	[marriage] [char] (1) NOT NULL ,
	[other] [char] (1) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[religion] (
	[choice] [char] (32) NULL ,
	[value] [char] (2) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[sex] (
	[choice] [char] (32) NOT NULL ,
	[value] [char] (1) NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[sex_preference] (
	[choice] [varchar] (32) NULL ,
	[value] [char] (1) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[smoke] (
	[choice] [varchar] (32) NULL ,
	[value] [char] (1) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[state] (
	[choice] [varchar] (32) NOT NULL ,
	[value] [char] (3) NOT NULL ,
	[iso_name] [char] (3) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[transactions_log] (
	[transaction_id] [char] (52) NOT NULL ,
	[batch_transaction_id] [varchar] (60) NULL ,
	[user_id] [varchar] (32) NOT NULL ,
	[user_name] [varchar] (32) NOT NULL ,
	[card_type] [char] (1) NOT NULL ,
	[name_on_card] [varchar] (64) NOT NULL ,
	[account_number] [varchar] (32) NOT NULL ,
	[expiration_month] [char] (2) NOT NULL ,
	[expiration_year] [char] (3) NOT NULL ,
	[transaction_type] [varchar] (18) NOT NULL ,
	[x_response_code] [char] (1) NOT NULL ,
	[months_joined] [varchar] (3) NOT NULL ,
	[amount] [money] NOT NULL ,
	[date_of_this_transaction] [datetime] NOT NULL ,
	[date_of_next_transaction] [datetime] NOT NULL ,
	[x_response_subcode] [char] (6) NULL ,
	[x_response_reason_code] [char] (2) NULL ,
	[x_response_reason_text] [varchar] (320) NULL ,
	[x_auth_code] [char] (8) NULL ,
	[x_avs_code] [char] (1) NULL ,
	[x_trans_id] [char] (9) NULL ,
	[x_md5_hash] [varchar] (50) NULL ,
	[x_description] [varchar] (256) NULL ,
	[x_method] [varchar] (18) NOT NULL ,
	[bank_ABA_code] [varchar] (9) NULL ,
	[bank_account_number] [varchar] (32) NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[weight] (
	[choice] [varchar] (32) NULL ,
	[value] [char] (4) NULL 
) ON [PRIMARY]
GO

