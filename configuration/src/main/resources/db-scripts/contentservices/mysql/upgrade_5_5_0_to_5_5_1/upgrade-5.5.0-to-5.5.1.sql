UPDATE OBJECT_DATA od SET od.objectDataPath = (
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