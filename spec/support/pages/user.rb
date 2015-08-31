require 'capybara/rspec'
require 'support/pages/shared'

module Pages
  class User
    include Capybara::DSL
    include Pages::Login

    def open
      visit('/user')
    end

    def notify_me
      find("input[name=notify_me]")
    end

    def submit
      click_on('Save')
    end

    def has_update_message?
      page.has_content?('Preferences updated')
    end

  end
end
