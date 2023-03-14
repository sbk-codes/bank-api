# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :from_account, class_name: 'Account'
  belongs_to :to_account, class_name: 'Account'

  validate :sufficient_balance

  private

  def sufficient_balance
    if from_account.balance < amount
      errors.add(:base, 'Insufficient balance')
    end
  end
end
