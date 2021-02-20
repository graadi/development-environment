#!/bin/bash

# prerequisites
sudo apt-get update

# install mysql server
sudo apt-get install mysql-server -y
mysql_secure_installation <<EOF
n
6Rb26oAy0hHB8BXWqxqj
6Rb26oAy0hHB8BXWqxqj
y
y
y
y
y
EOF

# /etc/my.cnf
sudo cp '/opt/vagrant/databases/configuration/my.cnf' '/etc/my.cnf'
sudo chown -R mysql /var/lib/mysql
sudo chgrp -R mysql /var/lib/mysql

# Start MySQL
sudo systemctl start mysql
sudo systemctl enable mysql
sudo systemctl status mysql

# Database
mysql --user="root" --password="6Rb26oAy0hHB8BXWqxqj"  -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '6Rb26oAy0hHB8BXWqxqj'"

# Sample command to create an empty database
mysql --user="root" --password="6Rb26oAy0hHB8BXWqxqj"  -e "CREATE DATABASE IF NOT EXISTS sampledb;"
 
# User
mysql --user="root" --password="6Rb26oAy0hHB8BXWqxqj"  -e "CREATE USER dbuser@'%' IDENTIFIED BY 'kPlSizyVakMJ6wBlgt1V';"
mysql --user="root" --password="6Rb26oAy0hHB8BXWqxqj"  -e "CREATE USER dbuser@'gateway' IDENTIFIED BY 'kPlSizyVakMJ6wBlgt1V';"
mysql --user="root" --password="6Rb26oAy0hHB8BXWqxqj"  -e "CREATE USER dbuser@'localhost' IDENTIFIED BY 'kPlSizyVakMJ6wBlgt1V';"

mysql --user="root" --password="6Rb26oAy0hHB8BXWqxqj"  -e "GRANT ALL PRIVILEGES ON * . * TO 'dbuser'@'%';"
mysql --user="root" --password="6Rb26oAy0hHB8BXWqxqj"  -e "GRANT ALL PRIVILEGES ON * . * TO 'dbuser'@'gateway';"
mysql --user="root" --password="6Rb26oAy0hHB8BXWqxqj"  -e "GRANT ALL PRIVILEGES ON * . * TO 'dbuser'@'localhost';"
mysql --user="root" --password="6Rb26oAy0hHB8BXWqxqj"  -e "FLUSH PRIVILEGES;"

# employees-db
echo "Setting up employees-db"
mysql --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" < /opt/vagrant/databases/schemas/employee-db/employees.sql

echo "Test employees-db"
mysql -t --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" < /opt/vagrant/databases/schemas/employee-db/test_employees_md5.sql

# menagerie-db
echo "Setting up menagerie-db"
mysql --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" < /opt/vagrant/databases/schemas/menagerie-db/dbcreate.sql
mysql --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" menagerie < /opt/vagrant/databases/schemas/menagerie-db/cr_pet_tbl.sql
mysql --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" menagerie < /opt/vagrant/databases/schemas/menagerie-db/load_pet_tbl.sql
 
mysqlimport --local --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" menagerie /opt/vagrant/databases/schemas/menagerie-db/pet.txt

mysql --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" menagerie < /opt/vagrant/databases/schemas/menagerie-db/ins_puff_rec.sql
mysql --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" menagerie < /opt/vagrant/databases/schemas/menagerie-db/cr_event_tbl.sql

mysqlimport --local --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" menagerie /opt/vagrant/databases/schemas/menagerie-db/event.txt

# sakila-db
echo "Setting up menagerie-db"
mysql --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" < /opt/vagrant/databases/schemas/sakila-db/sakila-schema.sql;
mysql --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" < /opt/vagrant/databases/schemas/sakila-db/sakila-data.sql;

# world-db
echo "Setting up world-db"
mysql --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" < /opt/vagrant/databases/schemas/world-db/world.sql;

# world-x-db
echo "Setting up world-x-db"
mysql --user="dbuser" --password="kPlSizyVakMJ6wBlgt1V" < /opt/vagrant/databases/schemas/world-x-db/world-x.sql;