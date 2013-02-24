require 'spec_helper'

module PlanikParser

  describe WochentagNode do
    context "comparator: =" do
      let(:expression) { WochentagNode.new(0, "wochentag", "=", "Mo") }

      it "should return true when Wochentage match" do
        expression.evaluate(DummyEvaluatorBuilder.wochentag("Mo")).should eq true
      end
      it "should return false when Wochentage don't match" do
        expression.evaluate(DummyEvaluatorBuilder.wochentag("Di")).should eq false
      end
    end
    context "comparator: !=" do
      let(:expression) { WochentagNode.new(0, "wochentag", "!=", "Mo") }

      it "should return false when Wochentage match" do
        expression.evaluate(DummyEvaluatorBuilder.wochentag("Mo")).should eq false
      end
      it "should return true when Wochentage don't match" do
        expression.evaluate(DummyEvaluatorBuilder.wochentag("Di")).should eq true
      end
    end
    context "comparator: in" do
      let(:expression) { WochentagNode.new(0, "wochentag", "in", "(Di, Fr)") }

      it "should return false when Wochentag is not in array" do
        expression.evaluate(DummyEvaluatorBuilder.wochentag("Mo")).should eq false
      end
      it "should return true when Wochentag is in array" do
        expression.evaluate(DummyEvaluatorBuilder.wochentag("Di")).should eq true
      end
    end

  end

end