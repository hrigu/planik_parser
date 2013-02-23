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
      ast =@transformer.apply(indermediate_tree)
      tree = PlanikParser::Tree.new(ast)
      tree
    end
  end
end