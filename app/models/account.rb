class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  after_create :generate_initial_deposit

  def generate_initial_deposit
    self.update(balance: rand(1000...3000))
  end
end
