module PlanikParser

  class WennDannEvaluator

    def initialize rule, situation
      @rule, @situation = rule, situation
    end

    def evaluate
      result = Evaluator.new(@rule.bedingung.tree, @situation).evaluate
      result
    end
  end
end