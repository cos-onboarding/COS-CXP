-- will be executed by the maven sql plugin after undeploy orchestrator
if exists (select 1 from sysobjects where name='TB_AFFECTED_PAGES')
  drop table TB_AFFECTED_PAGES
GO

if exists (select 1 from sysobjects where name='TB_APPROVAL_JOBS')
  drop table TB_APPROVAL_JOBS
GO

if exists (select 1 from sysobjects where name='TB_CONTENT_REFERENCES')
  drop table TB_CONTENT_REFERENCES
GO

if exists (select 1 from sysobjects where name='TB_IDENTITY_MAPPING')
  drop table TB_IDENTITY_MAPPING
GO

if exists (select 1 from sysobjects where name='TB_PUBLISH_RESULT_ITEM_LOGS')
  drop table TB_PUBLISH_RESULT_ITEM_LOGS
GO

if exists (select 1 from sysobjects where name='TB_PUBLISHING_JOBS')
  drop table TB_PUBLISHING_JOBS
GO

if exists (select 1 from sysobjects where name='TB_PUBLISH_RESULT_ITEMS')
  drop table TB_PUBLISH_RESULT_ITEMS
GO

if exists (select 1 from sysobjects where name='TB_HOSTS')
  drop table TB_HOSTS
GO

-- add alter table command
if exists (select 1 from sysobjects where name='TB_ITEM_REFERENCES')
	alter table TB_ITEM_REFERENCES drop constraint FK5FB3C479854912A;
GO

if exists (select 1 from sysobjects where name='TB_PUBLISHREQUESTS')
  drop table TB_PUBLISHREQUESTS
GO

if exists (select 1 from sysobjects where name='TB_ITEM_REFERENCES')
  drop table TB_ITEM_REFERENCES
GO

-- add alter table command
if exists (select 1 from sysobjects where name='TB_WORK_PACKAGES')
	alter table TB_WORK_PACKAGES drop constraint FK54941041948387E;
GO

if exists (select 1 from sysobjects where name='TB_PUBLISH_RESULTS')
  drop table TB_PUBLISH_RESULTS
GO

if exists (select 1 from sysobjects where name='TB_WORK_PACKAGE_BUNDLES')
  drop table TB_WORK_PACKAGE_BUNDLES
GO

if exists (select 1 from sysobjects where name='TB_WORK_PACKAGES')
  drop table TB_WORK_PACKAGES
GO

if exists (select 1 from sysobjects where name='TB_WORK_PACKAGE_LOGS')
  drop table TB_WORK_PACKAGE_LOGS
GO

if exists (select 1 from sysobjects where name='TB_NODES')
    drop table TB_NODES
GO

if exists (select 1 from sysobjects where name='TB_IMPORT_PROCESS_LOGS')
    drop table TB_IMPORT_PROCESS_LOGS
GO