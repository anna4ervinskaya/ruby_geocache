# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
Geolocate = () ->
  map = {}
  markers = []
  start_marker = null
  start_point =
    lat: -34.397
    lng: 150.644
  add_point = (lat, lng, message, save = true) ->
    data =
      message: message
      lat: lat
      lng: lng

    if !save || App.geo.send(new: data)
      markers.push placeMarkerAndPanTo lat, lng, message
      return true
    return false

  refresh_markers = () ->
    for m in markers
      m.setMap(map)
    return true

  draw_search_result = (show_markers) ->
    for m in show_markers
      placeMarkerAndPanTo m.lat, m.lng, m.message, 'blue'
    return true

  initMap = () ->
    map = new (google.maps.Map)(document.getElementById('map'),
      center:
        lat: start_point.lat
        lng: start_point.lng
      zoom: 5)

    start_marker = placeMarkerAndPanTo start_point.lat, start_point.lng, "Start point", "green"
    $('#search_lat').text(start_point.lat)
    $('#search_lng').text(start_point.lng)
    map.addListener 'click', (e) ->
      message = window.prompt('Please enter your message', '')
      if message
        add_point(e.latLng.lat(), e.latLng.lng(), message)

    map.addListener 'rightclick', (e) ->
      refresh_markers()
      start_marker.setMap(null)
      start_marker = placeMarkerAndPanTo e.latLng.lat(), e.latLng.lng(), "Start point", "green"
      $('#search_lat').text(e.latLng.lat())
      $('#search_lng').text(e.latLng.lng())

  placeMarkerAndPanTo = (lat, lng, message, color = "red") ->
    latLng = new google.maps.LatLng lat, lng
    marker = new (google.maps.Marker)(
      position: latLng
      map: map
      icon: 'http://maps.google.com/mapfiles/ms/icons/'+color+'-dot.png'
      title: message
      label: message)
    map.panTo latLng
    return marker


  return {
    init: initMap
    add_point: add_point
    draw_search_result: draw_search_result
    start_marker: start_marker
  }


$(document).on('turbolinks:load', ()->
  window.geo = new Geolocate()
  $('#closest_marker').bind 'click', ->
    data =
      lat: parseFloat $('#search_lat').text()
      lng: parseFloat $('#search_lng').text()
    App.geo.send(find_close: data)

  $('#find_markers_in_radius').bind 'click', ->
    data =
      lat: parseFloat $('#search_lat').text()
      lng: parseFloat $('#search_lng').text()
    App.geo.send(find_in_radius: data)
)
