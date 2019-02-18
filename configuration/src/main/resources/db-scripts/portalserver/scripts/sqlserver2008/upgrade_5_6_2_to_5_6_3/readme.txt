This update is not necessary in case the database is already set case sensitive. To check the case
sensitivity of the database please execute:

> SELECT collation_name FROM sys.databases WHERE name = 'portal';

Example: COLLATE Latin1_General_CS_AS_KS

The database collation should be exactly as above (according to specification): https://my.backbase.com/docs/product-documentation/documentation//portal/5.6.3/sqlserver_portalservices.html
The CS indicates the case sensitivity.

CS : Case Sensitive
CI : Case Insensitive

BEFORE EXECUTING THE COMMANDS BELOW PLEASE MAKE A BACKUP OF THE DATABASE

To change the database to case sensitive please execute:

> ALTER DATABASE portal COLLATE Latin1_General_CS_AS_KS;

If below errors appears:
The database could not be exclusively locked to perform the operation. ALTER DATABASE failed. The default collation of database 'portal' cannot be set to Latin1_General_CS_AS_KS.

Then set the database to single user mode first:

> ALTER DATABASE portal SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
> ALTER DATABASE portal COLLATE Latin1_General_CS_AS_KS;
> ALTER DATABASE portal SET MULTI_USER WITH ROLLBACK IMMEDIATE;

Now check if the database case sensitivity was changed:

> SELECT collation_name FROM sys.databases WHERE name = 'portal';

Check if the collation of the database was changed to Latin1_General_CS_AS_KS.

Now the upgrade-5.6.2-to-5.6.3.ddl script can be executed to change the lower cased 'id' collumns to uppercase.

If any step fails contact Backbase Support and restore the backup as instructed before executing the changes.

NOTE: sp_rename automatically renames the associated index whenever a PRIMARY KEY or UNIQUE constraint is renamed.
If a renamed index is tied to a PRIMARY KEY constraint, the PRIMARY KEY constraint is also automatically renamed by sp_rename.