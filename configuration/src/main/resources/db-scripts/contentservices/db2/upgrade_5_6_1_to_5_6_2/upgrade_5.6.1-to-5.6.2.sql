ALTER TABLE relationships ALTER COLUMN targetRepositoryId SET DATA TYPE varchar(36);
ALTER TABLE relationships ALTER COLUMN targetObjectId SET DATA TYPE varchar(36);

REORG table relationships;