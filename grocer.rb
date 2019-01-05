require "pry"


def consolidate_cart(cart)
  groceries = []

  cart.map{ |item| item.keys }.flatten.each { |grocery| groceries << grocery }

  cons_cart = {}

  cart.collect { |item|
    item.values[0][:count] = groceries.count(item.keys[0])
    cons_cart[item.keys[0]] = item.values[0]
  }

  cons_cart
end



def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      on_clearance = nil
      coupon_count = 0
      cart.collect { |grocery, info|
        while coupon[:item] == grocery && info[:count] >= coupon[:num]
          info[:count] = info[:count] - coupon[:num]
          on_clearance = info[:clearance]
          coupon_count = coupon_count + 1
        end
      }
      if on_clearance != nil
        cart["#{coupon[:item]} W/COUPON"] = {:price => coupon[:cost], :clearance => on_clearance, :count => coupon_count}
      end
    end
    cart
  end
  cart
end



def apply_clearance(cart)
  cart.collect { |grocery, info|
    if info[:clearance] == true
      info[:price] = (info[:price] * 0.8).round(2)
    end
  }
  cart
end



def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  cart_total = 0
  cart.map { |item, info|
    if info[:count] > 0
      cart_total = cart_total + (info[:price]*info[:count])
    end }
  if cart_total > 100
    cart_total = (cart_total * 0.9).round(2)
  else
    cart_total = cart_total.round(2)
  end
  cart_total
end
