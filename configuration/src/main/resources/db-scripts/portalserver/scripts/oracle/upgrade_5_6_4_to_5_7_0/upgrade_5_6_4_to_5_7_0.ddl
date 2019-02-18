CREATE TABLE last_publication_date (
  id                  NUMBER(19, 0)   NOT NULL,
  lastPublicationDate TIMESTAMP       NOT NULL,
  excludeList         NVARCHAR2(255),
  PRIMARY KEY (id)
);


-- Migration for AjaxButton_widget

DELETE FROM property_definition where name='method' and item_id in
(select id from items where name in ('AjaxButton_ResetCache_widget','AjaxButton_SOLR_reindexation_widget'));

UPDATE  property_definition
SET internalValue='DELETE:/orchestrator/caches'
WHERE  name='url' and item_id= (select id from items where name ='AjaxButton_ResetCache_widget');

UPDATE  property_definition
SET internalValue='DELETE:/portals/solr/reindex'
WHERE name='url'and item_id= (select id from items where name ='AjaxButton_SOLR_reindexation_widget');