module Tamebou
  module Helpers
    class Exclusion < Base
      def initialize(params)
        @in = params[:in].to_a
      end

      def expected_values
        super
      end

      def unexpected_values
        @in
      end
    end
  end
end
