# SOA Homework

All APIs can return a result in either JSON or XML format, read [API Doc](./doc/README.md) and checkout samples for more info.

## Notice

Read `Dockerfile.api` and `Dockerfile.web`, you can remove or change gem and npm mirrors

Read `docker-compose.yml` and setup environment variables!

**All data comes from the the Internet and make sure it can be accessed from your country!**

**You must setup API Keys for**
- openweathermap.org
- newsapi.org
- aqicn.org

## Usage

```
docker-compose up
```

then open `http://localhost:8080`

## Screenshot

Notice

![screenshot](./screenshot/1.png)

Meshup 

![screenshot](./screenshot/2.png)

![screenshot](./screenshot/3.png)

Failure

![screenshot](./screenshot/4.png)

## Design and Implementation

### Backend

Based on sinatra.rb (Ruby)

`backend/app/services` contains upstream API services

`backend/app/routes` contains our own API services

### Frontend

Based on Vue (Typescript)

`frontend/src/api/api.ts` contains utils to request our own API services

`frontend/src/components/Meshup.vue` contains our UI layout and its own business logic

### Dataflow

A user acquires static pages

```
               request
End user     ----------->    Server 
(Browser)    <----------- (Web Service)
             static pages
```

A user queries a city

```
               request                    request
Our code     ----------->    Server     ----------->    Upstream APIs
(Browser)    <----------- (API Service) <-----------    (API Service)
            gathered data                sparse data
```
