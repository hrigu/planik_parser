require "parslet"

class PlanikParser::Parser < Parslet::Parser
  rule(:space) { match[" "].repeat(1) }
  rule(:space?) { space.maybe }

  rule(:lparen) { str("(") >> space? }
  rule(:rparen) { str(")") >> space? }
  rule(:comma) { str(",") >> space? }

  rule(:d) { match('[0-9]') }
  rule(:integer) { d.repeat(1).as(:integer) }
  rule(:string) { match('[A-Za-z0-9]').repeat(1).as(:string) >> space? }


  rule(:date_time) { (d.repeat(4, 4) >> str("-") >> d.repeat(2, 2) >> str("-") >> d.repeat(2, 2) >> str("T") >> d.repeat(2, 2) >> str(":") >> d.repeat(2, 2) >> str(":") >> d.repeat(2, 2)).as(:date_time) }
  rule(:time) { (d.repeat(2, 2) >> str(":") >> d.repeat(2, 2) >> str(":") >> d.repeat(2, 2)).as(:time) }
  rule(:date) { (d.repeat(4, 4) >> str("-") >> d.repeat(2, 2) >> str("-") >> d.repeat(2, 2)).as(:date) }

  rule(:bool_value) { (str("true") | str("false")).as(:boolean) >> space? }
  rule(:besetzt_value) { (str("frei") | str("besetzt")).as(:besetzt) >> space? }
  rule(:date_time_value) { date | time | date_time | integer } #TODO warum auch integer?

  rule(:wochentag) { (str("Mo") | str("Di")| str("Mi") | str("Do") | str("Fr") | str("Sa") | str("So")).as(:wochentag) >> space?}

  rule(:strings) { lparen>>(string >> (comma >> string).repeat).as(:strings) >> rparen }
  rule(:wochentage) { lparen>>(wochentag >> (comma >> wochentag).repeat).as(:wochentage) >> rparen }


  rule(:comparator) { space? >> (str("!=") | str("=")).as(:comparator) >> space? }
  rule(:in_comparator) { space? >> (str("!").maybe >> str("in")).as(:comparator) >> space? }
  rule(:int_comparator) { (str('<=') | str('>=') | str('>') | str('<') | str('=')).as(:comparator) >> space? }

  rule(:int_property) { str(".") >> (str("zeit_von") | str("zeit_bis") | str("dauer") | str("tag") | str("soll") | str("datum_zeit_von") | str("datum_zeit_bis") | str("datum")).as(:property) >> space? }
  rule(:dienst_property) {str(".") >> str("name").as(:property)}
  rule(:diensttyp_property) {str(".") >> str("typ").as(:property)}
  rule(:wochentag_property) {str(".") >> str("wochentag").as(:property)}

  rule(:and_operator) { str("and") >> space? }
  rule(:or_operator) { str("or") >> space? }

  rule(:day) { str('t') >> integer.as(:index) }

  rule(:dienst_expression) { (day >> dienst_property >> comparator >> string.as(:value)).as(:dienst_expression) }
  rule(:diensttyp_expression) { (day >> diensttyp_property >> comparator >> string.as(:value)).as(:diensttyp_expression) }
  rule(:wochentag_expression) { (day >> wochentag_property >> comparator >> wochentag.as(:value)).as(:wochentag_expression) }

  rule(:dienste_expression) { (day >> dienst_property >> in_comparator >> strings).as(:dienste_expression) }
  rule(:diensttypen_expression) { (day >> diensttyp_property >> in_comparator >> strings).as(:diensttypen_expression) }
  rule(:wochentage_expression) { (day >> wochentag_property >> in_comparator >> wochentage).as(:wochentage_expression) }

  rule(:besetzt_expression) { (day >> str(".") >> besetzt_value).as(:besetzt_expression) }
  rule(:int_expression) { (day >> int_property >> int_comparator >> date_time_value).as(:int_expression) }


  #TODO LFunctionCompare: 't' operand:LNumber '.' operand:IntProperty > operand:IntComparator > operand:LConst
  #TODO LFunctionSubstractCompare: 't' operand:LNumber '.' operand:IntProperty > '-' > 't' operand:LNumber '.' operand:IntProperty > operand:IntComparator > operand:LConst


  #Alle Ausdrücke beziehen sich auf Tag
  rule(:day_expression) { (
    dienst_expression | diensttyp_expression | wochentag_expression |
    dienste_expression | diensttypen_expression | wochentage_expression |
    besetzt_expression | int_expression) } #(day >> str(".") >> property >> comparator >> value).as(:day_expression)

  rule(:expression) { bool_value | day_expression }

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
