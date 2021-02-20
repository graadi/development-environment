# empty the table
DELETE FROM pet;

# load new records into it
LOAD DATA LOCAL INFILE '/opt/vagrant/databases/schemas/menagerie-db/pet.txt' INTO TABLE pet;
