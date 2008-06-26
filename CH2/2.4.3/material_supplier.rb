class SupplierInterface
end

class MaterialSupplier

  def execute_purchase(purchase_data)
    purchase_data.each do |purchase|
      product_id = SupplierInterface.search(purchase[:item_name])
      SupplierInterface.add_to_cart(product_id, purchase[:quantity])
    end
    
    SupplierInterface.purchase
  end

end
