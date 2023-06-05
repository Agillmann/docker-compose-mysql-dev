-- USE devv
-- Example of a query that returns all roles names, smartdata names and versions names, for a given user id (user_id = 1 and join with user_role table):

-- SELECT roles.name, smartdata.name AS smartdata_name, smardata_versions.version AS, sectors.name AS sector_name, countries.name AS country_name
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
-- WHERE users.id = 1;

-- The query above returns the following result:


-- Example of a query that returns all roles names, smartdata names and versions names, for a given country id (country_id = 1 and join with country_role table):

--- 
--- Create a View
---

-- CREATE VIEW admin_role_view AS
-- SELECT roles.name, smartdata.name AS smartdata_name, smardata_versions.version AS version, sectors.name AS sector_name, countries.name AS country_name
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
-- WHERE users.id = 1;

-- SELECT * FROM admin_role_view;

-- Select from the view  all roles names, smartdata names and versions names, for a given country id (country_id = 1 and join with country_role table):

-- SELECT * FROM admin_role_view WHERE country_name = 'germany';

-- now use the view to query all role for a given smartdata name (smartdata_name = 'gdp_nowcast' and join with smartdata_role table):

-- SELECT * FROM admin_role_view WHERE smartdata_name = 'gdp_nowcast';

-- The query above returns the following result:

-- | name  | smartdata_name | version_name | sector_name | country_name |
-- | ----- | -------------- | ------------ | ----------- | ------------ |
-- | ADMIN | gdp_nowcast    | 1.0.0        | energie     | germany      |
-- | ADMIN | gdp_nowcast    | 1.0.0        | energie     | france       |
-- | ADMIN | gdp_nowcast    | 1.0.0        | energie     | italy        |
-- | ADMIN | gdp_nowcast    | 1.0.0        | energie     | spain        |
