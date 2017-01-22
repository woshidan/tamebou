# Tamebou

## Simple validation test generator for rails.

Tamebou generates a simple test for validation of rails.

It read single-line `validates` methods and write test code according to templates. the default fomart is prepared for minitest and rspec.

## cover validation options

- `exclusion`
- `inclusion`
- `length`
- `numericality`
- `presence`

For other validation options, Tamebou generates a template with placeholders.

## Installation

```
$ gem install tamebou
```

## Usage

```rb
class Sample < ActiveRecord::Base
  validates :name, length: { maximum: 32, minimum: 6 }, presence: true
  validates :id, numericality: { only_integer: true, greater_than: 0 }

  # ...
end
```

```rb
irb(main):001:0> Tamebou::Writer.new("../path/to/model/sample.rb").write
=============================================
class TestSample < MiniTest::Unit::TestCase
  def setup
    @sample = build(:sample)
  end

  def teardown
    # you can some clean up code in this method
  end

  def test_valid_name_values_in_terms_of_length
    expected_values = ["aaaaaaa", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"]
    expected_values.each do |expected_value|
      @sample.name = expected_value
      assert @sample.valid?
    end
  end

  def test_invalid_name_values_in_terms_of_length
    invalid_values = ["aaaaaa", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"]
    invalid_values.each do |invalid_value|
      @sample.name = invalid_value
      assert_not @sample.valid?
    end
  end
end
=============================================
=============================================
class TestSample < MiniTest::Unit::TestCase
  def setup
    @sample = build(:sample)
  end

  def teardown
    # you can some clean up code in this method
  end

  def test_valid_name_values_in_terms_of_presence
    expected_values = ["presence"]
    expected_values.each do |expected_value|
      @sample.name = expected_value
      assert @sample.valid?
    end
  end

  def test_invalid_name_values_in_terms_of_presence
    invalid_values = [nil]
    invalid_values.each do |invalid_value|
      @sample.name = invalid_value
      assert_not @sample.valid?
    end
  end
end
=============================================
=============================================
class TestSample < MiniTest::Unit::TestCase
  def setup
    @sample = build(:sample)
  end

  def teardown
    # you can some clean up code in this method
  end

  def test_valid_id_values_in_terms_of_numericality
    expected_values = [2, 1]
    expected_values.each do |expected_value|
      @sample.id = expected_value
      assert @sample.valid?
    end
  end

  def test_invalid_id_values_in_terms_of_numericality
    invalid_values = ["1.1", 2.0, 0]
    invalid_values.each do |invalid_value|
      @sample.id = invalid_value
      assert_not @sample.valid?
    end
  end
end
=============================================
=> #<File:../path/to/model/sample.rb (closed)>
```

if you want to use template for RSpec:

```rb
Tamebou::Writer.new("../path/to/model/sample.rb", Tamebou::Writer::DefaultTemplate::RSPEC).write
```

if you want to use custom template:

```rb
Tamebou::Writer.new("../path/to/model/sample.rb", "/path/to/your_template").write
```

## Contributing

1. Create your feature branch (`git checkout -b my-new-feature`)
2. Commit your changes (`git commit -am 'Add some feature'`)
3. Push to the branch (`git push origin my-new-feature`)
4. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

