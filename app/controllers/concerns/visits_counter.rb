# frozen_string_literal: true

module VisitsCounter
  private

  def count_visits
    session[:counter] ||= 0
    session[:counter] += 1
    @session_counter = session[:counter]
  end

  def reset_counter
    session.delete(:counter)
  end
end
