# Description
This is a checkout system implementation that calculates total price of items in a cart at checkout

# Running the program
1. cd to the root of the program from Terminal 
2. enter the command 'irb main.rb'
3. Initialize a checkout class instance by entering 'checkout = Checkout.new(promotional_rules)
4. Promotional rules is a Hash object and an example is defined in the predefined_promotional_rules method in checkout.rb
5. Scan items by passing in an item hash. Follow command below
6. checkout.scan(item)
7. Item is a Hash object and an example of item can be obtained from predefined_items method in checkout.rb
8. checkout.total would return the total price after discount
