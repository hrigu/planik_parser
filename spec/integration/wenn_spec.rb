require 'spec_helper'

module PlanikParser

  describe "wenn" do

    let(:tree_builder) { TreeBuilder.new }

    context "combination of name-expression and typ-expression" do
      context "same day" do
        context "or" do
          let(:situation){SituationBuilder.new.build([{name: "D1", typ: "DIENST"}])}

          it "example with true" do
            tree = tree_builder.build "t0.name = D1 or t0.typ != DIENST"
            evaluator = Evaluator.new(tree, situation)
            evaluator.evaluate.should eq true
          end

          it "example with false" do
            tree = tree_builder.build "t0.typ = DIENST and t0.name !in (D1, D2)"
            evaluator = Evaluator.new(tree, situation)
            evaluator.evaluate.should eq false
          end
        end
      end
    end
  end


end