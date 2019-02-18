-- Table codes for FK/Index names

-- TB_APPROVAL_JOBS - AJBS
-- TB_AFFECTED_PAGES - APGS
-- TB_CONTENT_REFERENCES - CRS
-- TB_ITEM_REFERENCES - IRS
-- TB_HOSTS - HTS
-- TB_PUBLISHING_JOBS - PJS
-- TB_PUBLISHREQUESTS - PRQS
-- TB_PUBLISH_RESULTS - PRTS
-- TB_PUBLISH_RESULT_ITEMS - PRTI
-- TB_PUBLISH_RESULT_ITEM_LOGS - PRTIL
-- TB_WORK_PACKAGES -WPS
-- TB_IDENTITY_MAPPING - IMG
-- TB_WORK_PACKAGE_BUNDLES - WPB
-- TB_NODES - NDS

-- FK_NAME = (FK)_(TABLE-1-CODE)_(TABLE-2-CODE)_(NUMBER-FK-BETWEEN-TABLES)
-- INDEX_NAME = (IDX)_(TABLE-NAME)_(FIELD_INDICATOR)
create table TB_AFFECTED_PAGES (
    AFFECTED_PAGE_ID bigint auto_increment,
    PAGE_NAME varchar(255) not null,
    PUBLISH_REQUEST_ID bigint not null,
    primary key (AFFECTED_PAGE_ID)
) ENGINE=ndbcluster;

create table TB_APPROVAL_JOBS (
    APPROVALJOB_ID bigint auto_increment,
    STATE varchar(255) not null,
    REQUEST_DATE timestamp,
    APPROVER_USER_ID varchar(255),
    DESCRIPTION varchar(1023),
    SUBJECT varchar(64),
    UUID varchar(255) unique,
    PUBLISH_REQUEST_ID bigint,
    HOST_ID bigint,
    WORKPACKAGE_ID bigint,
    primary key (APPROVALJOB_ID)
) ENGINE=ndbcluster;

create table TB_CONTENT_REFERENCES (
    CONTENT_REFERENCE_ID bigint auto_increment,
    CMIS_UID varchar(2000) not null,
    CONTEXT varchar(255) not null,
    TITLE varchar(255),
    PUBLISH_REQUEST_ID bigint,
    primary key (CONTENT_REFERENCE_ID)
) ENGINE=ndbcluster;

create table TB_HOSTS (
    DTYPE varchar(31) not null,
    HOST_ID bigint auto_increment,
    HOST varchar(255) not null,
    CONTEXT_PATH varchar(255) not null,
    TYPE varchar(255) not null,
    NAME varchar(255) not null,
    PORT integer not null,
    LOCK_STRATEGY varchar(255),
    REPOSITORY_ID varchar(255),
    primary key (HOST_ID)
) ENGINE=ndbcluster;

create table TB_ITEM_REFERENCES (
    DTYPE varchar(31) not null,
    ITEM_REFERENCE_ID bigint auto_increment,
    CONTEXT__ITEM_NAME varchar(255) not null,
    ITEM_NAME varchar(255) not null,
    ITEM_TYPE varchar(255) not null,
    ITEM_TITLE varchar(255),
    MODIFIED_AFTER_LAST_PUBLISH boolean,
    PUBLISH_ACTION_TYPE varchar(255),
    PUBLISH_REQUEST_ID bigint,
    LAST_MODIFIED_TS timestamp,
    PUBLISH_STATE varchar(255),
    RESOLVING_STRATEGY varchar(255),
    primary key (ITEM_REFERENCE_ID)
) ENGINE=ndbcluster;

create table TB_PUBLISHING_JOBS (
    PUBLISHING_JOB_ID bigint auto_increment,
    DISCRIMINATOR varchar(4) not null,
    CREATED_DATE timestamp,
    FINISHED_DATE timestamp null default null,
    MESSAGE varchar(255),
    ORCHESTRATOR_REQUIRES_APPROVAL boolean,
    UPDATE_PUBLISH_STATES boolean,
    STATE varchar(255) not null,
    STARTED_DATE timestamp null default null,
    UUID varchar(255) not null,
    TARGET_REPOSITORY varchar(255),
    PARENT_PUBLISHING_JOB_ID bigint,
    PUBLISH_REQUEST_ID bigint,
    ROOT_WORKPACKAGE_ID bigint not null,
    HOST_ID bigint,
    TARGET_PORTAL_SERVER_ID bigint,
    TARGET_PORTAL varchar(255),
    WORKPACKAGE_ID bigint,
    WORK_PACKAGE_PUBLISHING_JOB_ID bigint,
    PUBLISH_RESULT_ID bigint,
    primary key (PUBLISHING_JOB_ID)
) ENGINE=ndbcluster;

create table TB_PUBLISHREQUESTS (
    PUBLISH_REQUEST_ID bigint auto_increment,
    DESCRIPTION varchar(1023),
    REQUEST_DATE timestamp not null,
    REQUESTER_USER_ID varchar(255) not null,
    UUID varchar(255) not null unique,
    SOURCE_ITEM_REFERENCE_ID bigint not null,
    WORKPACKAGE_ID bigint not null,
    PUBLISH_ORDER integer null,
    primary key (PUBLISH_REQUEST_ID)
) ENGINE=ndbcluster;

create table TB_PUBLISH_RESULTS (
    PUBLISH_RESULT_ID bigint auto_increment,
    BUNDLE_ID varchar(255),
    BUNDLE_NAME varchar(255),
    HAS_ERRORS boolean,
    primary key (PUBLISH_RESULT_ID)
) ENGINE=ndbcluster;

create table TB_PUBLISH_RESULT_ITEMS (
    PUBLISH_RESULT_ITEM_ID bigint auto_increment,
    BUNDLE_ID varchar(255),
    CONTEXT_ITEM_NAME varchar(255),
    HAS_ERRORS boolean,
    ITEM_NAME varchar(255),
    ITEM_TYPE varchar(255),
    PUBLISH_RESULT_ID bigint not null,
    primary key (PUBLISH_RESULT_ITEM_ID)
) ENGINE=ndbcluster;

create table TB_PUBLISH_RESULT_ITEM_LOGS (
    PUBLISH_RESULT_ITEM_LOG_ID bigint auto_increment,
    LOG_LEVEL varchar(255),
    MESSAGE longtext,
    LOG_TYPE varchar(255),
    PUBLISH_RESULT_ITEM_ID bigint not null,
    primary key (PUBLISH_RESULT_ITEM_LOG_ID)
) ENGINE=ndbcluster;

create table TB_WORK_PACKAGES (
    WORKPACKAGE_ID bigint auto_increment,
    CREATION_DATE timestamp,
    DESCRIPTION varchar(1023),
    PORTAL_NAME varchar(255) not null,
    REPOSITORY_REFERENCE varchar(255),
    PUBLICATION_DATE timestamp null default null,
    STATUS_CHANGE_DATE timestamp null default null,
    PUBLISH_CHAIN_NAME varchar(255),
    PUBLISH_RESULT_ID bigint,
    SERVER_NAME varchar(255) not null,
    STAGING_PUBLICATION_DATE timestamp null default null,
    UUID varchar(255) not null unique,
    CONTEXT_TYPE varchar(255) not null,
    WORKPACKAGE_NAME varchar(255),
    OWNER_USER_ID varchar(255),
    STATE varchar(255),
    SCHEDULED_DATE timestamp null default null,
    primary key (WORKPACKAGE_ID)
) ENGINE=ndbcluster;

create table TB_WORK_PACKAGE_LOGS (
    WORKPACKAGE_LOG_ID bigint auto_increment,
    TIMESTAMP timestamp not null,
    LOG_LEVEL varchar(255),
    MESSAGE varchar(255),
    LOG_CODE varchar(255),
    PORTAL varchar(255),
    HOST varchar(255),
    WORKPACKAGE_ID bigint not null,
    primary key (WORKPACKAGE_LOG_ID)
) ENGINE=ndbcluster;

create table TB_IDENTITY_MAPPING  (
    IDENTITY_MAPPING_ID bigint auto_increment,
    SOURCE_IDENTITY varchar(255),
    TARGET_CONTEXT varchar(255),
    TARGET_IDENTITY varchar (255),
    primary key (IDENTITY_MAPPING_ID)
) ENGINE=ndbcluster;

create table TB_WORK_PACKAGE_BUNDLES (
    WORK_PACKAGE_BUNDLE_ID bigint auto_increment,
    WORKPACKAGE_ID bigint not null,
    TARGET_CONTEXT varchar(255) not null,
    HASH varbinary(255) not null,
    SALT varbinary(255) not null,
    primary key (WORK_PACKAGE_BUNDLE_ID)
) ENGINE=ndbcluster;

create table TB_NODES (
    NODE_ID bigint auto_increment,
    INSTANCE_NAME varchar(255) not null unique,
    HEARTBEAT timestamp not null default current_timestamp,
    IS_MASTER boolean not null default false,
    primary key (NODE_ID)
) ENGINE=ndbcluster;

create table TB_IMPORT_PROCESS_LOGS (
    IMPORT_LOG_ID bigint auto_increment,
    PORTAL_NAME varchar(255) not null,
    MESSAGE longtext,
    CREATOR_USERNAME varchar(255),
    STATUS varchar(25) not null,
    START_DATE timestamp,
    END_DATE timestamp,
    primary key (IMPORT_LOG_ID)
) ENGINE=ndbcluster;

create index FK82D73AFE506F736E on TB_AFFECTED_PAGES(PUBLISH_REQUEST_ID);

create index FK5FDA7609854516A on TB_APPROVAL_JOBS(HOST_ID);
create index FK5FDE7C0C7C251E2 on TB_APPROVAL_JOBS(PUBLISH_REQUEST_ID);
create index FKD034EFEBEE9B51F8 on TB_APPROVAL_JOBS(WORKPACKAGE_ID);
create index IDX_APJS_STATE on TB_APPROVAL_JOBS (STATE);

create index FK59B5ED469FE7600A on TB_CONTENT_REFERENCES(PUBLISH_REQUEST_ID);

create index FK5FB3C479854912A on TB_ITEM_REFERENCES(PUBLISH_REQUEST_ID);

create index FK5F54C779884992B on TB_PUBLISHING_JOBS(HOST_ID);
create index FK5F54C679984090B on TB_PUBLISHING_JOBS(WORKPACKAGE_ID);
create index IDX_PJS_PR_ID ON TB_PUBLISHING_JOBS (PUBLISH_REQUEST_ID);
create index FK5F64C074944792A on TB_PUBLISHING_JOBS (PARENT_PUBLISHING_JOB_ID);
create index IDX_PJS_PRT_WPPJ_ID ON TB_PUBLISHING_JOBS (WORK_PACKAGE_PUBLISHING_JOB_ID);
create index IDX_PJS_PRT_ID ON TB_PUBLISHING_JOBS (PUBLISH_RESULT_ID);
create index IDX_PJS_DISC ON TB_PUBLISHING_JOBS (DISCRIMINATOR);
create unique index IDX_PJS_UUID ON TB_PUBLISHING_JOBS (UUID);
create index IDX_PJS_STATE ON TB_PUBLISHING_JOBS (STATE);

create index FK5F649044948702C on TB_PUBLISHREQUESTS(WORKPACKAGE_ID);
create index FK5F640041948792E on TB_PUBLISHREQUESTS(SOURCE_ITEM_REFERENCE_ID);

create index FK54941041948387E on TB_WORK_PACKAGES(PUBLISH_RESULT_ID);
create index IDX_WPS_STATE on TB_WORK_PACKAGES (STATE);
create index IDX_WPS_PORTAL_NAME on TB_WORK_PACKAGES (PORTAL_NAME);
create index IDX_WPS_SERVER_NAME on TB_WORK_PACKAGES (SERVER_NAME);
create index IDX_WPS_OWNER_USER_ID on TB_WORK_PACKAGES (OWNER_USER_ID);
create index IDX_WPS_CREATION_DATE on TB_WORK_PACKAGES (CREATION_DATE);
create index IDX_WPS_STATUS_CHANGE_DATE on TB_WORK_PACKAGES (STATUS_CHANGE_DATE);

create index FK14541992940387E on TB_PUBLISH_RESULT_ITEMS(PUBLISH_RESULT_ID);

create index FK12501992946387C on TB_PUBLISH_RESULT_ITEM_LOGS(PUBLISH_RESULT_ITEM_ID);

create index IDX_WPB_WPS_ID on TB_WORK_PACKAGE_BUNDLES(WORKPACKAGE_ID);

create index IDX_HTS_NAME ON TB_HOSTS (NAME);

create index IDX_WPL_WORKPACKAGE_ID on TB_WORK_PACKAGE_LOGS (WORKPACKAGE_ID);
