# frozen_string_literal: true

class Api::V1::AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:balance, :transactions]

  def create
    account = current_user.accounts.new(account_params)

    if account.save
      render_api_success(serializer, account)
    else
      render_api_error(account.errors.full_messages, :unprocessable_entity)
    end
  end

  def balance
    if @account
      render_api_success(serializer, @account)
    else
      render_api_error(account.errors.full_messages, :not_found)
    end
  end

  def transactions
    if @account
      render_api_success(transaction_serializer, @account.from_transactions)
    else
      render_api_error(account.errors.full_messages, :not_found)
    end
  end

  def transfer
    from_account = current_user.accounts.find(params[:id])
    to_account = Account.find(params[:to_account_id])

    amount = params[:amount].to_f

    transaction = Transaction.new(
      from_account: from_account,
      to_account: to_account,
      amount: amount
    )

    if transaction.save
      from_account.withdraw(amount)
      to_account.deposit(amount)
      render_api_success(transaction_serializer, transaction)
    else
      render_api_error(transaction.errors.full_messages, :unprocessable_entity)
    end
  end

  private

  def serializer
    AccountsSerializer
  end

  def transaction_serializer
    TransactionsSerializer
  end

  def set_account
    @account = current_user.accounts.find_by!(id: params[:id])
  end

  def account_params
    params.except(:json).permit(:name)
  end
end
