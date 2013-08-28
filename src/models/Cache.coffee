###
Cache model
===========

Cached damerau - levenshtein distances for queries

###

mongoose    = require "mongoose"
$           = (require "debug") "Cache model"


# Occurence = new mongoose.Schema
#   # Term in which a word occurs
#   term        :
#     type        : mongoose.Schema.ObjectId
#     ref         : 'Term'
#   # Position of the word (first, second, etc)
#   position    : [ Number ]    

Cache = new mongoose.Schema
  _id         : 
    type        : String
  similar     :
    type        : [ String ]
    ref         : 'Index'

module.exports = mongoose.model 'Cache', Cache