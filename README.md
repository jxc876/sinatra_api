# demoApp

Sinatra API supporting registration & authentication

[Demo](https://demo-app-api.herokuapp.com/api)

## Install App

* `bundle install`

## Start App

Either of the following should work: 

* `rackup` 
* `heroku local`


## API Operations

* `/api/login` - acquire an auth token
* `/api/register` - register a new account
* `/api/notes` - view notes (auth token required)


### Registering

Successful registration: 

* Request: `http localhost:9292/api/register username=mike password=secret`
* Response: `HTTP/1.1 200 OK  | {"message":"user created"}`

Failed registration: 

* Request: `http localhost:9292/api/register username=mike password=secret`
* Response: `HTTP/1.1 400 Bad Request  | {"message":"username already used"}`

### Login

Exchanging credentials for a token:

* Request: `http localhost:9292/api/login username=mike password=secret`
* Response: `HTTP/1.1 200 OK | {"username":"mike","token":"ab219075-08c5-4d50-86a6-7dd242419976"}`


### Secured Resource 

Secured resources without auth: 

* Request: `http localhost:9292/api/notes`
* Response: `HTTP/1.1 401 Unauthorized`

Secured resources with auth: 

* Request: `http localhost:9292/api/notes X-Auth-Token:cba0230a-85e3-42ee-9946-31534610ffcb`
* Response: `HTTP/1.1 200 OK | ["note 1","note 2"]`
