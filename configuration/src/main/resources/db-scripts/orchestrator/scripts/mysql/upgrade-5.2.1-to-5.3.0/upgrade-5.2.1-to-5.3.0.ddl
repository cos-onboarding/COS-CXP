create table TB_WORK_PACKAGE_BUNDLES (
    WORK_PACKAGE_BUNDLE_ID bigint auto_increment,
    WORKPACKAGE_ID bigint not null,
    TARGET_CONTEXT varchar(255) not null,
    HASH varbinary(255) not null,
    SALT varbinary(255) not null,
    primary key (WORK_PACKAGE_BUNDLE_ID)
) ENGINE=InnoDB;

create index IDX_WPB_WPS_ID on TB_WORK_PACKAGE_BUNDLES(WORKPACKAGE_ID);
alter table TB_WORK_PACKAGE_BUNDLES
    add foreign key (WORKPACKAGE_ID)
    references TB_WORK_PACKAGES(WORKPACKAGE_ID);


-- Recreate TB_AFFECTED_PAGES to get rid of the unique constraint on page_name. Table is not used yet so we can drop it.
drop table if exists TB_AFFECTED_PAGES;

create table TB_AFFECTED_PAGES (
    AFFECTED_PAGE_ID bigint auto_increment,
    PAGE_NAME varchar(255) not null,
    PUBLISH_REQUEST_ID bigint not null,
    primary key (AFFECTED_PAGE_ID)
) ENGINE=InnoDB;

create index FK82D73AFE506F736E on TB_AFFECTED_PAGES(PUBLISH_REQUEST_ID);
alter table TB_AFFECTED_PAGES
    add foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS(PUBLISH_REQUEST_ID);

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
) ENGINE=InnoDB;
