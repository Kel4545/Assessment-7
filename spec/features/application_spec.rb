require 'spec_helper'

feature 'Homepage' do
  scenario 'Shows the welcome message' do
    visit '/'

    expect(page).to have_content 'Welcome!'

  end
end

feature "user goes to homepage" do
  scenario "User types in message" do
    visit 'homepage'
    fill_in "username", with: "kelly"
    fill_in "Message", with: "Yay"
    click_button("Add Message")
  end
end

feature "other messages list" do
  scenario "User can see their message and other users and messages" do
    create_user("kelly")
    create_user("sparklepony")
    expect(page).to have_content("kelly")
    expect(page).to have_content("sparklepony")
    expect(page).to have_content("message")
    expect(page).to have_content("message")
  end
end
