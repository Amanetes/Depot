# frozen_string_literal: true

class SupportMailbox < ApplicationMailbox
  def process
    recent_order = Order.where(email: mail.from_address.to_s)
                        .order(created_at: :desc)
                        .first
    SupportRequest.create!(
      email: mail.from_address.to_s,
      subject: mail.subject,
      body: mail.body.to_s,
      order: recent_order
    )
    # Rails.logger.debug 'START SupportMailbox#process:'
    # Rails.logger.debug { "From : #{mail.from_address}" }
    # Rails.logger.debug { "Subject: #{mail.subject}" }
    # Rails.logger.debug { "Body : #{mail.body}" }
    # Rails.logger.debug 'END SupportMailbox#process:'
  end
end
