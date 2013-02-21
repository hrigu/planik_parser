require "parslet"
require 'planik_parser/tree'

class PlanikParser::Transformer < Parslet::Transform

  rule(:boolean => simple(:x)) do
    value = x == "true" ? true : false
    PlanikParser::Leaf.new(x.to_s, value)
  end

  rule(:string => simple(:x)) {x.to_s}
  rule(:wochentag => simple(:x)) {x.to_s}

  rule(:dienst_expression => {
      :index => simple(:i), :property => simple(:p), :comparator => simple(:a), :value => simple(:v)}) do
    PlanikParser::ExpressionNode.new("dienst", i, p, a, v)
  end

  rule(:diensttyp_expression => {
      :index => simple(:i), :property => simple(:p), :comparator => simple(:a), :value => simple(:v)}) do
    PlanikParser::ExpressionNode.new("diensttyp", i, p, a, v)
  end

  rule(:wochentag_expression => {
      :index => simple(:i), :property => simple(:p), :comparator => simple(:a), :value => simple(:v)}) do
    PlanikParser::ExpressionNode.new("wochentag", i, p, a, v)
  end

  rule(:dienste_expression => {
      :index => simple(:i), :property => simple(:p), :comparator => simple(:a), :strings => sequence(:v)}) do
    PlanikParser::ExpressionNode.new("dienste", i, p, a, v)
  end
  rule(:diensttypen_expression => {
      :index => simple(:i), :property => simple(:p), :comparator => simple(:a), :strings => sequence(:v)}) do
    PlanikParser::ExpressionNode.new("diensttypen", i, p, a, v)
  end
  rule(:wochentage_expression => {
      :index => simple(:i), :property => simple(:p), :comparator => simple(:a), :wochentage => sequence(:v)}) do
    PlanikParser::ExpressionNode.new("wochentage", i, p, a, v)
  end

  #TODO besetzt_expression
  #TODO int_expression

  rule(:or => { :left => subtree(:left), :right => subtree(:right) }) do
    PlanikParser::OrNode.new(left, right)
  end

  rule(:and => { :left => subtree(:left), :right => subtree(:right) }) do
    PlanikParser::AndNode.new(left, right)
  end

  rule(:not => simple(:x)){ PlanikParser::NotNode.new(x)}
end
