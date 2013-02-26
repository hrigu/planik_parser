module PlanikParser

  class Evaluator
    attr_reader :tree, :situation

    def initialize tree, situation
      @tree, @situation = tree, situation
      @auswertungsfenster_index = 0 - @tree.min_index
    end

    ##
    # Berechnet für jedes Fenster das Resultat.
    # situation.tage:                               0, 1, 2, 3, 4
    # Fenster einer Regel mit Breite 3, start t0:                     Resultat
    # erster Durchgang                              -     -           -> [x]
    # zweiter Durchgang                                -     -        -> [x, y]
    # dritter Durchgang                                   -     -     -> [x, y, z]
    #
    # Das Fenster schiebt sich über die Situation.
    # @return Ein Array von boolean Werten (true, false, nil) der einzelnen Auswertungsfenster
    ##
    def evaluate previous_result = nil
      result = [] # Die Resultate der einzelnen Fenster. Grösse: Anz Tage - (Breite des Baumes - 1) - Minindex des Baumes
      start_i = 0
      end_i = @situation.tage.size - (@tree.breite - 1) - @tree.min_index

      (start_i...end_i).each do |n|
        if (previous_result &&  previous_result[n] == false)
          result << "-"
        else
          @auswertungsfenster_index = n
          result << @tree.evaluate(self)
        end
      end
      result
    end

    def value_for_node node
      day_index = @auswertungsfenster_index +node.index
      current_tag = @situation.tage[day_index]
      case node
        when DienstNode
          current_tag.dienst.nil? ? nil : current_tag.dienst.name
        when DiensttypNode
          current_tag.dienst.nil? ? nil : current_tag.dienst.typ
        when WochentagNode
          current_tag.wochentag
      end
    end

  end
end