module.exports = ->
  @scripts.push "/js/index.js"

  div ng: controller: "SearchController as search", ->

    div 
      id    : "search"
      class : "row"
      ->
        div class: "col-lg-12", ->
          form ->
            div class: "input-group input-group-lg", ->
              input
                type: "text"
                class: "form-control"
                placeholder: "Enter words you are you looking for here"
                ng:
                  model: "search.query"

              span class: "input-group-btn", ->
                button
                  type: "submit"
                  class: "btn btn-default"
                  ng:
                    click: "search.fetch()"
                  ->
                    i class: "icon-bolt"


    div
      id: "terms"
      class: "row"
      ->
        div class: "col-sm-4 col-lg-3", ng: repeat: "match in search.matches", ->
          a href: "/{{match.term._id}}", ->
            div class: "well term", ->
              p class: "text", "{{match.term.text}}"
              div class: "row", ->
                div class: "col-xs-6", -> p class: "small", -> strong "{{match.term._id}}"
                div class: "col-xs-6", -> p class: "small text-muted", " {{match.rank.toFixed(2)}}"