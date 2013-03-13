module PlanikParser


  module Rule
    class Bedingung
      attr_reader :raw_string
      attr_reader :tree

      def initialize raw_string
        @raw_string = raw_string
        @tree = TreeBuilder.instance.build(raw_string)
      end
    end
  end
end