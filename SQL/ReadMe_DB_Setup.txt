Scripts needed to set up a new DB:
 1.	DropAndCreateAllConnectionsTables.sql
 		If the tables have changed since the date of this 
 		file you will need to regenerate this script.
 2.	Generate_Lookup_Table_Populator.sql
 		If a new look up table has been added to the Connecitons 
 		design you will need to get the programmer to update this file
 3.	DropAndCreateAllConnectionsStoredProcedures.sql
 		If the tables have changed since the date of this 
 		file you will need to regenerate this script.
 4.	Initialize_Administrator_Profile.sql
 		If a new look up table has been added to the Connecitons 
 		design you will need to get the programmer to update this file


Setting up a new database
 1.	Create a new database
 2.	Set up new login
 3.	Add the new login name to the Advertising DB Users
 4.	login using the new login name you just created and run DropAndCreateAllConnectionsTables.sql
 5.	Open a new database connection, say Manhattan_Connections, and run Generate_Lookup_Table_Populator.sql
 	sending the output to a file.
 6.	Go back to you new database SQL Query Analyzer window and open the file you just created and execute it.
 7.	run DropAndCreateAllConnectionsStoredProcedures.sql
 8.	run Initialize_Administrator_Profile.sql


