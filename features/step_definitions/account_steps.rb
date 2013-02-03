When /^I create an account with "(.*?)" and "(.*?)"$/ do |username, password|
  visit '/'
  click_link 'Sign up'
  fill_in 'user_email', with: username
  fill_in 'user_password', with: password
  fill_in 'user_password_confirmation', with: password
  click_button 'Sign up'
end

When /^I sign out$/ do
  page.driver.submit :delete, '/users/sign_out', {}
end

When /^I sign in with "(.*?)" and "(.*?)"$/ do |username, password|
  visit '/users/sign_in'
  fill_in 'user_email', with: username
  fill_in 'user_password', with: password
  click_button 'Sign in'
end
