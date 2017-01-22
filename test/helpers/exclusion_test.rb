require 'test_helper'

class ExclusionTest < Minitest::Test
  def test_expected_values
    base_helper = Tamebou::Helpers::Base.new({})
    test_cases = [
      { condition: { in: 2..4 },   result: base_helper.expected_values },
      { condition: { in: [1, 5] }, result: base_helper.expected_values }
    ]

    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Exclusion.new(test_case[:condition])
      assert_equal test_case[:result], helper.expected_values
    end
  end

  def test_unexpected_values
    base_helper = Tamebou::Helpers::Base.new({})
    test_cases = [
      { condition: { in: 2..4 },   result: [2, 3, 4] },
      { condition: { in: [1, 5] }, result: [1, 5] }
    ]

    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Exclusion.new(test_case[:condition])
      assert_equal test_case[:result], helper.unexpected_values
    end
  end
end
