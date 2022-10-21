/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* The command "SELECT * FROM animals;" is use to check every change is made succesfully in any case */

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon%';
UPDATE animals
SET species = 'pokemon'
WHERE species = '';
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
SAVEPOINT SP;
UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO SP;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;

/* Analytical questions starts here */

SELECT COUNT (*) FROM animals WHERE escape_attempts < 1;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) 
FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' 
GROUP BY species;

SELECT animals FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';
SELECT animals FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
SELECT animals, owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id;
SELECT species.name, COUNT(animals.name) AS count_animals FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell' AND animals.name LIKE '%mon%';
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
SELECT owners.full_name, COUNT(animals.name) AS count_animals FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name;
SELECT owners.full_name, COUNT(animals.name) AS count_animals FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY COUNT(animals.name) DESC;

SELECT animals.name, visits.date_of_visit
FROM animals
JOIN visits ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

SELECT COUNT(animals.name)
FROM animals
JOIN visits ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name AS vets_name, species.name AS species_name
FROM vets
LEFT JOIN specializations ON specializations.vet_id = vets.id
LEFT JOIN species ON species.id = specializations.specie_id;

SELECT animals.name, visits.date_of_visit AS date_of_visit
FROM animals
INNER JOIN visits ON visits.animal_id = animals.id
INNER JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez'
AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name, COUNT(visits.date_of_visit) AS animal_most_visits
FROM animals
JOIN visits ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY animal_most_visits DESC;

SELECT animals.name, visits.date_of_visit
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maysi Smith'
ORDER BY date_of_visit ASC LIMIT 1;

SELECT animals.name AS animal_name, animals.date_of_birth, animals.neutered, animals.escape_attempts, animals.weight_kg, vets.name AS vets_name, visits.date_of_visit AS date_visited
FROM animals
JOIN visits ON visits.animal_id = animals.id
JOIN vets ON vets.id = visits.vet_id
ORDER BY date_visited DESC LIMIT 1;

SELECT COUNT(visits.animal_id)
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON animals.id = visits.animal_id
JOIN specializations ON specializations.specie_id = vets.id
WHERE specializations.specie_id != animals.species_id;

SELECT species.name AS specie, COUNT(visits.animal_id) AS visits
FROM visits
INNER JOIN vets ON vets.id = visits.vet_id
INNER JOIN animals ON animals.id = visits.animal_id
INNER JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maysi Smith'
GROUP BY species.name
ORDER BY visits DESC;
