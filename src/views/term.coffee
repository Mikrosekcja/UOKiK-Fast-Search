module.exports = ->
  div class: "jumbotron", ->
    h1 -> small @_id
    p -> em @text