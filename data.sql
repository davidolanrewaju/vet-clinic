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
