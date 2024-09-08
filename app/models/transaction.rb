class Transaction < ApplicationRecord
  belongs_to :investment_account

  def transaction_type
    if amount >= 0
      'contribution'
    else
      'withdrawal'
    end
  end

  def dollars
    amount / 100
  end

end
