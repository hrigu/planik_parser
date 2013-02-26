require 'spec_helper'

module PlanikParser

  module Rule

    describe WennDann do
      it "works" do
        rule = WennDann.new("Nach D1 immer D2", "t0.name = D1", "t1.name = D2")
        situation = SituationBuilder.new.build(
            start_datum: Date.parse("2013-01-07"),
            tage: [{name: "D1", typ: "DIENST"}, {name: "D3", typ: "DIENST"}, {name: "D1", typ: "DIENST"}, {name: "D2", typ: "DIENST"}]
        )

        wenn_dann_evaluator = WennDannEvaluator.new(rule, situation)
        wenn_dann_evaluator.evaluate
      end
    end


  end

end