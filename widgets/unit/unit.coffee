class Dashing.Unit extends Dashing.Widget


  ready: ->
    setInterval(@checkOnline, 1000 * 60)
    # This is fired when the widget is done being rendered

  onData: (data) ->
    @checkOnline()
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    $(@node).fadeOut().fadeIn() # will make the node flash each time data comes in.

  checkOnline: =>
    screenshotDate = @setMomentDate('screenshotCreatedAt', 'screenshotCreatedAtMessage')


    date = @setMomentDate('checkedinAt', 'checkedinAtMessage')
    now = new Date().getTime()
    # console.log(date)

    # console.log(now)
    # console.log(now - date)
    # console.log(1000 * 60 * 15)
    #15 mins since last checkin
    if now - date < 1000 * 60 * 15
      $(@node).css('background-color', '#00FF00')
    else
      $(@node).css('background-color', '#FF0000')

  setMomentDate: (dateKey, messageKey) ->
    rawDate = @get(dateKey)
    if rawDate
      date = Date.parse(rawDate)
      @set(messageKey,moment(date).fromNow())
    else
      @set(messageKey,'No data')
    date

