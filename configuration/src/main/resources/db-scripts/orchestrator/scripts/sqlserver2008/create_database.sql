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


-- will be executed by mvn sql plugin before deploy orchestrator
create table TB_AFFECTED_PAGES (
    AFFECTED_PAGE_ID numeric(19,0) identity not null,
    PAGE_NAME nvarchar(255) not null,
    PUBLISH_REQUEST_ID numeric(19,0) not null,
    primary key (AFFECTED_PAGE_ID)
)
GO

create table TB_APPROVAL_JOBS (
    APPROVALJOB_ID numeric(19,0) identity not null,
    STATE nvarchar(255) not null,
    REQUEST_DATE datetime null,
    APPROVER_USER_ID nvarchar(255) null,
    DESCRIPTION nvarchar(1023) null,
    SUBJECT nvarchar(64),
    UUID nvarchar(255) unique not null,
    PUBLISH_REQUEST_ID numeric(19,0) null,
    HOST_ID numeric(19,0) null,
    WORKPACKAGE_ID numeric(19,0) null,
    primary key (APPROVALJOB_ID)
)
GO

create table TB_CONTENT_REFERENCES (
    CONTENT_REFERENCE_ID numeric(19,0) identity not null,
    CMIS_UID nvarchar(2000) not null,
    CONTEXT nvarchar(255) not null,
    TITLE nvarchar(255),
    PUBLISH_REQUEST_ID numeric(19,0) null,
    primary key (CONTENT_REFERENCE_ID)
)
GO

create table TB_HOSTS (
    HOST_ID numeric(19,0) identity not null,
    DTYPE nvarchar(31) not null,
    HOST nvarchar(255) not null,
    CONTEXT_PATH nvarchar(255) not null,
    TYPE nvarchar(255) not null,
    NAME nvarchar(255) not null,
    PORT numeric(5,0) not null,
    LOCK_STRATEGY nvarchar(255) null,
    REPOSITORY_ID nvarchar(255) null,
    primary key (HOST_ID)
)
GO

create table TB_ITEM_REFERENCES (
    DTYPE nvarchar(31) not null,
    ITEM_REFERENCE_ID numeric(19,0) identity not null,
    CONTEXT__ITEM_NAME nvarchar(255) not null,
    ITEM_NAME nvarchar(255) not null,
    ITEM_TYPE nvarchar(255) not null,
    ITEM_TITLE nvarchar(255),
    MODIFIED_AFTER_LAST_PUBLISH bit null,
    PUBLISH_ACTION_TYPE nvarchar(255) null,
    PUBLISH_REQUEST_ID numeric(19,0) null,
    LAST_MODIFIED_TS datetime,
    PUBLISH_STATE nvarchar(255),
    RESOLVING_STRATEGY nvarchar(255) null,
    primary key (ITEM_REFERENCE_ID)
)
GO

create table TB_PUBLISHING_JOBS (
    PUBLISHING_JOB_ID numeric(19,0) identity not null,
    DISCRIMINATOR nvarchar(4) not null,
    CREATED_DATE datetime null,
    FINISHED_DATE datetime null,
    MESSAGE nvarchar(255) null,
    ORCHESTRATOR_REQUIRES_APPROVAL bit null,
    UPDATE_PUBLISH_STATES bit null,
    STATE nvarchar(255) not null,
    STARTED_DATE datetime null,
    UUID nvarchar(255) not null,
    TARGET_REPOSITORY nvarchar(255) null,
    PARENT_PUBLISHING_JOB_ID numeric(19,0) null,
    PUBLISH_REQUEST_ID numeric(19,0) null,
    ROOT_WORKPACKAGE_ID numeric(19,0) not null,
    HOST_ID numeric(19,0) null,
    TARGET_PORTAL_SERVER_ID numeric(19,0) null,
    TARGET_PORTAL nvarchar(255) null,
    WORKPACKAGE_ID numeric(19,0) null,
    WORK_PACKAGE_PUBLISHING_JOB_ID numeric (19,0),
    PUBLISH_RESULT_ID numeric (19,0),
    primary key (PUBLISHING_JOB_ID)
)
GO

create table TB_PUBLISHREQUESTS (
    PUBLISH_REQUEST_ID numeric(19,0) identity not null,
    DESCRIPTION nvarchar(1023) null,
    REQUEST_DATE datetime not null,
    REQUESTER_USER_ID nvarchar(255) not null,
    UUID nvarchar(255) not null unique,
    SOURCE_ITEM_REFERENCE_ID numeric(19,0) not null,
    WORKPACKAGE_ID numeric(19,0) not null,
    PUBLISH_ORDER numeric(10,0) null,
    primary key (PUBLISH_REQUEST_ID)
)
GO

create table TB_PUBLISH_RESULTS (
    PUBLISH_RESULT_ID numeric(19,0) identity not null,
    BUNDLE_ID nvarchar(255) null,
    BUNDLE_NAME nvarchar(255) null,
    HAS_ERRORS bit null,
    primary key (PUBLISH_RESULT_ID)
)
GO

create table TB_PUBLISH_RESULT_ITEMS (
    PUBLISH_RESULT_ITEM_ID numeric(19,0) identity not null,
    BUNDLE_ID nvarchar(255) null,
    CONTEXT_ITEM_NAME nvarchar(255) null,
    HAS_ERRORS bit null,
    ITEM_NAME nvarchar(255) null,
    ITEM_TYPE nvarchar(255) null,
    PUBLISH_RESULT_ID numeric(19,0) not null,
    primary key (PUBLISH_RESULT_ITEM_ID)
)
GO

create table TB_PUBLISH_RESULT_ITEM_LOGS (
    PUBLISH_RESULT_ITEM_LOG_ID numeric(19,0) identity not null,
    LOG_LEVEL nvarchar(255) null,
    MESSAGE nvarchar(MAX) null,
    LOG_TYPE nvarchar(255) null,
    PUBLISH_RESULT_ITEM_ID numeric(19,0) not null,
    primary key (PUBLISH_RESULT_ITEM_LOG_ID)
)
GO

create table TB_WORK_PACKAGES (
    WORKPACKAGE_ID numeric(19,0) identity not null,
    CREATION_DATE datetime null,
    DESCRIPTION nvarchar(1023) null,
    PORTAL_NAME nvarchar(255) not null,
    REPOSITORY_REFERENCE nvarchar(255) null,
    PUBLICATION_DATE datetime null,
    STATUS_CHANGE_DATE datetime null,
    PUBLISH_CHAIN_NAME nvarchar(255) null,
    PUBLISH_RESULT_ID numeric(19,0) null,
    SERVER_NAME nvarchar(255) not null,
    STAGING_PUBLICATION_DATE datetime null,
    UUID nvarchar(255) not null unique,
    CONTEXT_TYPE nvarchar(255) not null,
    WORKPACKAGE_NAME nvarchar(255) null,
    OWNER_USER_ID nvarchar(255) null,
    STATE nvarchar(255) not null,
    SCHEDULED_DATE datetime null,
    primary key (WORKPACKAGE_ID)
)
GO

create table TB_WORK_PACKAGE_LOGS (
    WORKPACKAGE_LOG_ID numeric(19,0) identity not null,
    TIMESTAMP datetime not null,
    LOG_LEVEL nvarchar(255),
    MESSAGE nvarchar(255),
    LOG_CODE nvarchar(255),
    PORTAL nvarchar(255),
    HOST nvarchar(255),
    WORKPACKAGE_ID numeric(19,0) not null,
    primary key (WORKPACKAGE_LOG_ID)
)
GO

create table TB_IDENTITY_MAPPING  (
    IDENTITY_MAPPING_ID numeric(19,0) identity not null,
    SOURCE_IDENTITY nvarchar(255) null,
    TARGET_CONTEXT nvarchar(255) null,
    TARGET_IDENTITY nvarchar (255) null,
    primary key (IDENTITY_MAPPING_ID)
)
GO

create table TB_WORK_PACKAGE_BUNDLES (
    WORK_PACKAGE_BUNDLE_ID numeric(19,0) identity not null,
    WORKPACKAGE_ID numeric(19,0) not null,
    TARGET_CONTEXT nvarchar(255) not null,
    HASH varbinary(255) not null,
    SALT varbinary(255) not null,
    primary key (WORK_PACKAGE_BUNDLE_ID)
)
GO

create table TB_NODES (
    NODE_ID numeric(19,0) identity not null,
    INSTANCE_NAME nvarchar(255) not null unique,
    HEARTBEAT datetime not null default current_timestamp,
    IS_MASTER bit not null default 0,
    primary key (NODE_ID)
)
GO

create table TB_IMPORT_PROCESS_LOGS (
    IMPORT_LOG_ID numeric(19,0) identity not null,
    PORTAL_NAME nvarchar(255) not null,
    MESSAGE nvarchar(MAX) null,
    CREATOR_USERNAME nvarchar(255),
    STATUS nvarchar(25) not null,
    START_DATE datetime,
    END_DATE datetime,
    primary key (IMPORT_LOG_ID)
)
GO

create nonclustered index IDX_APGS_PRQ_ID ON TB_AFFECTED_PAGES (PUBLISH_REQUEST_ID)
GO
alter table TB_AFFECTED_PAGES
    add constraint FK5FDE7509154510F foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS(PUBLISH_REQUEST_ID)
    GO

create nonclustered index IDX_APJS_HST_ID ON TB_APPROVAL_JOBS (HOST_ID)
GO
alter table TB_APPROVAL_JOBS
    add constraint FK5FDA7609854516A foreign key (HOST_ID)
    references TB_HOSTS(HOST_ID)
    GO

create nonclustered index IDX_APJS_PRQ_ID ON TB_APPROVAL_JOBS (PUBLISH_REQUEST_ID)
GO
alter table TB_APPROVAL_JOBS
    add constraint FK5FD37406154710C foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS(PUBLISH_REQUEST_ID)
    GO

create nonclustered index IDX_APJS_WPG_ID ON TB_APPROVAL_JOBS (WORKPACKAGE_ID)
GO
alter table TB_APPROVAL_JOBS
    add constraint FK5FD35409154610B foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES(WORKPACKAGE_ID)
    GO

create nonclustered index IDX_APJS_STATE on TB_APPROVAL_JOBS (STATE)
GO

create nonclustered index IDX_CRS_PRQ_ID ON TB_CONTENT_REFERENCES (PUBLISH_REQUEST_ID)
GO
alter table TB_CONTENT_REFERENCES
    add constraint FK5FD35469854812C foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS(PUBLISH_REQUEST_ID)
    GO

create nonclustered index IDX_IRS_PRQ_ID ON TB_ITEM_REFERENCES (PUBLISH_REQUEST_ID)
GO
alter table TB_ITEM_REFERENCES
    add constraint FK5FB3C479854912A foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS(PUBLISH_REQUEST_ID)
    GO

create nonclustered index IDX_PJS_HST_ID ON TB_PUBLISHING_JOBS (HOST_ID)
GO
alter table TB_PUBLISHING_JOBS
    add constraint FK5F54C779884992B foreign key (HOST_ID)
    references TB_HOSTS(HOST_ID)
    GO

create nonclustered index IDX_PJS_WPG_ID ON TB_PUBLISHING_JOBS (WORKPACKAGE_ID)
GO
alter table TB_PUBLISHING_JOBS
    add constraint FK5F54C679984090B foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES(WORKPACKAGE_ID)
    GO

create nonclustered index IDX_PJS_PR_ID ON TB_PUBLISHING_JOBS (PUBLISH_REQUEST_ID)
GO
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PRS foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS(PUBLISH_REQUEST_ID)
    GO

create nonclustered index IDX_PJS_PRT_PGJ_ID ON TB_PUBLISHING_JOBS (PARENT_PUBLISHING_JOB_ID)
GO
alter table TB_PUBLISHING_JOBS
    add constraint FK5F64C074944792A foreign key (PARENT_PUBLISHING_JOB_ID)
    references TB_PUBLISHING_JOBS(PUBLISHING_JOB_ID)
    GO

create nonclustered index IDX_PJS_PRT_WPPJ_ID ON TB_PUBLISHING_JOBS (WORK_PACKAGE_PUBLISHING_JOB_ID)
GO
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PJS foreign key (WORK_PACKAGE_PUBLISHING_JOB_ID)
    references TB_PUBLISHING_JOBS(PUBLISHING_JOB_ID)
GO

create nonclustered index IDX_PJS_PRT_ID ON TB_PUBLISHING_JOBS (PUBLISH_RESULT_ID)
GO
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PRT foreign key (PUBLISH_RESULT_ID)
    references TB_PUBLISH_RESULTS(PUBLISH_RESULT_ID)
    GO

create nonclustered index IDX_PJS_DISC ON TB_PUBLISHING_JOBS (DISCRIMINATOR)
GO
create unique nonclustered index IDX_PJS_UUID ON TB_PUBLISHING_JOBS (UUID)
GO
create nonclustered index IDX_PJS_STATE ON TB_PUBLISHING_JOBS (STATE)
GO

create nonclustered index IDX_PRQS_WPG_ID on TB_PUBLISHREQUESTS (WORKPACKAGE_ID)
GO
alter table TB_PUBLISHREQUESTS
    add constraint FK5F649044948702C foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES(WORKPACKAGE_ID)
    GO

create nonclustered index IDX_PRQS_SRC_IR_ID on TB_PUBLISHREQUESTS (SOURCE_ITEM_REFERENCE_ID)
GO
alter table TB_PUBLISHREQUESTS
    add constraint FK5F640041948792E foreign key (SOURCE_ITEM_REFERENCE_ID)
    references TB_ITEM_REFERENCES(ITEM_REFERENCE_ID)
    GO

create nonclustered index IDX_WPGS_PRT_ID on TB_WORK_PACKAGES (PUBLISH_RESULT_ID)
GO
alter table TB_WORK_PACKAGES
    add constraint FK54941041948387E foreign key (PUBLISH_RESULT_ID)
    references TB_PUBLISH_RESULTS(PUBLISH_RESULT_ID)
    GO

create nonclustered index IDX_WPS_STATE on TB_WORK_PACKAGES (STATE)
GO
create nonclustered index IDX_WPS_PORTAL_NAME on TB_WORK_PACKAGES (PORTAL_NAME)
GO
create nonclustered index IDX_WPS_SERVER_NAME on TB_WORK_PACKAGES (SERVER_NAME)
GO
create nonclustered index IDX_WPS_OWNER_USER_ID on TB_WORK_PACKAGES (OWNER_USER_ID)
GO
create nonclustered index IDX_WPS_CREATION_DATE on TB_WORK_PACKAGES (CREATION_DATE)
GO
create nonclustered index IDX_WPS_STATUS_CHANGE_DATE on TB_WORK_PACKAGES (STATUS_CHANGE_DATE)
GO

create nonclustered index IDX_PRTI_PRT_ID on TB_PUBLISH_RESULT_ITEMS (PUBLISH_RESULT_ID)
GO
alter table TB_PUBLISH_RESULT_ITEMS
    add constraint FK14541992940387E foreign key (PUBLISH_RESULT_ID)
    references TB_PUBLISH_RESULTS(PUBLISH_RESULT_ID)
    GO

create nonclustered index IDX_PRTIL_PRTI_ID on TB_PUBLISH_RESULT_ITEM_LOGS (PUBLISH_RESULT_ITEM_ID)
GO
alter table TB_PUBLISH_RESULT_ITEM_LOGS
    add constraint FK12501992946387C foreign key (PUBLISH_RESULT_ITEM_ID)
    references TB_PUBLISH_RESULT_ITEMS(PUBLISH_RESULT_ITEM_ID)
    GO

create nonclustered index IDX_WPB_WPS_ID on TB_WORK_PACKAGE_BUNDLES (WORKPACKAGE_ID)
GO
alter table TB_WORK_PACKAGE_BUNDLES
    add constraint FK_WPB_WPS_1 foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES(WORKPACKAGE_ID)
    GO

create nonclustered index IDX_HTS_NAME ON TB_HOSTS (NAME)
GO

create nonclustered index IDX_WPL_WORKPACKAGE_ID on TB_WORK_PACKAGE_LOGS (WORKPACKAGE_ID)
GO