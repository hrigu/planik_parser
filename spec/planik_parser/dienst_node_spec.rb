require 'spec_helper'

module PlanikParser

  describe DienstNode do
    context "comparator: =" do
      let(:expression) { DienstNode.new(13, "name", "=", "D1") }

      it "should return true when name is equal dienst_name of evaluator" do
        expression.evaluate(DummyEvaluator.new("D1")).should eq true
      end
      it "should return false when name is different to dienst_name of evaluator" do
        expression.evaluate(DummyEvaluator.new("D2")).should eq false
      end
    end

    #context "comparator: !=" do
    #  let(:expression) { DienstNode.new(13, "name", "!=", "D1") }
    #
    #  it "should return false when name is equal dienst_name of evaluator" do
    #    expression.evaluate(DummyEvaluator.new("D1")).should eq false
    #  end
    #  it "should return false when name is different to dienst_name of evaluator" do
    #    expression.evaluate(DummyEvaluator.new("D2")).should eq true
    #  end
    #end

  end

end