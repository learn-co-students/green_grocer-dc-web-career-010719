def consolidate_cart(cart)
  cart.each_with_object({}) do |item, result|
    item.each do |type, attr|
      if result[type]
        attr[:count] += 1
      else
        attr[:count] = 1
        result[type] = attr
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |name, attr|
    if attr[:clearance]
      new_price = attr[:price] * 0.8
      attr[:price] = new_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated, coupons)
  final_cart = apply_clearance(coupon_cart)
  total = 0
  final_cart.each do |name, attr|
    total += attr[:price] * attr[:count]
  end
  total = total * 0.9 if total > 100
  total
end
