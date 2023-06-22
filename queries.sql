/*Queries that provide answers to the questions from all projects.*/

SELECT *
FROM animals
WHERE animal_name LIKE '%mon';

SELECT *
FROM animals
WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

SELECT animal_name
FROM animals
WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth
FROM animals
WHERE animal_name = 'Agumon' OR animal_name = 'Pikachu';

SELECT animal_name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

SELECT *
FROM animals 
WHERE animal_name != 'Gabumon';

SELECT *
FROM animals
WHERE neutered = true;

SELECT *
FROM animals
WHERE  weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Transactions and modifications

BEGIN;
UPDATE animals SET species = 'undefined';
SELECT * FROM animals;
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE animal_name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE animal_name IN ('Charmander', 'Squirtle', 'Blossom', 'Ditto', 'Pikachu');
COMMIT;

BEGIN;
DELETE FROM animals WHERE id IN (1,2,3,4,5,6,7,8,9,10,11);
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


-- AGGREGATES

-- How many animals are there?
SELECT COUNT(*) AS number_of_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS zero_escape_attempt FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight_kg FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT animal_name, SUM (escape_attempts) AS total FROM animals
GROUP BY animal_name ORDER BY total DESC
LIMIT 1;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;
