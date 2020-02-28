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

3) Once MySQL server is installed, log into MySQL server instance and create a database (any name you like, i.e. type SQL command 
`CREATE DATABASE PROTOCOUNT` in mysqlclient once logged in).This database will be used to store the app's tables and data. 

4) Navigate to /mysql_files/BACKUP in local repository and type the following command `mysql -u <username> -p<password> <database> < backup.sql` 
to restore a production version of this app's database into your local MySQL instance. *\*There is no space between -p\<password> and 
\<database> is the name of the database you have created for this app in the previous step.*  
#### Initiate web server
5) type node index.js to initiate web server at port 4000
6) open browser and navigate to 



Copy and paste files from build process in [protocount-create-react-app] (https://github.com/mseong123/protocount-create-react-app) 
(/build folder) and pas


