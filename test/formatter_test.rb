require 'phoney/test_helper'

class FormatterTest < MiniTest::Unit::TestCase
  include PhoneNumber::Formatter
  
  def setup
    PhoneNumber.region = 'us'
  end
  
  def test_international_call_prefix_for_us_region
    assert_equal "0", international_call_prefix_for("0")
    assert_equal "01", international_call_prefix_for("01")
    assert_equal "011", international_call_prefix_for("011")
    assert_equal "011", international_call_prefix_for("011999")
    assert_equal nil, international_call_prefix_for("123")
  end
  
  def test_international_call_prefix_for_br_region
    assert_equal "+00", international_call_prefix_for("+0055123", region: PhoneNumber::Region["br"])
    assert_equal "00 55", international_call_prefix_for("0055123", region: PhoneNumber::Region["br"])
    assert_equal "00 12", international_call_prefix_for("0012456", region: PhoneNumber::Region["br"])
    assert_equal nil, international_call_prefix_for("03001234567", region: PhoneNumber::Region["br"])
  end
  
  def test_international_call_prefix_with_plus_sign
    assert_equal "+", international_call_prefix_for("+011")
    assert_equal "+", international_call_prefix_for("+123")
    assert_equal "+", international_call_prefix_for("+")
  end
  
  def test_international_calling_prefix_for_empty_number
    assert_equal nil, international_call_prefix_for("")
  end
  
  def test_country_code_extraction
    assert_equal "49", extract_country_code("+49")
    assert_equal "49", extract_country_code("01149")
    assert_equal "49", extract_country_code("01149123456")
    assert_equal nil, extract_country_code("03001234567", region: PhoneNumber::Region["br"])
  end
  
  def test_nonexisting_country_code
    assert_equal nil, extract_country_code("+99")
  end
  
  def test_trunk_prefix_extraction
    assert_equal "1", extract_trunk_prefix("+117041234567")
    assert_equal "0", extract_trunk_prefix("+49040")
    assert_equal nil, extract_trunk_prefix("+1705")
    assert_equal nil, extract_trunk_prefix("+1")
    assert_equal nil, extract_trunk_prefix("+4940")
  end
end