class ProductDiscountCalculator

  attr_reader :rules,
              :items_list

  def initialize(rules:, items_list:)
    @rules = rules
    @items_list = items_list
  end

  def calculate
    return 0 unless valid?
    discount_list.sum
  end

  private

  def valid?
    rules.present? && discount_list.present?
  end


  def grouped_product
    items_list.group_by{|s| s[:product_code]}.map{|k,v| {:product_code => k,
                                                         :price => v[0][:price],
                                                         :count => v.count}}
  end

  def marked_products_for_discount
    grouped_product.map{|product| mark_product(product) if product_eligible_for_discount?(product)}.compact
  end

  def product_eligible_for_discount?(product)
    discount_rule(product).present? && product_has_sufficient_quantity?(product)
  end

  def discount_rule(product)
    rules.find{|rule| rule[:product_code] == product[:product_code]}
  end

  def product_has_sufficient_quantity?(product)
    product[:count] >= discount_rule(product)[:min_quantity]
  end

  def mark_product(product)
    {
      product_code: product[:product_code],
      original_price: product[:price],
      discounted_price: discount_rule(product)[:discounted_price],
      count: product[:count]
    }
  end

  def discount_list
    return [] unless marked_products_for_discount.present?
    marked_products_for_discount.map{|product| calculate_discount(product)}
  end

  def calculate_discount(product)
    (product[:original_price] - product[:discounted_price]) * product[:count]
  end
end