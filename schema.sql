/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg DECIMAL(5,2) NOT NULL
);

ALTER TABLE animals ADD species VARCHAR(50);

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(50) NOT NULL,
  age INT NOT NULL
);
