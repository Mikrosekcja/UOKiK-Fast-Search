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
                    click: "search.search()"
                  ->
                    i class: "icon-bolt"


    div
      id: "terms"
      class: "row"
      ->
        div class: "col-lg-12", ng: repeat: "term in search.terms", ->
          div class: "well term", ->
            a href: "/{{term._id}}", ->
              p class: "text", "{{term.text}}"
            div class: "row", ->
              div class: "col-lg-10", -> p class: "small", ->
                strong  "{{term._id}} "
                text    "({{ term.register_date | date: 'yyyy-MM-dd'}})"
                do br
                span class: "text-muted", " {{term.rank.toFixed(2)}}"