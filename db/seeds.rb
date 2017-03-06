# frozen_string_literal: true
puts 'CREATING TEST USER'
user = User.new
user.email = 'test@example.com'
user.password = 'test123'
user.password_confirmation = 'test123'
user.save!

puts 'GENERATING SCRIPT HASHES'
# Automated email no. 1
script1 = { 1 => "goto 'seznam.cz'",
            2 => "element(css: 'button.expander__button').click",
            3 => "text_field(placeholder: 'jméno').set 'TestingPurpose123@seznam.cz'",
            4 => "text_field(placeholder: 'heslo').set 'Password123'",
            5 => "button(class: 'button button--submit button--with-input input-w-button__button').click",
            6 => "element(css: 'a.wm-button').click",
            7 => "textarea(css: 'textarea').set 'MValda@seznam.cz'",
            8 => "textarea(xpath: '//div[4]/div[2]/div/div/div[2]/div[5]/textarea').set 'TEST'",
            9 => "element(xpath: '//div[4]/div[2]/div/div/div[2]/div[6]/span[17]').click",
            10 => "element(xpath: '//div[6]/div[2]/input[1]').click",
            11 => "textarea(class: 'editor-content').set 'Dobrý den! Tento email byl automaticky vygenerován webovým robotem! Mazec Wau!'",
            12 => "element(xpath: '//div[4]/div[2]/div/div/div[4]/div/a[1]').click" }

script2 = { 1 => "goto 'http://pocasi.idnes.cz'",
            2 => "div(class: 'art text-forecast').select_text browser.div(class: 'art text-forecast').text.lines[1]",
            3 => "send_keys [:control, 'c']",
            4 => "goto 'poslatsms.cz'",
            5 => "textarea(id: 'textsms').set 'Předpověd na datum: '",
            6 => "textarea(id: 'textsms').append (Time.zone.now + 1.day).to_date",
            7 => "textarea(id: 'textsms').append ' - '",
            8 => "textarea(id: 'textsms').send_keys [:control, 'v']",
            9 => "text_field(name: 'cislo-prijemce').set '775191055'",
            10 => "element(id: 'odeslat-sms').click",
            11 => "element(id: 'odeslat-sms').wait_while_present" }

puts 'CREATING AUTOMATIONS'

automation1 = Automation.create(name: 'Zaslání emailu', active: true, browser_type: 'chrome', user_id: user.id)
automation2 = Automation.create(name: 'Předpověd počasí', active: true, browser_type: 'phantomjs', user_id: user.id)

puts 'ADDING PROCEDURES'

script1.keys.each do |key|
  Procedure.create(automation_id: automation1.id, position: key, script: script1[key])
end

script2.keys.each do |key|
  Procedure.create(automation_id: automation2.id, position: key, script: script2[key])
end

puts 'DB SUCCESSFULLY SEEDED'
puts 'for login - username: test@example.com  //  password: test123'
