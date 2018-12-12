require "pry"
# cart = [
#   {"AVOCADO" => {:price => 3.0, :clearance => true }},
#   {"AVOCADO" => {:price => 3.0, :clearance => true }},
#   {"KALE"    => {:price => 3.0, :clearance => false}}
# ]

# cart = {
#   "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
#   "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
# }
#
# coupons = {:item => "AVOCADO", :num => 2, :cost => 5.0}



def consolidate_cart(cart)
  cart.each_with_object({}) do |item, hash|
    item.each do |type, attribute|
      if hash[type]
        attribute[:count] += 1
      else
        attribute[:count] = 1
        hash[type] = attribute
      end
    end
  end
end

# def consolidate_cart(cart)
#   cart.each_with_object({}) do |item, hash|
#     hash[item]
# end


# consolidate_cart(cart)

# binding.pry

def apply_coupons(cart, coupons)
  coupon_cart_syntax = {}
  cart.each do |items, parameters|
    coupons.each do |coupon, data|
      # binding.pry
    if items == coupon[:item] && parameters[:count] >= coupons[:num]
      parameters[:count] -= coupons[:num]
        cart["#{items}" + " W/COUPON"] = {:price => coupons[:num], :clearance => parameters[:clearance], :count => 1}
      end
    end
  end
end


# apply_coupons(cart, coupons)



def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
