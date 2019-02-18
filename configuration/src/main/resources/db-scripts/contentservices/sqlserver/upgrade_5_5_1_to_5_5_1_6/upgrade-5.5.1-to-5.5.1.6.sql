drop index ODPATH_IDX on OBJECT_DATA;

create index ODPATH_IDX on OBJECT_DATA(uniquePathCheck) INCLUDE (objectDataPath);