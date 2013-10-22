app     = angular.module "ufs", ["ngRoute"]

_       = {}  # Placeholder for underscore. No need for that ATM.
_.words = require "underscore.string.words"

app.config ($routeProvider, $locationProvider) ->
  $routeProvider.when "/search/:query",
    resolve:
      fn: ($rootScope, $location, $route) -> 
        {query} = $route.current.params
        $rootScope.$emit "search", query


  $routeProvider.otherwise redirectTo: "/"


app.controller "SearchController", 
  class SearchController
    constructor: (@$http, @$location, @$route, @$rootScope, @$scope) -> 

      @$rootScope.$on 'search', (event, query) =>
        @query = (_.words query).join " "
        @fetch query



    query   : ""  # Raw query, as enterd by user
    matches : []  # List of matching terms

    search: ->

      if isNaN @query
        words = _.words @query
        @$location.path "/search/" + words.join "+"

      else
        window.location = @query


    fetch: (words) =>
        @terms = {}
        req = @$http.post "/", query: words

        req.success (data, status) =>
          @terms = data

        req.error (data, status) =>
          console.error status
          console.dir data

      


