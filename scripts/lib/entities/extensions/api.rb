require 'active_support/concern'
require 'active_support/inflector'

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

      def save
        name = "content_types/#{self.class.resource_name}/entries"

        begin
          if resource_id = attributes[:_id]
            api.update(name, resource_id, attributes)
          else
            api.create(name, attributes)
          end
          true
        rescue Locomotive::Mounter::ApiWriteException => e
          false
        end
      end

      module ClassMethods

        def all(where = nil, &block)
          where   ||= '{"_visible": true}'
          entries = self.api.fetch("content_types/#{resource_name}/entries", { where: where })
          list    = []

          entries.each do |attributes|
            if resource = self.build(attributes)
              if block_given?
                block.call(resource)
              else
                list << resource
              end
            end
          end

          list
        end

        def find(slug)
          where   ||= %({"_slug": "#{slug}"})
          entries = self.api.fetch("content_types/#{resource_name}/entries", { where: where })

          if attributes = entries.first
            self.build(attributes)
          else
            nil
          end
        end

        def destroy_all
          self.api.delete("/content_types/#{resource_name}/entries.json")
        end

        def build(attributes = {})
          # needed to by implemented by the class including this module
        end

        def resource_name
          name.demodulize.underscore.pluralize
        end

      end

    end
  end
end
