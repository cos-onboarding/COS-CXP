-- Table codes for FK/Index names

-- TB_APPROVAL_JOBS - AJBS
-- TB_AFFECTED_PAGES - APGS
-- TB_CONTENT_REFERENCES - CRS
-- TB_ITEM_REFERENCES - IRS
-- TB_HOSTS - HTS
-- TB_PUBLISHING_JOBS - PJS
-- TB_PUBLISHREQUESTS - PRQS
-- TB_PUBLISH_RESULTS - PRT
-- TB_PUBLISH_RESULT_ITEMS - PRTI
-- TB_PUBLISH_RESULT_ITEM_LOGS - PRTIL
-- TB_WORK_PACKAGES -WPS
-- TB_IDENTITY_MAPPING - IMG
-- TB_WORK_PACKAGE_BUNDLES - WPB
-- TB_NODES - NDS

-- FK_NAME = (FK)_(TABLE-1-CODE)_(TABLE-2-CODE)_(NUMBER-FK-BETWEEN-TABLES)
-- INDEX_NAME = (IDX)_(TABLE-NAME)_(FIELD_INDICATOR)

create table TB_AFFECTED_PAGES (
    AFFECTED_PAGE_ID bigint not null,
    PAGE_NAME nvarchar(255) not null,
    PUBLISH_REQUEST_ID bigint not null,
    primary key (AFFECTED_PAGE_ID)
);

create table TB_APPROVAL_JOBS (
    APPROVALJOB_ID bigint not null,
    STATE nvarchar(255) not null,
    REQUEST_DATE timestamp,
    APPROVER_USER_ID nvarchar(255),
    DESCRIPTION nvarchar(1023),
    SUBJECT nvarchar(64),
    UUID nvarchar(255) not null,
    PUBLISH_REQUEST_ID bigint,
    HOST_ID bigint,
    WORKPACKAGE_ID bigint,
    primary key (APPROVALJOB_ID),
    unique(UUID)
);

create table TB_CONTENT_REFERENCES (
    CONTENT_REFERENCE_ID bigint not null,
    CMIS_UID nvarchar(2000) not null,
    CONTEXT nvarchar(255) not null,
    TITLE nvarchar(255),
    PUBLISH_REQUEST_ID bigint,
    primary key (CONTENT_REFERENCE_ID)
);

create table TB_HOSTS (
    DTYPE nvarchar(31) not null,
    HOST_ID bigint not null,
    HOST nvarchar(255) not null,
    CONTEXT_PATH nvarchar(255) not null,
    TYPE nvarchar(255) not null,
    NAME nvarchar(255) not null,
    PORT smallint not null,
    LOCK_STRATEGY nvarchar(255),
    REPOSITORY_ID nvarchar(255),
    primary key (HOST_ID)
);

create table TB_ITEM_REFERENCES (
    DTYPE nvarchar(31) not null,
    ITEM_REFERENCE_ID bigint not null,
    CONTEXT__ITEM_NAME nvarchar(255) not null,
    ITEM_NAME nvarchar(255) not null,
    ITEM_TYPE nvarchar(255) not null,
    ITEM_TITLE nvarchar(255),
    MODIFIED_AFTER_LAST_PUBLISH smallint,
    PUBLISH_ACTION_TYPE nvarchar(255),
    PUBLISH_REQUEST_ID bigint,
    LAST_MODIFIED_TS timestamp,
    PUBLISH_STATE nvarchar(255),
    RESOLVING_STRATEGY nvarchar(255),
    primary key (ITEM_REFERENCE_ID)
);

create table TB_PUBLISHING_JOBS (
    PUBLISHING_JOB_ID bigint not null,
    DISCRIMINATOR nvarchar(4) not null,
    CREATED_DATE timestamp,
    FINISHED_DATE timestamp,
    MESSAGE nvarchar(255),
    ORCHESTRATOR_REQUIRES_APPROVAL smallint,
    UPDATE_PUBLISH_STATES smallint,
    STATE nvarchar(255) not null,
    STARTED_DATE timestamp,
    UUID nvarchar(255) not null,
    TARGET_REPOSITORY nvarchar(255) null,
    PARENT_PUBLISHING_JOB_ID bigint,
    PUBLISH_REQUEST_ID bigint,
    ROOT_WORKPACKAGE_ID bigint not null,
    HOST_ID bigint,
    TARGET_PORTAL_SERVER_ID bigint,
    TARGET_PORTAL nvarchar(255),
    WORKPACKAGE_ID bigint,
    WORK_PACKAGE_PUBLISHING_JOB_ID bigint,
    PUBLISH_RESULT_ID bigint,
    primary key (PUBLISHING_JOB_ID)
);

create table TB_PUBLISHREQUESTS (
    PUBLISH_REQUEST_ID bigint not null,
    DESCRIPTION nvarchar(1023),
    REQUEST_DATE timestamp not null,
    REQUESTER_USER_ID nvarchar(255) not null,
    UUID nvarchar(255) not null,
    SOURCE_ITEM_REFERENCE_ID bigint not null,
    WORKPACKAGE_ID bigint not null,
    PUBLISH_ORDER integer null,
    primary key (PUBLISH_REQUEST_ID),
    unique (UUID)
);

create table TB_PUBLISH_RESULTS (
    PUBLISH_RESULT_ID bigint not null,
    BUNDLE_ID nvarchar(255),
    BUNDLE_NAME nvarchar(255),
    HAS_ERRORS smallint,
    primary key (PUBLISH_RESULT_ID)
);

create table TB_PUBLISH_RESULT_ITEMS (
    PUBLISH_RESULT_ITEM_ID bigint not null,
    BUNDLE_ID nvarchar(255),
    CONTEXT_ITEM_NAME nvarchar(255),
    HAS_ERRORS smallint,
    ITEM_NAME nvarchar(255),
    ITEM_TYPE nvarchar(255),
    PUBLISH_RESULT_ID bigint not null,
    primary key (PUBLISH_RESULT_ITEM_ID)
);

create table TB_PUBLISH_RESULT_ITEM_LOGS (
    PUBLISH_RESULT_ITEM_LOG_ID bigint not null,
    LOG_LEVEL nvarchar(255),
    MESSAGE clob,
    LOG_TYPE nvarchar(255),
    PUBLISH_RESULT_ITEM_ID bigint not null,
    primary key (PUBLISH_RESULT_ITEM_LOG_ID)
);

create table TB_WORK_PACKAGES (
    WORKPACKAGE_ID bigint not null,
    CREATION_DATE timestamp,
    DESCRIPTION nvarchar(1023),
    PORTAL_NAME nvarchar(255) not null,
    REPOSITORY_REFERENCE nvarchar(255),
    PUBLICATION_DATE timestamp,
    STATUS_CHANGE_DATE timestamp,
    PUBLISH_CHAIN_NAME nvarchar(255),
    PUBLISH_RESULT_ID bigint,
    SERVER_NAME nvarchar(255) not null,
    STAGING_PUBLICATION_DATE timestamp,
    UUID nvarchar(255) not null,
    CONTEXT_TYPE nvarchar(255) not null,
    WORKPACKAGE_NAME nvarchar(255),
    OWNER_USER_ID nvarchar(255),
    STATE nvarchar(255) not null,
    SCHEDULED_DATE timestamp,
    primary key (WORKPACKAGE_ID),
    unique (UUID)
);

create table TB_WORK_PACKAGE_LOGS (
    WORKPACKAGE_LOG_ID bigint not null,
    TIMESTAMP timestamp not null,
    LOG_LEVEL nvarchar(255),
    MESSAGE nvarchar(255),
    LOG_CODE nvarchar(255),
    PORTAL nvarchar(255),
    HOST nvarchar(255),
    WORKPACKAGE_ID bigint not null,
    primary key (WORKPACKAGE_LOG_ID)
);

create table TB_IDENTITY_MAPPING  (
    IDENTITY_MAPPING_ID bigint not null,
    SOURCE_IDENTITY nvarchar(255),
    TARGET_CONTEXT nvarchar(255),
    TARGET_IDENTITY nvarchar (255),
    primary key (IDENTITY_MAPPING_ID)
);

create table TB_WORK_PACKAGE_BUNDLES (
    WORK_PACKAGE_BUNDLE_ID bigint not null,
    WORKPACKAGE_ID bigint not null,
    TARGET_CONTEXT nvarchar(255) not null,
    HASH blob not null,
    SALT blob not null,
    primary key (WORK_PACKAGE_BUNDLE_ID)
);

create table TB_NODES (
    NODE_ID bigint not null,
    INSTANCE_NAME nvarchar(255) not null unique,
    HEARTBEAT timestamp not null default current timestamp,
    IS_MASTER smallint not null default 0,
    primary key (NODE_ID)
);

create table TB_IMPORT_PROCESS_LOGS (
    IMPORT_LOG_ID bigint not null,
    PORTAL_NAME varchar(255) not null,
    MESSAGE clob,
    CREATOR_USERNAME varchar(255),
    STATUS varchar(25) not null,
    START_DATE timestamp,
    END_DATE timestamp,
    primary key (IMPORT_LOG_ID)
);

create index IDX_APGS_PRQ_ID ON TB_AFFECTED_PAGES (PUBLISH_REQUEST_ID);
alter table TB_AFFECTED_PAGES
    add constraint FK5FDE7509154510F foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS;

create index IDX_APJS_HST_ID ON TB_APPROVAL_JOBS (HOST_ID);
alter table TB_APPROVAL_JOBS
    add constraint FK5FDA7609854516A foreign key (HOST_ID)
    references TB_HOSTS;

create index IDX_APJS_PRQ_ID ON TB_APPROVAL_JOBS (PUBLISH_REQUEST_ID);
alter table TB_APPROVAL_JOBS
    add constraint FK5FD37406154710C foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS;

create index IDX_APJS_WPG_ID ON TB_APPROVAL_JOBS (WORKPACKAGE_ID);
alter table TB_APPROVAL_JOBS
    add constraint FK5FD35409154610B foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES;

create index IDX_APJS_STATE on TB_APPROVAL_JOBS (STATE);

create index IDX_CRS_PRQ_ID ON TB_CONTENT_REFERENCES (PUBLISH_REQUEST_ID);
alter table TB_CONTENT_REFERENCES
    add constraint FK5FD35469854812C foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS;

create index IDX_IRS_PRQ_ID ON TB_ITEM_REFERENCES (PUBLISH_REQUEST_ID);
alter table TB_ITEM_REFERENCES
    add constraint FK5FB3C479854912A foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS;

create index IDX_PJS_HST_ID ON TB_PUBLISHING_JOBS (HOST_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK5F54C779884992B foreign key (HOST_ID)
    references TB_HOSTS;

create index IDX_PJS_WPG_ID ON TB_PUBLISHING_JOBS (WORKPACKAGE_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK5F54C679984090B foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES;

create index IDX_PJS_PR_ID ON TB_PUBLISHING_JOBS (PUBLISH_REQUEST_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PRS foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS;

create index IDX_PJS_PRT_PGJ_ID ON TB_PUBLISHING_JOBS (PARENT_PUBLISHING_JOB_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK5F64C074944792A foreign key (PARENT_PUBLISHING_JOB_ID)
    references TB_PUBLISHING_JOBS;

create index IDX_PJS_PRT_WPPJ_ID ON TB_PUBLISHING_JOBS (WORK_PACKAGE_PUBLISHING_JOB_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PJS foreign key (WORK_PACKAGE_PUBLISHING_JOB_ID)
    references TB_PUBLISHING_JOBS;

create index IDX_PJS_PRT_ID ON TB_PUBLISHING_JOBS (PUBLISH_RESULT_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PRT foreign key (PUBLISH_RESULT_ID)
    references TB_PUBLISH_RESULTS;

create index IDX_PJS_DISC ON TB_PUBLISHING_JOBS (DISCRIMINATOR);

create unique index IDX_PJS_UUID ON TB_PUBLISHING_JOBS (UUID);

create index IDX_PJS_STATE ON TB_PUBLISHING_JOBS (STATE);

create index IDX_PRQS_WPG_ID on TB_PUBLISHREQUESTS (WORKPACKAGE_ID);
alter table TB_PUBLISHREQUESTS
    add constraint FK5F649044948702C foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES;

create index IDX_PRQS_SRC_IR_ID on TB_PUBLISHREQUESTS (SOURCE_ITEM_REFERENCE_ID);
alter table TB_PUBLISHREQUESTS
    add constraint FK5F640041948792E foreign key (SOURCE_ITEM_REFERENCE_ID)
    references TB_ITEM_REFERENCES(ITEM_REFERENCE_ID);

create index IDX_WPGS_PRT_ID on TB_WORK_PACKAGES (PUBLISH_RESULT_ID);
alter table TB_WORK_PACKAGES
    add constraint FK54941041948387E foreign key (PUBLISH_RESULT_ID)
    references TB_PUBLISH_RESULTS;

create index IDX_WPS_STATE on TB_WORK_PACKAGES (STATE);
create index IDX_WPS_PORTAL_NAME on TB_WORK_PACKAGES (PORTAL_NAME);
create index IDX_WPS_SERVER_NAME on TB_WORK_PACKAGES (SERVER_NAME);
create index IDX_WPS_OWNER_USER_ID on TB_WORK_PACKAGES (OWNER_USER_ID);
create index IDX_WPS_CREATION_DATE on TB_WORK_PACKAGES (CREATION_DATE);
create index IDX_WPS_STATUS_CHANGE_DATE on TB_WORK_PACKAGES (STATUS_CHANGE_DATE);

create index IDX_PRTI_PRT_ID on TB_PUBLISH_RESULT_ITEMS (PUBLISH_RESULT_ID);
alter table TB_PUBLISH_RESULT_ITEMS
    add constraint FK14541992940387E foreign key (PUBLISH_RESULT_ID)
    references TB_PUBLISH_RESULTS;

create index IDX_PRTIL_PRTI_ID on TB_PUBLISH_RESULT_ITEM_LOGS (PUBLISH_RESULT_ITEM_ID);
alter table TB_PUBLISH_RESULT_ITEM_LOGS
    add constraint FK12501992946387C foreign key (PUBLISH_RESULT_ITEM_ID)
    references TB_PUBLISH_RESULT_ITEMS;

create index IDX_WPB_WPS_ID on TB_WORK_PACKAGE_BUNDLES (WORKPACKAGE_ID);
alter table TB_WORK_PACKAGE_BUNDLES
    add constraint FK_WPB_WPS_1 foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES;

create index IDX_HTS_NAME ON TB_HOSTS (NAME);

create index IDX_WPL_WORKPACKAGE_ID on TB_WORK_PACKAGE_LOGS (WORKPACKAGE_ID);

alter table TB_NODES
    add constraint CH_NDS_IS_MASTER check (IS_MASTER in (0, 1));

create sequence hibernate_sequence;