# The follow line appears to only be require for version 1.x
require 'redmine'

# My libs
require 'fer_timelog_controller_patch'
require_dependency 'fer_timelog_helper_patch'


Redmine::Plugin.register :fer_plugin do
  name 'Fer Plugin'
  author 'Grant Ferley'
  author_url 'http://github.com/gferley'
  description 'Adds support for multiuser time logging'
  version '0.0.1'
	
	requires_redmine :version_or_higher => '3.2' rescue raise "\n\033[31mFer Plugin requires version 3.2 or higher.\033[0m"
  

  permission :log_foreign_time, {:timelog => [:new, :create]}, :require => :member

end

Rails.configuration.to_prepare do
  require 'fer_timelog_helper_patch'
  TimelogHelper.send :include, FerTimelogHelperPatch
end
