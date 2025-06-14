require "rails_helper"

RSpec.feature "Climb Logs", type: :feature do
  scenario "groups in days shwoing today" do
    user = FactoryBot.create(:user)
    FactoryBot.create(:climb_log, :today, user: user)
    login_as(user)

    # Session will now be authenticated
    visit root_path

    expect(page).to have_text("Today")
  end
  scenario "groups in days showing yesterday" do
    user = FactoryBot.create(:user)
    FactoryBot.create(:climb_log, :yesterday, user: user)
    login_as(user)

    # Session will now be authenticated
    visit root_path

    expect(page).to have_text("Yesterday")
    expect(page).not_to have_text("Today")
  end
  scenario "groups in days showing exact date" do
    user = FactoryBot.create(:user)
    climb_log = FactoryBot.create(:climb_log, user: user)
    login_as(user)

    # Session will now be authenticated
    visit root_path

    expect(page).to have_text(climb_log.date)
  end
end
