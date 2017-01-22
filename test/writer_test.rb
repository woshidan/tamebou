require 'test_helper'

class WriterTest < Minitest::Test
  def test_set_model_name_from_file_path
    writer = Tamebou::Writer.new('./test_model.rb')
    model_name = writer.instance_variable_get "@model_name"
    model_name_in_snake_case = writer.instance_variable_get "@model_name_in_snake_case"

    assert_equal "TestModel",  model_name
    assert_equal "test_model", model_name_in_snake_case
  end
end
