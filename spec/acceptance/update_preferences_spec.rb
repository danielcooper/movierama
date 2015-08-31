require 'rails_helper'
require 'capybara/rails'
require 'support/pages/user'
require 'support/with_user'

RSpec.describe 'update preferences', type: :feature do

  let(:page) { Pages::User.new }

  context "when logged out" do

    it "does not show the user" do
      expect{ page.open }.to raise_error(CanCan::AccessDenied)
    end

  end

  context "when logged in" do
    with_logged_in_user
    before { page.open }

    it "allows notify me to be checked" do
      expect(page.notify_me).to_not be_checked
      page.notify_me.set(true)
      page.submit
      expect(page).to have_update_message
      expect(page.notify_me).to be_checked
    end
  end



end
