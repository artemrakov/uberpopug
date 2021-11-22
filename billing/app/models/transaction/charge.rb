class Transaction::Charge < Transaction
  validates_with Transaction::ChargeValidator

  class Transaction::ChargeValidator < ActiveModel::Validator
    def validate(record)
      validation = data_schema.call(record[:data])

      return if validation.success?

      validation.errors.to_h.each do |key, value|
        record.errors.add key, value.join(', ')
      end
    end

    def data_schema
      Dry::Schema.Params do
        required(:task_public_id).filled(:string)
        required(:task_id).filled(:integer)
        required(:description).filled(:string)
        required(:employee_public_id).filled(:string)
        required(:account_id).filled(:integer)
      end
    end
  end
end
