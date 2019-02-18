create table cancel_import (
	id                  NUMBER(19, 0) NOT NULL,
	cancelled           NVARCHAR2(10),
	PRIMARY KEY (id)
);

update acl_sid set sid=upper(sid) where sid like 'role_%';

CREATE SEQUENCE "CANCEL_IMPORT_SEQ"
INCREMENT BY 1
MAXVALUE 9999999999999999999999999999
START WITH 1
CACHE 20
NOORDER
NOCYCLE;

CREATE OR REPLACE TRIGGER "CANCEL_IMPORT_ID"
BEFORE INSERT ON cancel_import
FOR EACH ROW
  BEGIN
    SELECT
      CANCEL_IMPORT_SEQ.NEXTVAL
    INTO :new.id
    FROM dual;
  END;
/