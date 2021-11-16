class CredentialsController < ApplicationController
  before_action :doorkeeper_authorize!

  def account
    @account = Account.find(doorkeeper_token.resource_owner_id)
  end
end
