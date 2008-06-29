# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'wmq'

class ApplicationController < ActionController::Base

  def self.wmq_config
    unless @wmq_config
      wmq_config_file = File.expand_path('config/wmq.yml', RAILS_ROOT)
      @wmq_config = YAML.load(File.read(wmq_config_file))[RAILS_ENV].symbolize_keys
    end
    @wmq_config
  end

end

