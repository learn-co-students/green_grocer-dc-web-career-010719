def consolidate_cart(cart)
  # code here
  consolidated_cart = {}

  cart.each do |item|
    item.each do |food, info|
      if !consolidated_cart.key?(food)
        consolidated_cart[food] = info
        consolidated_cart[food][:count] = 1
      else
        consolidated_cart[food][:count] += 1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |item|
    if cart.key?(item[:item])
      count = 0
      until item[:num] > cart[item[:item]][:count]
        cart[item[:item]][:count] -= item[:num]
        cart["#{item[:item]} W/COUPON"] = {price: item[:cost], clearance: cart[item[:item]][:clearance], count: count += 1}
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |food, info|
    if cart[food][:clearance]
      cart[food][:price] = (cart[food][:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart_total = 0
  cart.each do |food, info|
    if cart[food][:count] > 0
      cart_total += (cart[food][:price] * cart[food][:count])
    end
  end
  if cart_total > 100
    cart_total = (cart_total * 0.9).round(2)
  else
    cart_total
  end
end
