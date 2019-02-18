-- For rich text

insert into
    PROPERTY_DEFINITION (id, cardinality, description, displayName, localName, localNamespace, objectId, OBJECT_TYPE_ID, orderable, queryName, queryable, required, type, updatability)
values
    (hibernate_sequence.NEXTVAL, 'single', null, 'Sub Title', 'bb:subTitle', 'http://docs.oasis-open.org/ns/cmis/core/200908/', 'bb:subTitle', (select id from OBJECT_TYPE_DEFINITION where objectId='bb:richtext'), null, 'bb:subTitle', null, 0, 'string', 'readwrite')

insert into
    PROPERTY_DEFINITION (id, cardinality, description, displayName, localName, localNamespace, objectId, OBJECT_TYPE_ID, orderable, queryName, queryable, required, type, updatability)
values
    (hibernate_sequence.NEXTVAL, 'single', null, 'Description', 'bb:description', 'http://docs.oasis-open.org/ns/cmis/core/200908/', 'bb:description', (select id from OBJECT_TYPE_DEFINITION where objectId='bb:richtext'), null, 'bb:description', null, 0, 'string', 'readwrite')

-- For bb:image
insert into
    PROPERTY_DEFINITION (id, cardinality, description, displayName, localName, localNamespace, objectId, OBJECT_TYPE_ID, orderable, queryName, queryable, required, type, updatability)
values
    (hibernate_sequence.NEXTVAL, 'single', null, 'Sub Title', 'bb:subTitle', 'http://docs.oasis-open.org/ns/cmis/core/200908/', 'bb:subTitle', (select id from OBJECT_TYPE_DEFINITION where objectId='bb:image'), null, 'bb:subTitle', null, 0, 'string', 'readwrite')

insert into
    PROPERTY_DEFINITION (id, cardinality, description, displayName, localName, localNamespace, objectId, OBJECT_TYPE_ID, orderable, queryName, queryable, required, type, updatability)
values
    (hibernate_sequence.NEXTVAL, 'single', null, 'Description', 'bb:description', 'http://docs.oasis-open.org/ns/cmis/core/200908/', 'bb:description', (select id from OBJECT_TYPE_DEFINITION where objectId='bb:image'), null, 'bb:description', null, 0, 'string', 'readwrite')
