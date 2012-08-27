# Basic webserver using Zappa and Hyve to extract stream from sns
zappa = require 'zappajs'


# import hyve crawler 
hyve = require('./hyve/src/hyve.core.js')
require('./hyve/src/hyve.twitter.js')
require('./hyve/src/hyve.facebook.js')

# hyve setup
hyve.queue_enable = true
hyve.recall_enable = false


zappa 3003, ->

    @enable 'serve zappa', 'serve jquery', 'serve sammy'
    @use 'bodyParser', 'methodOverride', @app.router, 'static'

    
    @configure
      development: => @use errorHandler: {dumpExceptions: on}
      production: => @use 'errorHandler'
              
    @get '/': ->
        @render 'index': {layout: no}

    testcb = () ->
        console.log 'ok'

    @on query: ->
        @emit query:  { text: @data.text }
        sns = [ 'twitter','facebook' ]
        emit = @emit # fix annoying scope bug

        hyve.search.stream @data.text, ( (snsdata) ->
                #callback when a message is added
                emit newItem: { msg: snsdata }
            ), sns

    @client '/index.js': ->
        console.log('client-side route with sammy.js')
        @connect()

        @on query: ->
           $('#msg').append "<p>Query : #{@data.text}</p>"
        
        @on newItem: ->
            console.log( @data.msg )
            $('#msg').append "
                <p>
                    <img src='#{@data.msg.user.avatar}' />
                    #{@data.msg.service} : #{@data.msg.text}
                </p>"
        $ =>
          $('#box').focus()
          
          # get keyword
          $('button').click (e) =>
             k = $('#box').val()
             @emit query: { text: k }
             console.log k
             e.preventDefault()

    @view index: ->
        doctype 5
        html ->
          head ->
            meta charset: 'utf-8'
            title 'SBF example'
            script src: '/socket.io/socket.io.js'
            script src: '/zappa/jquery.js'
            script src: '/zappa/sammy.js'
            script src: '/zappa/zappa.js'
            script src: '/index.js'
            script src: 'processing.js'
          body ->
            h2 -> 'Example sbf'
            form ->
                  input id: 'box'
                  button 'Send'
            div id: 'msg'
            canvas id:"seuron", 'data-processing-sources':"seuron-meme.pde lib/Seuron.pde lib/Dendrit.pde lib/Message.pde lib/Transmitter.pde", tabindex:"0", width:"960", height:"550", style:"image-rendering: -webkit-optimize-contrast !important; "
