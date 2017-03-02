module OptionsHelper
  def options_for_browser_types
    Html::Browser::BROWSERS.map { |value| [I18n.t("enums.browser_types.#{value}"), value] }
  end
end
