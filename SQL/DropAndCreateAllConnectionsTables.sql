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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[customer_IP]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[customer_IP]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[income]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[income]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[persian_faces_user_names]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[persian_faces_user_names]
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[recurring_transactions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[recurring_transactions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[relationship]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[relationship]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[religion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[religion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[restricted_IP]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[restricted_IP]
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
	[user_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[screen_quote] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[about_yourself] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[questionable] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[billing_info] (
	[user_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[card_type] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[name_on_card] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[cvv2_code] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[account_number] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[expiration_month] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[expiration_year] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[is_membership_active] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[date_membership_expires] [smalldatetime] NULL ,
	[bank_ABA_code] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bank_account_number] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bank_account_type] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bank_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[name_on_bank_account] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[book_marks] (
	[user_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[book_mark] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[contact_info] (
	[user_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[first_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[last_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[street_address] [varchar] (96) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[city] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[state] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[country] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[zip] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[telephone] [char] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[cook] (
	[choice] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[country] (
	[choice] [char] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[value] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[iso_name] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[credit_card_type] (
	[choice] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[customer_IP] (
	[user_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[user_id] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[IP_address] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[drink] (
	[choice] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[education] (
	[choice] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[eyes] (
	[choice] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[hair] (
	[choice] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[height] (
	[choice] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[housing_status] (
	[choice] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[income] (
	[choice] [char] (48) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[login_info] (
	[user_id] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[user_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[membership_type] [int] NOT NULL ,
	[password] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[password_hint] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[email] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[sex] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[creation_date] [datetime] NOT NULL ,
	[last_login] [datetime] NOT NULL ,
	[photo_submitted] [int] NULL ,
	[date_started_paying] [datetime] NULL ,
	[email_verification_code] [varchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[is_email_verified] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[affiliate_tracking_id] [varchar] (44) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[affiliate_action_status] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[mail] (
	[mail_id] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[sent_to] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[sent_from] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[subject] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[message_text] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[when_sent] [datetime] NOT NULL ,
	[when_read] [datetime] NULL ,
	[sender_deleted] [int] NULL ,
	[receiver_deleted] [int] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[marital_status] (
	[choice] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[membership_cancellation] (
	[unique_id] [char] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[user_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[email] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[date_started_paying] [datetime] NOT NULL ,
	[date_cancelled] [datetime] NOT NULL ,
	[reason_for_leaving] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[membership_prices] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[website_design] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[suggestions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[membership_type] (
	[unique_id]  uniqueidentifier ROWGUIDCOL  NOT NULL ,
	[membership_type_id] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[can_membership_recur] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[membership_type_name] [char] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[membership_description] [varchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[duration_start] [smalldatetime] NULL ,
	[duration_end] [smalldatetime] NULL ,
	[date_promotion_started] [smalldatetime] NULL ,
	[date_promotion_ended] [smalldatetime] NULL ,
	[months_1] [smallmoney] NULL ,
	[months_3] [smallmoney] NULL ,
	[months_6] [smallmoney] NULL ,
	[months_12] [smallmoney] NULL ,
	[months_240] [smallmoney] NULL ,
	[rebilled_1] [smallmoney] NULL ,
	[rebilled_3] [smallmoney] NULL ,
	[rebilled_6] [smallmoney] NULL ,
	[rebilled_12] [smallmoney] NULL ,
	[force_pic_upload] [bit] NOT NULL ,
	[allow_search_simple] [bit] NOT NULL ,
	[allow_search_advanced] [bit] NOT NULL ,
	[allow_view_profiles] [bit] NOT NULL ,
	[allow_mail_receive] [bit] NOT NULL ,
	[allow_mail_read] [bit] NOT NULL ,
	[allow_mail_send] [bit] NOT NULL ,
	[allow_mail_reply] [bit] NOT NULL ,
	[allow_romance_wizard] [bit] NOT NULL ,
	[allow_chat_view] [bit] NOT NULL ,
	[allow_chat_use] [bit] NOT NULL ,
	[allow_view_stats] [bit] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[party] (
	[choice] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[persian_faces_user_names] (
	[user_name] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[personal_info] (
	[user_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[sex_preference] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[age] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[marital_status] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[profession] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[income] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[education] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[religion] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[height] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[weight] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[eyes] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[hair] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[min_age_desired] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[max_age_desired] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[cook] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[smoke] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[drink] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[party] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[political] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[housing_status] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[pictures] (
	[user_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[photo_1] [varchar] (48) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[photo_2] [varchar] (48) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[photo_3] [varchar] (48) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[photo_4] [varchar] (48) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[photo_5] [varchar] (48) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[political] (
	[choice] [char] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[profession] (
	[choice] [char] (48) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[recurring_transactions] (
	[user_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[sendable] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[transaction_type] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[date_of_this_transaction] [datetime] NOT NULL ,
	[date_of_next_transaction] [datetime] NOT NULL ,
	[card_type] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[name_on_card] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[cvv2_code] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[account_number] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[expiration_month] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[expiration_year] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[x_method] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[bank_ABA_code] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bank_account_number] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bank_account_type] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bank_name] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[name_on_bank_account] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[echeck_type] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[rebilling_amount] [smallmoney] NULL ,
	[plan_unique_id] [varchar] (38) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[street_address] [varchar] (96) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[city] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[state] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[zip] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[country] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[telephone] [varchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[relationship] (
	[user_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[prefer_not_to_say] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[any_relationship] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[hang_out] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[short_term] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[long_term] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[talk_email] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[photo_exchange] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[marriage] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[other] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[religion] (
	[choice] [char] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[restricted_IP] (
	[IP_address] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[sex] (
	[choice] [char] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[sex_preference] (
	[choice] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[smoke] (
	[choice] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[state] (
	[choice] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[value] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[iso_name] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[transactions_log] (
	[transaction_id] [char] (52) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[batch_transaction_id] [varchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[user_id] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[user_name] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[x_customer_IP] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[card_type] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[name_on_card] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[cvv2_code] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[account_number] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[expiration_month] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[expiration_year] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[transaction_type] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[x_response_code] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[x_cvv2_resp_code] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[months_joined] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[amount] [smallmoney] NOT NULL ,
	[rebilling_amount] [smallmoney] NULL ,
	[plan_unique_id] [varchar] (38) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[date_of_this_transaction] [smalldatetime] NOT NULL ,
	[date_of_next_transaction] [smalldatetime] NOT NULL ,
	[x_response_subcode] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[x_response_reason_code] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[x_response_reason_text] [varchar] (320) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[x_auth_code] [char] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[x_avs_code] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[x_trans_id] [char] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[x_md5_hash] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[x_description] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[x_method] [varchar] (18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[bank_ABA_code] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bank_account_number] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bank_account_type] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bank_name] [varchar] (51) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[bank_account_name] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[echeck_type] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[street_address] [varchar] (96) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[city] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[state] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[zip] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[country] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[telephone] [varchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[x_FP_Hash] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[weight] (
	[choice] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[value] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[login_info] WITH NOCHECK ADD 
	CONSTRAINT [DF__login_inf__email__1352D76D] DEFAULT (convert(varchar(10),convert(int,(rand() * 100000000)))) FOR [email_verification_code],
	CONSTRAINT [DF__login_inf__is_em__1446FBA6] DEFAULT ('0') FOR [is_email_verified],
	CONSTRAINT [DF__login_inf__where__153B1FDF] DEFAULT ('') FOR [affiliate_tracking_id],
	CONSTRAINT [DF__login_inf__adver__162F4418] DEFAULT (0) FOR [affiliate_action_status]
GO

ALTER TABLE [dbo].[membership_type] WITH NOCHECK ADD 
	CONSTRAINT [DF_membership_type_unique_id] DEFAULT (newid()) FOR [unique_id]
GO

ALTER TABLE [dbo].[relationship] WITH NOCHECK ADD 
	CONSTRAINT [DF_relationship_Prefer not to say] DEFAULT (0) FOR [prefer_not_to_say],
	CONSTRAINT [DF_relationship_Any] DEFAULT (0) FOR [any_relationship],
	CONSTRAINT [DF_relationship_Hang Out] DEFAULT (0) FOR [hang_out],
	CONSTRAINT [DF_relationship_Short-term] DEFAULT (0) FOR [short_term],
	CONSTRAINT [DF_relationship_Long-term] DEFAULT (0) FOR [long_term],
	CONSTRAINT [DF_relationship_Talk/E-mail] DEFAULT (0) FOR [talk_email],
	CONSTRAINT [DF_relationship_Photo Exchange] DEFAULT (0) FOR [photo_exchange],
	CONSTRAINT [DF_relationship_marriage] DEFAULT (0) FOR [marriage],
	CONSTRAINT [DF_relationship_Other Relationship] DEFAULT (0) FOR [other]
GO

