mongoose  = require "mongoose"
async     = require "async"
fs        = require "fs"
path      = require "path"
yaml      = require "js-yaml"
Term      = require "./models/Term"
Word      = require "./models/Word"

# Lowercase word letters.
# Big thanks to Debilski: http://stackoverflow.com/a/2013539/1151982
words_re = ///
  [
  a-z
  æðǝəɛɣĳŋœĸſßþƿȝ
  ąɓçđɗęħįƙłøơşșţțŧųưy̨ƴ
  áàâäǎăāãåǻąæǽǣɓćċĉčçďḍđɗðéèėêëěĕēęẹǝəɛġĝǧğģɣ
  ĥḥħıíìiîïǐĭīĩįịĳĵķƙĸĺļłľŀŉńn̈ňñņŋóòôöǒŏōõőọøǿơœ
  ŕřŗſśŝšşșṣßťţṭŧþúùûüǔŭūũűůųụưẃẁŵẅƿýỳŷÿȳỹƴźżžẓ
  ]+
  ///g

split_words = (text) -> text.toLowerCase().match words_re

save_term = (data, done) ->
  term = new Term data
  term.save (error) ->
    if error then return done error
    words = split_words data.text 
    for wrd, position in words
      Word.findById wrd, (error, word) ->
        if error then return done error
        if not word then word = new Word _id: wrd
        console.log "#{term._id}\t: #{word._id}"
        
        word.terms.push term._id
        word.save done
  
  

import_file = (file, done) ->
  # TODO: check if exists (?)
  if file.match /\/[0-9]+\.yaml$/
    term = require file
    save_term term, (error) ->
      if error
        if error.name is "ValidationError"
          console.error "ValidationError in #{file}"
          return do done
        else done error

      else do done
    
  else do done

import_dir = (dir, done) ->
  fs.readdir dir, (error, files) ->
    if error then throw error
    files = files.map (file) -> "#{dir}/#{file}"
    async.each files, import_file, done

module.exports = import_dir

if require.main is module
  dir = path.resolve __dirname, process.argv[2] or "."
  if not fs.existsSync(dir) or not fs.statSync(dir).isDirectory()
    throw Error "No such directory: #{dir}"

  console.log "Importing from #{dir}"
  mongoose.connect ("mongodb://localhost/terms")

  # async.parallel [
  #   Term.remove
  #   Word.remove  
  # ], (error) -> 
  # if error then throw error

  import_dir dir, (error) ->
    if error then throw error
    console.log "all done!"