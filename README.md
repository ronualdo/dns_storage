# Dns Storage

## Setting up database

Run the command `docker-compose run rake db:create db:migrate` to create database
and run project migrations.

## Running Project

Use `docker-compose up` to start the server. After the service is up,
the application will be available at `http://localhost:3000`.

## Running Tests

Use `docker-compose exec dns_storage rspec`

## Setting up example scenario

With the service up run the following commands to populate the database:

```
curl -XPOST -H "Content-Type: application/json" http://localhost:3000/dns_records -d '{"dns_records":{"ip": "1.1.1.1", "hostnames_attributes":[{"hostname": "lorem.com"},{"hostname": "ipsum.com"}, {"hostname": "dolor.com"}, {"hostname": "amet.com"}]}}'

curl -XPOST -H "Content-Type: application/json" http://localhost:3000/dns_records -d '{"dns_records":{"ip": "2.2.2.2", "hostnames_attributes":[{"hostname": "ipsum.com"}]}}'

curl -XPOST -H "Content-Type: application/json" http://localhost:3000/dns_records -d '{"dns_records":{"ip": "3.3.3.3", "hostnames_attributes":[{"hostname": "ipsum.com"}, {"hostname": "dolor.com"}, {"hostname": "amet.com"}]}}'

curl -XPOST -H "Content-Type: application/json" http://localhost:3000/dns_records -d '{"dns_records":{"ip": "4.4.4.4", "hostnames_attributes":[{"hostname": "ipsum.com"}, {"hostname": "dolor.com"}, {"hostname": "sit.com"}, {"hostname": "amet.com"}]}}'

curl -XPOST -H "Content-Type: application/json" http://localhost:3000/dns_records -d '{"dns_records":{"ip": "5.5.5.5", "hostnames_attributes":[{"hostname": "dolor.com"}, {"hostname": "sit.com"}]}}'

curl -XGET -H "Content-Type: application/json" "http://localhost:3000/dns_records?page=1&included=ipsum.com,dolor.com&excluded=sit.com"
```
