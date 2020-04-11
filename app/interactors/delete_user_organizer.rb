# frozen_string_literal: true

class DeleteUserOrganizer
  include Interactor::Organizer

  organize DeleteUser, Cognito::DeleteUser
end
