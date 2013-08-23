do (require "source-map-support").install

request   = require "request"
jsdom     = require "jsdom"
async     = require "async"
fs        = require "fs"
iconv     = new (require "iconv").Iconv "windows-1250", "utf-8"

base_uri = "http://decyzje.uokik.gov.pl/nd_wz_um.nsf/WWW-wszystkie?OpenView"
links    = {}
delay    = 200



scrape_list_page = (start) ->
  uri = base_uri + "&Start=" + start

  request 
    uri       : uri
    encoding  : null
    (error, response, body) ->
      console.log "Scraping #{uri}"

      if error or (response.statusCode isnt 200)
        console.error "Failure :( #{uri}"

      jsdom.env
        html    : iconv.convert body
        scripts : [
          "https://raw.github.com/nbubna/HTML/0.9.4/dist/HTML.all.min.js"
        ]
        done    : (error, window) ->
          if error then throw error

          HTML  = window.HTML
          cells = HTML.body.form.table.only(0).find('td')
          if cells.length isnt 0
            cells.each (td) ->
              number  = parseInt td.b.only(0).textContent
              link    = td.a.attributes.href.value

              links[number] = link

            start += cells.length

            setTimeout (scrape_list_page.bind null, start), delay
          
          else # We have 'em all
            console.dir links

scrape_list_page 1