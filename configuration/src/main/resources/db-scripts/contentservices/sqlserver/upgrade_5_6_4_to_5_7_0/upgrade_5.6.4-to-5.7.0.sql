create table LAST_PUBLICATION_DATE (
    id numeric(19,0) identity not null,
    lastPublicationDate datetime not null,
    excludeList nvarchar(255),
    primary key (id)
);
GO