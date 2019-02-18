exec sp_rename 'groups.id', 'ID' , 'COLUMN'
GO

exec sp_rename 'tags.id', 'ID' , 'COLUMN'
GO

exec sp_rename 'items.id', 'ID' , 'COLUMN'
GO

exec sp_rename 'item_tags.id', 'ID' , 'COLUMN'
GO

exec sp_rename 'property_definition.id', 'ID' , 'COLUMN'
GO

exec sp_rename 'user_property_definition.id', 'ID' , 'COLUMN'
GO

exec sp_rename 'deleted_page_item.id', 'ID' , 'COLUMN'
GO

exec sp_rename 'users.id', 'ID' , 'COLUMN'
GO
