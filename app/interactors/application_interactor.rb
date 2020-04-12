# frozen_string_literal: true

class ApplicationInteractor
  include Interactor

  protected

  def handle_errors(errors)
    errors = errors.full_messages.map do |message|
      { message: message }
    end
    context.fail!(errors: errors)
  end
end
