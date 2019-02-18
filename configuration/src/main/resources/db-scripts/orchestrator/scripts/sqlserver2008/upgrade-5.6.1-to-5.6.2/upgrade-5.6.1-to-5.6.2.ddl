create nonclustered index IDX_PJS_DISC ON TB_PUBLISHING_JOBS (DISCRIMINATOR)
GO
create unique nonclustered index IDX_PJS_UUID ON TB_PUBLISHING_JOBS (UUID)
GO
create nonclustered index IDX_PJS_STATE ON TB_PUBLISHING_JOBS (STATE)
GO

create nonclustered index IDX_HTS_NAME ON TB_HOSTS (NAME)
GO
alter table TB_HOSTS
  alter column PORT numeric(5,0) not null
GO

create nonclustered index IDX_WPL_WORKPACKAGE_ID on TB_WORK_PACKAGE_LOGS (WORKPACKAGE_ID)
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

create nonclustered index IDX_APJS_STATE on TB_APPROVAL_JOBS (STATE)
GO

create table TB_NODES (
    NODE_ID numeric(19,0) identity not null,
    INSTANCE_NAME nvarchar(255) not null unique,
    HEARTBEAT datetime not null default current_timestamp,
    IS_MASTER bit not null default 0,
    primary key (NODE_ID)
)
GO
