# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @sign_in = SignInForm.new
  end

  def create
    @sign_in = SignInForm.new(params[:sign_in_form])

    if @sign_in.valid?
      sign_in @sign_in.account
      redirect_to params[:return_to] || root_path
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to new_session_path
  end
end
