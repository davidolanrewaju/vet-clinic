/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    animal_id serial PRIMARY KEY,
    animal_name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    escape_attempts SMALLINT,
    neutered BOOLEAN,
    weight_kg NUMERIC(6, 2) NOT NULL;
);

ALTER TABLE animals ADD species VARCHAR(255);

/*Create owners table*/

CREATE TABLE owners (
    id serial PRIMARY KEY,
    full_name VARCHAR(255),
    age INT
);

/*Create species table*/

CREATE TABLE species (
    id serial PRIMARY KEY,
    specie_name VARCHAR(255)
);

/*Alter animals table*/

ALTER TABLE animals DROP species;

-- Create a species foreign key constraint
ALTER TABLE animals ADD COLUMN species_id SMALLINT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);

-- Create an owner foreign key id
ALTER TABLE animals ADD COLUMN owner_id SMALLINT;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id);

-- Create vets table
CREATE TABLE vets (
    id serial PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    date_of_graduation DATE
);

-- Create specializations table (join table for vets and species)
CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

-- Create visits table (join table for animals and vets)
CREATE TABLE visits (
    visit_id serial PRIMARY KEY,
    animal_id INT,
    vet_id INT,
    visit_date DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(animal_id),
    FOREIGN KEY (vet_id) REFERENCES vets(id)
);



