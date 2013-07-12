class AjaxRender
  constructor: ->
    @register_events( $('body') )
    console.log "Ajax Render initialized"

  register_events: ( $el ) ->
    $el.find('[data-remote=true]').on 'ajax:success', @do_success
    $el.find('[data-remote=true]').on 'ajax:error', @do_error

  do_success: (e, object) =>
    if typeof object == 'object'
      @parse_html(object.html)
      @render_all()
      window.history.pushState("", "", object.path );
      @render_flash flash, object.selector for flash in object.flash

  do_error: (e) =>
    console.log 'Ajax Render error', e

  get_flash_id: ->
    "flash_#{@flash_id++}"

  parse_html: (html) ->
    @$content = $( html ).filter('ajax_render')
                         .add( $( html ).find('ajax_render') )
                         .map (i,el) -> { html: el.children, opts: JSON.parse($(el).attr('data-ajax-options')) }

  render_all: ->
    @render_object(obj) for obj in @$content

  render_object: (obj) ->
    method = obj.opts.method || 'html'
    selector = obj.opts.selector 
    $(selector)[method](obj.html)
    @register_events($(selector))

  render_flash: (flash, selector) =>
    $f = $(flash)
    $('[data-ajax-flash]').prepend $f
    console.log $f
    closeFunc = -> 
      $f.hide()
  
    setTimeout closeFunc, 5000

window.AjaxRender = AjaxRender



jQuery ->
  window.ajax_render = new AjaxRender()
  