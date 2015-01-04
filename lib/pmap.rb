require 'concurrent'

module PMap
  def self.included(base)
    base.class_eval do
      # Parallel "map" for any Enumerable.
      # Requires a block of code to run for each Enumerable item.
      def pmap
        self.map { |i| Concurrent::Future.execute { yield i } }.map(&:value)
      end

      # Parallel "each" for any Enumerable.
      # Requires a block of code to run for each Enumerable item.
      def peach
        self.each { |i| Concurrent::Future.execute { yield i } }

        self
      end
    end
  end
end

module Enumerable
  include PMap
end
