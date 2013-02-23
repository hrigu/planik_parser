module PlanikParser
  class DummyEvaluator
    def initialize dienst_name, typ
      @dienst_name, @typ = dienst_name, typ
    end

    def tag index
      Tag.new("name", Dienst.new(Dienstart.new(@dienst_name, @typ)))
    end
  end

  class DummyEvaluatorBuilder
    def self.name name
      DummyEvaluator.new(name, "typ")
    end
    def self.typ typ
      DummyEvaluator.new("name", typ)
    end
  end
end