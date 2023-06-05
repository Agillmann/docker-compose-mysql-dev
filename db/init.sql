CREATE DATABASE devv;

USE devv

CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT DEFAULT NULL
);

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE countries (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    capital VARCHAR(255) DEFAULT NULL,
    population BIGINT DEFAULT NULL
);

CREATE TABLE sectors (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT DEFAULT NULL
);



CREATE TABLE smartdata (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT DEFAULT NULL,
    version_id VARCHAR(255) NOT NULL,
    UNIQUE KEY(id, name, version_id)
);



CREATE TABLE smartdata_countries (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
    smartdata_id INT NOT NULL,
    country_id INT NOT NULL,
    UNIQUE KEY(smartdata_id, country_id),
    FOREIGN KEY(smartdata_id) REFERENCES smartdata(id) ON DELETE CASCADE,
    FOREIGN KEY(country_id) REFERENCES countries(id) ON DELETE CASCADE
);
    

CREATE TABLE smartdata_sectors (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    smartdata_id INT NOT NULL,
    sector_id INT NOT NULL,
    UNIQUE KEY(smartdata_id, sector_id),
    FOREIGN KEY(smartdata_id) REFERENCES smartdata(id) ON DELETE CASCADE,
    FOREIGN KEY(sector_id) REFERENCES sectors(id) ON DELETE CASCADE
);

CREATE TABLE smartdata_role (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
    smartdata_id INT,
    role_id INT,
    country_id INT,
    UNIQUE KEY(smartdata_id, role_id, country_id),
    FOREIGN KEY(smartdata_id) REFERENCES smartdata(id) ON DELETE CASCADE,
    FOREIGN KEY(role_id) REFERENCES roles(id) ON DELETE CASCADE,
    FOREIGN KEY(country_id) REFERENCES countries(id) ON DELETE CASCADE
);

CREATE TABLE user_role (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    UNIQUE KEY(user_id, role_id),
    FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- CREATE TABLE country_role (
--     id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
--     country_id INT NOT NULL,
--     role_id INT NOT NULL,
--     UNIQUE KEY(country_id, role_id),
--     FOREIGN KEY(country_id) REFERENCES countries(id) ON DELETE CASCADE,
--     FOREIGN KEY(role_id) REFERENCES roles(id) ON DELETE CASCADE
-- );

-- CREATE TABLE sector_role (
--     id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
--     sector_id INT,
--     role_id INT,
--     UNIQUE KEY(sector_id, role_id),
--     FOREIGN KEY(sector_id) REFERENCES sectors(id) ON DELETE CASCADE,
--     FOREIGN KEY(role_id) REFERENCES roles(id) ON DELETE CASCADE
-- );



-- CREATE TABLE smartdata_units (
--     id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
--     name VARCHAR(255) NOT NULL,
--     unit_type VARCHAR(255) NOT NULL
-- );

-- CREATE TABLE smartdata_values (
--     id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
--     country_id INT NOT NULL,
--     sector_id INT NOT NULL,
--     unit_id INT NOT NULL,
--     value FLOAT,
--     UNIQUE KEY(country_id, sector_id, unit_id),
--     FOREIGN KEY(sector_id) REFERENCES sectors(id) ON DELETE CASCADE,
--     FOREIGN KEY(unit_id) REFERENCES smartdata_units(id) ON DELETE CASCADE,
--     FOREIGN KEY(country_id) REFERENCES countries(id) ON DELETE CASCADE
-- );

-- CREATE TABLE smartdata_sectors (
--     id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
--     smartdata_id INT NOT NULL,
--     sector_id INT NOT NULL,
--     UNIQUE KEY(smartdata_id, sector_id),
--     FOREIGN KEY(smartdata_id) REFERENCES smartdata(id) ON DELETE CASCADE,
--     FOREIGN KEY(sector_id) REFERENCES sectors(id) ON DELETE CASCADE
-- );



-- CREATE TABLE version_role (
--     id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
--     version_id INT,
--     role_id INT,
--     UNIQUE KEY(version_id, role_id),
--     FOREIGN KEY(version_id) REFERENCES smardata_versions(id) ON DELETE CASCADE,
--     FOREIGN KEY(role_id) REFERENCES roles(id) ON DELETE CASCADE
-- );

-- CREATE TABLE unit_role (
--     id INT AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
--     unit_id INT,
--     role_id INT,
--     UNIQUE KEY(unit_id, role_id),
--     FOREIGN KEY(unit_id) REFERENCES smartdata_units(id) ON DELETE CASCADE,
--     FOREIGN KEY(role_id) REFERENCES roles(id) ON DELETE CASCADE
-- );

-- Create Indexes
-- CREATE INDEX idx_user_role ON user_role (user_id, role_id);
-- CREATE INDEX idx_country_role ON country_role (country_id, role_id);
-- CREATE INDEX idx_sector_role ON sector_role (sector_id, role_id);
-- CREATE INDEX idx_smartdata_role ON smartdata_role (smartdata_id, role_id);
-- CREATE INDEX idx_version_role ON version_role (version_id, role_id);
-- CREATE INDEX idx_unit_role ON unit_role (unit_id, role_id);

-- Create Views

-- CREATE A VIEWS FOR ADMIN ROLE 



-- -- User Role View
-- CREATE VIEW user_role_view AS
-- SELECT roles.name as role_name, smartdata.name AS smartdata_name, smardata_versions.version AS version, sectors.name AS sector_name, countries.name AS country_name
-- FROM roles
-- JOIN user_role ON roles.id = user_role.role_id
-- JOIN users ON user_role.user_id = users.id
-- JOIN country_role ON roles.id = country_role.role_id
-- JOIN countries ON country_role.country   _id = countries.id
-- JOIN sector_role ON roles.id = sector_role.role_id
-- JOIN sectors ON sector_role.sector_id = sectors.id
-- JOIN smartdata_role ON roles.id = smartdata_role.role_id
-- JOIN smartdata ON smartdata_role.smartdata_id = smartdata.id
-- JOIN version_role ON roles.id = version_role.role_id
-- JOIN smardata_versions ON version_role.version_id = smardata_versions.id
-- WHERE users.id = 2;

-- -- Guest Role View
-- CREATE VIEW guest_role_view AS
-- SELECT roles.name as role_name, smartdata.name AS smartdata_name, smardata_versions.version AS version, sectors.name AS sector_name, countries.name AS country_name
-- FROM roles
-- JOIN user_role ON roles.id = user_role.role_id
-- JOIN users ON user_role.user_id = users.id
-- JOIN country_role ON roles.id = country_role.role_id
-- JOIN countries ON country_role.country_id = countries.id
-- JOIN sector_role ON roles.id = sector_role.role_id
-- JOIN sectors ON sector_role.sector_id = sectors.id
-- JOIN smartdata_role ON roles.id = smartdata_role.role_id
-- JOIN smartdata ON smartdata_role.smartdata_id = smartdata.id
-- JOIN version_role ON roles.id = version_role.role_id
-- JOIN smardata_versions ON version_role.version_id = smardata_versions.id
-- WHERE users.id = 3;


INSERT INTO roles (name, description) VALUES ('ADMIN', 'Administrator');
INSERT INTO roles (name, description) VALUES ('ONLY_GDP', 'eco pages only');
INSERT INTO roles (name, description) VALUES ('GUEST', 'Guest');

INSERT INTO users (username, password) VALUES ('admin', 'admin');
INSERT INTO users (username, password) VALUES ('user', 'user');
INSERT INTO users (username, password) VALUES ('guest', 'guest');

INSERT INTO countries (name, capital, population) VALUES ('germany', 'Berlin', 83000000);
INSERT INTO countries (name, capital, population) VALUES ('france', 'Paris', 67000000);
INSERT INTO countries (name, capital, population) VALUES ('italy', 'Rome', 60000000);
INSERT INTO countries (name, capital, population) VALUES ('spain', 'Madrid', 46000000);

INSERT INTO sectors (name, description) VALUES ('energie', 'Energy sector');
INSERT INTO sectors (name, description) VALUES ('transport', 'Transport sector');
INSERT INTO sectors (name, description) VALUES ('industry', 'Industry sector');
INSERT INTO sectors (name, description) VALUES ('agriculture', 'Agriculture sector');

INSERT INTO smartdata (name, description, version_id) VALUES ('no2', 'NO2 emissions', '1.0.0');
INSERT INTO smartdata (name, description, version_id) VALUES ('gdp_nowcast', 'GDP Nowcast', '1.0.0');
INSERT INTO smartdata (name, description, version_id) VALUES ('gdp_nowcast', 'GDP Nowcast', '1.0.1');
INSERT INTO smartdata (name, description, version_id) VALUES ('eco_growth_leading', 'Eco Growth Leading', '1.0.0');
INSERT INTO smartdata (name, description, version_id) VALUES ('eco_growth', 'Eco Growth', '1.0.0');

INSERT INTO smartdata_countries (smartdata_id, country_id) VALUES (1, 1);
INSERT INTO smartdata_countries (smartdata_id, country_id) VALUES (1, 2);
INSERT INTO smartdata_countries (smartdata_id, country_id) VALUES (1, 3);
INSERT INTO smartdata_countries (smartdata_id, country_id) VALUES (1, 4);
INSERT INTO smartdata_countries (smartdata_id, country_id) VALUES (2, 2);
INSERT INTO smartdata_countries (smartdata_id, country_id) VALUES (3, 1);
INSERT INTO smartdata_countries (smartdata_id, country_id) VALUES (3, 3);
INSERT INTO smartdata_countries (smartdata_id, country_id) VALUES (3, 2);

INSERT INTO smartdata_sectors (smartdata_id, sector_id) VALUES (4, 1);
INSERT INTO smartdata_sectors (smartdata_id, sector_id) VALUES (4, 2);
INSERT INTO smartdata_sectors (smartdata_id, sector_id) VALUES (4, 3);

INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (1, 1);
INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (2, 1);
INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (3, 1);
INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (4, 1);
INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (2, 2);
INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (3, 2);

INSERT INTO user_role (user_id, role_id) VALUES (1, 1);
INSERT INTO user_role (user_id, role_id) VALUES (1, 2);



-- INSERT INTO smardata_versions (smartdata_id, version, country_id) VALUES (1, '1.0.0', 1);
-- INSERT INTO smardata_versions (smartdata_id, version, country_id) VALUES (1, '1.0.1', 1);
-- INSERT INTO smardata_versions (smartdata_id, version, country_id) VALUES (2, '1.0.0', 1);
-- INSERT INTO smardata_versions (smartdata_id, version, country_id) VALUES (2, '1.0.0', 2);
-- INSERT INTO smardata_versions (smartdata_id, version, country_id) VALUES (2, '1.0.1', 3);

-- INSERT INTO user_role (user_id, role_id) VALUES (1, 1);
-- INSERT INTO user_role (user_id, role_id) VALUES (2, 2);
-- INSERT INTO user_role (user_id, role_id) VALUES (3, 3);

-- INSERT INTO country_role (country_id, role_id) VALUES (1, 1);
-- INSERT INTO country_role (country_id, role_id) VALUES (2, 2);
-- INSERT INTO country_role (country_id, role_id) VALUES (3, 3);
-- INSERT INTO country_role (country_id, role_id) VALUES (4, 3);



-- INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (1, 1);
-- INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (2, 1);
-- INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (3, 1);
-- INSERT INTO smartdata_role (smartdata_id, role_id) VALUES (4, 1);

-- INSERT INTO version_role (version_id, role_id) VALUES (1, 1);
-- INSERT INTO version_role (version_id, role_id) VALUES (2, 2);

-- INSERT INTO unit_role (unit_id, role_id) VALUES (1, 1);
-- INSERT INTO unit_role (unit_id, role_id) VALUES (2, 2);
-- INSERT INTO unit_role (unit_id, role_id) VALUES (3, 3);


-- INSERT INTO smartdata_units (name, unit_type) VALUES ('Current', 'flat');
-- INSERT INTO smartdata_units (name, unit_type) VALUES ('Year to year', 'yty');
-- INSERT INTO smartdata_units (name, unit_type) VALUES ('Month to Month', 'mtm');

-- INSERT INTO smartdata_values (country_id, sector_id, unit_id, value) VALUES (1, 1, 1, 100);
-- INSERT INTO smartdata_values (country_id, sector_id, unit_id, value) VALUES (2, 2, 2, 200);
-- INSERT INTO smartdata_values (country_id, sector_id, unit_id, value) VALUES (3, 3, 3, 300);
-- INSERT INTO smartdata_values (country_id, sector_id, unit_id, value) VALUES (4, 4, 1, 400);

-- INSERT INTO sector_role (sector_id, role_id) VALUES (1, 1);
-- INSERT INTO sector_role (sector_id, role_id) VALUES (2, 2);
-- INSERT INTO sector_role (sector_id, role_id) VALUES (3, 3);
-- INSERT INTO sector_role (sector_id, role_id) VALUES (4, 3);