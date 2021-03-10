# php8-apache-focal

Docker Image based on Ubuntu 20.04 LTS (Focal Fossa)

Includes:
- Apache
- PHP 8
- PHP Extensions
- MySQL 8.0.19
- phpMyAdmin 5.1.0

**Usage:**

*Building & Starting*
``` bash
docker-compose up -d --build
```

*Stopping*
``` bash
docker-compose down
```

----
*Web Server*
`http://localhost:8080/`

*MySQL DB Server*
`localhost:13306`

*phpMyAdmin*
`http://localhost:5000/`

*HTDOCS*
Modify the contents of htdocs directory to see the changes reflected on webserver.
