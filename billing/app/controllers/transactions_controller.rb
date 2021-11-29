class TransactionsController < ApplicationController
  before_action :authenticate_account!

  def index
    @transactions = Transaction.all
  end
end
