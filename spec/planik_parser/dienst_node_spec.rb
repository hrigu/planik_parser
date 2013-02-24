require 'spec_helper'

module PlanikParser

  describe DienstNode do
    context "comparator: =" do
      let(:expression) { DienstNode.new(0, "name", "=", "D1") }

      it "should return true when name is equal dienst_name of evaluator" do
        expression.evaluate(DummyEvaluatorBuilder.name("D1")).should eq true
      end
      it "should return false when name is different to dienst_name of evaluator" do
        expression.evaluate(DummyEvaluatorBuilder.name("D2")).should eq false
      end
    end

    context "comparator: !=" do
      let(:expression) { DienstNode.new(0, "name", "!=", "D1") }

      it "should return false when name is equal dienst_name of evaluator" do
        expression.evaluate(DummyEvaluatorBuilder.name("D1")).should eq false
      end
      it "should return true when name is different to dienst_name of evaluator" do
        expression.evaluate(DummyEvaluatorBuilder.name("D2")).should eq true
      end
    end

    context "comparator: in" do
      let(:expression) { DienstNode.new(0, "name", "in", ["D1", "D3"]) }

      it "should return true when name is in array" do
        expression.evaluate(DummyEvaluatorBuilder.name("D1")).should eq true
      end
      it "should return false when name is not in array" do
        expression.evaluate(DummyEvaluatorBuilder.name("D2")).should eq false
      end
    end

    context "comparator: !in" do
      let(:expression) { DienstNode.new(0, "name", "!in", ["D1", "D3"]) }

      it "should return false when name is in array" do
        expression.evaluate(DummyEvaluatorBuilder.name("D1")).should eq false
      end
      it "should return true when name is not in array" do
        expression.evaluate(DummyEvaluatorBuilder.name("D2")).should eq true
      end
    end

  end

end