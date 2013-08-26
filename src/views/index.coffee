module.exports = ->
  div class: "input-group input-group-lg", ->
    input type: "text", class: "form-control ", placeholder: @message
    span class: "input-group-btn", ->
      button type: "button", class: "btn btn-default", ->
        i class: "icon-bolt"

  