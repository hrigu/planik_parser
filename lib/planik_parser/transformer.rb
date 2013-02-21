require "parslet"
require 'planik_parser/tree'

class PlanikParser::Transformer < Parslet::Transform

  rule(:boolean => simple(:x)) do
    value = x == "true" ? true : false
    PlanikParser::Leaf.new(x.to_s, value)
  end

  rule(:day_expression => {
      :index => simple(:i), :property => simple(:p), :comparator => simple(:a), :value => simple(:v)}) do
    DayExpression.new(i, p, a, v)
  end

  rule(:or => { :left => subtree(:left), :right => subtree(:right) }) do
    PlanikParser::OrNode.new(left, right)
  end

  rule(:and => { :left => subtree(:left), :right => subtree(:right) }) do
    PlanikParser::AndNode.new(left, right)
  end

  rule(:not => simple(:x)){ PlanikParser::NotNode.new(x)}
end
