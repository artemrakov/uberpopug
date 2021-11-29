# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_account!, only: :index

  def index
    @accounts = Account.all
  end

  def new
    @account = Account::SignUpForm.new
  end

  def create
    @account = AccountMutator.create(params[:account_sign_up_form])

    if @account.persisted?
      sign_in @account

      redirect_to params[:return_to] || root_path
    else
      render :new
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    result = AccountMutator.update(@account, account_params)

    if result
      redirect_to root_path
    else
      render :edit
    end
  end

  def set_role
    @account = Account.find(params[:id])
    result = AccountMutator.set_role(@account, account_params[:role])

    if result
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @account = Account.find(params[:id])
    AccountMutator.destroy(@account)

    redirect_to root_path
  end

  private

  def account_params
    params.require(:account).permit(:full_name, :role, :email)
  end
end
