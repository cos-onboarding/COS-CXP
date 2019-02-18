alter table TB_WORK_PACKAGES
    add SCHEDULED_DATE timestamp null default null;

alter table TB_PUBLISHING_JOBS
    add PUBLISH_REQUEST_ID bigint;

create index IDX_PJS_PR_ID ON TB_PUBLISHING_JOBS (PUBLISH_REQUEST_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PRS foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS(PUBLISH_REQUEST_ID);

alter table TB_PUBLISHING_JOBS
    add PUBLISH_RESULT_ID bigint;

alter table TB_PUBLISHING_JOBS add DISCRIMINATOR varchar(4);
update TB_PUBLISHING_JOBS set DISCRIMINATOR = 'WPPJ';
alter table TB_PUBLISHING_JOBS modify DISCRIMINATOR varchar(4) not null;

alter table TB_PUBLISHING_JOBS
    add WORK_PACKAGE_PUBLISHING_JOB_ID bigint;

alter table TB_PUBLISHING_JOBS
    modify ORCHESTRATOR_REQUIRES_APPROVAL boolean;

alter table TB_PUBLISHING_JOBS
    modify HOST_ID bigint;

alter table TB_PUBLISHING_JOBS
    modify TARGET_PORTAL varchar(255);

create index IDX_PJS_PRT_ID ON TB_PUBLISHING_JOBS (PUBLISH_RESULT_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PRT foreign key (PUBLISH_RESULT_ID)
    references TB_PUBLISH_RESULTS(PUBLISH_RESULT_ID);

create index IDX_PJS_PRT_WPPJ_ID ON TB_PUBLISHING_JOBS (WORK_PACKAGE_PUBLISHING_JOB_ID);
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PJS foreign key (WORK_PACKAGE_PUBLISHING_JOB_ID)
    references TB_PUBLISHING_JOBS(PUBLISHING_JOB_ID);

alter table TB_PUBLISHREQUESTS
    add PUBLISH_ORDER integer;
