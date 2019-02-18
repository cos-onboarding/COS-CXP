-- For bb:link

insert into
    PROPERTY_DEFINITION (id, cardinality, description, displayName, localName, localNamespace, objectId, OBJECT_TYPE_ID, orderable, queryName, queryable, required, type, updatability)
values
    (hibernate_sequence.NEXTVAL, 'single', null, 'Description', 'bb:description', 'http://docs.oasis-open.org/ns/cmis/core/200908/', 'bb:description', (select id from OBJECT_TYPE_DEFINITION where objectId='bb:link'), null, 'bb:description', null, 0, 'string', 'readwrite')
