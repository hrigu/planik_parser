$:.unshift File.dirname(__FILE__) + "/../lib"
require 'planik_parser'
require 'parslet'
require 'pp'

pp tree = PlanikParser::Parser.new.parse("t0.typ = DIENST and true or not t0.wochentag = Mo")

