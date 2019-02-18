create table last_publication_date (
	id numeric(19,0) identity not null,
  lastPublicationDate datetime not null,
  excludeList nvarchar(255),
  primary key (id)
)
GO

-- Migration for AjaxButton_widget

DELETE FROM property_definition where name='method' and item_id in
(select ID from items where name in ('AjaxButton_ResetCache_widget','AjaxButton_SOLR_reindexation_widget'))
GO

UPDATE  property_definition
SET internalValue='DELETE:/orchestrator/caches'
WHERE  name='url' and item_id= (select ID from items where name ='AjaxButton_ResetCache_widget')
GO

UPDATE  property_definition
SET internalValue='DELETE:/portals/solr/reindex'
WHERE name='url'and item_id= (select ID from items where name ='AjaxButton_SOLR_reindexation_widget')
GO