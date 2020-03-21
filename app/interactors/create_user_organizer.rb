# frozen_string_literal: true

class CreateUserOrganizer
  include Interactor::Organizer

  organize Cognito::CreateUser, CreateUser
end
