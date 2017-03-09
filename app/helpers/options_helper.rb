# frozen_string_literal: true
module OptionsHelper
  def options_for_browser_types
    Html::Browser::BROWSERS.map { |value| [I18n.t("enums.browser_types.#{value}"), value] }
  end

  def options_for_categories
    Procedure.categories.map { |category, _key| [category, category] }
  end

  def options_for_selectors
    Procedure.selectors.map { |selector, _key| [selector, selector] }
  end

  def options_for_actions
    Procedure.actions.map { |action, _key| [action, action] }
  end
end
