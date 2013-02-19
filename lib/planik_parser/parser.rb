require "parslet"

class PlanikParser::Parser < Parslet::Parser
  rule(:space) { match[" "].repeat(1) }
  rule(:space?) { space.maybe }

  rule(:integer) { match('[0-9]').repeat(1) }
  rule(:word) { match('[A-Za-z0-9]').repeat(1).as(:word) >> space? }

  rule(:lparen) { str("(") >> space? }
  rule(:rparen) { str(")") >> space? }

  rule(:bool_literal) { (str("true") | str("false")).as(:bool_const) >> space? }

  rule(:eql) { str("=") }
  rule(:not_eql) { str("!=") }
  rule(:assignment) { (eql | not_eql).as(:assignment) >> space? }

  rule(:and_operator) { str("and") >> space? }
  rule(:or_operator) { str("or") >> space? }

  rule(:day) { str('t') >> integer.as(:index) >> space? }
  rule (:property) {word.as(:property)}
  rule (:value) {word.as(:value)}

  rule(:day_expression) { (day >> str(".") >> property >> assignment >> value).as(:day_expression) }

  rule(:expression) { bool_literal | day_expression }


  # The primary rule deals with parentheses.
  rule(:primary) { lparen >> or_operation >> rparen | expression }

  rule(:not_operation) { (str("not") >> space? >> primary).as(:not) | primary }

  # Note that following rules are both right-recursive.
  rule(:and_operation) {
    (not_operation.as(:left) >> and_operator >>
        and_operation.as(:right)).as(:and) |
        not_operation }

  rule(:or_operation) {
    (and_operation.as(:left) >> or_operator >>
        or_operation.as(:right)).as(:or) |
        and_operation }

  # We start at the lowest precedence rule.
  root(:or_operation)
end
