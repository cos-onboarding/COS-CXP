-- will be executed by the maven sql plugin after undeploy orchestrator
drop table if exists TB_AFFECTED_PAGES;

drop table if exists TB_APPROVAL_JOBS;

drop table if exists TB_CONTENT_REFERENCES;

drop table if exists TB_IDENTITY_MAPPING;

drop table if exists TB_PUBLISH_RESULT_ITEM_LOGS;

drop table if exists TB_PUBLISHING_JOBS;

drop table if exists TB_PUBLISH_RESULT_ITEMS;

drop table if exists TB_HOSTS;

alter table TB_ITEM_REFERENCES drop foreign key FK_IRS_PRQS_01;

drop table if exists TB_PUBLISHREQUESTS;

drop table if exists TB_ITEM_REFERENCES;

alter table TB_WORK_PACKAGES drop foreign key FK_PRTS_WPS_01;

drop table if exists TB_PUBLISH_RESULTS;

drop table if exists TB_WORK_PACKAGE_BUNDLES;

drop table if exists TB_WORK_PACKAGE_LOGS;

drop table if exists TB_WORK_PACKAGES;

drop table if exists TB_NODES;

drop table if exists TB_IMPORT_PROCESS_LOGS;

