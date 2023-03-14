# frozen_string_literal: true

class TransactionsSerializer
  include JSONAPI::Serializer
  attribute :from_account_id, :to_account_id, :amount
end
