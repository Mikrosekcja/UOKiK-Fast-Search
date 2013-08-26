###
Word model
==========

Index of words in terms

###

mongoose    = require "mongoose"
Term        = require "./Term"
$           = (require "debug") "Word model"
# _           = require "underscore"

# Occurence = new mongoose.Schema
#   # Term in which a word occurs
#   term        :
#     type        : mongoose.Schema.ObjectId
#     ref         : 'Term'
#   # Position of the word (first, second, etc)
#   position    : [ Number ]    

Word = new mongoose.Schema
  _id         : 
    type        : String
  terms       :
    type        : [ Number ]
    ref         : 'Term'

module.exports = mongoose.model 'Word', Word