ALTER TABLE OBJECT_DATA ADD path VARCHAR2(765 char) NULL;
ALTER TABLE OBJECT_DATA ADD versionLabel VARCHAR2(255 char) NULL;
ALTER TABLE OBJECT_DATA ADD versionSeriesId VARCHAR2(255 char) NULL;
ALTER TABLE OBJECT_DATA ADD isLatestVersion VARCHAR2(255 char) NULL;
ALTER TABLE OBJECT_DATA ADD uniquePathCheck VARCHAR2(64 char) NULL;

CREATE INDEX ODILV_IDX ON OBJECT_DATA (isLatestVersion);
CREATE INDEX ODVL_IDX ON OBJECT_DATA (versionLabel);
CREATE INDEX ODVSID_IDX ON OBJECT_DATA (versionSeriesId);
CREATE INDEX ODPATH_IDX ON OBJECT_DATA (path);

CREATE INDEX FK_PDEF_IDX_OBJ_ID ON PROPERTY_DEFINITION (objectId);
CREATE INDEX FK_RND_IDX_CONTENT_STREAM_ID ON RENDITION (CS_ID);

UPDATE OBJECT_DATA od
SET od.path = (select pd.value from PROPERTY_DATA pd where od.id = pd.OBJECT_DATA_ID  and pd.objectId = 'cmis:path');

UPDATE OBJECT_DATA od
SET od.versionSeriesId = (select pd.value from PROPERTY_DATA pd where od.id = pd.OBJECT_DATA_ID  and pd.objectId = 'cmis:versionSeriesId');


UPDATE OBJECT_DATA od
SET od.isLatestVersion = (select pd.value from PROPERTY_DATA pd where od.id = pd.OBJECT_DATA_ID  and pd.objectId = 'cmis:isLatestVersion');

UPDATE OBJECT_DATA od
SET od.versionLabel = (select pd.value from PROPERTY_DATA pd where od.id = pd.OBJECT_DATA_ID  and pd.objectId = 'cmis:versionLabel');


UPDATE OBJECT_DATA od SET od.isLatestVersion = 'true'
WHERE od.isLatestVersion IS NULL;

UPDATE OBJECT_DATA od SET od.versionLabel = '1.0'
WHERE od.versionLabel IS NULL
AND od.versionSeriesId IS NOT NULL;

ALTER TABLE OBJECT_DATA MODIFY path VARCHAR(765 char) NOT NULL;
ALTER TABLE OBJECT_DATA MODIFY uniquePathCheck VARCHAR(64 char) UNIQUE;
