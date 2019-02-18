-- will be executed by the maven sql plugin after undeploy orchestrator

drop table TB_AFFECTED_PAGES;

drop table TB_APPROVAL_JOBS;

drop table TB_CONTENT_REFERENCES;

drop table TB_ITEM_REFERENCES;

drop table TB_PUBLISHING_JOBS;

drop table TB_PUBLISHREQUESTS;

drop table TB_PUBLISH_RESULTS;

drop table TB_PUBLISH_RESULT_ITEMS;

drop table TB_PUBLISH_RESULT_ITEM_LOGS;

drop table TB_WORK_PACKAGE_LOGS;

drop table TB_WORK_PACKAGES;

drop table TB_IDENTITY_MAPPING;

drop table TB_HOSTS;

drop table TB_WORK_PACKAGE_BUNDLES;

drop table TB_NODES;

drop table TB_IMPORT_PROCESS_LOGS;

drop sequence hibernate_sequence RESTRICT;

