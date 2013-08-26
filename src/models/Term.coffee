###
Term model
==========

Single prohibited contract term from the register

 
###

mongoose    = require "mongoose"
$           = (require "debug") "Term model"
# _           = require "underscore"

Term = new mongoose.Schema
  _id         : # Number of term in register
    type        : Number
  text        : 
    type        : String
    required    : yes
  original_uri:
    type        : String

module.exports = mongoose.model 'Term', Term