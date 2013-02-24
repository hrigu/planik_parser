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
  class Comparator
    attr_reader :node
    def initialize string_representation, node
      @string_representation, @node = string_representation, node
    end
    def to_s
      @string_representation
    end
  end
  class EqualComparator < Comparator
    def compare_with(target)
      target ? node.value == target : nil
    end
  end
  class NotComparator < Comparator
    def compare_with(target)
      target ? node.value != target : nil
    end
  end
  class InComparator < Comparator
    def compare_with(target)
      node.value.include? target
    end
  end
  class NotInComparator < Comparator
    def compare_with(target)
      ! node.value.include? target
    end
  end

  class ExpressionNode < Leaf
    attr_reader :index, :property, :comparator

    def initialize(index, property, comparator, value)
      super(value)
      @index, @property = index, property
      @comparator = build_comparator comparator
    end

    def to_s ident = ""
      ident+name + " "+index.to_s+" "+property+" "+comparator.to_s+" "+value.to_s
    end

    private
    def build_comparator c
      case c
        when "="
          EqualComparator.new c, self
        when "!="
          NotComparator.new c, self
        when "in"
          InComparator.new c, self
        when "!in"
          NotInComparator.new c, self
      end
    end


  end

  class DienstNode < ExpressionNode
    def evaluate evaluator
      comparator.compare_with(evaluator.tag(index).dienst.name)
    end
  end

  class DiensttypNode < ExpressionNode;
    def evaluate evaluator
      comparator.compare_with(evaluator.tag(index).dienst.typ)
    end
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
#      puts "And: evaluate"
      left.evaluate(evaluator) && right.evaluate(evaluator)
    end

  end

  class OrNode < InnerNode
    def evaluate evaluator
#      puts "Or: evaluate"
      left.evaluate(evaluator) || right.evaluate(evaluator)
    end
  end

  class NotNode < InnerNode
    def initialize(child)
      super(child, nil)
    end

    def evaluate evaluator
#      puts "Not: evaluate"
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