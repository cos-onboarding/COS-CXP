create table TB_WORK_PACKAGE_BUNDLES (
    WORK_PACKAGE_BUNDLE_ID bigint not null,
    WORKPACKAGE_ID bigint not null,
    TARGET_CONTEXT nvarchar(255) not null,
    HASH blob not null,
    SALT blob not null,
    primary key (WORK_PACKAGE_BUNDLE_ID)
);

create index IDX_WPB_WPS_ID on TB_WORK_PACKAGE_BUNDLES (WORKPACKAGE_ID);
alter table TB_WORK_PACKAGE_BUNDLES
    add constraint FK_WPB_WPS_1 foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES;

-- Recreate TB_AFFECTED_PAGES to get rid of the unique constraint on page_name. Table is not used yet so we can drop it.
drop table TB_AFFECTED_PAGES;

create table TB_AFFECTED_PAGES (
    AFFECTED_PAGE_ID bigint not null,
    PAGE_NAME nvarchar(255) not null,
    PUBLISH_REQUEST_ID bigint not null,
    primary key (AFFECTED_PAGE_ID)
);

create index IDX_APGS_PRQ_ID ON TB_AFFECTED_PAGES (PUBLISH_REQUEST_ID);
alter table TB_AFFECTED_PAGES
    add constraint FK5FDE7509154510F foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS;

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

