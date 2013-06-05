class AjaxRender
  constructor: ->
    @register_events()
    console.log "Ajax Render initialized"

  register_events: ->
    $('[data-remote=true]').on 'ajax:success', @do_success
    $('[data-remote=true]').on 'ajax:error', @do_error

  do_success: ( e, object ) =>
    console.log "Ajax Render success", e, object
    @render_flash flash, object.selector for flash in object.flash
    $el = $(object.html)
    $( object.selector ).html( $el )

  do_error: ( e ) =>
    #message = $(e.target).attr('data-error-message')
    #@error message if message
    console.log 'error', e

  get_flash_id: ->
    "flash_#{@flash_id++}"

  render_flash: ( flash, selector ) =>
    $f = $(flash)
    $('#main').prepend $f
    console.log $f
    closeFunc = -> 
      $f.hide()
  
    setTimeout closeFunc, 5000


window.AjaxRender = AjaxRender

jQuery ->
  window.ajax_render = new AjaxRender()
  