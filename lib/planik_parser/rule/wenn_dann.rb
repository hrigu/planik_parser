module PlanikParser
  module Rule
    class WennDann
      attr_reader :name
      attr_reader :bedingung
      attr_reader :raw_wenn, :raw_dann
      def initialize name, raw_wenn, raw_dann
        @name, @raw_wenn, @raw_dann = name, raw_wenn, raw_dann
        @bedingung = Bedingung.new("not (#{raw_wenn}) or #{raw_dann}")
      end

      def to_s
        "#{name}:  WENN #{raw_wenn}  DANN #{raw_dann} (Oder: #{bedingung.raw_string})"
      end

    end
  end
end