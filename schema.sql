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