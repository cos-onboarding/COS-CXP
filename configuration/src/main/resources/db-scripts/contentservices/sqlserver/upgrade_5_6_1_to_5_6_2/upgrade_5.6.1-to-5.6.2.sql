drop index ODPATH_IDX on OBJECT_DATA;
go

create index ODPATH_IDX on OBJECT_DATA(uniquePathCheck) INCLUDE (path);
go

drop index REL_TARGET_IDX on RELATIONSHIPS;
go

alter table RELATIONSHIPS alter column targetRepositoryId nvarchar(36) not null;
go

alter table RELATIONSHIPS alter column targetObjectId nvarchar(36) not null;
go

create index REL_TARGET_IDX on RELATIONSHIPS (targetRepositoryId, targetObjectId);
go