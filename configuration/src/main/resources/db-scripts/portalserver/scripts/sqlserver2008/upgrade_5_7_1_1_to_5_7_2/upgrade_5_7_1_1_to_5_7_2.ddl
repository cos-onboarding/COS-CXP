create table cancel_import (
	id                  numeric(19, 0) IDENTITY NOT NULL,
	cancelled           nvarchar(10),
	primary key (id)
)
GO

update acl_sid set sid=upper(sid) where sid like 'role_%';