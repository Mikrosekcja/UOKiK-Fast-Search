async       = require "async"
Term        = require "../models/Term"
debug       = require "debug"
_           = require "underscore"

module.exports =
  "/":
    get: ->
      @bind "index", message: "UOKiK Fast Search and Classification Engine"

    post: ->
      $ = debug "ufs:controllers:index:post"
      query = @req.body?.query or ""
      Term.findByText query, (error, terms) =>
        if error 
          $ "Error getting terms by text: %j", error
          @res.statusCode = 500
          { name, message } = error
          return @res.json error: { name, message }

        $ "Terms are", terms
        $ "Best match is: %d", terms[0].rank
        @res.json terms
              

    "/([0-9]+)":
      get: (number) ->
        Term.findById number, (error, term) =>
          if error    then return @bind "error", error
          if not term
            @res.statusCode = 404
            error           = Error "Term not found"
            error.name      = 404
            return @bind "error", error

          @bind "term", term

