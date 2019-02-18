UPDATE OBJECT_DATA SET objectDataPath = (
  SELECT pd.value FROM PROPERTY_DATA pd
  WHERE pd.objectId = 'cmis:path' AND pd.OBJECT_DATA_ID = OBJECT_DATA.id
);

UPDATE OBJECT_DATA SET versionSeriesId = (
  SELECT pd.value FROM PROPERTY_DATA pd
  WHERE pd.objectId = 'cmis:versionSeriesId' AND pd.OBJECT_DATA_ID = OBJECT_DATA.id
);

UPDATE OBJECT_DATA SET isLatestVersion = (
  SELECT pd.value FROM PROPERTY_DATA pd
  WHERE pd.objectId = 'cmis:isLatestVersion' AND pd.OBJECT_DATA_ID = OBJECT_DATA.id
);

UPDATE OBJECT_DATA SET versionLabel = (
  SELECT pd.value FROM  PROPERTY_DATA pd
  WHERE pd.objectId = 'cmis:versionLabel' AND pd.OBJECT_DATA_ID = OBJECT_DATA.id
);

UPDATE OBJECT_DATA SET isLatestVersion = 'true'
WHERE isLatestVersion IS NULL;

UPDATE OBJECT_DATA SET versionLabel = '1.0'
WHERE versionLabel IS NULL AND versionSeriesId IS NOT NULL;