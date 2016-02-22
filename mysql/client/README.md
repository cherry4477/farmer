# Farmer MySql Client
Farmer MySql Client is an ambassador container that registers and connects to a **MySql Broker** in [Farmer](https://github.com/ravaj-group/farmer). You can treat it as a usual MySql Server listening on port 3306.

## Usage
To run `farmer-mysql-client` container set these environment variables first:

* **DATABASE_NAME**: Database name

At the first run container register itself to Mysql API and save `DATABASE_NAME`, `USERNAME` and `PASSWORD` at `/config/database.cfg` file

## Usage in `docker`
```sh
docker run -d
    -e DATABASE_NAME=your_database_name
    --link farmer_mysql_api
    --link farmer_mysql_server
    ravaj/farmer-mysql-client
```

## Usage in `docker-compose`
```yml
db:
    image: ravaj/farmer-mysql-client
    environment:
        DATABASE_NAME: unique_database_name
    external_links:
        - farmer_mysql_api
        - farmer_mysql_server
```