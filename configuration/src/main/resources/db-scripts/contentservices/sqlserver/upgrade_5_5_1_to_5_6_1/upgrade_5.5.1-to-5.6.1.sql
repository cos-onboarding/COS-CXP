update PROPERTY_DEFINITION set required = 0 where required is null
GO

alter table PROPERTY_DEFINITION alter column required numeric(1,0) not null
GO

alter table PROPERTY_DEFINITION add constraint def_req default 0 for required
GO

insert into property_definition (cardinality, displayname, inherited, localname, localnamespace, objectid, object_type_id, orderable, queryname, queryable, required, type, updatability)
  select 'single',
    'Publish State',
    '0',
    'bb:publishState',
    'http://docs.oasis-open.org/ns/cmis/core/200908/',
    'bb:publishState',
    id,
    '0',
    'bb:publishState',
    '0',
    0,
    'string',
    'readwrite'
  from object_type_definition
  where objectid='cmis:document'
GO


INSERT INTO PROPERTY_DATA (
  DISPLAYNAME, OBJECT_DATA_ID, OBJECTID, PROPERTY_DEFINITION_ID, QUERYNAME)
  SELECT
    'Publish State',
    OD.ID,
    'bb:publishState',
    (SELECT PDEF.ID FROM PROPERTY_DEFINITION AS PDEF WHERE PDEF.OBJECTID = 'bb:publishState'),
    'bb:publishState'
  FROM OBJECT_DATA AS OD
    join OBJECT_TYPE_DEFINITION as OTD on OD.OBJECT_TYPE_ID=OTD.ID
  WHERE OTD.BASETYPE = 'cmis:document'
GO


create table repository_definition (
  id numeric(19,0) NOT NULL IDENTITY PRIMARY KEY,
  REPOSITORY_ID varchar(255) NOT NULL,
  NAME varchar(255) NOT NULL,
  DESCRIPTION varchar(255) DEFAULT NULL,
  VENDOR_NAME varchar(255) DEFAULT NULL,
  PRODUCT_NAME varchar(255) DEFAULT NULL,
  PRODUCT_VERSION varchar(255) NOT NULL,
  CONSTRAINT UK_REPO_ID unique(REPOSITORY_ID),
  constraint UK_NAME unique(NAME)
)
GO

insert into repository_definition
values
  ('contentRepository',
   'Content Repository',
   'Backbase Content Services content repository for storing content, both pulled and pushed in from sources like a CMS or webfeeds.',
   'Backbase',
   'Backbase Content Repository',
   '0.1'),
  (
   'configurationRepository',
   'Configuration Repository',
   'Backbase Content Services configuration Services repository for storing configuration, both pulled and pushed in from sources like a CMS or webfeeds.',
   'Backbase','Backbase Configuration Repository','0.1'),
  (
   'resourceRepository',
   'Resource Repository',
   'Backbase Content Services resource repository for storing resources, both pulled and pushed in from sources like a CMS or webfeeds.',
   'Backbase','Backbase Resource Repository','0.1')
go

create table relationships (
  id numeric(19,0) NOT NULL IDENTITY PRIMARY KEY,
  objectId varchar(255) NOT NULL,
  sourceId numeric(19,0) DEFAULT NULL,
  targetRepositoryId varchar(255) NOT NULL,
  targetObjectId varchar(255) NOT NULL,
  relationshipType varchar(255) NOT NULL,
  CONSTRAINT FK_REL_OD FOREIGN KEY (sourceId) REFERENCES object_data (id)
)
go

create index FK_SOURCE_ID on relationships(sourceId)
go

create index REL_TARGET_IDX on relationships(targetRepositoryId,targetObjectId)
go

EXEC sp_rename 'OBJECT_DATA.objectDataPath', 'path', 'COLUMN'
go

alter table OBJECT_DATA add RD_ID numeric(19,0)
go

update OBJECT_DATA set RD_ID = '1' where RD_ID is null
go

alter table OBJECT_DATA alter column RD_ID numeric(19,0) not null
go

alter table OBJECT_DATA add constraint FK_OD_RD foreign key (RD_ID) references repository_definition (id)
go

alter table OBJECT_TYPE_DEFINITION add RD_ID numeric(19,0) DEFAULT 1 NOT NULL;

DECLARE @SQL VARCHAR(4000)
SET @SQL = 'ALTER TABLE OBJECT_TYPE_DEFINITION DROP CONSTRAINT ' +
    (SELECT name FROM sysobjects WHERE xtype = 'UQ' AND parent_obj = OBJECT_ID('OBJECT_TYPE_DEFINITION'))
EXEC (@SQL)
go

DECLARE @SQL_OBJECTID VARCHAR(4000)
SET @SQL_OBJECTID = 'ALTER TABLE OBJECT_DATA DROP CONSTRAINT ' +
    (select TC.Constraint_Name from information_schema.table_constraints TC
inner join information_schema.constraint_column_usage CC on TC.Constraint_Name = CC.Constraint_Name
where TC.constraint_type = 'Unique' AND CC.COLUMN_NAME = 'objectId')
EXEC (@SQL_OBJECTID)
go

create index FK_OD_IDX_OTD_RD_REPOID ON OBJECT_DATA (RD_ID)
go

UPDATE PROPERTY_DEFINITION SET localname='cmis:changeToken', objectid='cmis:changeToken', queryname='cmis:changeToken'
WHERE localname='cmis:changetoken' or objectid='cmis:changetoken' or queryname='cmis:changetoken';
go

UPDATE PROPERTY_DATA SET objectid='cmis:changeToken', queryname='cmis:changeToken'
WHERE objectid='cmis:changetoken' or queryname='cmis:changetoken';
go