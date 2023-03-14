# frozen_string_literal: true

class AccountsSerializer
  include JSONAPI::Serializer
  attribute :name, :user_id, :balance
end
