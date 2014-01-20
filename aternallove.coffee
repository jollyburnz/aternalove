if Meteor.isClient
  Meteor.startup ->
    Meteor.call 'getMessages', (err, res) ->
      if err?
        console.log 'err', err
      else
        console.log 'res', res
        aaa = JSON.parse(res.content)
        console.log aaa
        Session.set 'test', aaa.success

  Template.intro.lovenotes = ->
    console.log 'love notes'
    Session.get 'test'


  Template.intro.events 
    # "click .call2action": ->
    #   # template data, if any, is available in 'this'
    #   console.log "You pressed the button"  if typeof console isnt "undefined"

    #   vex.defaultOptions.className = 'vex-theme-flat-attack'

    #   vex.dialog.open
    #     message: 'Enter your username and password:'
    #     input: """
    #       <input name="username" type="text" placeholder="Username" required />
    #       <input name="password" type="password" placeholder="Password" required />
    #     """
    #     buttons: [
    #       $.extend({}, vex.dialog.buttons.YES, text: 'Login')
    #       $.extend({}, vex.dialog.buttons.NO, text: 'Back')
    #     ]
    #     callback: (data) ->
    #       return console.log('Cancelled') if data is false
    #       console.log 'Username', data.username, 'Password', data.password

    # "click .call2action": (e, t) ->
    #   console.log 'please open!'
    #   $("#myModal").reveal
    #     animation: "fade" #fade, fadeAndPop, none
    #     animationspeed: 1000 #how fast animtions are
    #     closeonbackgroundclick: true #if you click background will modal close?
    #     dismissmodalclass: "close-reveal-modal" #the class of a button or element that will close an open modal


    "click .contact": (e, t) ->
      e.preventDefault()

    "click .paper": (e, t) ->
      e.preventDefault()
      # console.log @, @[0], @[1], @[2], e.target
      # $(e.target).find('.notes').show()
      #console.log 'click contact', t.find('.notes')
      #$(t.find('.notes')).show()

      # "mouseout .paper": (e, t) ->
      #   console.log $(e.target).find('.notes').hide()

      console.log @[0]

      vex.defaultOptions.className = 'vex-theme-os';
      vex.dialog.alert
          message: @[2]
          className: 'vex-theme-wireframe' # Overwrites defaultOptions

  Template.form.events 
    "click #submit-love": (e, t) ->
      e.preventDefault()
      #console.log 'submit-love', e, t

      name = t.find('#name').value
      email = t.find('#email').value
      rname = t.find('#rname').value
      remail = t.find('#remail').value
      message = t.find('#love-message').value

      console.log name, email, rname, remail, message, 'yes'
    
      Meteor.call 'sendLoveMessage', name, email, rname, remail, message, (err, res) ->
        if err?
          console.log 'err', err
        else
          console.log res, 'fuck yea!'
          if res.data.success is 0
            console.log 'nooooo!'
          else
            $('#eternalform').fadeOut()

            #blank out fields
            t.find('#name').value = ""
            t.find('#email').value = ""
            t.find('#rname').value = ""
            t.find('#remail').value = ""
            t.find('#love-message').value = ""
            
            setTimeout ->
              $('#sent').fadeIn()
            , 1000

            setTimeout ->
              console.log 'hide the damn modal'
              # $('#myModal').modal('hide')
              # $('.modal-backdrop').hide()
              # $('#myModal').fadeOut('fast')
            , 2000

if Meteor.isServer
  Meteor.startup ->
    Meteor.methods
      getMessages: ->
        @unblock()
        yo = HTTP.call "GET", "http://florincoin.info/api/messages.php?requests=0&requests2=30&prefix=text"
        console.log yo, 'yooo'
        yo

      sendLoveMessage: (name, email, rname, remail, message) ->
        @unblock()
        #console.log name, email, rname, remail, message, 'nice!'
        url = "http://florincoin.info/love/send_form.php?name="+name+"&email="+email+"&rname="+rname+"&remail="+remail+"&message="+message
        console.log url
        HTTP.call "GET", url

        # HTTP.call "GET", "http://florincoin.info/love/send_form.php",
        #   data:
        #     name : name
        #     email : email
        #     rname : rname
        #     remail : remail
        #     message : message
        # , (error, result) ->
        #   if error?
        #     console.log error, 'error'
        #   else
        #     console.log result

        #console.log yo




# code to run on server at startup
