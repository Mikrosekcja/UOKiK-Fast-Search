module.exports = ->
  div class: "panel panel-danger", ->
    div class: "panel-heading", ->
      h3 ->
        i class: "icon-frown", " "
        text  "Error #{@name} "
        small @message
    div class: "panel-body", ->
      p ->
        i class: "icon-chevron-left", " "
        a href: "/", "Go back"