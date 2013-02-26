module PlanikParser

  class WennDannEvaluator

    def initialize wenn_dann_rule, situation
      @wenn_dann_rule, @situation = wenn_dann_rule, situation

    end

    def evaluate
      wenn_result = Evaluator.new(@wenn_dann_rule.wenn_bedingung.tree, @situation).evaluate
      dann_result = Evaluator.new(@wenn_dann_rule.dann_bedingung.tree, @situation).evaluate(wenn_result)

      bis = [wenn_result.size, dann_result.size].min

      pp wenn_result
      pp dann_result

      (0...bis).each do |x|
        if wenn_result[x]
          if dann_result[x]
            puts "Korrekt in Fenster #{x}: " + @situation.tage[x+@wenn_dann_rule.dann_bedingung.tree.min_index].to_s
          end
          unless dann_result[x]
            puts "Verletzung in Fenster #{x}: " + @situation.tage[x+@wenn_dann_rule.dann_bedingung.tree.min_index].to_s
          end
        end
      end

    end
  end
end