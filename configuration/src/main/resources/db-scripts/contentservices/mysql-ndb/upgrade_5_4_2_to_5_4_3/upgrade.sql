#OBJECT_DATA
ALTER TABLE OBJECT_DATA ADD COLUMN path VARCHAR(765) NOT NULL;
ALTER TABLE OBJECT_DATA ADD COLUMN versionLabel VARCHAR(255) DEFAULT NULL;
ALTER TABLE OBJECT_DATA ADD COLUMN versionSeriesId VARCHAR(255) DEFAULT NULL;
ALTER TABLE OBJECT_DATA ADD COLUMN isLatestVersion VARCHAR(255) DEFAULT NULL;
ALTER TABLE OBJECT_DATA ADD COLUMN uniquePathCheck VARCHAR(64) UNIQUE;

CREATE INDEX ODILV_IDX ON OBJECT_DATA (isLatestVersion);
CREATE INDEX ODVL_IDX ON OBJECT_DATA (versionLabel);
CREATE INDEX ODVSID_IDX ON OBJECT_DATA (versionSeriesId);
CREATE INDEX ODPATH_IDX ON OBJECT_DATA (path);

CREATE INDEX FK_PDEF_IDX_OBJ_ID ON PROPERTY_DEFINITION (objectId);
CREATE INDEX FK_RND_IDX_CONTENT_STREAM_ID ON RENDITION (CS_ID);

UPDATE OBJECT_DATA od SET od.path = (
  SELECT pd.value FROM PROPERTY_DATA pd
  WHERE pd.objectId = 'cmis:path' AND pd.OBJECT_DATA_ID = od.id
);

UPDATE OBJECT_DATA od SET od.versionSeriesId = (
  SELECT pd.value FROM PROPERTY_DATA pd
  WHERE pd.objectId = 'cmis:versionSeriesId' AND pd.OBJECT_DATA_ID = od.id
);

UPDATE OBJECT_DATA od SET od.isLatestVersion = (
  SELECT pd.value FROM PROPERTY_DATA pd
  WHERE pd.objectId = 'cmis:isLatestVersion' AND pd.OBJECT_DATA_ID = od.id
);

UPDATE OBJECT_DATA od SET od.versionLabel = (
  SELECT pd.value FROM  PROPERTY_DATA pd
  WHERE pd.objectId = 'cmis:versionLabel' AND pd.OBJECT_DATA_ID = od.id
);

UPDATE OBJECT_DATA od SET od.isLatestVersion = 'true'
WHERE od.isLatestVersion IS NULL;

UPDATE OBJECT_DATA od SET od.versionLabel = '1.0'
WHERE od.versionLabel IS NULL AND od.versionSeriesId IS NOT NULL;

