require 'spec_helper'

module PlanikParser

  describe DiensttypNode do
    context "comparator: =" do
      let(:expression) { DiensttypNode.new(0, "typ", "=", "DIENST") }

      it "should return true when Typ is equal typ of evaluator" do
        expression.evaluate(DummyEvaluatorBuilder.typ("DIENST")).should eq true
      end
      it "should return false when Typ is != typ of evaluator" do
        expression.evaluate(DummyEvaluatorBuilder.typ("FERIEN")).should eq false
      end
    end

  end

end