alter table TB_IMPORT_PROCESS_LOGS
    ADD CREATOR_USERNAME varchar(255);

alter table TB_IMPORT_PROCESS_LOGS
              modify MESSAGE longtext;