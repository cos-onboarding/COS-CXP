alter table OBJECT_DATA ADD RD_REPOSITORY_ID nvarchar(36)
go

update OBJECT_DATA set  OBJECT_DATA.RD_REPOSITORY_ID = REPOSITORY_DEFINITION.REPOSITORY_ID
from OBJECT_DATA, REPOSITORY_DEFINITION where OBJECT_DATA.RD_ID = REPOSITORY_DEFINITION.id
go

alter table OBJECT_DATA alter column RD_REPOSITORY_ID nvarchar(36) not null
go

alter table OBJECT_DATA
  drop constraint FK_6gu2if5arkmusbvrssixki55r
go

drop index FK_OD_IDX_OD_RD_REPOID ON OBJECT_DATA
go

create index FK_OD_IDX_OD_RD_REPOID on OBJECT_DATA (RD_REPOSITORY_ID)
go

alter table OBJECT_DATA drop column RD_ID
go

ALTER TABLE RELATIONSHIPS ADD sourceObjectId VARCHAR(36)
go

UPDATE RELATIONSHIPS SET RELATIONSHIPS.sourceObjectId = (SELECT objectId FROM OBJECT_DATA WHERE RELATIONSHIPS.sourceId = OBJECT_DATA.id)
go

ALTER TABLE RELATIONSHIPS ALTER COLUMN sourceObjectId VARCHAR(36) NOT NULL
go

alter table OBJECT_DATA ADD objectTypeId nvarchar(255)
go

update OBJECT_DATA set OBJECT_DATA.objectTypeId = OBJECT_TYPE_DEFINITION.objectId from OBJECT_TYPE_DEFINITION , OBJECT_DATA
where OBJECT_DATA.OBJECT_TYPE_ID = OBJECT_TYPE_DEFINITION.id
go

alter table OBJECT_DATA drop constraint FK_354y502ct1ju7tg6v1rlfpwgo
go

alter table PROPERTY_DEFINITION drop constraint FK_s6scxspskrpjulqsj4u98us2g
go

alter table PROPERTY_DATA drop constraint FK_c2yshju50dy6nutodteogo28t
go

drop index FK_OD_IDX_OBJECT_TYPE_ID ON OBJECT_DATA
go

alter table OBJECT_DATA drop column OBJECT_TYPE_ID
go

drop index FK_PD_IDX_PROP_DEF_ID ON PROPERTY_DATA
go

alter table PROPERTY_DATA drop column PROPERTY_DEFINITION_ID
go

drop table OBJECT_TYPE_DEFINITION
go

drop table PROPERTY_DEFINITION
go

ALTER TABLE OBJECT_DATA ALTER COLUMN objectTypeId varchar(255) not null
go

create nonclustered index IDX_OPT_IX001 ON OBJECT_DATA (objectId, RD_REPOSITORY_ID)
GO

create nonclustered index IDX_OPT_IX002 ON RELATIONSHIPS (objectId)
GO

create nonclustered index IDX_OPT_IX003 ON RELATIONSHIPS (relationshipType)
GO

create nonclustered index IDX_OPT_IX004 ON RELATIONSHIPS (sourceId)
include (id, objectId, targetRepositoryId, targetObjectId, relationshipType, sourceObjectId)
GO

create nonclustered index IDX_OPT_IX005 ON RELATIONSHIPS (sourceObjectId)
include (id, objectId, sourceId, targetRepositoryId, targetObjectId, relationshipType)
GO


