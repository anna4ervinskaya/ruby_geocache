App.geo = App.cable.subscriptions.create "GeoChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data.list
      window.geo.init()
      window.geo.markers = data.list
      for i of data.list
        window.geo.add_point data.list[i].lat, data.list[i].lng, data.list[i].message, false
    if data.closest
      window.geo.draw_search_result [data.closest]
    if data.in_radius && data.in_radius.length > 0
      window.geo.draw_search_result data.in_radius
    # Called when there's incoming data on the websocket for this channel
