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
      redirect_to root_path
    else
      render :new
    end
  end
end
