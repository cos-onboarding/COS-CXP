alter table TB_PUBLISHING_JOBS
    add PUBLISH_REQUEST_ID bigint;

create index IDX_PJS_PR_ID ON TB_PUBLISHING_JOBS (PUBLISH_REQUEST_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PRS foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS;

alter table TB_PUBLISHING_JOBS
    add PUBLISH_RESULT_ID bigint;

alter table TB_PUBLISHING_JOBS add DISCRIMINATOR varchar(4);
update TB_PUBLISHING_JOBS set DISCRIMINATOR = 'WPPJ';
alter table TB_PUBLISHING_JOBS alter DISCRIMINATOR set not null;

alter table TB_PUBLISHING_JOBS
    add WORK_PACKAGE_PUBLISHING_JOB_ID bigint;

alter table TB_PUBLISHING_JOBS
    alter ORCHESTRATOR_REQUIRES_APPROVAL drop not null;

alter table TB_PUBLISHING_JOBS
    alter HOST_ID drop not null;

alter table TB_PUBLISHING_JOBS
    alter TARGET_PORTAL drop not null;

alter table TB_PUBLISHING_JOBS
    add TARGET_REPOSITORY varchar(255);

create index IDX_PJS_PRT_ID ON TB_PUBLISHING_JOBS (PUBLISH_RESULT_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PRT foreign key (PUBLISH_RESULT_ID)
    references TB_PUBLISH_RESULTS;

create index IDX_PJS_PRT_WPPJ_ID ON TB_PUBLISHING_JOBS (WORK_PACKAGE_PUBLISHING_JOB_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PJS foreign key (WORK_PACKAGE_PUBLISHING_JOB_ID)
    references TB_PUBLISHING_JOBS;


alter table TB_PUBLISHREQUESTS
    add PUBLISH_ORDER integer;

alter table TB_WORK_PACKAGES
    add REPOSITORY_REFERENCE varchar(255);

alter table TB_PUBLISHREQUESTS
    drop column PUBLISH_ACTION_TYPE;

alter table TB_CONTENT_REFERENCES
    add TITLE varchar(255);

alter table TB_CONTENT_REFERENCES drop column MARKED_FOR_DELETION;

alter table TB_CONTENT_REFERENCES drop column TYPE;

alter table TB_CONTENT_REFERENCES rename column ITEM_NAME to CONTEXT;

update TB_CONTENT_REFERENCES set CONTEXT = 'contentRepository';

alter table TB_CONTENT_REFERENCES alter column CONTEXT SET DATA TYPE varchar(255) not null;

REORG table TB_WORK_PACKAGES;
REORG table PUBLISHING_JOBS;
REORG table TB_PUBLISHREQUESTS;
