require 'planik_parser/tree'
module PlanikParser

  class Evaluator
    def initialize tree, situation
      @tree, @situation = tree, situation
    end

    def evaluate
      @tree.evaluate(self)
    end

    def tag index
      @situation.tage[index]
    end
  end
end