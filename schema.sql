/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL,
    PRIMARY KEY(id) 
);

ALTER TABLE animals ADD species char(50);

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY(id) 
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY(id) 
);

ALTER TABLE animals DROP COLUMN species;
SELECT * FROM animals;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_speciesid_owners FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT;
SELECT * FROM animals;
ALTER TABLE animals ADD CONSTRAINT fk_ownerid_owner FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(50) NOT NULL,
  age INT NOT NULL,
  date_of_graduation date NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE specializations (
  vet_id INT NOT NULL,
  specie_id INT NOT NULL,
  PRIMARY KEY(species_id, vets_id),
  CONSTRAINT fk_specializations_species FOREIGN KEY (species_id) REFERENCES  species(id),
  CONSTRAINT fk_specializations_vets FOREIGN KEY (vets_id) REFERENCES vets(id)
);

CREATE TABLE visits (
  animal_id INT NOT NULL,
  vet_id INT NOT NULL,
  date_of_visit date NOT NULL,
  PRIMARY KEY (animal_id, vet_id),
  CONSTRAINT fk_visits_animals FOREIGN KEY (animal_id) REFERENCES animals(id),
  CONSTRAINT fk_vet_visits FOREIGN KEY (vet_id) REFERENCES vets(id) 
);

ALTER TABLE visits DROP CONSTRAINT visits_pkey;
LTER TABLE visits ADD COLUMN id SERIAL PRIMARY KEY;
SELECT * FROM visits;