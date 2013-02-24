module PlanikParser
  class DummyEvaluator
    attr_accessor :tree
    def initialize tage
      @tage = tage#@dienst_name, @typ = dienst_name, typ
    end

    def evaluate
      tree.evaluate(self)
    end

    def value_for_node node
      case node
        when DienstNode
          self.tag(node.index).dienst.name
        when DiensttypNode
          self.tag(node.index).dienst.typ
      end
    end


    def tag index
      @tage[index]#
    end


  end

  class DummyEvaluatorBuilder

    def self.create_day name, typ
      Tag.new("name", Dienst.new(Dienstart.new(name, typ)))
    end

    def self.name name
      DummyEvaluator.new([create_day(name, "typ")])
    end
    def self.typ typ
      DummyEvaluator.new([create_day("name", typ)])
    end

  end
end