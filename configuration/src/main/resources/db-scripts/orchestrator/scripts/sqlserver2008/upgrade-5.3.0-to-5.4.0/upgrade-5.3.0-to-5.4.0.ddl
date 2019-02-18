alter table TB_PUBLISHING_JOBS
    add TARGET_PORTAL_SERVER_ID numeric(19,0) null
    GO

alter table TB_ITEM_REFERENCES
    add DTYPE nvarchar(31) null
    GO

alter table TB_ITEM_REFERENCES
    add RESOLVING_STRATEGY nvarchar(255) null
    GO

update TB_ITEM_REFERENCES
    set DTYPE = 'S'
    where PUBLISH_REQUEST_ID is null
    GO

update TB_ITEM_REFERENCES
    set DTYPE = 'I'
    where PUBLISH_REQUEST_ID is not null
    GO

update TB_ITEM_REFERENCES
    set RESOLVING_STRATEGY = 'WITH_LINKED_ITEMS'
    where PUBLISH_REQUEST_ID is null
    GO

alter table TB_ITEM_REFERENCES
    alter column DTYPE varchar(31) not null
    GO
