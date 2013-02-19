require 'spec_helper'

module PlanikParser

  describe Parser do
    context "subject"
    it "should be a PlanikParser" do
      subject.class.name.should == "PlanikParser::Parser"
    end

    context "rules" do

      context "integer" do
        before :each do
          @rule = subject.integer
        end
        it "should parse '123'" do
          @rule.should parse("123")
        end
        #it "should parse integer with trailing whitespace '123  '" do
        #  @rule.should parse("123  ")
        #end
      end


      context "day" do
        before :each do
          @rule = subject.day
        end
        it "should parse 't0'" do
          @rule.should parse("t0")
        end
        it "should parse 't456'" do
          @rule.should parse("t456")
        end

        it "should handle whitespace 't631 '" do
          @rule.should parse("t631 ")
        end

        context "return" do
          it "should return the index as string which represents an integer" do
            x = @rule.parse("t456")[:index].should == "456"
          end
          it "should return handle whitespace" do
            x = @rule.parse("t456  ")[:index].should == "456"
          end

        end

      end
    end
  end


end