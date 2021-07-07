def consolidate_cart(cart)
  new_cart = {}

  cart.each do |item|
    item.each do |key, value|
      if new_cart.keys.include?(key) == false
        new_cart[key] = value
        new_cart[key][:count] = 1
      else
        new_cart[key][:count] += 1
      end
    end
  end

  new_cart
end

def apply_coupons(cart, coupons)
  new_cart = cart
  coupons.each do |coupon|
    if new_cart.keys.include?(coupon[:item])
      count = 0
      until coupon[:num] > new_cart[coupon[:item]][:count]
        new_cart[coupon[:item]][:count] -= coupon[:num]
        new_cart["#{coupon[:item].upcase} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => new_cart[coupon[:item]][:clearance],
          :count => count += 1
        }
      end
    end
  end
  
  cart
end

def apply_clearance(cart)
  cart.each do |food, values|
    if cart[food][:clearance]
      price = cart[food][:price] * 0.8
      cart[food][:price] = price.round(2)
    end
  end
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  new_cart = apply_coupons(new_cart, coupons)
  new_cart = apply_clearance(new_cart)
  total = 0

  new_cart.each do |food, values|
    if new_cart[food][:count] > 0
      total += new_cart[food][:price] * new_cart[food][:count]
    end
  end
  
  if total > 100
    price = total * 0.9
    total = price.round(2)
  else
    total
  end
end
