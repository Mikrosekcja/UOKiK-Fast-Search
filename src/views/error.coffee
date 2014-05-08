module.exports = ->
  div class: "panel panel-danger", ->
    div class: "panel-heading", ->
      h3 ->
        i class: "icon-frown", " "
        text  "Rerror... em... #{@name} "
        small @message
    div class: "panel-body", ->
      p ->
        i class: "icon-chevron-left", " "
        a href: "/", "Go back"