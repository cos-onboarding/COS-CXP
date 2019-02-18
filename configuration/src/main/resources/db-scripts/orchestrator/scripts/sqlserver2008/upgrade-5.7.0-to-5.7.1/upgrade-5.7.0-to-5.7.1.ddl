create table TB_IMPORT_PROCESS_LOGS (
    IMPORT_LOG_ID numeric(19,0) identity not null,
    PORTAL_NAME nvarchar(255) not null,
    MESSAGE nvarchar(255),
    STATUS nvarchar(25) not null,
    START_DATE datetime,
    END_DATE datetime,
    primary key (IMPORT_LOG_ID)
)
GO