require 'test/unit'
require 'material_supplier'


class SupplierInterface
  @@products = {
    1234 => 'Red Rug',
    5678 => 'Ergonomic Chair',
    9012 => 'Set of Pens'
  }

  @@cart = {}
  
  def self.search(product_name)
    @@products.index(product_name)
  end
  
  def self.add_to_cart(id, quantity)
    @@cart[id] = quantity
  end
  
  def self.purchase
    true if @@cart.length > 0
  end
end


class TestSupplierInterface < Test::Unit::TestCase

  def test_execute_purchase
    data = [
      {:item_name => 'Red Rug', :quantity => 2}, 
      {:item_name => 'Set of Pens', :quantity => 17}
    ]

    my_supplier = MaterialSupplier.new
    assert my_supplier.execute_purchase(data)
  end

end
