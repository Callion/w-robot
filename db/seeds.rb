# frozen_string_literal: true
puts 'GENERATING SCRIPT HASHES'
# Automated email
script1 = { 1 => "goto 'seznam.cz'",
            2 => "element(css: 'button.expander__button').click",
            3 => "text_field(placeholder: 'jméno').set 'TestingPurpose123@seznam.cz'",
            4 => "text_field(placeholder: 'heslo').set 'Password123'",
            5 => "element(xpath: '//div/div/div/div[1]/div[2]/div/div/div[4]/div[2]/div[1]/div/div[2]/div[1]/div/div/div[2]/div/div[2]/form/div[2]/div/button').click",
            6 => "element(css: 'a.wm-button').click",
            7 => "textarea(css: 'textarea').set 'MValda@seznam.cz'",
            8 => "textarea(xpath: '//div[4]/div[2]/div/div/div[2]/div[5]/textarea').set 'TEST'",
            9 => "element(xpath: '//div[4]/div[2]/div/div/div[2]/div[6]/span[17]').click",
            10 => "element(xpath: '//div[6]/div[2]/input[1]').click",
            11 => "textarea(class: 'editor-content').set 'Dobrý den! Tento email byl automaticky vygenerován webovým robotem! Mazec Wau!'",
            12 => "element(xpath: '//div[4]/div[2]/div/div/div[4]/div/a[1]').click" }

puts 'CREATING AUTOMATIONS'

automation = Automation.create(name: 'Automatický email', active: true, browser_type: 'chrome')

puts 'ADDING PROCEDURES'

script1.keys.each do |key|
  Procedure.create(automation_id: automation.id, position: key, script: script1[key], broken: nil)
end

puts 'DB SUCCESSFULLY SEEDED'
