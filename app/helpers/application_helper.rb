module ApplicationHelper

  def hp_field_label(model_or_name, attribute = nil, options = {})
    content = if model_or_name && attribute
        t("helpers.label.#{model_or_name}.#{attribute}", default: '').presence ||
          hp_human_name_for(model_or_name, attribute)
      else
        model_or_name
      end

    content_tag(:strong, content, options)
  end

  def hp_field_content(content, options = {})
    content = content.presence if !content.is_a?(FalseClass)

    case content
    when String     then content
    when Date       then l(content, format: options[:format] || :default)
    when Time       then l(content, format: options[:format] || :default)
    when NilClass   then t('helpers.field_content.no_content')
    when Fixnum     then content
    when Float      then number_with_precision(content)
    when BigDecimal then number_to_currency(content)
    when TrueClass, FalseClass then t("helpers.field_content.#{content}")
    end
  end

  def hp_human_name_for(model_name, attribute = nil)
    model = model_name.to_s.camelize.constantize

    if attribute
      traslation = model.human_attribute_name(attribute.to_s, default: '')
      traslation = attribute.to_s.upcase unless traslation.present?
    else
      traslation = model.model_name.human
    end

    traslation
  end

  def hp_human_code_name_for(model_name, code)
    if (code.present?)
      scope = "activerecord.attributes.#{model_name}.code_value"

      t(code, scope: scope)
    else
      '----'
    end
  end

  def hp_delete_button(url, options = {})
    scope     = 'helpers.delete_button'
    css_class = "btn btn-danger #{options[:class]}"
    confirm   = options[:confirm] || t('confirmation', scope: scope)

    form_tag url, method: :delete, class: 'd-inline' do
      submit_tag(t('title', scope: scope),
        data:   { confirm: confirm },
        class:  css_class
      )
    end
  end

end
