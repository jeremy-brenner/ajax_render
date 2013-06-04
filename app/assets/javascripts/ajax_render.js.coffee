class AjaxRender
  constructor: ->
    @register_events()
    console.log "Ajax Render initialized"

  register_events: ->
    $('form').on 'ajax:success', @do_success
    $('form').on 'ajax:error', @do_error

window.AjaxRender = AjaxRender

jQuery ->
  window.ajax_render = new AjaxRender()
  