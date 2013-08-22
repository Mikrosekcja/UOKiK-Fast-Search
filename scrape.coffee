request = require "request"
jsdom   = require "jsdom"
async   = require "async"

iconv   = new (require "iconv").Iconv "windows-1250", "utf-8"

start = "http://decyzje.uokik.gov.pl/nd_wz_um.nsf/WWW-wszystkie"

request 
  uri       : start
  encoding  : null
  (error, response, body) ->
    if error or (response.statusCode isnt 200)
      console.error "Failure :( #{start}"

    console.log body.length

    jsdom.env
      html    : iconv.convert body
      scripts : [
        "https://raw.github.com/nbubna/HTML/0.9.4/dist/HTML.all.min.js"
      ]
      done    : (error, window) ->
        if error then throw error

        HTML  = window.HTML
        as    = HTML.body.form.table.only(0).find('a')
        console.log as.length + " found"
        as.each (a) ->
          console.log a.textContent + " -> " + a.attributes.href.value