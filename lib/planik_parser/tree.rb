module PlanikParser

  class Node
    attr_reader :name
    attr_accessor :parent

    def to_s ident = ""
      ident + name
    end

    def evaluate evaluator
      raise "implement in subclass"
    end

    def name
      self.class.name.split("::")[1].sub("Node", "")
    end

    def visit
      yield self
    end

  end

  class Leaf < Node
    attr_reader :value

    def initialize value
      @value = value
    end

    def to_s ident = ""
      super(ident) + " "+value.to_s
    end
  end


  class InnerNode < Node
    attr_reader :left, :right

    def initialize left, right
      super()
      @left, @right = left, right
    end

    def to_s ident = ""
      left_s = left.to_s(ident +" ")
      right_s = right.to_s(ident +" ") if right
      self_s = super(ident)
      string = "#{self_s}\n#{left_s}"
      string += "\n#{right_s}" if right_s
      string
    end

    def visit &block
      yield self
      left.visit &block
      right.visit &block if right
    end

  end

  class ExpressionNode < Leaf
    attr_reader :index, :property, :comparator

    def initialize(index, property, comparator, value)
      super(value)
      @index, @property, @comparator = index, property, comparator
    end

    def to_s ident = ""
      ident+name + " "+index.to_s+" "+property+" "+comparator+" "+value.to_s
    end


  end

  class DienstNode < ExpressionNode
    def evaluate evaluator
      evaluator.tag(index).dienst.name == value
    end
  end

  class DiensttypNode < ExpressionNode;
  end
  class WochentagNode < ExpressionNode;
  end
  class TagFreiNode < ExpressionNode;
  end


  class BooleanNode < Leaf
    def initialize value
      super value
    end

    def evaluate evaluator
      value
    end
  end

  class AndNode < InnerNode
    def evaluate evaluator
      left.evaluate(evaluator) && right.evaluate(evaluator)
    end

  end

  class OrNode < InnerNode
    def evaluate evaluator
      left.evaluate(evaluator) || right.evaluate(evaluator)
    end
  end

  class NotNode < InnerNode
    def initialize(child)
      super(child, nil)
    end

    def evaluate evaluator
      !left.evaluate evaluator
    end
  end

  class Tree
    attr_reader :root

    def initialize root
      @root = root
    end

    def visit &block
      root.visit &block
    end

    def to_s
      root.to_s
    end

    def evaluate evaluator
      root.evaluate evaluator
    end

  end
end