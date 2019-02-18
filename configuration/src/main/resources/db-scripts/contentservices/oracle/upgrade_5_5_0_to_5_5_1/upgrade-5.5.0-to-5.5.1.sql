UPDATE OBJECT_DATA od
SET od.objectDataPath = (select pd.value from PROPERTY_DATA pd where od.id = pd.OBJECT_DATA_ID  and pd.objectId = 'cmis:path');

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