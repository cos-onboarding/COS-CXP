alter table TB_WORK_PACKAGES
    add SCHEDULED_DATE datetime null
GO

alter table TB_PUBLISHING_JOBS
    add PUBLISH_REQUEST_ID numeric(19,0) null
GO

CREATE NONCLUSTERED index IDX_PJS_PR_ID ON TB_PUBLISHING_JOBS (PUBLISH_REQUEST_ID)
GO
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PRS foreign key (PUBLISH_REQUEST_ID)
    references TB_PUBLISHREQUESTS(PUBLISH_REQUEST_ID)
GO

alter table TB_PUBLISHING_JOBS
    add PUBLISH_RESULT_ID numeric(19,0) null
GO

alter table TB_PUBLISHING_JOBS add DISCRIMINATOR nvarchar(4)
GO
update TB_PUBLISHING_JOBS set DISCRIMINATOR = 'WPPJ'
GO
alter table TB_PUBLISHING_JOBS alter column DISCRIMINATOR nvarchar(4) not null
GO

alter table TB_PUBLISHING_JOBS 
    add WORK_PACKAGE_PUBLISHING_JOB_ID numeric (19,0)
GO

alter table TB_PUBLISHING_JOBS
    alter column ORCHESTRATOR_REQUIRES_APPROVAL numeric (1,0)
GO

alter table TB_PUBLISHING_JOBS
    alter column HOST_ID numeric (19,0)
GO

alter table TB_PUBLISHING_JOBS
    alter column TARGET_PORTAL nvarchar(255) null
GO

create nonclustered index IDX_PJS_PRT_ID ON TB_PUBLISHING_JOBS (PUBLISH_RESULT_ID)
GO
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PRT foreign key (PUBLISH_RESULT_ID)
    references TB_PUBLISH_RESULTS(PUBLISH_RESULT_ID)
GO

create nonclustered index IDX_PJS_PRT_WPPJ_ID ON TB_PUBLISHING_JOBS (WORK_PACKAGE_PUBLISHING_JOB_ID)
GO
alter table TB_PUBLISHING_JOBS
    add constraint FK_PJS_PJS foreign key (WORK_PACKAGE_PUBLISHING_JOB_ID)
    references TB_PUBLISHING_JOBS(PUBLISHING_JOB_ID)
GO

alter table TB_PUBLISHREQUESTS
    add PUBLISH_ORDER numeric(10,0) null
GO

alter table TB_HOSTS
    alter column PORT numeric(5,0) not null
GO
