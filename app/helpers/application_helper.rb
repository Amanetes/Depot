# frozen_string_literal: true

module ApplicationHelper

  def reset_counter
    session.delete(:counter)
  end
end
