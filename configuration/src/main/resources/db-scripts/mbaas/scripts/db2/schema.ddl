create table app_configuration (
    integer_pos INT,
	  portal_name nvarchar(255) not null,
    version nvarchar(255) not null,
    platform nvarchar(255) not null,
    status nvarchar(255),
    link nvarchar(255)
);

ALTER TABLE app_configuration ADD CONSTRAINT pk_app_configuration PRIMARY KEY (portal_name,version,platform);

create index idx_app_conf_01 on app_configuration (portal_name);

create index idx_app_conf_02 on app_configuration (version);

create index idx_app_conf_03 on app_configuration (platform);