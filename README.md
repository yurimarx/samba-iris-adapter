 [![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://openexchange.intersystems.com/package/iris-interoperability-template)
 [![Quality Gate Status](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Firis-interoperability-template&metric=alert_status)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Firis-interoperability-template)
 [![Reliability Rating](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Firis-interoperability-template&metric=reliability_rating)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Firis-interoperability-template)
# samba-iris-adapter
This is a SAMBA interoperability Adapter for InterSystems IRIS.
Using this adapter is possible read, write and find remote files and folders using SAMBA v2/v3 protocol.

## Installation: ZPM

Open IRIS Namespace with Interoperability Enabled.
Open Terminal and call:
USER>zpm "install interoperability-sample"

## Installation: Docker
Clone/git pull the repo into any local directory

```
$ git clone https://github.com/yurimarx/samba-iris-adapter.git
```

Open the terminal in this directory and run:

```
$ docker-compose build
```

3. Run the IRIS container with your project:

```
$ docker-compose up -d
```

## How to Run the App

1. Go to the [credentials](http://localhost:52795/csp/user/EnsPortal.Credentials.zen?$NAMESPACE=USER&$NAMESPACE=USER&) and Set credentials and save with these values:
    - ID: SambaCredentials
    - User name: bob
    - Password: bobspasswd

2. Open the [production](http://localhost:52795/csp/user/EnsPortal.ProductionConfig.zen?PRODUCTION=dc.samba.SambaProduction) and start it.

3. Go to your REST client app and use these REST operations (with basic auth and credentials _SYSTEM/SYS):
    - To Create a new Remote Folder: POST http://localhost:52795/csp/samba/CreateFolder with JSON Body: {"Folder":"foldername"}
    - To Send a File to a Remote Folder: POST http://localhost:52795/csp/samba/CreateFile/foldername with form-data selected to send multipart file. The name of the multipart file is file and in value select any file from your computer, check this image with a example using postman:
    ![Upload](https://github.com/yurimarx/samba-iris-adapter/raw/master/savefile.jpg "Upload")
    - To List files inside a Remote Folder: GET http://localhost:52795/csp/samba/ListFilesIntoFolder/{foldername}
    - To Delete a Remote Folder: DELETE http://localhost:52795/csp/samba/DeleteFolder with JSON Body: {"Folder":"foldername"}
    
## More functions will added this week (download files)
