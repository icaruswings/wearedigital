# Define the products that should trigger hiding Afterpay
# Product IDs or product SKU codes can be used here
products_that_hide_afterpay = [
    "SKU00001"
]

# Check if the cart contains any of the specified products
def contains_line_item?(cart, ids_or_skus)
  cart.line_items.any? do |item|
    item.variant.skus.any? { |sku| ids_or_skus.include?(sku) } ||
    ids_or_skus.include?(item.variant.id)
  end
end

# Main script logic
Output.payment_gateways = Input.payment_gateways.delete_if do |payment_gateway|
  payment_gateway.name == "Afterpay" && contains_line_item?(Input.cart, products_that_hide_afterpay)
end
