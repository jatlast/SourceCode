create database New_DB2

sp_addlogin 'jason', 'baumbach', 'WebDB_1'

sp_grantdbaccess 'jason'

sp_helpuser
go
sp_helpuser 'jatlast'
go


