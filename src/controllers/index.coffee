async       = require "async"
debug       = require "debug"
_           = require "underscore"
elastic     = require "elasticsearch"

$           = debug   "ufs:controllers:index"

es      = new elastic.Client
  host: process.env.ELASTICSEARCH_URL or 'http://localhost:9200'
  # log : "trace"

module.exports =
  "/":
    get: ->
      @bind "index", message: "UOKiK Fast Search and Classification Engine"

    post: ->
      $ = debug "ufs:controllers:index:post"
      query = @req.body?.query or ""
      $ "Looking for %s", query
  
      es.search
        index   : 'ab2c'
        type    : 'term'
        body    :
          query   :
            match   :
               text   : query

        (error, result) =>
          if error then throw error

          terms = result.hits.hits.map (hit) ->
            _.extend hit._source,
              term_id     : hit._source._id
              original_uri: '#'
              rank        : hit._score
          @res.json terms

              

    # "/([0-9]+)":
    #   get: (number) ->
    #     Term.findById number, (error, term) =>
    #       if error    then return @bind "error", error
    #       if not term
    #         @res.statusCode = 404
    #         error           = Error "Term not found"
    #         error.name      = 404
    #         return @bind "error", error

    #       @bind "term", term

