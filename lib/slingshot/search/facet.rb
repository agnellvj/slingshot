module Slingshot
  module Search

    #--
    # TODO: Implement all elastic search facets (geo, histogram, range, etc)
    # http://elasticsearch.org/guide/reference/api/search/facets/
    #++

    class Facet

      def initialize(name, options={}, &block)
        @name    = name
        @options = options
        self.instance_eval(&block) if block_given?
      end

      def terms(field, size=10, options={})
        @value = { :terms => { :field => field, :size => size } }.update(options)
        self
      end

      def date(field, interval='day', options={})
        @value = { :date_histogram => { :field => field, :interval => interval } }.update(options)
        self
      end

      def to_json
        to_hash.to_json
      end

      def to_hash
        h = { @name => @value }
        h[@name].update @options
        return h
      end
    end

  end
end
