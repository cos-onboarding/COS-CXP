create table TB_WORK_PACKAGE_BUNDLES (
    WORK_PACKAGE_BUNDLE_ID NUMBER(19,0) not null,
    WORKPACKAGE_ID NUMBER(19,0) not null,
    TARGET_CONTEXT nvarchar2(255) not null,
    HASH raw(255) not null,
    SALT raw(255) not null,
    primary key (WORK_PACKAGE_BUNDLE_ID)
);

create index IDX_WPB_WPS_ID on TB_WORK_PACKAGE_BUNDLES (WORKPACKAGE_ID) logging noparallel;
alter table TB_WORK_PACKAGE_BUNDLES
    add constraint FK_WPB_WPS_1 foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES(WORKPACKAGE_ID);


-- Recreate TB_AFFECTED_PAGES to get rid of the unique constraint on page_name. Table is not used yet so we can drop it.
drop table TB_AFFECTED_PAGES cascade constraints;

create table TB_AFFECTED_PAGES (
    AFFECTED_PAGE_ID NUMBER(19,0) NOT NULL,
    PAGE_NAME nvarchar2(255) NOT NULL,
    PUBLISH_REQUEST_ID NUMBER(19,0) NOT NULL,
    primary key (AFFECTED_PAGE_ID)
);

create index IDX_APGS_PRQ_ID ON TB_AFFECTED_PAGES (PUBLISH_REQUEST_ID) logging noparallel;
alter table TB_AFFECTED_PAGES
    add constraint FK5FDE7509154510F foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS(PUBLISH_REQUEST_ID);

create table TB_WORK_PACKAGE_LOGS (
    WORKPACKAGE_LOG_ID NUMBER(19,0) not null,
    TIMESTAMP timestamp not null,
    LOG_LEVEL nvarchar2(255),
    MESSAGE nvarchar2(255),
    LOG_CODE nvarchar2(255),
    PORTAL nvarchar2(255),
    HOST nvarchar2(255),
    WORKPACKAGE_ID  NUMBER(19,0) not null,
    primary key (WORKPACKAGE_LOG_ID)
);