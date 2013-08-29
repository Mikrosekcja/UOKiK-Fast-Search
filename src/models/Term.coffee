###
Term model
==========

Single prohibited contract term from the register

 
###

mongoose    = require "mongoose"
$           = (require "debug") "ufs:model:Term"
async       = require "async"
_           = require "underscore"

Term = new mongoose.Schema
  _id         : # Number of term in register
    type        : Number
  text        : 
    type        : String
    required    : yes
  original_uri:
    type        : String

# TODO: Abstract out and move to fulltext.coffee
split_words = require "../split_words" # TODO: pack

Index = require "./Index"
Cache = require "./Cache"
dld   = require "damerau-levenshtein"

Term.static "findByText", (query, options = {}, callback) ->
  # Query can be 
  # * String    - as entered by user
  # * [String]  - Array of words, will be sanitized

  # Options is a dictionary. Possible values:
  # * limit     - maximal number of matching terms

  # Callback is a function with signature
  # * error
  # * matches   - array of matching terms {term, rank}
  # * quantity  - number of matched terms (before limit is applied)
  # * words     - words extracted from query

  defaults  =
    limit: 20

  if typeof options is 'function'
    callback  = options
    options   = defaults
  else
    options = _.defaults options, defaults

  words     = []
  ranking   = {}                # { term: rank } dictionary

  if query instanceof Array
    words.concat split_words s for s in query
  else 
    words = split_words query

  if not words
    $ "No words in query: %pj", words
    return callback Error "Empty query"

  async.waterfall [
    (done) -> Index.count done
    (total) =>
      async.each words,
        (word, done) =>
          # TODO: use levenshtein distances
          Index.findById word, (error, entry) ->
            $ "Looking for #{word}"
            $ "%j", entry
            if error      then done error
            if not entry  then return do done

            # How common is this word, and thus how much does it weight in ranking
            # .5 in weight is arbitrarily choosen. I fill like 1 is too much :)
            frequency = entry.volume / total
            weight    = (1 / frequency) * .5

            for term in entry.terms
              if not ranking[term] then ranking[term]  = weight
              else                      ranking[term] += weight

            do done
            
        (error) =>
          if error then return callback error
          ranking   = _.sortBy ({term, rank} for term, rank of ranking), "rank"
          $ "Ranking is: %j", ranking
          quantity  = ranking.length
          ranking   = ranking.slice(-options.limit).reverse()

          async.map ranking,
            (match, done) =>
              @findById match.term, (error, term) ->
                if error    then return done error
                if not term then return done Error "No such term #{match.term}"
                $ "Match is: %j", match
                $ "Term is: %j", term
                match.term = term
                done null, match
            (error, matches) =>
              callback error, matches, quantity, words


  ]
  

Term.post "save", (term) ->
  words = split_words term.text

  async.each words,
    (word, done) ->
      Index.update { _id: word },
        {
          $addToSet:
            terms: term
          $inc:
            volume: 1
          length: word.length
        }
        { upsert: true }
        (error, number, response) ->
          if error then return done error
          if not response.updatedExisting
            $ "New word discovered: #{word}"
          do done
    (error) ->
      if error then throw error

module.exports = mongoose.model 'Term', Term