require 'test_helper'

class BaseTest < Minitest::Test
  def setup
    @helper = Tamebou::Helpers::Base.new({})
  end

  def test_expected_values
    assert_equal ["YOU SHOULD ADD EXPECTED VALUES BY YOUR OWN"], @helper.expected_values
  end

  def unexpected_values
    assert_equal ["YOU SHOULD ADD EXPECTED VALUES BY YOUR OWN"], @helper.unexpected_values
  end
end
