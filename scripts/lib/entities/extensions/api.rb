require 'active_support/concern'

module Entities
  module Extensions
    module Api

      extend ActiveSupport::Concern

      included do

        class << self
          attr_accessor :api
        end

      end

      def api
        self.class.api
      end

    end
  end
end
