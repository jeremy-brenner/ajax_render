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
        format.js { render :ajax => '_company_list' }   
      end
    end

Use the ajax_render helper in your view to get your content to the right place:

= ajax_render :selector => "#css.selector" do 
  %ul.nav.nav-pills
    - @companies.each do |copmany|
      %li= company.name

Outside of the :ajax renderer the ajax_render helper gets out of the way and doesn't mess with your view allowing you to use your views for both ajax rendering and standard rendering.