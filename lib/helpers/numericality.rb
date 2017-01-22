module Tamebou
  module Helpers
    class Numericality < Base
      def initialize(params)
        if params.is_a?(TrueClass) || params.is_a?(FalseClass)
          @numericality = params
        end

        if params.is_a? Hash
          @numericality = true
          @only_integer = params[:only_integer]

          @allowed_maximum = params[:less_than].to_i - 1         if params.has_key? :less_than
          @allowed_maximum = params[:less_than_or_equal_to].to_i if params.has_key? :less_than_or_equal_to
          @allowed_maximum = params[:equal_to].to_i              if params.has_key? :equal_to

          @allowed_minimum = params[:greater_than].to_i + 1         if params.has_key? :greater_than
          @allowed_minimum = params[:greater_than_or_equal_to].to_i if params.has_key? :greater_than_or_equal_to
          @allowed_minimum = params[:equal_to].to_i                 if params.has_key? :equal_to

          @is_odd  = params[:odd]  if params.has_key? :odd
          @is_even = params[:even] if params.has_key? :even
        end
      end

      def expected_values
        expected_value_array = []

        if @numericality
          expected_value_array.push 1.1
        else
          return expected_value_array
        end

        if @only_integer
          expected_value_array.pop
          expected_value_array.push 2
        else
          expected_value_array.push 2.0
          expected_value_array.push 2
        end

        expected_value_array.push 157 if @is_odd
        expected_value_array.push 156 if @is_even

        expected_value_array.push  @allowed_minimum if @allowed_minimum
        expected_value_array.push  @allowed_maximum if @allowed_maximum

        expected_value_array
      end

      def unexpected_values
        unexpected_value_array = []

        unexpected_value_array.push "1.1" if @numericality

        unexpected_value_array.push 2.0 if @only_integer

        unexpected_value_array.push 156 if @is_odd
        unexpected_value_array.push 157 if @is_even

        unexpected_value_array.push  @allowed_minimum - 1 if @allowed_minimum
        unexpected_value_array.push  @allowed_maximum + 1 if @allowed_maximum

        unexpected_value_array
      end
    end
  end
end
