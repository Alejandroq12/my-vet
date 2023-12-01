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

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

BEGIN;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY(owner_id) REFERENCES owners(id);
COMMIT;

CREATE TABLE vets (id SERIAL PRIMARY KEY, name VARCHAR(50) NOT NULL, age INT NOT NULL, date_of_graduation DATE NOT NULL);

CREATE TABLE specializations (vet_id INT NOT NULL, species_id INT NOT NULL, PRIMARY KEY (vet_id, species_id), FOREIGN KEY (vet_id) REFERENCES vets (id), FOREIGN KEY (species_id) REFERENCES species (id));

CREATE TABLE visits (animal_id INT NOT NULL, vet_id INT NOT NULL, date_of_visit DATE NOT NULL, PRIMARY KEY (animal_id, vet_id, date_of_visit), FOREIGN KEY (animal_id) REFERENCES animals (id), FOREIGN KEY (vet_id) REFERENCES vets (id));

-- Add an email column to the owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Create a summary table to store pre-calculated totals
CREATE TABLE animal_visit_summary (animal_id INT PRIMARY KEY, visits_total INT);

-- Create a summary table to store pre-calculated totals
CREATE TABLE vet_visit_summary AS SELECT vet_id, COUNT(*) AS total_visits, MAX(date_of_visit) AS last_visit FROM visits GROUP BY vet_id;

-- Create index
CREATE INDEX idx_vet_visit_summary_vet_id ON vet_visit_summary(vet_id);
