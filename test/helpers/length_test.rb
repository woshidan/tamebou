require 'test_helper'

class Tamebou::Helpers::LengthTest < Minitest::Test
  def test_expected_values
    test_cases = [
      { condition: { minimum: 3, maximum: 6}, result: ["aaaa", "aaaaa"] },
      { condition: { minimum: 2 },            result: ["aaa"] },
      { condition: { maximum: 5 },            result: ["aaaa"] },
      { condition: { in: 1..3 },              result: ["a", "aaa"] }
    ]

    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Length.new(test_case[:condition])
      assert_equal test_case[:result], helper.expected_values
    end
  end

  def test_unexpected_values
    test_cases = [
      { condition: { minimum: 3, maximum: 6}, result: ["aaa", "aaaaaa"] },
      { condition: { minimum: 2 },            result: ["aa"] },
      { condition: { maximum: 5 },            result: ["aaaaa"] },
      { condition: { in: 1..3 },              result: ["", "aaaa"] }
    ]

    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Length.new(test_case[:condition])
      assert_equal test_case[:result], helper.unexpected_values
    end
  end
end
