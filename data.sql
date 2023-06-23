/* Populate database with sample data. */

INSERT INTO 
    animals (animal_name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES 
    ('Agamon', '2020-02-03', '0', '1', '10.23'),
    ('Gabumon', '2018-11-15', '2', '1', '8'),
    ('Pikachu', '2021-01-07', '1', '0', '15.04'),
    ('Devimon', '2017-05-12', '5', '1', '11');

INSERT INTO 
    animals (animal_name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES 
    ('Charmander', '2020-02-08', '0', '0', '-11'),
    ('Plantmon', '2021-11-15', '2', '1', '-5.7'),
    ('Squirtle', '1993-04-02', '3', '0', '-12.13'),
    ('Angemon', '2005-06-12', '1', '1', '-45'),
    ('Boarmon', '2005-06-07', '7', '1', '20.4'),
    ('Blossom', '1998-10-13', '3', '1', '17'),
    ('Ditto', '2022-05-14', '4', '1', '22');



-- Insert data into owners table
INSERT INTO
    owners (full_name, age)
VALUES
    ('Sam Smith', '34'),
    ('Jennifer Orwell', '19'),
    ('Bob', '45'),
    ('Melody Pond', '77'),
    ('Dean Winchester', '14'),
    ('Jodie Whittaker', '38');

-- Insert data into species table
INSERT INTO
    species (specie_name)
VALUES
    ('Pokemon'),
    ('Digimon');


-- Update animals table to set species_id based on animal_name
UPDATE animals
SET species_id = 
    CASE 
        WHEN animal_name LIKE '%mon' THEN (SELECT id FROM species WHERE specie_name = 'Digimon')
        ELSE (SELECT id FROM species WHERE specie_name = 'Pokemon')
    END;

-- Update animals table to set owner_id based on owner's name
UPDATE animals
SET owner_id = 
    CASE 
        WHEN animal_name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
        WHEN animal_name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
        WHEN animal_name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
        WHEN animal_name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
        WHEN animal_name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
    END;

-- Insert data for vets
INSERT INTO vets (name, age, date_of_graduation)
VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

-- Insert data for specializations
INSERT INTO specializations (vet_id, species_id)
VALUES
    (1, 1), -- Vet William Tatcher is specialized in Pokemon
    (3, 2), -- Vet Stephanie Mendez is specialized in Digimon
    (3, 1), -- Vet Stephanie Mendez is specialized in Pokemon
    (4, 2); -- Vet Jack Harkness is specialized in Digimon

-- Insert data for visits
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
    (1, 1, '2020-05-24'),  -- Agumon visited William Tatcher on May 24th, 2020
    (1, 3, '2020-07-22'),  -- Agumon visited Stephanie Mendez on Jul 22th, 2020
    (2, 4, '2021-02-02'),  -- Gabumon visited Jack Harkness on Feb 2nd, 2021
    (3, 2, '2020-01-05'),  -- Pikachu visited Maisy Smith on Jan 5th, 2020
    (3, 2, '2020-03-08'),  -- Pikachu visited Maisy Smith on Mar 8th, 2020
    (3, 2, '2020-05-14'),  -- Pikachu visited Maisy Smith on May 14th, 2020
    (4, 3, '2021-05-04'),  -- Devimon visited Stephanie Mendez on May 4th, 2021
    (5, 4, '2021-02-24'),  -- Charmander visited Jack Harkness on Feb 24th, 2021
    (6, 2, '2019-12-21'),  -- Plantmon visited Maisy Smith on Dec 21st, 2019
    (6, 1, '2020-08-10'),  -- Plantmon visited William Tatcher on Aug 10th, 2020
    (6, 2, '2021-04-07'),  -- Plantmon visited Maisy Smith on Apr 7th, 2021
    (7, 3, '2019-09-29'),  -- Squirtle visited Stephanie Mendez on Sep 29th, 2019
    (8, 4, '2020-10-03'),  -- Angemon visited Jack Harkness on Oct 3rd, 2020
    (8, 4, '2020-11-04'),  -- Angemon visited Jack Harkness on Nov 4th, 2020
    (9, 2, '2019-01-24'),  -- Boarmon visited Maisy Smith on Jan 24th, 2019
    (9, 2, '2019-05-15'),  -- Boarmon visited Maisy Smith on May 15th, 2019
    (9, 2, '2020-02-27'),  -- Boarmon visited Maisy Smith on Feb 27th, 2020
    (9, 2, '2020-08-03'),  -- Boarmon visited Maisy Smith on Aug 3rd, 2020
    (10, 3, '2020-05-24'), -- Blossom visited Stephanie Mendez on May 24th, 2020
    (10, 1, '2021-01-11'); -- Blossom visited William Tatcher on Jan 11th, 2021
