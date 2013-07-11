ajax_render
===========

Rails 4 ajax partial rendering gem

usage
=====

Add this line to your gemfile, will be published to rubygems when reasonably complete.
gem 'ajax_render', github: "jeremy-brenner/ajax_render"

Add this line to your app/assets/javascripts/application.js:
//= require ajax_render

run: bundle update

add "remote: true" to the link you want to ajaxify

add a format.js line in the respond_to for that controller action:

    def index
      @companies = Company.all
      respond_to do |format|
        format.html
        format.js { render :ajax => '_company_list' }   # notice we specify the partial to avoid the entire template from rendering
      end
    end

ajax_render will look for the '#index' div to replace with the rendered content. You can override this by putting a data attribute on the link element or any of it's parent elements:  data-ajax-target = '#jquery-selector'
