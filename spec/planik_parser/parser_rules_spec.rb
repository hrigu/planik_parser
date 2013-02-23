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
      context "digit" do
        let(:rule) { subject.d }
        it "should parse '1'" do
          rule.should parse("1")
        end
        it "should parse '12'" do
          rule.should_not parse("21")
        end
      end
      context "date_time" do
        let(:rule) { subject.date_time }
        it "should parse '2012-02-21:08:15:00'" do
          rule.should parse("2012-02-21T08:15:00")
        end
      end
      context "time" do
        let(:rule) { subject.time }
        it "should parse '08:15:00'" do
          rule.should parse("08:15:00")
        end
      end


      context "day" do
        let(:rule) { subject.day }
        it "should parse 't0'" do
          rule.should parse("t0")
        end
        it "should parse 't456'" do
          rule.should parse("t456")
        end

        context "return" do
          it "should return the index as string which represents an integer" do
            x = rule.parse("t456")[:index][:integer].should == "456"
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
      context "dienste_expression" do
        let(:rule) { subject.dienste_expression }
        it "should parse 't0.name in (A, B)'" do
          rule.should parse("t0.name in (A, B)")
          pp rule.parse "t0.name in (A, B)"
        end
        it "should parse 't0.name !in (A, B)'" do
          rule.should parse("t0.name !in (A, B)")
          pp rule.parse "t0.name !in (A, B)"
        end
      end
      context "diensttypen_expression" do
        let(:rule) { subject.diensttypen_expression }
        it "should parse 't0.typ in (A, B)'" do
          rule.should parse("t0.typ in (A, B)")
          pp rule.parse "t0.typ in (A, B)"
        end
        it "should parse 't0.typ !in (A, B)'" do
          rule.should parse("t0.typ !in (A, B)")
          pp rule.parse "t0.typ !in (A, B)"
        end
      end

      context "wochentage_expression" do
        let(:rule) { subject.wochentage_expression }
        it "should parse 't0.wochentag in (Mo, Do, Fr)'" do
          rule.should parse("t0.wochentag in (Mo, Do, Fr)")
          pp rule.parse "t0.wochentag in (Mo, Do, Fr)"
        end
        it "should parse 't0.wochentag !in (Mo, Do, Fr)'" do
          rule.should parse("t0.wochentag !in (Mo, Do, Fr)")
          pp rule.parse "t0.wochentag !in (Mo, Do, Fr)"
        end
      end
      context "besetzt_expression" do
        let(:rule) { subject.besetzt_expression }
        it "should parse 't0.besetzt'" do
          rule.should parse("t0.besetzt")
          pp rule.parse "t0.besetzt"
        end
        it "should parse 'should parse 't0.frei'" do
          rule.should parse("t0.frei")
          pp rule.parse "t0.frei"
        end
      end
      context "int_expression" do
        let(:rule) { subject.int_expression }
        it "should parse a int_expression'" do
          puts rule.parse("t0.zeit_von < 2012-01-31T12:33:00")
          puts rule.parse("t0.zeit_von < 12:33:00")
        end
      end


      context "day_expression" do
        let(:rule) { subject.day_expression }
        it "should parse a wochentag_expression'" do
          rule.should parse("t0.wochentag = Mo")
        end
        it "should parse a wochentage_expression'" do
          rule.should parse("t0.wochentag !in (Mo,Di)")
          pp rule.parse("t0.wochentag !in (Mo,Di)")
        end
      end
    end

    context "parser" do
      it "should parse a whole string" do
        pp subject.parse("t0.name = D1")
      end
    end
  end


end