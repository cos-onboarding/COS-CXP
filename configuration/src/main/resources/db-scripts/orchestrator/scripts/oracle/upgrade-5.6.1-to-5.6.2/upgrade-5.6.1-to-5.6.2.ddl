create index IDX_PJS_DISC ON TB_PUBLISHING_JOBS (DISCRIMINATOR) logging noparallel;
create unique index IDX_PJS_UUID ON TB_PUBLISHING_JOBS (UUID) logging noparallel;
create index IDX_PJS_STATE ON TB_PUBLISHING_JOBS (STATE) logging noparallel;

create index IDX_HTS_NAME ON TB_HOSTS (NAME) logging noparallel;

create index IDX_WPL_WORKPACKAGE_ID on TB_WORK_PACKAGE_LOGS (WORKPACKAGE_ID) logging noparallel;

create index IDX_WPS_STATE on TB_WORK_PACKAGES (STATE) logging noparallel;
create index IDX_WPS_PORTAL_NAME on TB_WORK_PACKAGES (PORTAL_NAME) logging noparallel;
create index IDX_WPS_SERVER_NAME on TB_WORK_PACKAGES (SERVER_NAME) logging noparallel;
create index IDX_WPS_OWNER_USER_ID on TB_WORK_PACKAGES (OWNER_USER_ID) logging noparallel;
create index IDX_WPS_CREATION_DATE on TB_WORK_PACKAGES (CREATION_DATE) logging noparallel;
create index IDX_WPS_STATUS_CHANGE_DATE on TB_WORK_PACKAGES (STATUS_CHANGE_DATE) logging noparallel;

create index IDX_APJS_STATE on TB_APPROVAL_JOBS (STATE) logging noparallel;

create table TB_NODES (
    NODE_ID NUMBER(19,0) not null,
    INSTANCE_NAME nvarchar2(255) unique not null,
    HEARTBEAT timestamp default SYSTIMESTAMP not null,
    IS_MASTER number(1,0) default 0 not null,
    primary key (NODE_ID)
);
alter table TB_NODES
    add constraint CH_NDS_IS_MASTER check (IS_MASTER in (0, 1));