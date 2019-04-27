# Description
This is a checkout system implementation that calculates total price of items in a cart at checkout

# Running the program
cd to the root of the program from Terminal
enter the command 'irb main.rb'
Initialize a checkout class instance by entering 'checkout = Checkout.new(promotional_rules)
Promotional rules is a Hash object and an example is defined in the predefined_promotional_rules method in checkout.rb
Scan items by passing in an item hash. Follow command below
checkout.scan(item)
Item is a Hash object and an example of item can be obtained from predefined_items method in checkout.rb
checkout.total would return the total price after discount
