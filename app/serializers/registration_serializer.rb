# frozen_string_literal: true

class RegistrationSerializer
  include JSONAPI::Serializer
  attributes :name, :email
end
