-- will be executed by the maven sql plugin after undeploy orchestrator
drop table TB_AFFECTED_PAGES cascade constraints;

drop table TB_APPROVAL_JOBS cascade constraints;

drop table TB_CONTENT_REFERENCES cascade constraints;

drop table TB_ITEM_REFERENCES cascade constraints;

drop table TB_PUBLISHING_JOBS cascade constraints;

drop table TB_PUBLISHREQUESTS cascade constraints;

drop table TB_PUBLISH_RESULTS cascade constraints;

drop table TB_PUBLISH_RESULT_ITEMS cascade constraints;

drop table TB_PUBLISH_RESULT_ITEM_LOGS cascade constraints;

drop table TB_WORK_PACKAGE_LOGS cascade constraints;

drop table TB_WORK_PACKAGES cascade constraints;

drop table TB_IDENTITY_MAPPING cascade constraints;

drop table TB_HOSTS cascade constraints;

drop table TB_WORK_PACKAGE_BUNDLES cascade constraints;

drop table TB_NODES cascade constraints;

drop table TB_IMPORT_PROCESS_LOGS cascade constraints;

drop sequence hibernate_sequence;