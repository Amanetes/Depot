# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  after_destroy :ensure_an_admin_remains
  has_secure_password

  class Error < StandardError
  end

  private

  # Ключевой концепцией является использование исключения для указания ошибки при удалении пользователя.
  # Это исключение служит двум целям. Во-первых, поскольку оно возникает внутри транзакции, оно вызывает автоматический откат.
  # Подняв исключение, если таблица users пуста после удаления, мы отменяем удаление и восстанавливаем последнего пользователя.
  # Во-вторых, исключение сигнализирует об ошибке обратно в контроллер, где мы используем блок rescue_from для ее обработки и сообщаем об ошибке пользователю в уведомлении.

  def ensure_an_admin_remains
    if User.count.zero?
      raise Error, "Can't delete the last user"
    end
  end
end
