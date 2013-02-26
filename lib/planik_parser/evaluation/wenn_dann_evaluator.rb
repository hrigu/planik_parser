module PlanikParser

  class WennDannEvaluator

    def initialize wenn_dann_rule, situation
      @wenn_dann_rule, @situation = wenn_dann_rule, situation

    end

    def evaluate
      wenn_result = Evaluator.new(@wenn_dann_rule.wenn_bedingung.tree, @situation).evaluate
      dann_result = Evaluator.new(@wenn_dann_rule.dann_bedingung.tree, @situation).evaluate

      pp wenn_result
      pp dann_result
    end



  end
end