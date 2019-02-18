create table TB_IMPORT_PROCESS_LOGS (
    IMPORT_LOG_ID NUMBER(19,0) not null,
    PORTAL_NAME nvarchar2(255) not null,
    MESSAGE nvarchar2(255),
    STATUS nvarchar2(25) not null,
    START_DATE timestamp,
    END_DATE timestamp,
    primary key (IMPORT_LOG_ID)
);