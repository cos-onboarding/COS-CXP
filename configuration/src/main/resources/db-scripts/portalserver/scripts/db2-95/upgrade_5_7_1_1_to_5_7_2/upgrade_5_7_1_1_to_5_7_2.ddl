create table cancel_import (
    id bigint not null,
    cancelled varchar(10),
    primary key (id)
);

CREATE SEQUENCE CANCEL_IMPORT_SEQ AS DECIMAL(27,0)
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 999999
    NOCYCLE
    CACHE 20
    NO ORDER;

CREATE TRIGGER cancel_import_id NO CASCADE BEFORE INSERT ON cancel_import REFERENCING NEW AS new_cancel_import
	FOR EACH ROW MODE DB2SQL
	SET new_cancel_import.id = CANCEL_IMPORT_SEQ.nextVal;

update acl_sid set sid=UPPER(sid) where sid like 'role_%';
