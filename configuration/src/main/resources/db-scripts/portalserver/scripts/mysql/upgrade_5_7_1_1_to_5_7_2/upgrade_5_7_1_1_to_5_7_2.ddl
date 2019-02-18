create table cancel_import (
	id bigint not null auto_increment,
	cancelled varchar(10),
	primary key (id)
)ENGINE=InnoDB;

update acl_sid set sid=upper(sid) where sid like 'role_%';