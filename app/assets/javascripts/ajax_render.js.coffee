class AjaxRender
  constructor: ->
    @register_events()
    console.log "Ajax Render initialized"

  register_events: ->
    $('[data-remote=true]').on 'ajax:success', @do_success
    $('[data-remote=true]').on 'ajax:error', @do_error

  do_success: (e, object) =>
    console.log "Ajax Render success", e, object
    window.history.pushState("", "", object.path );
    @render_flash flash, object.selector for flash in object.flash
    @render_content(e, object)
    @fire_callback(e, object)


  do_error: (e) =>
    console.log 'Ajax Render error', e

  get_flash_id: ->
    "flash_#{@flash_id++}"

  get_ajax_target: (e, object) ->
    object.target or @search_upward(e,'data-ajax-target') or "\##{object.params.action}" 

  search_upward: (e, search) ->
    $(e.target).attr(search) or $(e.target).parents("[#{search}]").first().attr(search)

  render_content: (e, object) ->
    $el = $(object.html)
    $target = $( @get_ajax_target(e,object) )
    $target.html( $el )

  render_flash: (flash, selector) =>
    $f = $(flash)
    $('[data-ajax-flash]').prepend $f
    console.log $f
    closeFunc = -> 
      $f.hide()
  
    setTimeout closeFunc, 5000

  fire_callback: (e, object) ->
    cb = eval(@search_upward(e, 'data-ajax-callback'))
    cb(e, object) if cb

window.AjaxRender = AjaxRender

jQuery ->
  window.ajax_render = new AjaxRender()
  