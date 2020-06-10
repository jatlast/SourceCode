SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updatePicture]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updatePicture]
GO



CREATE PROCEDURE [updatePicture]
@UserName varchar(32)
, @Password varchar(16)
, @PictureNumber int
, @PictureName varchar(32)

 AS

-- Update the pictures table by adding the new picture_name to the existing user
if exists (select user_name from pictures where user_name = @UserName)
BEGIN
	if ( (select password from login_info where user_name = @UserName) = @Password)
	BEGIN
		if(@PictureNumber = 1)
		BEGIN
			print 'update photo_1 in the pictures table'
			update pictures 
				set photo_1 = @PictureName
				where user_name = @UserName
		END
		else if(@PictureNumber = 2)
		BEGIN
			print 'update photo_2 in the pictures table'
			update pictures 
				set photo_2 = @PictureName
				where user_name = @UserName
		END
		else if(@PictureNumber = 3)
		BEGIN
			print 'update photo_3 in the pictures table'
			update pictures 
				set photo_3 = @PictureName
				where user_name = @UserName
		END
		else if(@PictureNumber = 4)
		BEGIN
			print 'update photo_4 in the pictures table'
			update pictures 
				set photo_4 = @PictureName
				where user_name = @UserName
		END
		else if(@PictureNumber = 5)
		BEGIN
			print 'update photo_5 in the pictures table'
			update pictures 
				set photo_5 = @PictureName
				where user_name = @UserName
		END
		print 'update photo_submitted in the login_info table'
		update login_info 
			set photo_submitted = 1
			where user_name = @UserName
		return 1
	END
	else
	BEGIN
		print 'user_name & password did not match.'
		return 666
	END

END
-- Insert the user_name and picture_name into the pictures table if the user_name does not already exist
else
BEGIN
	print 'user_name does not exist'
	if(@PictureNumber = 1)
	BEGIN
		print 'insert photo_1 in the pictures table'
		insert into pictures (user_name
				, photo_1
				) 
		values (@UserName
			, @PictureName
			)
	END
	else if(@PictureNumber = 2)
	BEGIN
		print 'insert photo_2 in the pictures table'
		insert into pictures (user_name
				, photo_2
				) 
		values (@UserName
			, @PictureName
			)
	END
	else if(@PictureNumber = 3)
	BEGIN
		print 'insert photo_3 in the pictures table'
		insert into pictures (user_name
				, photo_3
				) 
		values (@UserName
			, @PictureName
			)
	END
	else if(@PictureNumber = 4)
	BEGIN
		print 'insert photo_4 in the pictures table'
		insert into pictures (user_name
				, photo_4
				) 
		values (@UserName
			, @PictureName
			)
	END
	else if(@PictureNumber = 5)
	BEGIN
		print 'insert photo_5 in the pictures table'
		insert into pictures (user_name
				, photo_5
				) 
		values (@UserName
			, @PictureName
			)
	END
	print 'update photo_submitted in the login_info table'
	update login_info 
		set photo_submitted = 1
		where user_name = @UserName
	return 1
END

-- clean up all pictures table entries that no longer have pictures...
UPDATE login_info
SET photo_submitted = '0'
WHERE user_name IN ( SELECT login_info.user_name
 FROM login_info
	, pictures
WHERE pictures.user_name = login_info.user_name
AND pictures.photo_1 = 'Nothing'
AND pictures.photo_2 = 'Nothing'
AND pictures.photo_3 = 'Nothing'
AND pictures.photo_4 = 'Nothing'
AND pictures.photo_5 = 'Nothing'
AND login_info.photo_submitted = '1'
)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

