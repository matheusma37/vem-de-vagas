module JobOpportunityHelper
  def human_attribute_enum(model_name, enum_attr, attr_name)
    I18n.t("activerecord.attributes.#{model_name}/#{enum_attr}.#{attr_name}")
  end
end
