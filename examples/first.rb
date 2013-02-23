$:.unshift File.dirname(__FILE__) + "/../lib"
require 'planik_parser'

#tree = PlanikParser::TreeBuilder.new.build("t0.typ = DIENST and t2.name = D1 or not t1.wochentag = Mo")
#tree = PlanikParser::TreeBuilder.new.build("t0.typ = DIENST and t2.name = D1 or not t3.wochentag = Di or not t1.wochentag = Mo")
tree = PlanikParser::TreeBuilder.new.build("t3.wochentag = Di and t1.wochentag = Mo")
#tree = PlanikParser::TreeBuilder.new.build("t0.typ = DIENST and t2.name = D1")

puts tree

