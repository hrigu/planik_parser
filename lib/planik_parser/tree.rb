module PlanikParser

  class Node
    attr_reader :name
    attr_reader :parent

    def to_s ident = ""
      ident + name
    end

    def evaluate
      raise "implement in subclass"
    end

    def name
      self.class.name.split("::")[1].sub("Node", "")
    end
  end

  class Leaf < Node
    attr_reader :value

    def initialize value
      @value = value
    end

    def evaluate
      value
    end
  end


  class InnerNode < Node
    attr_reader :left, :right

    def initialize left, right
      super()
      @left, @right = left, right
    end

    def to_s ident = ""
      l = left.to_s(ident +" ")
      r = right.to_s(ident +" ") if right
      o = super(ident)
      s = "#{o}\n#{l}"
      s += "\n#{r}" if r
      s
    end

  end

  class ExpressionNode < Leaf
    attr_reader :index, :property, :comparator
    def initialize(index, property, comparator, value)
      super(value)
      @index, @property, @comparator = index, property, comparator#      :index => simple(:i), :property => simple(:p), :comparator => simple(:a), :value => simple(:v)}) do
    end

  end

  class DienstNode < ExpressionNode ; end
  class DiensttypNode < ExpressionNode ; end
  class WochentagNode < ExpressionNode ; end
  class TagFreiNode < ExpressionNode ; end


  class BooleanNode < Leaf
    def initialize value
      super value
    end
  end

  class AndNode < InnerNode
    def evaluate
      left.evaluate && right.evaluate
    end

  end

  class OrNode < InnerNode
    def evaluate
      left.evaluate || right.evaluate
    end
  end

  class NotNode < InnerNode
    def initialize(child)
      super(child, nil)
    end

    def evaluate
      !left.evaluate
    end
  end


end