module PlanikParser
  class Node
    attr_reader :name

    def initialize name
      @name = name
    end

    def to_s ident = ""
      ident + name
    end

    def eval
      raise "implement in subclass"
    end
  end

  class Leaf < Node
    attr_reader :value

    def initialize name, value
      super(name)
      @value = value
    end

    def eval
      value
    end
  end

  class InnerNode < Node
    attr_reader :left, :right

    def initialize name, left, right
      super(name)
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

  class AndNode < InnerNode
    def initialize(left, right)
      super("and", left, right)
    end

    def eval
      left.eval && right.eval
    end

  end

  class OrNode < InnerNode
    def initialize(left, right)
      super("or", left, right)
    end

    def eval
      left.eval || right.eval
    end
  end

  class NotNode < InnerNode
    def initialize(child)
      super("not", child, nil)
    end

    def eval
      !left.eval
    end
  end


end