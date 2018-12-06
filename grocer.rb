require 'pry'

def consolidate_cart(cart)
  consolidated_cart = {}

  cart.each do |cart_item_hash|
    cart_item_hash.each do |item_name, item_info|
      if consolidated_cart.key?(item_name)
        consolidated_cart[item_name][:count] += 1
      else
        consolidated_cart[item_name] = item_info
        consolidated_cart[item_name][:count] = 1
      end
    end
  end

  consolidated_cart
end

def apply_coupons(cart, coupons)
  cart_changes = {}
  coupons = [coupons] if coupons.class != Array

  cart.each do |item_name, item_info|
    coupons.each do |coupon|
      if item_name == coupon[:item] && item_info[:count] >= coupon[:num]
        item_info[:count] -= coupon[:num]
        couponed_item_name = "#{item_name} W/COUPON"

        if cart_changes.key?(couponed_item_name)
          cart_changes[couponed_item_name][:count] += 1
        else
          cart_changes[couponed_item_name] = {
            price: coupon[:cost],
            clearance: item_info[:clearance],
            count: 1
          }
        end
      end
    end
  end

  cart.merge(cart_changes)
end

def apply_clearance(cart)
  cart.each do |item_name, item_info|
    item_info[:price] = ((item_info[:price] * 0.8)).round(2) if item_info[:clearance]
  end
end

def total(cart)
  total = 0

  cart.each do |item_name, item_info|
    total += item_info[:price] * item_info[:count]
  end

  (total = total * 0.9).round(2) if total > 100
  total
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total(cart)
end
