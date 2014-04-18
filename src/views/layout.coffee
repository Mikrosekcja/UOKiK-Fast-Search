module.exports = ->

  # This array can be modified by views. It is used in the end of this file.
  @scripts = [
    "//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min.js"
    "//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"
    "//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"
    "//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular.min.js"
    "//ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-route.min.js"
    "/js/browserified.js"
  ]

  doctype 5
  html ng: app: "ufs", ->
    head ->
      title "UOKiK Fast Search"
      meta charset: "utf-8"
      meta "http-equiv": "content-type", "content": "text/html; charset=utf-8"
      meta "http-equiv": "X-UA-Compatible", "content": "IE=edge,chrome=1"
      meta "name": "description", "content": "Fast and mordern search engine for prohibited B2C terms"
      meta "name": "keywords", "content": "UOKiK, Search, B2C, prohibited"
      meta "name": "author", "content": 'Tadeusz Łazurski'
      meta "name": "viewport", "content": "width=device-width, initial-scale=1.0"

      # Shortcut icons
      # TODO: static file server
      link rel: "shortcut icon",                href: "/ico/favicon.png"
      link rel: "apple-touch-icon-precomposed", href: "/ico/apple-touch-icon-144-precomposed.png", sizes: "144x144"
      link rel: "apple-touch-icon-precomposed", href: "/ico/apple-touch-icon-114-precomposed.png", sizes: "114x114"
      link rel: "apple-touch-icon-precomposed", href: "/ico/apple-touch-icon-72-precomposed.png",  sizes: "72x72"
      link rel: "apple-touch-icon-precomposed", href: "/ico/apple-touch-icon-57-precomposed.png"

      ie "lt IE 9", ->
        script async: yes, src: "http://html5shim.googlecode.com/svn/trunk/html5.js"

      link rel: "stylesheet", type: "text/css", href: url for url in [
        "//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.no-icons.min.css"
        "//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.min.css"
        # "/styles/style.css"
        # TODO: static file server and .styl to .css compilation
      ]
      stylus """
        .credit
          margin 20px 0

        a, a:link
          cursor pointer

        body
          padding-top 120px

        #terms
          margin-top 50px

          a
            color initial
            &:hover
              color initial
              text-decoration: initial

          .term .text
            max-height 120px
            overflow hidden
            text-overflow ellipsis
      """

        

      body ->
        div class: "navbar navbar-default navbar-fixed-top", ->
          div class: "container", ->
            div class: "navbar-header", ->
              button
                type: "button"
                class: "navbar-toggle"
                data:
                  toggle: "collapse"
                  target: ".navbar-collapse"
                ->
                  span class: "icon-bar" for i in [1..3]

              a class: "navbar-brand", href: "/", ->
                text "UOK"; i class: "icon-bolt"; text "K"

            div class: "collapse navbar-collapse", ->
              ul class: "nav navbar-nav", ->
                # for document in [ # TODO: some links :P ]
                #   li
                    # typeof: "sioc:Page"
                    # about: document.url
                    # class: ('active' if @document.url is document.url)
                    # ->
                    #   a
                    #     href: document.url
                    #     property: "dc:title"
                    #     document.title

      div class: "container", ->
        do content

      footer id: "footer", ->
        div class: "container", ->
          p class: "text-muted credit", ->
            text "UOKiK Fast Search #{@version} &copy Tadeusz Łazurski"
            do br
            text "This site is not hosted or endorsed in any way by the "
            a 
              href: "http://uokik.gov.pl"
              target: "_blank"
              "Office of Competition and Consumer Protection."
      
      script type: "text/javascript", src: url for url in @scripts
