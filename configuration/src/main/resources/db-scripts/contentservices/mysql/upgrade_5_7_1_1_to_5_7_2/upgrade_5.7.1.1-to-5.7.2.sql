create table CANCEL_IMPORT (
    id bigint not null auto_increment,
    cancelled varchar(10),
    primary key (id)
) ROW_FORMAT=DYNAMIC;