require 'spec_helper'

module PlanikParser
  describe Transformer do
    let(:parser) { Parser.new }

    def transform string
      tree = parser.parse(string)
      puts tree
      subject.apply(tree)
    end

    describe "string" do
      it "should transform" do
        tree = {:string => "hi"}
        ast = subject.apply(tree)
        ast.should eq ("hi")
      end
    end

    describe "boolean node" do

      it "should transform" do
        ast = transform("true")
        ast.class.should eql (PlanikParser::BooleanNode)
        ast.name.should eql ("Boolean")
        ast.value.should eql true
      end
    end

    describe "and node" do
      it "should transform" do
        ast = transform("true and false")
        ast.name.should eql "And"
      end
      it "should transform recursive" do
        ast = transform("true and false and true")
        ast.name.should eql "And"
        #pp ast
      end
    end

    describe "or node" do
      it "should transform" do
        ast = transform("true or false")
        ast.name.should eql "Or"
        #pp ast
      end
      it "should transform recursive" do
        ast = transform("true and false or true or false or true and false")
        ast.name.should eql "Or"
        #pp ast
      end
    end

    describe "not node" do
      it "should transform" do
        ast = transform("not true")
        ast.name.should eql "Not"
        puts ast.to_s
      end

    end

    describe "expression node" do
      it "should transform a dienst_expression" do
        ast = transform("t0.name = D1")
        ast.class.should eq(PlanikParser::DienstNode)
        ast.name.should eq("Dienst")
      end
      it "should transform a diensttyp_expression" do
        ast = transform("t0.typ = DIENST")
        puts ast.to_s
        ast.class.should eq(PlanikParser::DiensttypNode)
        ast.name.should eq("Diensttyp")
      end

      it "should transform a wochentag_expression" do
        ast = transform("t0.wochentag = Mo")
        ast.class.should eq(PlanikParser::WochentagNode)
        ast.name.should eq("Wochentag")
      end

      it "should transform a dienste_expression" do
        ast = transform("t0.name in (D1, D2)")
        puts ast.to_s
        ast.class.should eq(PlanikParser::DienstNode)
        ast.name.should eq("Dienst")
        ast.property.should eq("name")
        ast.comparator.should eq("in")
        ast.value.should eq(["D1", "D2"])
      end
      it "should transform a diensttypen_expression" do
        ast = transform("t0.typ !in (DIENST, FREI)")
        puts ast.to_s
        ast.class.should eq(PlanikParser::DiensttypNode)
        ast.name.should eq("Diensttyp")
        ast.property.should eq("typ")
        ast.comparator.should eq("!in")
        ast.value.should eq(["DIENST", "FREI"])
      end
      it "should transform a wochentage_expression" do
        ast = transform("t8.wochentag !in (Mo, Fr)")
        puts ast.to_s
        ast.class.should eq(PlanikParser::WochentagNode)
        ast.name.should eq("Wochentag")
        ast.index.should eq 8
        ast.property.should eq("wochentag")
        ast.comparator.should eq("!in")
        ast.value.should eq(["Mo", "Fr"])
      end
    end

  end
end