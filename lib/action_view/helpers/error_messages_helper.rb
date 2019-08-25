require 'action_view/helpers/tag_helper'

module ActionView
  module Helpers
    module ErrorMessages

      def error_messages(attribute, options = {})
        errors = @object.errors[attribute].map(&:capitalize).join(', ')

        options[:class] ||= ''
        options[:class] << 'field_errors_explanation'

        @template.content_tag(:div, errors, options)
      end

    end
  end
end

ActiveSupport.on_load(:action_view) do
  ActionView::Helpers::FormBuilder
    .send(:include, ActionView::Helpers::ErrorMessages)
end
