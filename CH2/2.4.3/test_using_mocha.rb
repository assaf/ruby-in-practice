require 'rubygems'
require 'test/unit'
require 'mocha'
require 'material_supplier'

class TestSupplierInterface < Test::Unit::TestCase

  def test_execute_purchase
    data = [
      {:item_name => 'Red Rug', :quantity => 2}, 
      {:item_name => 'Set of Pens', :quantity => 17}
    ]
    
    my_supplier = MaterialSupplier.new
    
    SupplierInterface.expects(:search).with('Red Rug').returns(1234)
    SupplierInterface.expects(:add_to_cart).with(1234, 2)

    SupplierInterface.expects(:search).with('Set of Pens').returns(9012)
    SupplierInterface.expects(:add_to_cart).with(9012, 17)
                                                                     
    SupplierInterface.expects(:purchase).returns(true)
    
    assert my_supplier.execute_purchase(data)
  end

end
