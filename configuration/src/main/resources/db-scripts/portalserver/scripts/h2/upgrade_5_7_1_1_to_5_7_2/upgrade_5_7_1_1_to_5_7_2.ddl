create table cancel_import (
    id bigint not null auto_increment,
    cancelled varchar(10),
    primary key (id)
);

update acl_sid set sid=UPPER(sid) where sid like 'role_%';