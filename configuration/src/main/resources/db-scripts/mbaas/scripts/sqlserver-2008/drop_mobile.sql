if exists (select 1 from sysobjects where name='app_configuration')
    drop table app_configuration;
GO