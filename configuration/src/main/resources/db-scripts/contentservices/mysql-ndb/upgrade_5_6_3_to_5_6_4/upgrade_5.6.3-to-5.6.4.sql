alter table OBJECT_DATA
  add column RD_REPOSITORY_ID varchar(36);

update OBJECT_DATA od join REPOSITORY_DEFINITION rd on od.RD_ID = rd.id
  set od.RD_REPOSITORY_ID = rd.REPOSITORY_ID;

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

alter table RELATIONSHIPS add column sourceObjectId varchar(36);

update RELATIONSHIPS rel join OBJECT_DATA obj on rel.sourceId = obj.id
  set rel.sourceObjectId = obj.objectId;

alter table RELATIONSHIPS MODIFY sourceObjectId varchar(36) not null;

alter table OBJECT_DATA add column objectTypeId varchar(255);

update OBJECT_DATA set objectTypeId =
(select objectId from OBJECT_TYPE_DEFINITION where OBJECT_DATA.OBJECT_TYPE_ID = OBJECT_TYPE_DEFINITION.id);

alter table OBJECT_DATA drop foreign key FK_354y502ct1ju7tg6v1rlfpwgo;

alter table PROPERTY_DEFINITION drop foreign key FK_s6scxspskrpjulqsj4u98us2g;

alter table PROPERTY_DATA drop foreign key FK_c2yshju50dy6nutodteogo28t;

alter table OBJECT_DATA drop column OBJECT_TYPE_ID;

alter table PROPERTY_DATA drop column PROPERTY_DEFINITION_ID;

drop table OBJECT_TYPE_DEFINITION;

drop table PROPERTY_DEFINITION;

alter table OBJECT_DATA modify objectTypeId varchar(255) not null;