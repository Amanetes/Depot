# frozen_string_literal: true

class ProductsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'products'
  end

  # Каналы могут иметь последствия для безопасности, поэтому по умолчанию Rails разрешает доступ только с localhost при работе в режиме разработки.
  # Если вы ведете разработку на нескольких машинах, вы должны отключить эту проверку.

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
