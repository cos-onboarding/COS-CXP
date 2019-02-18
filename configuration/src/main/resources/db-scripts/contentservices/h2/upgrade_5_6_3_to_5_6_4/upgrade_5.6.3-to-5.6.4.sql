alter table OBJECT_DATA
  add column RD_REPOSITORY_ID varchar(36);

update OBJECT_DATA od set od.RD_REPOSITORY_ID = (
  select rd.REPOSITORY_ID from REPOSITORY_DEFINITION rd where rd.id = od.RD_ID
);

alter table OBJECT_DATA
  modify RD_REPOSITORY_ID varchar(36) not null;

alter table OBJECT_DATA
  drop foreign key FK_6gu2if5arkmusbvrssixki55r;

drop index FK_OD_IDX_OD_RD_REPOID on OBJECT_DATA;

create index FK_OD_IDX_OD_RD_REPOID on OBJECT_DATA (RD_REPOSITORY_ID);

alter table OBJECT_DATA
  add constraint FK_6gu2if5arkmusbvrssixki55r
  foreign key (RD_REPOSITORY_ID)
  references REPOSITORY_DEFINITION (REPOSITORY_ID);

alter table OBJECT_DATA
  drop column RD_ID;

update RELATIONSHIPS rel set rel.sourceObjectId = (
  select obj.objectId from OBJECT_DATA obj where obj.id = rel.sourceId
);

alter table RELATIONSHIPS MODIFY sourceObjectId varchar(36) not null;

alter table OBJECT_DATA add column objectTypeId varchar(255);

update OBJECT_DATA set objectTypeId = (select objectId from OBJECT_TYPE_DEFINITION where OBJECT_DATA.OBJECT_TYPE_ID = OBJECT_TYPE_DEFINITION.id);

alter table OBJECT_DATA drop constraint FK_354y502ct1ju7tg6v1rlfpwgo;

alter table PROPERTY_DEFINITION drop constraint FK_s6scxspskrpjulqsj4u98us2g;

alter table PROPERTY_DATA drop constraint FK_c2yshju50dy6nutodteogo28t;

alter table OBJECT_DATA drop column OBJECT_TYPE_ID;

alter table PROPERTY_DATA drop column PROPERTY_DEFINITION_ID;

drop table OBJECT_TYPE_DEFINITION;

drop table PROPERTY_DEFINITION;

alter table OBJECT_DATA modify objectTypeId varchar(255) not null;