create table CANCEL_IMPORT (
    id numeric(19,0) identity not null,
    cancelled nvarchar(10),
    primary key (id)
);
GO