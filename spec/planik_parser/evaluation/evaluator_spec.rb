require 'spec_helper'

module PlanikParser

  describe Evaluator do

    context "evaluate" do
      let(:evaluator) do
        tree = TreeBuilder.instance.build "t1.name=D1 and t0.name=D2"
        situation = SituationBuilder.new.build(
            start_datum: Date.parse("2013-01-07"),
            tage: [{name: "D1", typ: "DIENST"}, {name: "D2", typ: "DIENST"}, {name: "D1", typ: "DIENST"}]

        )
        Evaluator.new(tree, situation)
      end

      it "should return an results-array which is even long as the situation.tage - (breite - 1)" do
        result = evaluator.evaluate
        result.should eq  [false, true]
        result.size.should eq evaluator.situation.tage.size - (evaluator.tree.breite - 1)
      end
    end
  end
end