# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
  end

  def create
  end

  def destroy
    sign_out
    redirect_to new_session_path
  end
end
