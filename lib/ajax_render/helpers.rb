module AjaxRender
  module Helpers

    def ajax_render *args, &block
      options = args.extract_options!
      raise ArgumentError, "Missing block" unless block_given?
      
      if in_ajax_render?
        "<ajax_render data-ajax-options='#{options.to_json}'>#{capture(&block)}</ajax_render>".html_safe
      else
        capture(&block)
      end
    end

    def in_ajax_render?
      @in_ajax_render && @in_ajax_render != nil && @in_ajax_render == true 
    end
    
  end
end