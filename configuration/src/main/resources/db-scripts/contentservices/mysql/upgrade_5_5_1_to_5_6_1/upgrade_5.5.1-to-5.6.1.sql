update PROPERTY_DEFINITION set required = 0 where required is null;
alter table PROPERTY_DEFINITION MODIFY required bit(1) not null default 0;

insert into PROPERTY_DEFINITION (cardinality, displayname, inherited, localname, localnamespace, objectid, object_type_id, orderable, queryname, queryable, required, type, updatability)
  select 'single',
    'Publish State',
    0,
    'bb:publishState',
    'http://docs.oasis-open.org/ns/cmis/core/200908/',
    'bb:publishState',
    id,
    0,
    'bb:publishState',
    0,
    0,
    'string',
    'readwrite'
  from OBJECT_TYPE_DEFINITION
  where objectid='cmis:document';


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
  WHERE OTD.BASETYPE = 'cmis:document';


create table `REPOSITORY_DEFINITION` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `REPOSITORY_ID` varchar(255) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `VENDOR_NAME` varchar(255) DEFAULT NULL,
  `PRODUCT_NAME` varchar(255) DEFAULT NULL,
  `PRODUCT_VERSION` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_REPO_ID` (`REPOSITORY_ID`),
  UNIQUE KEY `UK_NAME` (`NAME`)
)  ROW_FORMAT=DYNAMIC;

insert into REPOSITORY_DEFINITION
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

create table `RELATIONSHIPS` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `objectId` varchar(255) NOT NULL,
  `sourceId` bigint(20) DEFAULT NULL,
  `targetRepositoryId` varchar(255) NOT NULL,
  `targetObjectId` varchar(255) NOT NULL,
  `relationshipType` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_SOURCE_ID` (`sourceId`),
  KEY `REL_TARGET_IDX` (`targetRepositoryId`,`targetObjectId`),
  CONSTRAINT `FK_REL_OD` FOREIGN KEY (`sourceId`) REFERENCES `OBJECT_DATA` (`id`)
) ROW_FORMAT=DYNAMIC;

alter table OBJECT_DATA change objectDataPath path varchar(765) NOT NULL;

alter table OBJECT_DATA add column RD_ID bigint(20);

update OBJECT_DATA set RD_ID = 1 where RD_ID is null;

alter table OBJECT_DATA MODIFY RD_ID bigint(20) NOT NULL;

alter table OBJECT_DATA add constraint FK_OD_RD foreign key (RD_ID) references REPOSITORY_DEFINITION (id);

create index FK_OD_IDX_OD_RD_REPOID ON OBJECT_DATA (RD_ID);

alter table OBJECT_TYPE_DEFINITION add RD_ID bigint(20) DEFAULT 1 NOT NULL;

set @tmp = (select constraint_name from information_schema.key_column_usage
where table_name='OBJECT_TYPE_DEFINITION' and column_name='OBJECTID' and
      information_schema.key_column_usage.table_schema = (SELECT DATABASE() FROM DUAL));
set @que = concat("alter table OBJECT_TYPE_DEFINITION drop index ", @tmp);
prepare stmt from @que;
execute stmt;

set @objectid_unique = (select constraint_name from information_schema.key_column_usage
where table_name='OBJECT_DATA' and column_name='OBJECTID' and
      information_schema.key_column_usage.table_schema = (SELECT DATABASE() FROM DUAL));
set @objectid_query = concat("alter table OBJECT_DATA drop index ", @objectid_unique);
prepare objectid_stmt from @objectid_query;
execute objectid_stmt;

UPDATE PROPERTY_DEFINITION SET localname='cmis:changeToken', objectid='cmis:changeToken', queryname='cmis:changeToken'
WHERE localname='cmis:changetoken' or objectid='cmis:changetoken' or queryname='cmis:changetoken';
UPDATE PROPERTY_DATA SET objectid='cmis:changeToken', queryname='cmis:changeToken'
WHERE objectid='cmis:changetoken' or queryname='cmis:changetoken';

ALTER table OBJECT_DATA ROW_FORMAT=DYNAMIC;
ALTER table CONTENT_STREAM ROW_FORMAT=DYNAMIC;
ALTER table OBJECT_TYPE_DEFINITION ROW_FORMAT=DYNAMIC;
ALTER table PROPERTY_DATA ROW_FORMAT=DYNAMIC;
ALTER table PROPERTY_DEFINITION ROW_FORMAT=DYNAMIC;
ALTER table RENDITION ROW_FORMAT=DYNAMIC;
ALTER table REPOSITORY_DEFINITION ROW_FORMAT=DYNAMIC;
