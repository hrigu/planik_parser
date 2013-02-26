module PlanikParser

  class Evaluator
    attr_reader :tree, :situation
    def initialize tree, situation
      @tree, @situation = tree, situation
      @relative_day_index = 0 - @tree.min_index
    end

    ##
    # Berechnet für jedes Fenster das Resultat.
    # situation.tage:                               0, 1, 2, 3, 4
    # Fenster einer Regel mit Breite 3:                               Resultat
    # erster Durchgang                              -     -           -> [x]
    # zweiter Durchgang                                -     -        -> [x, y]
    # dritter Durchgang                                   -     -     -> [x, y, z]
    #
    # Das Fenster schiebt sich über die Situation.
    # @return Ein Array von boolean Werten (true, false, nil) der Auswertungen des Trees über den einzelnen Fenster
    ##
    def evaluate
      result = []
      start_i = 0 - @tree.min_index
      end_i = @situation.tage.size - @tree.min_index - @tree.breite
      (start_i..end_i).each do |n|
        @relative_day_index = n
        result << @tree.evaluate(self)
      end
      result
    end

    def value_for_node node
      day_index = @relative_day_index +node.index
      current_tag =  @situation.tage[day_index]
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