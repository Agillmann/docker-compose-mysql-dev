CREATE DATABASE devv;

USE devv

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role INT,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE countries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    capital VARCHAR(255),
    population BIGINT
);

CREATE TABLE sectors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE smartdata (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE smartdata_values (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country_id INT,
    sector_id INT,
    unit_id INT,
    value FLOAT
    PRIMARY KEY(country_id, sector_id, unit_id),
    FOREIGN KEY(sector_id) REFERENCES sectors(id),
    FOREIGN KEY(unit_id) REFERENCES smartdata_units(id)
);

CREATE TABLE smartdata_units (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    unit_type VARCHAR(255) NOT NULL,
    sector INT
);

CREATE TABLE smardata_versions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    version VARCHAR(255) NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_role (
    user_id INT,
    role_id INT,
    PRIMARY KEY(user_id, role_id),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(role_id) REFERENCES roles(id)
);

CREATE TABLE country_role (
    country_id INT,
    role_id INT,
    PRIMARY KEY(country_id, role_id),
    FOREIGN KEY(country_id) REFERENCES countries(id),
    FOREIGN KEY(role_id) REFERENCES roles(id)
);

CREATE TABLE sector_role (
    sector_id INT,
    role_id INT,
    PRIMARY KEY(sector_id, role_id),
    FOREIGN KEY(sector_id) REFERENCES sectors(id),
    FOREIGN KEY(role_id) REFERENCES roles(id)
);

CREATE TABLE smartdata_role (
    smartdata_id INT,
    role_id INT,
    PRIMARY KEY(smartdata_id, role_id),
    FOREIGN KEY(smartdata_id) REFERENCES smartdata(id),
    FOREIGN KEY(role_id) REFERENCES roles(id)
);

CREATE TABLE version_role (
    version_id INT,
    role_id INT,
    PRIMARY KEY(version_id, role_id),
    FOREIGN KEY(version_id) REFERENCES smardata_versions(id),
    FOREIGN KEY(role_id) REFERENCES roles(id)
);

CREATE TABLE unit_role (
    unit_id INT,
    role_id INT,
    PRIMARY KEY(unit_id, role_id),
    FOREIGN KEY(unit_id) REFERENCES smartdata_units(id),
    FOREIGN KEY(role_id) REFERENCES roles(id)
);

-- Create Indexes
CREATE INDEX idx_user_role ON user_role (user_id, role_id);
CREATE INDEX idx_country_role ON country_role (country_id, role_id);
CREATE INDEX idx_sector_role ON sector_role (sector_id, role_id);
CREATE INDEX idx_smartdata_role ON smartdata_role (smartdata_id, role_id);
CREATE INDEX idx_version_role ON version_role (version_id, role_id);
CREATE INDEX idx_unit_role ON unit_role (unit_id, role_id);

-- Create Views

-- Admin Role View
CREATE VIEW admin_role_view AS
SELECT roles.name, smartdata.name AS smartdata_name, smardata_versions.version AS version, sectors.name AS sector_name, countries.name AS country_name
FROM roles
JOIN user_role ON roles.id = user_role.role_id
JOIN users ON user_role.user_id = users.id
JOIN country_role ON roles.id = country_role.role_id
JOIN countries ON country_role.country_id = countries.id
JOIN sector_role ON roles.id = sector_role.role_id
JOIN sectors ON sector_role.sector_id = sectors.id
JOIN smartdata_role ON roles.id = smartdata_role.role_id
JOIN smartdata ON smartdata_role.smartdata_id = smartdata.id
JOIN version_role ON roles.id = version_role.role_id
JOIN smardata_versions ON version_role.version_id = smardata_versions.id
WHERE users.id = 1;

-- User Role View
CREATE VIEW user_role_view AS
SELECT roles.name, smartdata.name AS smartdata_name, smardata_versions.version AS version, sectors.name AS sector_name, countries.name AS country_name
FROM roles
JOIN user_role ON roles.id = user_role.role_id
JOIN users ON user_role.user_id = users.id
JOIN country_role ON roles.id = country_role.role_id
JOIN countries ON country_role.country_id = countries.id
JOIN sector_role ON roles.id = sector_role.role_id
JOIN sectors ON sector_role.sector_id = sectors.id
JOIN smartdata_role ON roles.id = smartdata_role.role_id
JOIN smartdata ON smartdata_role.smartdata_id = smartdata.id
JOIN version_role ON roles.id = version_role.role_id
JOIN smardata_versions ON version_role.version_id = smardata_versions.id
WHERE users.id = 2;

-- Guest Role View
CREATE VIEW guest_role_view AS
SELECT roles.name, smartdata.name AS smartdata_name, smardata_versions.version AS version, sectors.name AS sector_name, countries.name AS country_name
FROM roles
JOIN user_role ON roles.id = user_role.role_id
JOIN users ON user_role.user_id = users.id
JOIN country_role ON roles.id = country_role.role_id
JOIN countries ON country_role.country_id = countries.id
JOIN sector_role ON roles.id = sector_role.role_id
JOIN sectors ON sector_role.sector_id = sectors.id
JOIN smartdata_role ON roles.id = smartdata_role.role_id
JOIN smartdata ON smartdata_role.smartdata_id = smartdata.id
JOIN version_role ON roles.id = version_role.role_id
JOIN smardata_versions ON version_role.version_id = smardata_versions.id
WHERE users.id = 3;


INSERT INTO roles (name, description) VALUES ('ADMIN', 'Administrator');
INSERT INTO roles (name, description) VALUES ('USER', 'User');
INSERT INTO roles (name, description) VALUES ('GUEST', 'Guest');

INSERT INTO users (username, password, role) VALUES ('admin', 'admin', 1);
INSERT INTO users (username, password, role) VALUES ('user', 'user', 2);
INSERT INTO users (username, password, role) VALUES ('guest', 'guest', 3);

INSERT INTO countries (name, capital, population) VALUES ('germany', 'Berlin', 83000000);
INSERT INTO countries (name, capital, population) VALUES ('france', 'Paris', 67000000);
INSERT INTO countries (name, capital, population) VALUES ('italy', 'Rome', 60000000);
INSERT INTO countries (name, capital, population) VALUES ('spain', 'Madrid', 46000000);

INSERT INTO sectors (name, description) VALUES ('energie', 'Energy sector');
INSERT INTO sectors (name, description) VALUES ('transport', 'Transport sector');
INSERT INTO sectors (name, description) VALUES ('industry', 'Industry sector');
INSERT INTO sectors (name, description) VALUES ('agriculture', 'Agriculture sector');

INSERT INTO smartdata (name, description) VALUES ('no2', 'NO2 emissions');
INSERT INTO smartdata (name, description) VALUES ('gdp_nowcast', 'GDP Nowcast');
INSERT INTO smartdata (name, description) VALUES ('POP', 'Population');

INSERT INTO smartdata_units (name, unit_type, sector) VALUES ('flat', 'flat', 1);
INSERT INTO smartdata_units (name, unit_type, sector) VALUES ('yty', 'yty', 2);
INSERT INTO smartdata_units (name, unit_type, sector) VALUES ('mtm', 'mtm', 3);

INSERT INTO smartdata_values (country, sector, unit, value) VALUES (1, 1, 1, 1000);
INSERT INTO smartdata_values (country, sector, unit, value) VALUES (1, 2, 1, 2000);
INSERT INTO smartdata_values (country, sector, unit, value) VALUES (1, 3, 1, 3000);
INSERT INTO smartdata_values (country, sector, unit, value) VALUES (2, 1, 1, 4000);
INSERT INTO smartdata_values (country, sector, unit, value) VALUES (2, 2, 1, 5000);
INSERT INTO smartdata_values (country, sector, unit, value) VALUES (2, 3, 1, 6000);

INSERT INTO smardata_versions (version) VALUES ('1.0.0');
INSERT INTO smardata_versions (version) VALUES ('1.0.1');

INSERT INTO user_role (user_id, role_id) VALUES (1, 1);
INSERT INTO user_role (user_id, role_id) VALUES (2, 2);
INSERT INTO user_role (user_id, role_id) VALUES (3, 3);

INSERT INTO country_role (country_id, role_id) VALUES (1, 1);
INSERT INTO country_role (country_id, role_id) VALUES (2, 2);
INSERT INTO country_role (country_id, role_id) VALUES (3, 3);
INSERT INTO country_role (country_id, role_id) VALUES (4, 3);

INSERT INTO sector_role (sector_id, role_id) VALUES (1, 1);
INSERT INTO sector_role (sector_id, role_id) VALUES (2, 2);
INSERT INTO sector_role (sector_id, role_id) VALUES (3, 3);
INSERT INTO sector_role (sector_id, role_id) VALUES (4, 3);

INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (1, 1);
INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (2, 2);
INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (3, 3);

INSERT INTO version_role (version_id, role_id) VALUES (1, 1);
INSERT INTO version_role (version_id, role_id) VALUES (2, 2);

INSERT INTO unit_role (unit_id, role_id) VALUES (1, 1);
INSERT INTO unit_role (unit_id, role_id) VALUES (2, 2);
INSERT INTO unit_role (unit_id, role_id) VALUES (3, 3);

