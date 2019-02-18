create table LAST_PUBLICATION_DATE (
        id bigint not null auto_increment,
        lastPublicationDate datetime not null,
        excludeList varchar(255),
        primary key (id)
    ) engine=ndbcluster;