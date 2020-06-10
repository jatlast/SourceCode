SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[verifyMembershipTypePermissions]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[verifyMembershipTypePermissions]
GO


CREATE PROCEDURE [verifyMembershipTypePermissions]
	@UserName varchar(32)
	, @FeatureRequested varchar (32)
 AS

-- Check if this is a promotional membership_type
if (
	 (select membership_type.date_promotion_ended
		from login_info
		  , membership_type
		where login_info.membership_type = membership_type_id
		and login_info.user_name = @UserName
	) != NULL
   )
BEGIN
	print 'Promotional Membership'
	print 'Must check Promotion Date'
	if (
		 (select membership_type.date_promotion_ended
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) > getdate()
	   )
	BEGIN
		print 'Promotion is active'
	END
	else
	BEGIN
		print 'Promotion Expired'
		return 600
	END	
END
else
BEGIN
	print 'Non-Promotional Membership'
END

if ( @FeatureRequested = 'allow_search_simple' )
BEGIN
	print 'Check allow_search_simple permissions'
	if (
		 (select membership_type.allow_search_simple
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_search_simple'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_search_simple'
		return 601
	END
END
if ( @FeatureRequested = 'allow_search_advanced' )
BEGIN
	print 'Check allow_search_advanced permissions'
	if (
		 (select membership_type.allow_search_advanced
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_search_advanced'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_search_advanced'
		return 602
	END
END
if ( @FeatureRequested = 'allow_view_profiles' )
BEGIN
	print 'Check allow_view_profiles permissions'
	if (
		 (select membership_type.allow_view_profiles
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_view_profiles'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_view_profiles'
		return 603
	END
END
if ( @FeatureRequested = 'allow_mail_receive' )
BEGIN
	print 'Check allow_mail_receive permissions'
	if (
		 (select membership_type.allow_mail_receive
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_mail_receive'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_mail_receive'
		return 604
	END
END
if ( @FeatureRequested = 'allow_mail_read' )
BEGIN
	print 'Check allow_mail_read permissions'
	if (
		 (select membership_type.allow_mail_read
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_mail_read'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_mail_read'
		return 605
	END
END
if ( @FeatureRequested = 'allow_mail_send' )
BEGIN
	print 'Check allow_mail_send permissions'
	if (
		 (select membership_type.allow_mail_send
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_mail_send'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_mail_send'
		return 606
	END
END
if ( @FeatureRequested = 'allow_mail_reply' )
BEGIN
	print 'Check allow_mail_reply permissions'
	if (
		 (select membership_type.allow_mail_reply
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_mail_reply'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_mail_reply'
		return 607
	END
END
if ( @FeatureRequested = 'allow_romance_wizard' )
BEGIN
	print 'Check allow_romance_wizard permissions'
	if (
		 (select membership_type.allow_romance_wizard
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_romance_wizard'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_romance_wizard'
		return 608
	END
END
if ( @FeatureRequested = 'allow_chat_view' )
BEGIN
	print 'Check allow_chat_view permissions'
	if (
		 (select membership_type.allow_chat_view
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_chat_view'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_chat_view'
		return 609
	END
END
if ( @FeatureRequested = 'allow_chat_use' )
BEGIN
	print 'Check allow_chat_use permissions'
	if (
		 (select membership_type.allow_chat_use
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_chat_use'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_chat_use'
		return 610
	END
END
if ( @FeatureRequested = 'allow_view_stats' )
BEGIN
	print 'Check allow_view_stats permissions'
	if (
		 (select membership_type.allow_view_stats
			from login_info
			  , membership_type
			where login_info.membership_type = membership_type_id
			and login_info.user_name = @UserName
		) = 1
	   )
	BEGIN
		print 'Permission GRANTED for allow_view_stats'
		return 1
	END
	else
	BEGIN
		print 'Permission DENIED for allow_view_stats'
		return 611
	END
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

