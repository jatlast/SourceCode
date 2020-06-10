SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[updateBookMarks]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[updateBookMarks]
GO



CREATE PROCEDURE [updateBookMarks]
@UserName char(32)
, @Password char(32)
, @BookMark char(32)
, @AddRemove char(8)

 AS

if (@AddRemove = 'Add')
BEGIN
	print 'Add book_mark to book_marks table'
	if exists (select user_name from book_marks where user_name = @UserName AND book_mark = @BookMark)
	BEGIN
		print 'book_mark already exists.'
		return 1
	END
	else
	BEGIN
		print 'book_mark does not exist in book_marks'
			print 'insert user_name and book_mark into the book_marks table'
			insert into book_marks (user_name
					, book_mark
					) 
			values (@UserName
				, @BookMark
				)
		return 1
	END
END
else
if (@AddRemove = 'Remove')
BEGIN
	print 'Remove book_mark from book_marks table'
	DELETE book_marks
		WHERE user_name = @UserName
		AND book_mark = @BookMark
	return 1
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

