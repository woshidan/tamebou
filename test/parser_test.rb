require 'test_helper'

class ParserTest < Minitest::Test
  def test_parse_validation_with_indent
    validation_with_indent =  "  validates :profile, presence: true"

    result = Tamebou::Parser.parse(validation_with_indent)
    assert_equal "profile", result[:field_name]
    assert_equal({ presence: true }, result[:options])
  end

  def test_parse_validation_with_multiple_options
    multiple_options_validation  = "validates :username, :uniqueness => true, length: { minimum: 6 }"

    result = Tamebou::Parser.parse(multiple_options_validation)
    assert_equal "username", result[:field_name]
    assert_equal({ :uniqueness => true, length: { minimum: 6 } }, result[:options])
  end

    def test_parse_validation_with_paren
    validation_with_paren = "validates(:username, length: { minimum: 6 }"

    result = Tamebou::Parser.parse(validation_with_paren)
    assert_equal "username", result[:field_name]
    assert_equal({ length: { minimum: 6 } }, result[:options])
  end

  def test_parse_validation_with_regular_expression
    validation_with_regular_expression = "validates :username, :format => /\A([^@\s]+)@((?:[a-z0-9]+\.)+[a-z]{2,})\Z/i"

    result = Tamebou::Parser.parse(validation_with_regular_expression)
    assert_equal "username", result[:field_name]

    assert !({ :format => /\A([^@\s]+)@((?:[a-z0-9]+\.)+[a-z]{2,})\Z/i } == (result[:options]))
    assert_equal({ :format => /A([^@ ]+)@((?:[a-z0-9]+.)+[a-z]{2,})Z/i }, result[:options])
  end

  def test_parse_validation_with_multiple_lines
    validation_with_multiple_lines = " validates :subdomain, exclusion: { in: %w(www us ca jp),
      message: \"%{value} is reserved\" }"

    result = Tamebou::Parser.parse(validation_with_multiple_lines)
    assert_equal "subdomain", result[:field_name]
    assert_equal({:exclusion=>{:in=>["www", "us", "ca", "jp"]}}, result[:options])
  end

  def test_parse_validation_with_block
    validations_with_block = [
      "validates :profile { |prof|
        # some method
      }",
      "validates :profile do |prof|
        # some method
      end"
    ]

    validations_with_block.each do |validation_with_block|
      result = Tamebou::Parser.parse(validation_with_block)
      assert_equal "profile", result[:field_name]
      assert_nil result[:options]
    end
  end
end
