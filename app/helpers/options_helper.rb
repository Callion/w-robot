# frozen_string_literal: true
module OptionsHelper
  def options_for_browser_types
    Html::Browser::BROWSERS.map { |value| [I18n.t("enums.browser_types.#{value}"), value] }
  end

  def options_for_categories
    Procedure.categories.map { |category, _key| [t("enums.categories.#{category}"), category] }
  end

  def options_for_selectors
    Procedure.selectors.map { |selector, _key| [t("enums.selectors.#{selector}"), selector] }
  end

  def options_for_actions
    Procedure.actions.map { |action, _key| [action.to_s.upcase, action] }
  end

  def options_for_repetititons
    Automation.repetitions.map { |repetition, _key| [t("enums.repetitions.#{repetition}"), repetition] }
  end

  def options_for_filling(automation)
    automation.procedures.map(&:position).compact
  end

  def options_for_groups
    Category.all.map { |category| [category.name, category.id] }
  end
end
