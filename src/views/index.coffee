module.exports = ->
  div class: "input-group input-group-lg", ->
    input
      type: "text"
      class: "form-control"
      placeholder: "Enter words you are you looking for here"
      ng:
        model: "query"

    span class: "input-group-btn", ->
      button type: "button", class: "btn btn-default", ->
        i class: "icon-bolt"

  p ng: model: "query"

  