### Inception

A Project to build a Docker environment featuring Wordpress, MariaDB, Nginx.
Bonus Services include like Adminer, duplicati, Redis, a static html page as well as FTP service.

Built using docker-compose using a yaml file is mandatory

---

### DOCKER <img src="https://github.com/devicons/devicon/blob/6910f0503efdd315c8f9b858234310c06e04d9c0/icons/docker/docker-plain-wordmark.svg" width="60" height="60" title="Docker" alt="Docker"/>

 - The core of the project consists of creating a custom docker network, each service running in their own container connected through a bridge:
   
 - This is achieved by creation of a yaml file that manages our containers and sets up the appropriate network 
 - Local volumes store the necessary information needed to keep the services stable and retaining information provided to the wordpress and mariadb.

### RULES

The Containers must be build using a stable penultimate debian/alpine image, manually setting up each service without including other services in the same container.
 - The Server needs to run a TLSv1.2 or TLSv1.3 protocol, only serving HTTPS 
 - Both mariadb and wordpress must be correctly configured to be only accessed over certain ports as well.

---

### Nginx <img src="https://github.com/devicons/devicon/blob/6910f0503efdd315c8f9b858234310c06e04d9c0/icons/nginx/nginx-original.svg" width="60" height="60" title="Nginx" alt="Nginx"/>

Nginx is a high-performance web-server and reverse-proxy that has many built in features for modern web development.

Features:
 - SSL/TLS termination
 - Load balancing
 - Caching capabilities
 - HTTP/WEB2 support
 - Modular configuration options.

Utilizing these functionalities can make a page 
load faster, be managed and connected easier and improves security just to name a few benefits.

### MariaDB <img src="https://github.com/devicons/devicon/blob/6910f0503efdd315c8f9b858234310c06e04d9c0/icons/mariadb/mariadb-original-wordmark.svg" width="60" height="60" title="MariaDB" alt="MariaDB"/>

Popular open-source relational database forked from mysql

Features:
 - High Compability with mysql, making migration and interoperability easy
 - High Performance, taking advantage of thread pooling, query optimization and more
 - JSON support
 - Scalability
 - Security in form of role based access control

This is the database running in the background saving the users, comments and changes made on the frontend wordpress site


### Wordpress <img src="https://github.com/devicons/devicon/blob/6910f0503efdd315c8f9b858234310c06e04d9c0/icons/wordpress/wordpress-plain-wordmark.svg" width="60" height="60" title="WP" alt="WP"/>

Widely used Content Management system

Features:
 - Easy to use, utilizing an on site editor to modify the site
 - Provides multimedia support, easily customizable by using themes and plugins that are widely available and open source
 - Community supported, providing regular new feature implementation and updates
 - Secure, widely tested and receiving regular updates
 
Originally designed as a blogging platform this popular website manager is going to be our frontend, displaying the php themes, site design, comment section and posts.

Now this description of the project only describes the mandatory part we are supposed to work on, the bonuses make the management of the website easier. 

### Bonus

Providing features like: 
 - website display of the backend (adminer),
 - caching support (redis),
 - a regular backup service (duplicati),
 - easy file transfers (FTP)
 - and a custom static html page (nginx based index html).

### STRUCTURE
<img width="562" alt="Inception_struct" src="https://github.com/user-attachments/assets/84c2ff7f-3e8c-43b3-9a4e-385b4ad532e4">

