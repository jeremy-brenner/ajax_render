# Copyright (C) 2012 Jeremy Brenner
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in coSmpliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

ActionController::Renderers.add :ajax do |obj, *args|
  @in_ajax_render = true
  options = args.extract_options!
  Rails.logger.info [ obj, options ]
  output =  { 
              html:     render_to_string( :action => obj, :layout => options[:layout] || false ),
              flash:    flash.map { |f| render_to_string( :partial => 'shared/flash', :locals => { :name => f[0], :message => f[1] } ) },
              target:   options[:target],
              params:   params,
              path:     request.original_fullpath
            }
  @in_ajax_render = false      
  send_data output.to_json, :type => Mime::JSON
end