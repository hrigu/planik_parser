module PlanikParser
  class DummyEvaluator
    def initialize dienst_name
      @dienst_name = dienst_name
    end

    def tag index
      Tag.new("name", Dienst.new(Dienstart.new(@dienst_name, "typ")))
    end
  end
end