require File.join(File.dirname(__FILE__), 'wmq_test_helper.rb')

class AccountsControllerTest < Test::Unit::TestCase
  include Test::Unit::WMQTest

  def setup
    @q_name = 'ACCOUNTS.CREATED'
    @attributes = { 'first_name'=>'John', 'last_name'=>'Smith',
                    'company'=>'ACME', 'email'=>'john@acme.com' }
  end

  def test_wmq_account_created
    post :create, :account=>@attributes
    wmq_check_message @q_name do |message|
      from_xml = Hash.from_xml(message.data)
      app = @account.merge('application'=>'test.host')
      assert_equal app, from_xml['account']
    end
  end

  def teardown
    wmq_empty_queues @q_name
  end

end
