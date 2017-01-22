module Tamebou
  module Helpers
    class Length < Base
      def initialize(params)
        @allowed_maximum = params[:maximum].to_i - 1 if params.has_key? :maximum
        @allowed_minimum = params[:minimum].to_i + 1 if params.has_key? :minimum

        if params.has_key? :in
          @allowed_maximum = params[:in].max
          @allowed_minimum = params[:in].min
        end
      end

      def expected_values
        expected_value_array = []
        expected_value_array.push "a" * @allowed_minimum if @allowed_minimum
        expected_value_array.push "a" * @allowed_maximum if @allowed_maximum
        expected_value_array
      end

      def unexpected_values
        unexpected_value_array = []
        unexpected_value_array.push "a" * (@allowed_minimum - 1) if @allowed_minimum
        unexpected_value_array.push "a" * (@allowed_maximum + 1) if @allowed_maximum
        unexpected_value_array
      end
    end
  end
end
