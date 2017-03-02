module OptionsHelper
  def options_for_browser_types
    Html::Browser::BROWSERS.map { |value| [I18n.t("activerecord.enums.browser_types.#{value}"), value] }
  end
end
