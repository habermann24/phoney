require 'phoney/test_helper'

class NIRegionTest < MiniTest::Unit::TestCase
  def setup
    Phoney.region = "ni"
  end
  
  def test_international_dialing_with_trunk_prefix
     assert_equal "+505 0", Phoney::Parser.parse("+5050")
     assert_equal "+505 0234 5678", Phoney::Parser.parse("+50502345678")
     assert_equal "+505 (0) 2345 6789", Phoney::Parser.parse("+505023456789")
     assert_equal "+505 (0) 234567891", Phoney::Parser.parse("+5050234567891")
  end
end