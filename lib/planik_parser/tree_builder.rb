require 'planik_parser/parser'
require 'planik_parser/transformer'
require 'planik_parser/tree'
module PlanikParser

  class TreeBuilder
    def initialize
      @parser = PlanikParser::Parser.new
      @transformer = PlanikParser::Transformer.new
    end
    def build string
      indermediate_tree = @parser.parse(string)
      ast = @transformer.apply(indermediate_tree)
      tree = PlanikParser::Tree.new(ast)
      set_parents(tree)
      evaluate_breite tree
      tree
    end

    private

    def evaluate_breite(tree)
      min = 0
      max = 0
      tree.visit do |node|
        if (node.kind_of? PlanikParser::ExpressionNode)
          min = node.index if node.index < min
          max = node.index if node.index > max
        end
      end
      tree.min_index = min
      tree.max_index = max
    end

    def set_parents(tree)
      tree.visit do |node|
        if (node.kind_of? PlanikParser::InnerNode)
          node.left.parent = node
          node.right.parent = node if node.right
        end
      end
    end
  end
end