require 'test_helper'

class Tamebou::Helpers::NumericalityTest < Minitest::Test
  def test_expected_values_for_params_including_only_boolean
    test_cases = [
      { condition: true,  result: [1.1, 2.0, 2] },
      { condition: false, result: [] }
    ]

    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Numericality.new(test_case[:condition])
      assert_equal test_case[:result], helper.expected_values
    end
  end

  def test_unexpected_values_for_params_including_only_boolean
    test_cases = [
      { condition: true,  result: ["1.1"] },
      { condition: false, result: [] }
    ]

    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Numericality.new(test_case[:condition])
      assert_equal test_case[:result], helper.unexpected_values
    end
  end

  def test_expected_values_for_only_integer
    test_cases = [
      { condition: {only_integer: true }, result_subset: [2] },
      { condition: {only_integer: false}, result_subset: [2.0, 2] }
    ]
    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Numericality.new(test_case[:condition])
      test_case[:result_subset].each do |value_in_result|
        assert_includes helper.expected_values, value_in_result
      end
    end
  end

  def test_unexpected_values_for_only_integer
    test_cases = [
      { condition: {only_integer: true }, result_subset: [2.0] },
      { condition: {only_integer: false}, result_subset: [] }
    ]

    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Numericality.new(test_case[:condition])
      test_case[:result_subset].each do |value_in_result|
        assert_includes helper.unexpected_values, value_in_result
      end
    end
  end

  def test_expected_values_for_even_or_odd
    test_cases = [
      { condition: {odd:  true}, result_subset: [157] },
      { condition: {even: true}, result_subset: [156] }
    ]

    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Numericality.new(test_case[:condition])
      test_case[:result_subset].each do |value_in_result|
        assert_includes helper.expected_values, value_in_result
      end
    end
  end

  def test_unexpected_values_for_even_or_odd
    test_cases = [
      { condition: {odd:  true}, result_subset: [156] },
      { condition: {even: true}, result_subset: [157] }
    ]

    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Numericality.new(test_case[:condition])
      test_case[:result_subset].each do |value_in_result|
        assert_includes helper.unexpected_values, value_in_result
      end
    end
  end

  def test_expected_values_for_range_limitation
    test_cases = [
      { condition: { less_than: 10 },                result_subset: [9] },
      { condition: { less_than_or_equal_to: 10 },    result_subset: [10] },
      { condition: { greater_than: 10 },             result_subset: [11] },
      { condition: { greater_than_or_equal_to: 10 }, result_subset: [10] },
      { condition: { equal_to: 10},                  result_subset: [10] },
      { condition: { less_than: 15, greater_than: 11 }, result_subset: [12, 14] }
    ]
    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Numericality.new(test_case[:condition])
      test_case[:result_subset].each do |value_in_result|
        assert_includes helper.expected_values, value_in_result
      end
    end
  end

  def test_unexpected_values_for_range_limitation
    test_cases = [
      { condition: { less_than: 10 },                result_subset: [10] },
      { condition: { less_than_or_equal_to: 10 },    result_subset: [11] },
      { condition: { greater_than: 10 },             result_subset: [10] },
      { condition: { greater_than_or_equal_to: 10 }, result_subset: [9] },
      { condition: { equal_to: 10},                  result_subset: [9, 11] },
      { condition: { less_than: 15, greater_than: 11 }, result_subset: [11, 15] }
    ]

    test_cases.each do |test_case|
      helper = Tamebou::Helpers::Numericality.new(test_case[:condition])
      test_case[:result_subset].each do |value_in_result|
        assert_includes helper.unexpected_values, value_in_result
      end
    end
  end
end
