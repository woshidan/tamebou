module Tamebou
  module Helpers
    class Inclusion < Base
      def initialize(params)
        @in = params[:in].to_a
      end

      def expected_values
        @in
      end

      def unexpected_values
        super
      end
    end
  end
end
