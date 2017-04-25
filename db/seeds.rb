# frozen_string_literal: true
puts 'CREATING TEST USER'
user = User.new
user.email = 'test@example.com'
user.password = 'test123'
user.password_confirmation = 'test123'
user.save!

puts 'GENERATING SCRIPT HASHES'
# Automated email
script1 = [
  { position: 1, action: :goto, input: 'seznam.cz' },
  { position: 2, category: :element, selector: :css, path: 'button.expander__button', action: :click },
  { position: 3, category: :text_field, selector: :placeholder, path: 'jméno', action: :set, input: 'TestingPurpose123@seznam.cz' },
  { position: 4, category: :text_field, selector: :placeholder, path: 'heslo', action: :set, input: 'Password123' },
  { position: 5, category: :button, selector: :klass, path: 'button button--submit button--with-input input-w-button__button', action: :click },
  { position: 6, category: :element, selector: :xpath, path: '//div/nav/div/a[2]', action: :click },
  { position: 7, category: :element, selector: :xpath, path: '//section/div[2]/dl/div[2]/dd/div/input', action: :send_keys, input: 'MValda@seznam.cz' },
  { position: 8, category: :element, selector: :xpath, path: '//section/div[2]/dl/div[5]/dd/input', action: :send_keys, input: 'TEST' },
  { position: 9, category: :element, selector: :xpath, path: '//section/div[2]/div[1]/button', action: :click },
  { position: 10, category: :element, selector: :xpath, path: '//div[5]/div/button[1]', action: :click },
  { position: 11, category: :textarea, selector: :xpath, path: '//section/div[2]/div[2]/div[1]/textarea', action: :set, input: 'Dobrý den! Tento email byl automaticky vygenerován webovým robotem! Mazec Wau!' },
  { position: 12, category: :element, selector: :xpath, path: '//section/div[3]/button[1]', action: :click }
]

# Forecast sms
script2 = [
  { position: 1, action: :goto, input: 'http://pocasi.idnes.cz' },
  { position: 2, category: :div, selector: :klass, path: 'art text-forecast', action: :text, fill_into: 4 },
  { position: 3, action: :goto, input: 'poslatsms.cz' },
  { position: 4, category: :textarea, selector: :id, path: 'textsms', action: :set },
  { position: 5, category: :text_field, selector: :klass_name, path: 'cislo-prijemce', action: :set, input: '775191055' },
  { position: 6, category: :element, selector: :id, path: 'odeslat-sms', action: :click }
]

puts 'CREATING AUTOMATIONS'

automation1 = Automation.create(name: 'Zaslání emailu', active: true, browser_type: 'chrome', user_id: user.id)
automation2 = Automation.create(name: 'Předpověd počasí', active: true, browser_type: 'phantomjs', user_id: user.id)

puts 'ADDING PROCEDURES'

script1.each do |procedure|
  automation1.procedures.create(procedure)
end

script2.each do |procedure|
  automation2.procedures.create(procedure)
end

puts 'DB SUCCESSFULLY SEEDED'
puts 'for login - username: test@example.com  //  password: test123'
