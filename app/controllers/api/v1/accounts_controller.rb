# frozen_string_literal: true

class Api::V1::AccountsController < ApplicationController
  before_action :authenticate_user!

  def create
    account = current_user.accounts.new(account_params)
    account.balance = rand(1000...3000)

    if account.save
      render_api_success(serializer, account)
    else
      render_api_error(account.errors.full_messages, 422)
    end
  end

  def balance
    account = current_user.accounts.find(params[:id])

    if account
      render_api_success(serializer, account)
    else
      render_api_error(account.errors.full_messages, 404)
    end
  end

  def transactions
    account = current_user.accounts.find(params[:id])
    transactions = account.transactions
    render json: transactions
  end

  # def transfer
  #   from_account = current_user.accounts.find(params[:id])
  #   to_account = Account.find(params[:to_account_id])

  #   amount = params[:amount].to_f

  #   from_account.withdraw(amount)
  #   to_account.deposit(amount)

  #   transaction = Transaction.create!(
  #     from_account: from_account,
  #     to_account: to_account,
  #     amount: amount
  #   )

  #   render json: transaction, status
  # end

  private

  def serializer
    AccountsSerializer
  end

  def account_params
    params.except(:json).permit(:name)
  end
end
