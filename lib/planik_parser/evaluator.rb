require 'planik_parser/tree'
module PlanikParser

  class Evaluator

    def initialize tree, situation
      @tree, @situation = tree, situation
      @current_day_index = 0
    end

    ##
    # Berechnet für jedes Fenster das Resultat
    # Das Fenster schiebt sich über die Situation
    ##
    def evaluate
      result = []
      (0..(@situation.tage.size - 1 - @tree.breite)).each do |n|
        @current_day_index = n
        result << @tree.evaluate(self)
      end
      result
    end

    def value_for_node node
      case node
        when DienstNode
          self.tag(node.index).dienst.nil? ? nil : self.tag(node.index).dienst.name
        when DiensttypNode
          self.tag(node.index).dienst.nil? ? nil : self.tag(node.index).dienst.typ
      end
    end

    def tag relative_day_index
      day_index = @current_day_index +relative_day_index
      @situation.tage[day_index]
    end
  end
end