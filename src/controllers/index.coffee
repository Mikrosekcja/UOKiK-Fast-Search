async       = require "async"
Term        = require "../models/Term"
Word        = require "../models/Word"
split_words = require "../split_words"
debug       = require "debug"
_           = require "underscore"

module.exports =
  "/":
    get: ->
      @bind "index", message: "UOKiK Fast Search and Classification Engine"

    post: ->
      $ = debug "ufs:controllers:index:post"
      { query } = @req.body
      words     = split_words query
      ranking   = {}                # { term: rank } dictionary

      async.each words,
        (word, done) =>
          # TODO: use levenshtein distances
          Word.findById word, (error, index) ->
            $ "Looking for #{word}"
            $ "%j", index
            if error      then done error
            if not index  then return do done

            for term in index.terms
              if not ranking[term] then ranking[term] = 1
              else                      ranking[term]++

            do done
            
        (error) =>
          if error then @res.json error
          ranking   = _.sortBy ({term, rank} for term, rank of ranking), "rank"
          $ "Ranking is: %j", ranking
          quantity  = ranking.length
          ranking   = ranking.slice(-20).reverse()

          async.map ranking,
            (match, done) ->
              Term.findById match.term, (error, term) ->
                if error then return done error
                if not term then return done Error "No such term #{match.term}"
                $ "Match is: %j", match
                $ "Term is: %j", term
                match.term = term
                done null, match
            (error, matches) =>
              if error 
                @res.statusCode = 500
                @res.json { error }
              @res.json { words, quantity, matches }

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

