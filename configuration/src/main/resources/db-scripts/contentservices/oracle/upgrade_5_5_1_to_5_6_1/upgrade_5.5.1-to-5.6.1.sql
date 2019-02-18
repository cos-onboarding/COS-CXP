update PROPERTY_DEFINITION set required = 0 where required is null;
alter table PROPERTY_DEFINITION MODIFY ("REQUIRED" DEFAULT 0 NOT NULL ENABLE);

INSERT INTO property_definition (id, cardinality, displayname, inherited, localname, localnamespace, objectid, object_type_id, orderable, queryname, queryable, required, type, updatability)
  SELECT
    hibernate_sequence.nextVal,
    'single',
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
  FROM object_type_definition
  WHERE objectid = 'cmis:document';


INSERT INTO PROPERTY_DATA (
  ID, DISPLAYNAME, OBJECT_DATA_ID, OBJECTID, PROPERTY_DEFINITION_ID, QUERYNAME)
  SELECT
    hibernate_sequence.nextVal,
    'Publish State',
    OD.ID,
    'bb:publishState',
    (SELECT
       PDEF.ID
     FROM PROPERTY_DEFINITION PDEF
     WHERE PDEF.OBJECTID = 'bb:publishState'),
    'bb:publishState'
  FROM OBJECT_DATA OD
    JOIN OBJECT_TYPE_DEFINITION OTD ON OD.OBJECT_TYPE_ID = OTD.ID
  WHERE OTD.BASETYPE = 'cmis:document';


create table RELATIONSHIPS (
    id number(19,0) not null,    
    objectId varchar2(255 char),
    sourceId number(19,0),
    targetRepositoryId number(19,0),
    targetObjectID varchar2(255 char),
    relationshipType varchar2(255 char) not null,
    primary key (id)
);
alter table RELATIONSHIPS
    add constraint FK_a6uckrvvnj0hxeo3dqky7vdgh
    foreign key (sourceId)
    references OBJECT_DATA;
alter table RELATIONSHIPS
    add constraint FK_mdssqaapp7dm9u1oe8ppt5tkr
    foreign key (targetRepositoryId)
    references OBJECT_DATA;

create table repository_definition (
  id number(19,0) NOT NULL,
  REPOSITORY_ID varchar(255) NOT NULL UNIQUE,
  NAME varchar(255) NOT NULL UNIQUE,
  DESCRIPTION varchar(255) DEFAULT NULL,
  VENDOR_NAME varchar(255) DEFAULT NULL,
  PRODUCT_NAME varchar(255) DEFAULT NULL,
  PRODUCT_VERSION varchar(255) NOT NULL,
  PRIMARY KEY (id)
);

insert into repository_definition
values (1,
   'contentRepository',
   'Content Repository',
   'Backbase Content Services content repository for storing content, both pulled and pushed in from sources like a CMS or webfeeds.',
   'Backbase',
   'Backbase Content Repository',
   '0.1');
insert into  repository_definition
values (2,
   'configurationRepository',
   'Configuration Repository',
   'Backbase Content Services configuration Services repository for storing configuration, both pulled and pushed in from sources like a CMS or webfeeds.',
   'Backbase','Backbase Configuration Repository','0.1');
insert into  repository_definition
values (3,
   'resourceRepository',
   'Resource Repository',
   'Backbase Content Services resource repository for storing resources, both pulled and pushed in from sources like a CMS or webfeeds.',
   'Backbase','Backbase Resource Repository','0.1');


alter table OBJECT_DATA drop unique(OBJECTID);

alter table OBJECT_DATA rename column objectDataPath to path;

alter table OBJECT_DATA add RD_ID number(19,0);

update OBJECT_DATA set RD_ID = '1' where RD_ID is null;

alter table OBJECT_DATA modify RD_ID number(19,0) NOT NULL;

alter table OBJECT_DATA
     add constraint FK_OD_RD foreign key (RD_ID)
     references repository_definition (id);

alter table OBJECT_TYPE_DEFINITION add RD_ID number(19,0) DEFAULT 1 NOT NULL;

alter table OBJECT_TYPE_DEFINITION drop unique(OBJECTID);

create index FK_OD_IDX_OD_RD_REPOID ON OBJECT_DATA (RD_ID);

UPDATE PROPERTY_DEFINITION SET localname='cmis:changeToken', objectid='cmis:changeToken', queryname='cmis:changeToken'
WHERE localname='cmis:changetoken' or objectid='cmis:changetoken' or queryname='cmis:changetoken';
UPDATE PROPERTY_DATA SET objectid='cmis:changeToken', queryname='cmis:changeToken'
WHERE objectid='cmis:changetoken' or queryname='cmis:changetoken';