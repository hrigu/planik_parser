require 'spec_helper'

module PlanikParser

  describe Parser do
    context "subject"
    it "should be a PlanikParser" do
      subject.class.name.should == "PlanikParser::Parser"
    end

    context "parser_rules" do

      context "integer" do
        let(:rule) { subject.integer }
        it "should parse '123'" do
          rule.should parse("123")
        end
        #not used any more
        #it "should parse integer with trailing whitespace '123  '" do
        #  rule.should parse("123  ")
        #end
      end


      context "day" do
        let(:rule) { subject.day }
        it "should parse 't0'" do
          rule.should parse("t0")
        end
        it "should parse 't456'" do
          rule.should parse("t456")
        end

        it "should handle whitespace" do
          rule.should parse("t631 ")
        end

        context "return" do
          it "should return the index as string which represents an integer" do
            x = rule.parse("t456")[:index].should == "456"
          end
          it "should return handle whitespace" do
            x = rule.parse("t456  ")[:index].should == "456"
          end
        end

      end

      context "dienst_expression" do
        let(:rule) { subject.dienst_expression }
        it "should parse 't0.name = D1'" do
          rule.should parse("t0.name=D1")
          rule.should parse("t0.name = D1")
#          pp rule.parse "t0.name = D1"
        end
        it "should parse 't0.name != D1'" do
          rule.should parse("t0.name != D1")
          rule.should parse("t0.name = D1")
          #pp rule.parse "t0.name != D1"
        end
      end
      context "diensttyp_expression" do
        let(:rule) { subject.diensttyp_expression }
        it "should parse 't0.typ = DIENST'" do
          rule.should parse("t0.typ = DIENST")
          pp rule.parse "t0.typ = DIENST"
        end
      end
      context "wochentag_expression" do
        let(:rule) { subject.wochentag_expression }
        it "should parse 't0.wochentag = Mo'" do
          rule.should parse("t0.wochentag = Mo")
          pp rule.parse "t0.wochentag = Di"
        end
      end

      context "day_expression" do
        let(:rule) { subject.day_expression }
        it "should parse for example a wochentag_expression'" do
          rule.should parse("t0.wochentag = Mo")
          pp rule.parse "t0.wochentag = Di"
        end
      end

    end
  end


end