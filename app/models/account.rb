# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user
  has_many :from_transactions, class_name: 'Transaction', foreign_key: :from_account_id, dependent: :destroy
  has_many :to_transactions, class_name: 'Transaction', foreign_key: :to_account_id, dependent: :destroy

  after_create :generate_initial_deposit

  def withdraw(amount)
    self.balance -= amount
    save
  end

  def deposit(amount)
    self.balance += amount
    save
  end

  private
  def generate_initial_deposit
    update(balance: rand(1000...3000))
  end
end
