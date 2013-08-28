app = angular.module "ufs", []

app.controller "SearchController", 
  class SearchController
    constructor: ($http) -> 
      @http = $http

    query: ""
      
    matches: []

    fetch: ->
      console.log "Fetching data..."
      req = @http.post "/", query: @query

      req.success (data, status) =>
        console.log data.quantity
        console.dir data
        @matches = data.matches

      req.error (data, status) =>
        console.log status
        console.dir data


