# README

Simple geocache service on ROR.
Contains two parts - API and user interface.

Page for user interface - http://localhost:3000/geoservice/index
User can add geolocation with message on google map and find closest geolocations or geolocations in raduis from certain marker on map.

API Requests:

=> show certain geolocation
   url: http://localhost:3000/api/show/:id
   method: GET

=> list of all geolocations
   url: http://localhost:3000/api/list
   method: GET

=> create new geolocation
  url: http://localhost:3000/api/create
  method: Post
  Body : json
  params: 
	message: string
	lat: float
	lng: float

=> delete certain geolocation
   url: http://localhost:3000/api/delete/:id
   method: DELETE
   body : not needed	

=> update certain geolocation
  url: http://localhost:3000/api/update/:id 
  method: PUT
  Body : json
  params: 
	message: string
	lat: float
	lng: float
  
=> find closest geolocation 
  url: http://localhost:3000/api/closest/:lat/:lng
  method: GET
  body : not needed

=> find list of geolocations in 100 km radius
  url: http://localhost:3000/api/in_radius/:lat/:lng
  method: GET
  body : not needed
