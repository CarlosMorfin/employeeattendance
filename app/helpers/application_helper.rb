module ApplicationHelper

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

end
