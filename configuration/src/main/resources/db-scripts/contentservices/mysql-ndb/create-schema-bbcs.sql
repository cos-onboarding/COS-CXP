
create table CONTENT_STREAM (
    id bigint not null auto_increment,
    CONTENT longblob not null,
    primary key (id)
) engine=ndbcluster;

create table OBJECT_DATA (
    id bigint not null auto_increment,
    path varchar(765) not null,
    versionLabel varchar(255),
    objectTypeId varchar(255) not null,
    versionSeriesId varchar(255),
    objectId varchar(36) not null,
    isLatestVersion varchar(255),
    PARENT_ID bigint,
    CS_ID bigint,
    RD_REPOSITORY_ID varchar(36) not null,
    uniquePathCheck varchar(64) not null,
    primary key (id)
) engine=ndbcluster;

create table PROPERTY_DATA (
    id bigint not null auto_increment,
    displayName varchar(255),
    localName varchar(255),
    OBJECT_DATA_ID bigint not null,
    objectId varchar(255) not null,
    queryName varchar(255),
    value varchar(765),
    primary key (id)
) engine=ndbcluster;

create table RELATIONSHIPS (
    id bigint not null auto_increment,
    objectId varchar(255) not null,
    sourceId bigint,
    targetRepositoryId varchar(36) not null,
    targetObjectId varchar(36) not null,
    sourceObjectId varchar(36) not null,
    relationshipType varchar(255) not null,
    primary key (id)
) engine=ndbcluster;

create table RENDITION (
    id bigint not null auto_increment,
    filePath varchar(765),
    height decimal(19,2),
    kind varchar(255),
    length decimal(19,2),
    mimeType varchar(255),
    OBJECT_DATA_ID bigint not null,
    renditionDocumentId varchar(255),
    title varchar(255),
    width decimal(19,2),
    objectId varchar(255) not null,
    streamId varchar(255) not null,
    CS_ID bigint,
    primary key (id)
) engine=ndbcluster;

create table REPOSITORY_DEFINITION (
    id bigint not null auto_increment,
    REPOSITORY_ID varchar(36) not null,
    NAME varchar(255) not null,
    DESCRIPTION varchar(255),
    VENDOR_NAME varchar(255),
    PRODUCT_NAME varchar(255),
    PRODUCT_VERSION varchar(255) not null,
    primary key (id)
) engine=ndbcluster;

create table LAST_PUBLICATION_DATE (
    id bigint not null auto_increment,
    lastPublicationDate datetime not null,
    excludeList varchar(255),
    primary key (id)
) engine=ndbcluster;

create table CANCEL_IMPORT (
    id bigint not null auto_increment,
    cancelled varchar(10),
    primary key (id)
) engine=ndbcluster;

alter table OBJECT_DATA
    add constraint UK_6gtsqb7fmaw6p0ikg6xheulrb unique (uniquePathCheck);

create index ODVL_IDX on OBJECT_DATA (versionLabel);

create index ODVSID_IDX on OBJECT_DATA (versionSeriesId);

create index ODILV_IDX on OBJECT_DATA (isLatestVersion);

create index FK_OD_IDX_CS_ID on OBJECT_DATA (CS_ID);

create index FK_OD_IDX_OD_RD_REPOID on OBJECT_DATA (RD_REPOSITORY_ID);

create index FK_OD_IDX_PARENT on OBJECT_DATA (PARENT_ID);

create index FK_PD_IDX_OBJECT_DATA_ID on PROPERTY_DATA (OBJECT_DATA_ID);

create index FK_PD_IDX_OBJECTID on PROPERTY_DATA (objectId);

create index REL_TARGET_IDX on RELATIONSHIPS (targetRepositoryId, targetObjectId);

create index FK_RND_IDX_OBJECT_DATA_ID on RENDITION (OBJECT_DATA_ID);

create index FK_RND_IDX_CONTENT_STREAM_ID on RENDITION (CS_ID);

alter table REPOSITORY_DEFINITION
    add constraint UK_xqvd20ipg9a1qh4fb48oekvu unique (REPOSITORY_ID);

alter table REPOSITORY_DEFINITION
    add constraint UK_kamy1gwcod11baf33ml8f61jv unique (NAME);
