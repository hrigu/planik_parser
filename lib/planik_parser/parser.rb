require "parslet"

class PlanikParser::Parser < Parslet::Parser
  rule(:space) { match[" "].repeat(1) }
  rule(:space?) { space.maybe }

  rule(:lparen) { str("(") >> space? }
  rule(:rparen) { str(")") >> space? }
  rule(:comma) { str(",") >> space? }

  rule(:integer) { match('[0-9]').repeat(1) }
  rule(:string) { match('[A-Za-z0-9]').repeat(1).as(:string) >> space? }

  rule(:wochentag) { (str("Mo") | str("Di")| str("Mi") | str("Do") | str("Fr") | str("Sa") | str("So")).as(:wochentag) }
  rule(:strings) {lparen>>(string >> (comma >> string).repeat).as(:strings) >> rparen}
  rule(:wochentage) {lparen>>(string >> (comma >> wochentag).repeat).as(:wochentage) >> rparen}

  rule(:bool_literal) { (str("true") | str("false")).as(:boolean) >> space? }
  rule(:besetzt_literal) { (str("frei") | str("besetzt")).as(:besetzt) >> space? }

  rule(:comparator) { space? >> (str("!=") | str("=")).as(:comparator) >> space? }
  rule(:in_comparator) { space? >> (str("!").maybe >> str("in")).as(:comparator) >> space? }

  rule(:and_operator) { str("and") >> space? }
  rule(:or_operator) { str("or") >> space? }

  rule(:day) { str('t') >> integer.as(:index)}

  rule(:dienst_expression) { (day >> str(".name") >> comparator >> string).as(:dienst_expression) }
  rule(:diensttyp_expression) { (day >> str(".typ") >> comparator >> string).as(:diensttyp_expression) }
  rule(:wochentag_expression) { (day >> str(".wochentag") >> comparator >> wochentag).as(:wochentag_expression) }

  rule(:dienste_expression) { (day >> str(".name") >> in_comparator >> strings).as(:dienste_expression) }
  rule(:diensttypen_expression) { (day >> str(".typ") >> in_comparator >> strings).as(:diensttypen_expression) }
  rule(:wochentage_expression) { (day >> str(".wochentag") >> in_comparator >> wochentage).as(:wochentage_expression) }

  rule(:besetzt_expression) { (day >> str(".") >> besetzt_literal).as(:besetzt_expression)}

  #Alle Ausdrücke beziehen sich auf Tag
  rule(:day_expression) { (dienst_expression | diensttyp_expression | wochentag_expression | dienste_expression | diensttypen_expression | wochentage_expression | besetzt_expression) } #(day >> str(".") >> property >> comparator >> value).as(:day_expression)

  rule(:expression) { bool_literal | day_expression }

  # Behandelt Klammern
  rule(:primary) { lparen >> or_operation >> rparen | expression }

  # Soll die Regel auch "!" verstehen?
  rule(:not_operation) { (str("not") >> space? >> primary).as(:not) | primary }

  # Rechts rekursiv
  rule(:and_operation) {
    (not_operation.as(:left) >> and_operator >>
        and_operation.as(:right)).as(:and) |
        not_operation }

  # Rechts rekursiv: Der rechte Teil (:right) ruft wieder diese Regel auf
  rule(:or_operation) {
    (and_operation.as(:left) >> or_operator >>
        or_operation.as(:right)).as(:or) |
        and_operation }

  # Start mit der Regel der tiefsten Priorität
  root(:or_operation)
end
