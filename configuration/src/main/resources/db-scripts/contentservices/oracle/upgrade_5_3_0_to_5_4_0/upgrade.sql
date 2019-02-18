alter table OBJECT_TYPE_DEFINITION add (versionable number(1,0));
update OBJECT_TYPE_DEFINITION set versionable = 1 where objectid like 'bb:%';
update OBJECT_TYPE_DEFINITION set versionable = 0 where objectid = 'cmis:document';
commit;