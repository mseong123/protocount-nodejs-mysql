# ProtoCount Accounting App (back end)

[Live on Heroku](http://protocount.herokuapp.com) 

Please use the following login details to access the app and experiment:

> Username: protocount  
> Password: password

### Description
Back end web server built using NodeJS (ExpressJS Framework) for request/response routing and MySQL for database 
(including mysql-node npm package for MySQL driver).
Most CRUD (Create,Read,Update,Delete) operations for the App are executed using database Stored Procedures consistent with best practices.


Front end files (HTML, CSS, Javascript) stored in /build folder are built using create-react-app. See [protocount-create-react-app](https://github.com/mseong123/protocount-create-react-app) repository. 


### Quick Installation/Usage
The following guidelines' purpose is to enable the set up of a local nodejs web server which can serve the app over the browser and also installs a database for the app's core functionalities.

1) Clone this repository to target local folder and npm install dependencies.

```
git clone https://github.com/mseong123/protocount-nodejs-mysql.git <target folder>
cd <target folder>
npm install
```

#### Database installation
2) Go to [MySQL website](https://www.mysql.com/) and follow instructions to download and install MySQL community server. 
**Install versions 8.0 and above only and use default installation options.**

3) Once MySQL server is installed, log into MySQL server instance using the root account (created during installation process) and 
create a MySQL account which mysql-node npm package driver can connect to. **Use the following SQL command AS SPECIFIED to create the account in order for the driver to work:** 

```
CREATE USER '<username>' IDENTIFIED WITH mysql_native_password BY '<password>';
```

*\*come up with your own \<username> and \<password>*

Log into the newly created account and create a database (any name you like, i.e. type SQL command `CREATE DATABASE PROTOCOUNT;` in 
command prompt once logged in).This database will be used to store the app's tables and data. 

4) Navigate to /mysql_files/BACKUP in local repository and type the following command `mysql -u <username> -p<password> <database> < backup.sql;` to restore a production version of this app's database into your local MySQL instance. *\*There is no space between -p\<password> and \<database> is the name of the database you have created for this app in the previous step.*  
#### Initiate web server
5) create a .env file (not a text file!) in the root path of repository(core folder where the index.js file is stored). The .env file is used to store environment variables and referred to by app. Google .env file if you are not sure what it does. Insert the following into .env file and save:
```
DB_HOST=localhost
DB_USER=<username of mysql account you created in step (3) with no opening/closing quotation marks>
DB_PASS=<password of mysql account you created in step (3) with no opening/closing quotation marks>
DB_DATABASE=<database name you created in step (3) with no opening/closing quotation marks>


COOKIEKEY_0=accounts
COOKIEKEY_1=finance
COOKIEKEY_2=econs

```

5) navigate back to root path in this local repository and type node index.js to initiate webserver/app at port 4000.
6) open browser and type in URL `localhost:4000` and app will be served.

### Other information
The above guidelines have to be done even if [protocount-create-react-app](https://github.com/mseong123/protocount-create-react-app) is initialised for development purpose. The backend will work with the create-react-app front end development environment in the link if settings are not changed (ie ports are not changed in index.js).  


All build files should be stored in /build folder. The most current production build files from [protocount-create-react-app](https://github.com/mseong123/protocount-create-react-app) are contained in /build in this repository and will be served once the URL is set to `localhost:4000` in browser.


The database schema is stored in mysql_files/SCHEMA and can be opened using MySQL Workshop (installed as part of a bundle together with MySQL Community Server by default). All stored procedures SQL queries used for this app are stored in mysql_files/STORED PROCEDURES.



Any problems or bugs, please message me. Thanks!
