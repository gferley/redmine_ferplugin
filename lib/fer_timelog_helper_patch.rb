require_dependency 'timelog_helper'

module FerTimelogHelperPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
		
		base.class_eval do
			unloadable
	  def user_collection_for_select_options(project, selected = nil)
			collection = project.members.map{ |member| member.user }
			collection.keep_if{ |user| user.allowed_to?(:log_time, project) }
			s = ''
			s << content_tag('option', "<< #{l(:label_me)} >>", :value => User.current.id) if User.current.admin? || collection.include?(User.current)
			collection.sort.each do |element|
				selected_attribute = ' selected="selected"' if option_value_selected?(element, selected)
				s << %(<option value="#{element.id}"#{selected_attribute}>#{h element.name}</option>)
			end
			s.html_safe
	  end
		end
  end
  
  module InstanceMethods
	  def user_collection_for_select_options(project, selected = nil)
			collection = project.members.map{ |member| member.user }
			collection.keep_if{ |user| user.allowed_to?(:log_time, project) }
			s = ''
			s << content_tag('option', "<< #{l(:label_me)} >>", :value => User.current.id) if User.current.admin? || collection.include?(User.current)
			collection.sort.each do |element|
				selected_attribute = ' selected="selected"' if option_value_selected?(element, selected)
				s << %(<option value="#{element.id}"#{selected_attribute}>#{h element.name}</option>)
			end
			s.html_safe
	  end
	end
end

# Maybe needed?
#TimelogHelper.send(:include, FerTimelogHelperPatch)