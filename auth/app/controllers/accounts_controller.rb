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
    @account = Account::SignUpForm.new(params[:account_sign_up_form])

    if @account.save
      sign_in @account

      event = AccountEvent.created(@account)
      WaterDrop::SyncProducer.call(event.to_json, topic: 'accounts-stream')
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

    if @account.update(account_params)
      event = AccountEvent.updated(@account)
      WaterDrop::SyncProducer.call(event.to_json, topic: 'accounts-stream')

      redirect_to root_path
    else
      render :edit
    end
  end

  def set_role
    @account = Account.find(params[:id])

    if @account.update(role: account_params[:role])

      event = AccountEvent.role_changed(@account)
      WaterDrop::SyncProducer.call(event.to_json, topic: 'accounts')
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.mark_as_removed!

    event = AccountEvent.deleted(@account)
    WaterDrop::SyncProducer.call(event.to_json, topic: 'accounts-stream')

    redirect_to root_path
  end

  private

  def account_params
    params.require(:account).permit(:full_name, :role, :email)
  end
end
