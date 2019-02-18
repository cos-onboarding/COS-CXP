alter table TB_PUBLISHING_JOBS
    add TARGET_PORTAL_SERVER_ID NUMBER(19,0);

alter table TB_ITEM_REFERENCES
    add DTYPE nvarchar2(31);

alter table TB_ITEM_REFERENCES
    add RESOLVING_STRATEGY nvarchar2(255);

update TB_ITEM_REFERENCES
    set DTYPE = 'S'
    where PUBLISH_REQUEST_ID is null;

update TB_ITEM_REFERENCES
    set DTYPE = 'I'
    where PUBLISH_REQUEST_ID is not null;

update TB_ITEM_REFERENCES
    set RESOLVING_STRATEGY = 'WITH_LINKED_ITEMS'
    where PUBLISH_REQUEST_ID is null;

alter table TB_ITEM_REFERENCES
    modify DTYPE nvarchar2(31) not null;
