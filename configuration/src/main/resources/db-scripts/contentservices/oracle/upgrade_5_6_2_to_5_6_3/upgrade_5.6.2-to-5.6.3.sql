declare
index_not_exists EXCEPTION;
PRAGMA EXCEPTION_INIT(index_not_exists, -1418);
begin
    execute immediate 'drop index ODPATH_IDX';
exception
    when index_not_exists then null;
end;


