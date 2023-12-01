/* Database schema to keep the structure of entire database. */

CREATE TABLE owners(
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(20),
  age INT,
  PRIMARY KEY(id)
);

CREATE TABLE species(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(20),
  PRIMARY KEY(id)
);

CREATE TABLE animals(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(20),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL,
  species_id INT REFERENCES species(id),
  owner_id INT REFERENCES owners(id),
  PRIMARY KEY(id)
);

CREATE TABLE vets(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(20),
  age INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);

CREATE TABLE specializations(
  id INT GENERATED ALWAYS AS IDENTITY,
  species_id INT REFERENCES species(id),
  vet_id INT REFERENCES vets(id),
  PRIMARY KEY(id)
);

CREATE TABLE visits(
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT REFERENCES animals(id),
  vet_id INT REFERENCES vets(id),
  date_of_visit DATE,
  PRIMARY KEY(id)
);

CREATE TABLE specializations (vet_id INT NOT NULL, species_id INT NOT NULL, PRIMARY KEY (vet_id, species_id), FOREIGN KEY (vet_id) REFERENCES vets (id), FOREIGN KEY (species_id) REFERENCES species (id));

CREATE TABLE visits (animal_id INT NOT NULL, vet_id INT NOT NULL, date_of_visit DATE NOT NULL, PRIMARY KEY (animal_id, vet_id, date_of_visit), FOREIGN KEY (animal_id) REFERENCES animals (id), FOREIGN KEY (vet_id) REFERENCES vets (id));

-- Add an email column to the owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Create a summary table to store pre-calculated totals
CREATE TABLE animal_visit_summary (animal_id INT PRIMARY KEY, visits_total INT);

-- Create a summary table to store pre-calculated totals
CREATE TABLE vet_visit_summary AS SELECT vet_id, COUNT(*) AS total_visits, MAX(date_of_visit) AS last_visit FROM visits GROUP BY vet_id;

-- Create index for vet_id
CREATE INDEX idx_vet_visit_summary_vet_id ON vet_visit_summary(vet_id);

-- Create inde for owbers email
CREATE INDEX idx_email ON owners (email);

