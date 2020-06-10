osql -Usa -P -Q "drop database GSTPA_BDR" -n
osql -Usa -P -Q "create database GSTPA_BDR" -n
osql -Usa -P -d "GSTPA_BDR" -i "GSTPA BDR TABLES & VIEWS.sql" -n
osql -Usa -P -d "GSTPA_BDR" -i "GSTPA BDR Drop FK Constraints.sql" -n
osql -Usa -P -d "GSTPA_BDR" -i "..\Test Data\State Table.sql" -n
osql -Usa -P -d "GSTPA_BDR" -i "..\Test Data\TestData_BDR.sql" -n
osql -Usa -P -d "GSTPA_BDR" -i "GSTPA Triggers and SPs.sql" -n
osql -Usa -P -d "GSTPA_BDR" -i "GSTPA BDR Add FK Constraints.sql" -n
