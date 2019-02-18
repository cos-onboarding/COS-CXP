create index IDX_PJS_DISC ON TB_PUBLISHING_JOBS (DISCRIMINATOR);
create unique index IDX_PJS_UUID ON TB_PUBLISHING_JOBS (UUID);
create index IDX_PJS_STATE ON TB_PUBLISHING_JOBS (STATE);

create index IDX_HTS_NAME ON TB_HOSTS (NAME);

create index IDX_WPL_WORKPACKAGE_ID on TB_WORK_PACKAGE_LOGS (WORKPACKAGE_ID);

create index IDX_WPS_STATE on TB_WORK_PACKAGES (STATE);
create index IDX_WPS_PORTAL_NAME on TB_WORK_PACKAGES (PORTAL_NAME);
create index IDX_WPS_SERVER_NAME on TB_WORK_PACKAGES (SERVER_NAME);
create index IDX_WPS_OWNER_USER_ID on TB_WORK_PACKAGES (OWNER_USER_ID);
create index IDX_WPS_CREATION_DATE on TB_WORK_PACKAGES (CREATION_DATE);
create index IDX_WPS_STATUS_CHANGE_DATE on TB_WORK_PACKAGES (STATUS_CHANGE_DATE);

create index IDX_APJS_STATE on TB_APPROVAL_JOBS (STATE);

create table TB_NODES (
    NODE_ID bigint not null,
    INSTANCE_NAME varchar(255) not null unique,
    HEARTBEAT timestamp not null default current timestamp,
    IS_MASTER varchar(1) not null default 'N',
    primary key (NODE_ID)
);
alter table TB_NODES
    add constraint CH_NDS_IS_MASTER check (IS_MASTER in ('Y', 'N'));