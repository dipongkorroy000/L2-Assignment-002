-- Active: 1754713590050@@127.0.0.1@5432@conservation_db
create DATABASE conservation_db;
DROP DATABASE conservation_db;

create TABLE rangers (
    ranger_id SERIAL PRIMARY KEY UNIQUE,
    name VARCHAR(50),
    region VARCHAR(50)
);
DROP TABLE rangers;

create TABLE species (
    species_id SERIAL PRIMARY KEY UNIQUE,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(30)
);
DROP TABLE species;

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY UNIQUE,
    species_id INT REFERENCES species(species_id),
    ranger_id INT REFERENCES rangers(ranger_id),
    location VARCHAR(50),
    sighting_time TIMESTAMP,
    notes VARCHAR(50)
);
DROP TABLE sightings;

INSERT INTO
    rangers (name, region)
VALUES ('Alice Green', 'Northern Hills'),
    ('Bob White', 'River Delta'),
    ('Carol King', 'Mountain Range');

INSERT INTO species(common_name,scientific_name,discovery_date,conservation_status)
    VALUES('Snow Leopard','Panthera uncia','1775-01-01','Endangered'),
        ('Bengal Tiger','Panthera tigris tigris','1758-01-01','Endangered'),
        ('Red Panda','Ailurus fulgens','1825-01-01','Vulnerable'),
        ('Asiatic Elephant','Elephas maximus indicus','1758-01-01','Endangered');

INSERT INTO sightings( species_id, ranger_id, location,sighting_time,notes)
    VALUES(1, 1, 'Peak Ridge', '2024-05-10 07:45:00','Camera trap image captured'),
        (2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
        (3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
        (1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;


--- 1. Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO  rangers (name, region) VALUES( 'Derek Fox', 'Coastal Plains');

--- 2. unique species count
SELECT count(*) FROM species WHERE conservation_status = 'Endangered';

--- 3. Find all sightings where the location includes "Pass".
SELECT * FROM sightings WHERE location LIKE '%Pass%';

--- 4. List each ranger's name and their total number of sightings.
SELECT name, count(*) FROM sightings
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id
        GROUP BY name
            ORDER BY name ASC;

--- 5. List species that have never been sighted.
SELECT  common_name FROM sightings
    FULL JOIN species ON sightings.species_id = species.species_id
        WHERE ranger_id IS NULL

--- 6. Show the most recent 2 sightings.
-- SELECT * FROM sightings ORDER BY sighting_time DESC LIMIT 2;
SELECT name, sighting_time, common_name FROM sightings
    JOIN species ON species.species_id = sightings.species_id
    JOIN rangers ON rangers.ranger_id = sightings.ranger_id
        ORDER BY sighting_time DESC LIMIT 2;

--- 7. Update all species discovered before year 1800 to have status 'Historic'.




--- 8 Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT sighting_id, sighting_time,
    CASE
        WHEN sighting_time::TIME >= '04:00:00' AND sighting_time::TIME < '12:00:00' THEN 'Morning'
        WHEN sighting_time::TIME >= '12:00:00' AND sighting_time::TIME < '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;

--- 9 Delete rangers who have never sighted any species
DELETE FROM rangers
WHERE ranger_id NOT IN (SELECT ranger_id FROM sightings);
