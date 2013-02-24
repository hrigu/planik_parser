module PlanikParser

  class DummyEvaluatorBuilder

    def self.create_day name, typ
      Tag.new("name", Dienst.new(Dienstart.new(name, typ)))
    end

    def self.name name
      Evaluator.new(nil, Situation.new([create_day(name, "typ")]))
    end
    def self.typ typ
      Evaluator.new(nil, Situation.new([create_day("name", typ)]))
    end
    def self.wochentag wochentag
      Evaluator.new(nil, Situation.new([Tag.new(wochentag, nil)]))
    end
  end
end