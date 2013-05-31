class AjaxRender
  constructor: ->
    console.log "Ajax Render initialized"

window.AjaxRender = AjaxRender

jQuery ->
  window.ajax_render = new AjaxRender()
  