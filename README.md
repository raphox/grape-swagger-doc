API to expose service for external enviroments and API clients.

To cosume the API the first step is get a Token on authentication service.

# Authentication

All services requires the header "Authorization". To generate a value to "Authorization" you need a valid user and password. In such data can you will generate the Token sending them for using Authentication service. Such as:

~~~ sh
# Request
curl -X POST -H "Content-Type: application/json" -d '{
  "username": "Alberto",
  "password": "alberto1234",
  "country": "PT"
}' http://192.168.254.2:3000/api/auth/login

# Response
{
  "id": 61,
  "name": "Alberto Ferreira",
  "login": "Alberto",
  "email": "portugal@deco.proteste.pt",
  "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2xvZ2luIjoiQWxiZXJ0byI...",
  "country":
      {
          "id": 2,
          "name": "Portugal"
      }
}
~~~

Take the 'token' attribute of the response and the user in future requests. Such as:

~~~ sh
curl -X GET -H "Content-Type: application/json" \
-H "Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2xvZ2luI..." \
http://192.168.254.2:3000/api/projects
~~~

# Possible API returns

## Success

You can receive 3 type of success response for GET requests. They are:

### Empty body

In some cases, the requests do not require data return beyond the success:

~~~ json
{
  "success": true,
  "message": string|null
}
~~~

### One object

When you request only one object:

~~~ json
{
  "foo": string|integer|float|null,
  "bar": string|integer|float|null
}
~~~

### Collection of objects

When you request more than one object or when the response to the request is more than one object:

~~~ json
{
  "total": integer,
  "total_pages": integer,
  "page": integer,
  "per_page": integer,
  "paging": {
    "next": integer|null,
    "previous": integer|null,
    "first": integer,
    "last": integer
  },
  "data": [
    {
      "foo": string|integer|float|null,
      "bar": string|integer|float|null
    },
    ...
  ]
}
~~~

## Errors

The error occurrences (which does not often occur) have standard format:

~~~ json
{
  "code": string,
  "message": string|null,
  "details": string|null,
  "success": false
}
~~~