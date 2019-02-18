INSERT INTO app_configuration (portal_name, version, platform, status) VALUES ('hello-1_2-iphone','1.2','IPHONE','OK');
INSERT INTO app_configuration (portal_name, version, platform, status,link) VALUES ('hello-1_1-iphone','1.1','IPHONE','DEPRECATED', 'https://www.youtube.com/watch?v=RenOUsGvS90');
INSERT INTO app_configuration (portal_name, version, platform, status,link) VALUES ('hello','1.0','IPHONE','OBSOLETE', 'https://www.youtube.com/watch?v=RenOUsGvS90');

INSERT INTO app_configuration (portal_name, version, platform, status) VALUES ('hello-2_0-android','2.0','ANDROID','OK');
INSERT INTO app_configuration (portal_name, version, platform, status,link) VALUES ('hello','1.0','ANDROID','DEPRECATED','https://www.youtube.com/watch?v=RenOUsGvS90');

INSERT INTO app_configuration (portal_name, version, platform, status,link) VALUES ('hello2','1.0','ANDROID','DEPRECATED','https://www.youtube.com/watch?v=RenOUsGvS90');
INSERT INTO app_configuration (portal_name, version, platform, status,link) VALUES ('hello2','2.0','ANDROID','OK','');
INSERT INTO app_configuration (portal_name, version, platform, status,link) VALUES ('hello2','2.0','IPHONE','OK','');