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
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE animal_name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species = NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

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
SELECT neutered, MAX(escape_attempts) AS total 
FROM animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


/*Joining multiple tables*/

-- What animals belong to Melody Pond?
SELECT animals.animal_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.animal_name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.specie_name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.animal_name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.specie_name, COUNT(*) AS animal_count
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.specie_name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.animal_name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.specie_name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.animal_name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(*) AS animal_count
FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY COUNT(*) DESC
LIMIT 1;

/*Query many-to-many relationship*/


-- Who was the last animal seen by William Tatcher?
SELECT a.animal_name
FROM animals a
JOIN visits v ON a.animal_id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT v.animal_id)
FROM visits v
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name, s.specie_name AS specialization
FROM vets v
LEFT JOIN specializations sp ON sp.vet_id = v.id
LEFT JOIN species s ON s.id = sp.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.animal_name
FROM animals a
JOIN visits v ON a.animal_id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
WHERE vt.name = 'Stephanie Mendez'
  AND v.visit_date >= '2020-04-01'
  AND v.visit_date <= '2020-08-30';

-- What animal has the most visits to vets?
SELECT a.animal_name, COUNT(*) AS visit_count
FROM animals a
JOIN visits v ON a.animal_id = v.animal_id
GROUP BY a.animal_id
ORDER BY visit_count DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.animal_name AS animal_name
FROM vets v
JOIN visits vt ON v.id = vt.vet_id
JOIN animals a ON a.animal_id = vt.animal_id
WHERE v.name = 'Maisy Smith'
ORDER BY vt.visit_date ASC
LIMIT 1;

-- Details for the most recent visit: animal information, vet information, and date of visit.
SELECT a.animal_name, v.name AS vet_name, vt.visit_date
FROM animals a
JOIN visits vt ON a.animal_id = vt.animal_id
JOIN vets v ON v.id = vt.vet_id
ORDER BY vt.visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS non_specialized_visits
FROM visits v
JOIN animals a ON a.animal_id = v.animal_id
JOIN vets vt ON vt.id = v.vet_id
LEFT JOIN specializations s ON s.vet_id = vt.id AND s.species_id = a.species_id
WHERE s.vet_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT specie_name, COUNT(*) AS num_visits
FROM visits
JOIN animals a ON visits.animal_id = a.animal_id
JOIN species s ON a.species_id = s.id
JOIN vets v ON visits.visit_id = v.id
WHERE v.name = 'Maisy Smith'
GROUP BY specie_name
ORDER BY num_visits DESC
LIMIT 1;

