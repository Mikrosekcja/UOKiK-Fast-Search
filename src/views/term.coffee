module.exports = ->
  div class: "jumbotron", ->
    h1 -> small @_id
    p -> em @text
    p -> small -> a href: @original_uri, target: "_blank", "Entry in official register"