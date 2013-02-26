module PlanikParser
  module Rule
    class WennDann
      attr_reader :name, :wenn_bedingung, :dann_bedingung

      def initialize name, raw_wenn, raw_dann
        @name = name
        @wenn_bedingung = Bedingung.new raw_wenn
        @dann_bedingung = Bedingung.new raw_dann
      end

    end
  end
end