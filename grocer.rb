def consolidate_cart(cart)
  new_hash = {}
  cart.each do |c|
    c.each do |food, info|
      if new_hash.keys.include?(food)
        new_hash[food][:count] += 1
      else
        new_hash[food] = {
          :price => info[:price],
          :clearance => info[:clearance],
          :count => 1
        }
      end
    end
  end

  new_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |c|
    if cart.keys.include?(c[:item])
      counter = 0
      while c[:num] < cart[c[:item]][:count]
        cart[c[:item]][:count] -= c[:num]
        cart["#{c[:item].upcase} W/COUPON"] = {
          :price => c[:cost],
          :clearance => cart[c[:item]][:clearance],
          :count => count += 1
        }
      end
    end
  end

  cart
end

def apply_clearance(cart)
  cart.each do |k, v|
    if cart[k][:clearance] == true
      new_cart = cart[k][:price] = cart[k][:price] * 0.8
      new_cart.round
    end
  end
end

def checkout(cart, coupons)
  # code here
end
