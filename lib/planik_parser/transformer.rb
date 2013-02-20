require "parslet"
require "pp"
require 'planik_parser/day_expression'

class PlanikParser::Transformer < Parslet::Transform


  rule(:boolean => simple(:x))  { x == "true" ? true : false }
  rule(:word => simple(:x))                 { x }
  rule(:day_expression => {
      :index => simple(:i), :property => simple(:p), :comparator => simple(:a), :value => simple(:v)}) do
    DayExpression.new(i, p, a, v)
  end


  rule(:or => { :left => subtree(:left), :right => subtree(:right) }) do
    left || right
  end

  rule(:and => { :left => subtree(:left), :right => subtree(:right) }) do
    left && right
  end

  rule(:not => simple(:x))                  { !x}

end
