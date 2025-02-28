# AcObject
Wraps JSON data with convenience methods and indifferent access. Heavily inspired by Stripe's `StripeObject`.
```ruby
json_data = JSON.parse(response_body)
product = AcObject.new(json_data)

# Access properties with dot notation
product.title
# => "Kit C/100 Envelope Embalagem Segurança"
product.price
# => 58.47

# Nested objects are automatically wrapped
product.pictures.first.size
# => "500x422"

# Indifferent access
product[:site_id]
# => "MLB"
product["site_id"]
# => "MLB"

# Does not override core methods
special = AcObject.new({"class" => "VIP", "inspect" => "custom view"})

special[:class]
# => "VIP"
special[:inspect]
# => "custom view"

special.class
# => AcObject

puts special.inspect
# prints
# #<AcObject:0xef0> JSON: {
#   "class": "VIP",
#   "inspect": "custom view"
# }
```
