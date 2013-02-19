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
        it "should parse integer with trailing whitespace '123  '" do
          @rule.should parse("123  ")
        end
      end
    end
  end


end