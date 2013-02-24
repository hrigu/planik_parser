require 'date'
require 'ostruct'

module PlanikParser

  class DummyEvaluatorBuilder

    def self.create_evaluator
      situation = Situation.new(Date.parse("2013-01-07"))
      d = yield situation
      situation.tage= [d]
      Evaluator.new(nil, situation)
    end

    def self.create_day(name, typ, situation)
      d = Tag.new(Dienst.new(Dienstart.new(name, typ)))
      d.date = situation.start_date
      d
    end

    def self.name name
      create_evaluator() do |situation|
        create_day(name, "typ", situation)
      end
    end
    def self.typ typ
      create_evaluator() do |situation|
        create_day("name", typ, situation)
      end
    end

    def self.wochentag wochentag
      create_evaluator() do |situation|
        OpenStruct.new(wochentag: wochentag)
      end
    end
  end
end