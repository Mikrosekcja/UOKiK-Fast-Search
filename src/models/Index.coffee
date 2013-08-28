###
Word index model
================

Index of words in terms

###

mongoose    = require "mongoose"
$           = (require "debug") "ufs:model:word-index"
# _           = require "underscore"

# Occurence = new mongoose.Schema
#   # Term in which a word occurs
#   term        :
#     type        : mongoose.Schema.ObjectId
#     ref         : 'Term'
#   # Position of the word (first, second, etc)
#   position    : [ Number ]    

Index = new mongoose.Schema
  _id         : 
    type        : String
  terms       :
    type        : [ Number ]
    ref         : 'Term'

module.exports = mongoose.model 'Index', Index