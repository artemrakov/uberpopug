require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    get root_path
    assert_response :success
  end

  test 'new' do
    get new_account_path
    assert_response :success
  end

  test 'create' do
    account_params = { email: 'test@one.com', password: '123123' }

    post accounts_path, params: { account_sign_up_form: account_params }

    assert { Account.find_by(email: account_params[:email]) }
  end
end
