alter table TB_PUBLISHING_JOBS
	add UPDATE_PUBLISH_STATES boolean;
	
update TB_PUBLISHING_JOBS set UPDATE_PUBLISH_STATES = 0;

alter table TB_WORK_PACKAGES
	  add STATUS_CHANGE_DATE timestamp null default null;

alter table TB_PUBLISHING_JOBS
    modify FINISHED_DATE timestamp null default null;

alter table TB_PUBLISHING_JOBS
    modify STARTED_DATE timestamp null default null;

alter table TB_WORK_PACKAGES
    modify PUBLICATION_DATE timestamp null default null;

alter table TB_WORK_PACKAGES
    modify STAGING_PUBLICATION_DATE timestamp null default null;