require 'test_helper'

class PresenceTest < Minitest::Test
  def test_expected_values
    test_cases = [
      { condition: false, result: [nil, "presence"] },
      { condition: true,  result: ["presence"] },
    ]

    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Presence.new(test_case[:condition])
      assert_equal test_case[:result], helper.expected_values
    end
  end

  def test_unexpected_values
    test_cases = [
      { condition: false, result: [] },
      { condition: true,  result: [nil] },
    ]

    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Presence.new(test_case[:condition])
      assert_equal test_case[:result], helper.unexpected_values
    end
  end
end
