async       = require "async"
debug       = require "debug"
_           = require "underscore"
elastic     = require "elasticsearch"

$           = debug   "ufs:controllers:index"

db_port     = 9200
db_host     = process.env["DB_PORT_ #{db_port}_TCP_ADDR"] or 'localhost'
db_url      = db_host + ':' + db_port

$ "Connecting to %s", db_url

es      = new elastic.Client
  host: db_url
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

