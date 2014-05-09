module.exports = ->
  div class: "jumbotron", ->
    h1 -> small @_id
    p class: "lead", @text

  dl class: "dl-horizontal", ->
    dt "Court decision"
    dd class: "reference-sign", @court_sign
    dd class: "date", @moment(@court_date).format "YYYY-MM-DD"
    
    dt "Plaintiff(s)"
    dd @plaintiffs
    
    dt "Defendant(s)"
    dd @defendants

    dt "Registration date"
    dd class: "date", @moment(@register_date).format "YYYY-MM-DD"
