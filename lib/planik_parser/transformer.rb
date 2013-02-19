require "parslet"
require "pp"
require 'planik_parser/day_expression'

class PlanikParser::Transformer < Parslet::Transform
  rule(:bool_const => simple(:bool_const)) { puts "CONST"; bool_const == "true" ? true : false }
  rule(:word => simple(:x)) { puts "WORD"; x }
  #rule(:index => simple(:i), :property => simple(:p), :assignment => simple(:a), :value => simple(:v)) do
  #  puts("INDEX PROPERTY ASSIGNMENT VALUE")
  #  "day_expression"
  #end
  rule(:day_expression => {
      :index => simple(:i), :property => simple(:p), :assignment => simple(:a), :value => simple(:v)}) do
    puts "DAY_EXPRESSION"
    DayExpression.new(i, p, a, v)
  end


  rule(:or => { :left => subtree(:left), :right => subtree(:right) }) do
    puts "OR"
    left || right
  end

  rule(:and => { :left => subtree(:left), :right => subtree(:right) }) do
    puts "AND"
    pp left
    left && right
  end

  rule(:not => simple(:x)){ puts "NOT"; !x}

end
