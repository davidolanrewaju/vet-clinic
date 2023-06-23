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
    age SMALLINT
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
