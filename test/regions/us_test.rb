require 'phoney/test_helper'

class USRegionTest < MiniTest::Unit::TestCase
  def setup
    PhoneNumber.region = :us
  end
  
  def test_format_phone_number
    assert_equal "568-9780", PhoneNumber::Parser.parse("5689780")
    assert_equal "(704) 568-9780", PhoneNumber::Parser.parse("7045689780")
    assert_equal "1 (704) 568-9780", PhoneNumber::Parser.parse("17045689780")
  end
  
  def test_as_you_type_formatting
    assert_equal "+1 (7  )", PhoneNumber::Parser.parse("+17")
    assert_equal "+1 (71 )", PhoneNumber::Parser.parse("+171")
    assert_equal "+1 (712)", PhoneNumber::Parser.parse("+1712")
    assert_equal "+1 (712) 34", PhoneNumber::Parser.parse("+171234")
    assert_equal "+1 (712) 345", PhoneNumber::Parser.parse("+1712345")
    assert_equal "+1 (712) 345-6", PhoneNumber::Parser.parse("+17123456")
  end
  
  def test_international_incomplete_number_with_trunk_prefix
    assert_equal "+1 (1) (7  )", PhoneNumber::Parser.parse("+1171")
  end
  
  def test_fallback_for_invalid_phone_number
    # the number is too long for [:us]
    assert_equal "+1 704123456789", PhoneNumber::Parser.parse("+1704123456789")
    assert_equal "123456789012", PhoneNumber::Parser.parse("123456789012")
  end
end