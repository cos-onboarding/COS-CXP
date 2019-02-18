 create table LAST_PUBLICATION_DATE (
    id number(19,0) not null,
    lastPublicationDate timestamp not null,
    excludeList nvarchar2(255),
    primary key (id)
);