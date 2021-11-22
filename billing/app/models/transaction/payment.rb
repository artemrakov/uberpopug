class Transaction::Payment < Transaction
  validates_with Transaction::PaymentValidator

  def description
    data['description']
  end

  def transactions
    @transactions ||= Transaction.where(ids: data['transaction_ids'])
  end

  def account
    @account ||= Account.find_by(id: data['account_id'])
  end

  def billing_cycle
    @billing_cycle ||= BillingCycle.find_by(id: data['billing_cycle_id'])
  end

  def employee_public_id
    data['employee_public_id']
  end

  class Transaction::PaymentValidator < ActiveModel::Validator
    def validate(record)
      validation = data_schema.call(record[:data])

      return if validation.success?

      validation.errors.to_h.each do |key, value|
        record.errors.add key, value.join(', ')
      end
    end

    def data_schema
      Dry::Schema.Params do
        required(:description).filled(:string)
        required(:transaction_ids).filled(:string)
        required(:employee_public_id).filled(:string)
        required(:account_id).filled(:integer)
        required(:billing_cycle_id).filled(:integer)
      end
    end
  end
end
