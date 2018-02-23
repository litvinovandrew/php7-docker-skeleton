CREATE DATABASE project CHARACTER SET = 'utf8' COLLATE = 'utf8_unicode_ci';
CREATE DATABASE project_test CHARACTER SET = 'utf8' COLLATE = 'utf8_unicode_ci';
CREATE USER 'project'@'%' IDENTIFIED BY 'project123';
GRANT ALL PRIVILEGES ON wimoov.* TO 'project'@'%';
GRANT ALL PRIVILEGES ON wimoov_test.* TO 'project'@'%';
FLUSH PRIVILEGES;
