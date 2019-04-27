class SpendingLimitDiscountCalculator

  attr_reader :rules,
              :total_amount

  def initialize(rules:, total_amount:)
    @rules = rules
    @total_amount = total_amount
  end

  def calculate
    return 0 unless valid?
    total_amount * discount_percentage
  end

  private

  def rules_present?
    rules[:spending_limit].present? && rules[:discount_percentage].present?
  end

  def amount_exceeds_spending_limit?
    total_amount >= rules[:spending_limit]
  end

  def valid?
    rules_present? && amount_exceeds_spending_limit?
  end

  def discount_percentage
    rules[:discount_percentage].fdiv(100)
  end
end