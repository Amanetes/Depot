# frozen_string_literal: true

class ApplicationMailbox < ActionMailbox::Base
  routing 'support@example.com' => :support
end
