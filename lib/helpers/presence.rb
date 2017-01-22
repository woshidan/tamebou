module Tamebou
  module Helpers
    class Presence < Base
      def initialize(params)
        if params.is_a?(TrueClass) || params.is_a?(FalseClass)
          @presence = params
        end
      end

      def expected_values
        @presence ? ["presence"] : [nil, "presence"]
      end

      def unexpected_values
        @presence ? [nil] : []
      end
    end
  end
end
