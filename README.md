# ProtoCount Accounting App (back end)

[Live on Heroku](http://protocount.herokuapp.com) 

Please use the following login details to access the app and experiment:

> Username: protocount  
> Password: password

### Description
Back end web server logic built using NodeJS(ExpressJS Framework) for request/response routing and MySQL for database 
(including mysql-node npm package for MySQL driver).
Most CRUD (Create,Read,Update,Delete) operations for the App are stored in Stored Procedures (located in /mysql_files folder).


### Quick Installation/Usage
1) Clone this repository to target local folder and npm install dependencies.

```
git clone https://github.com/mseong123/protocount-create-react-app.git <target folder>
cd <target folder>
npm install
```

#### Database installation
2) Go to [MySQL website](https://www.mysql.com/) and follow instructions to download and install MySQL community server. 
**Install 8.0 and above versions only and use recommended installation options.**

3) Once MySQL server is installed, log into MySQL server instance using the root account (created during installation process) and 
create a MySQL account which mysql-node npm package driver can connect to. **Please type in the following SQL command specifically once logged into root account in order for driver to work** 

```
CREATE USER '<username>' IDENTIFIED WITH mysql_native_password BY '<password>';
```

Log into the newly created account and create a database (any name you like, i.e. type SQL command `CREATE DATABASE PROTOCOUNT` in 
command prompt once logged in).This database will be used to store the app's tables and data. 

4) Navigate to /mysql_files/BACKUP in local repository and type the following command `mysql -u <username> -p<password> <database> < backup.sql` to restore a production version of this app's database into your local MySQL instance. *\*There is no space between -p\<password> and \<database> is the name of the database you have created for this app in the previous step.*  
#### Initiate web server
5) create a .env file (not a text file!) in the root path of repository(core folder where the index.js file is stored). The .env file is used to store environment variables and referred to by app. Insert the following into .env file and save:
```
DB_HOST=localhost
DB_USER=<username of mysql account you created in step (3) with no opening/closing quotation marks>
DB_PASS=<password of mysql account you created in step (3) with no opening/closing quotation marks>
DB_DATABASE=<database name you created in step (3) with no opening/closing quotation marks>


COOKIEKEY_0=accounts
COOKIEKEY_1=finance
COOKIEKEY_2=econs

```

5) type node index.js to initiate webserver/app at port 4000
6) open browser and type in URL `localhost:4000` and app will be served.

### Other information








Copy and paste files from build process in [protocount-create-react-app] (https://github.com/mseong123/protocount-create-react-app) 
(/build folder) and pas


