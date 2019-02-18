update PROPERTY_DEFINITION set required = 0 where required is null;
alter table PROPERTY_DEFINITION ALTER COLUMN required boolean default 0 not null;

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
  where objectid='cmis:document';


INSERT INTO property_data (
  displayname, object_data_id, objectid, property_definition_id, queryname)
  SELECT
    'Publish State',
    OD.ID,
    'bb:publishState',
    (SELECT PDEF.ID FROM property_definition AS PDEF WHERE PDEF.objectid = 'bb:publishState'),
    'bb:publishState'
  FROM object_data AS OD
    join OBJECT_TYPE_DEFINITION as OTD on OD.OBJECT_TYPE_ID=OTD.ID
  WHERE OTD.BASETYPE = 'cmis:document';


create table repository_definition (
  id bigint PRIMARY KEY NOT NULL,
  REPOSITORY_ID varchar(255) NOT NULL,
  NAME varchar(255) NOT NULL,
  DESCRIPTION varchar(255) DEFAULT NULL,
  VENDOR_NAME varchar(255) DEFAULT NULL,
  PRODUCT_NAME varchar(255) DEFAULT NULL,
  PRODUCT_VERSION varchar(255) NOT NULL,
  CONSTRAINT UK_REPO_ID UNIQUE(REPOSITORY_ID),
  CONSTRAINT UK_NAME UNIQUE (NAME)
);

insert into repository_definition
values
  (1,
   'contentRepository',
   'Content Repository',
   'Backbase Content Services content repository for storing content, both pulled and pushed in from sources like a CMS or webfeeds.',
   'Backbase',
   'Backbase Content Repository',
   '0.1'),
  (2,
   'configurationRepository',
   'Configuration Repository',
   'Backbase Content Services configuration Services repository for storing configuration, both pulled and pushed in from sources like a CMS or webfeeds.',
   'Backbase','Backbase Configuration Repository','0.1'),
  (3,
   'resourceRepository',
   'Resource Repository',
   'Backbase Content Services resource repository for storing resources, both pulled and pushed in from sources like a CMS or webfeeds.',
   'Backbase','Backbase Resource Repository','0.1');

create table relationships (
  id bigint PRIMARY KEY NOT NULL,
  objectId varchar(255) NOT NULL,
  sourceId bigint DEFAULT NULL,
  targetRepositoryId varchar(255) NOT NULL,
  targetObjectId varchar(255) NOT NULL,
  relationshipType varchar(255) NOT NULL,
  CONSTRAINT FK_REL_OD FOREIGN KEY (sourceId) REFERENCES object_data (id)
);

create index FK_SOURCE_ID on relationships(sourceId);
create index REL_TARGET_IDX on relationships(targetRepositoryId,targetObjectId);

CREATE ALIAS IF NOT EXISTS EXECUTE AS $$ void executeSql(Connection conn, String sql)
throws SQLException { conn.createStatement().executeUpdate(sql); } $$;
call execute('alter table object_data drop constraint ' || (select distinct constraint_name from information_schema.constraints
where table_name='OBJECT_DATA' and column_list='OBJECTID'));

alter table OBJECT_DATA alter column objectDataPath rename to path;
alter table OBJECT_DATA add RD_ID bigint;

update OBJECT_DATA set RD_ID = '1' where RD_ID is null;

alter table OBJECT_DATA alter column RD_ID set NOT NULL;
alter table OBJECT_DATA add constraint FK_OD_RD foreign key (RD_ID) references repository_definition (id);

create index FK_OD_IDX_OD_RD_REPOID ON OBJECT_DATA (RD_ID);

alter table OBJECT_TYPE_DEFINITION add RD_ID bigint DEFAULT 1 NOT NULL;

ALTER TABLE PUBLIC.OBJECT_TYPE_DEFINITION
ADD FOREIGN KEY (RD_ID)
REFERENCES PUBLIC.REPOSITORY_DEFINITION(ID);

create index FK_OD_IDX_OTD_RD_REPOID ON OBJECT_TYPE_DEFINITION (RD_ID);

CREATE ALIAS IF NOT EXISTS EXECUTE AS $$ void executeSql(Connection conn, String sql)
throws SQLException { conn.createStatement().executeUpdate(sql); } $$;
call execute('alter table object_type_definition drop constraint ' || (select distinct constraint_name from information_schema.constraints
where table_name='OBJECT_TYPE_DEFINITION' and column_list='OBJECTID'));

UPDATE property_definition SET localname='cmis:changeToken', objectid='cmis:changeToken', queryname='cmis:changeToken'
WHERE localname='cmis:changetoken' or objectid='cmis:changetoken' or queryname='cmis:changetoken';
UPDATE property_data SET objectid='cmis:changeToken', queryname='cmis:changeToken'
WHERE objectid='cmis:changetoken' or queryname='cmis:changetoken';