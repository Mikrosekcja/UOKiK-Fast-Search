mongoose    = require "mongoose"
async       = require "async"
fs          = require "fs"
path        = require "path"
yaml        = require "js-yaml"
Term        = require "./models/Term"

split_words = require "./split_words"


save_term = (data, done) ->
  term = new Term data
  term.save done

import_file = (file, done) ->
  # TODO: check if exists (?)
  if file.match /\/[0-9]+\.yaml$/
    term = require file
    save_term term, (error) ->
      if error
        if error.name is "ValidationError"
          console.error "ValidationError in #{file}"
          return do done
        else return done error

      else return do done

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

  import_dir dir, (error) ->
    if error then throw error
    console.log "Import done!"
    do mongoose.connection.close
    
    # console.log "Saving index..."
    # async.each ({_id, terms} for _id, terms of index),
    #   (o, done) ->
    #     word = new Word o
    #     word.save done
    #   (error) ->
    #     if error then throw error
    #     
    #     console.log "All done!"
