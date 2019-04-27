require_relative './spending_limit_discount_calculator'
require_relative './product_discount_calculator'

class Checkout

  attr_reader :promotional_rules
  attr_accessor :items_list

  #promotional_rules hash to be passed in
  def initialize(promotional_rules=nil)
    @promotional_rules = promotional_rules || predefined_promotional_rules
    @items_list = []
  end

  # item hash to be passed in
  def scan(item=nil)
    scanned_item = item || predefined_items.sample
    items_list << scanned_item
  end

  def total
    return total_price unless promotional_rules.present?
    (total_after_product_discount - spending_limit_discount).round(2)
  end

  private

  def spending_limit_discount
    sld_calculator = SpendingLimitDiscountCalculator.new(rules: promotional_rules[:spending_limit_discount],
                                                         total_amount: total_after_product_discount)
    sld_calculator.calculate
  end

  def product_discount
    pd_calculator = ProductDiscountCalculator.new(rules: promotional_rules[:product_discount],
                                                  items_list: items_list)
    pd_calculator.calculate
  end

  def total_after_product_discount
    total_price - product_discount
  end

  def total_price
    items_list.sum{|s| s[:price]}
  end

  def predefined_promotional_rules
    {
      spending_limit_discount: {
        spending_limit: 60,
        discount_percentage: 10
      },
      product_discount: [
        {
          product_code: '001',
          discounted_price: 8.50,
          min_quantity: 2
        }
      ]
    }
  end

  def predefined_items
    [
      {
        product_code: '001',
        name: 'Lavender Heart',
        price: 9.25
      },
      {
        product_code: '002',
        name: 'cufflinks',
        price: 45.00
      },
      {
        product_code: '001',
        name: 'Lavender Heart',
        price: 9.25
      },
      {
        product_code: '003',
        name: 'Kids t-shirt',
        price: 19.95
      }
    ]
  end
end

