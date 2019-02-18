-- For bb:link
insert into
    PROPERTY_DEFINITION (cardinality, description, displayName, localName, localNamespace, objectId, OBJECT_TYPE_ID, orderable, queryName, queryable, required, type, updatability)
values
    ('single', null, 'Sub Title', 'bb:subTitle', 'http://docs.oasis-open.org/ns/cmis/core/200908/', 'bb:subTitle', (select id from OBJECT_TYPE_DEFINITION where objectId='bb:link'), null, 'bb:subTitle', null, 0, 'string', 'readwrite')

