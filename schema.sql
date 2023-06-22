/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    animal_id serial PRIMARY KEY,
    animal_name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    escape_attempts SMALLINT,
    neutered BOOLEAN,
    weight_kg NUMERIC(6, 2) NOT NULL
);
