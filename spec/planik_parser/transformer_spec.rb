require 'spec_helper'

module PlanikParser
  describe Transformer do
    let(:parser) { Parser.new }

    def transform string
      tree = parser.parse(string)
      subject.apply(tree)
    end

    describe "boolean node" do

      it "should transform" do
        tree = transform("true")
        tree.class.name.should eql ("PlanikParser::Leaf")
        tree.to_s.should eql ("true")
        tree.value.should eql true
      end
    end

    describe "and node" do
      it "should transform" do
        tree = transform("true and false")
        tree.name.should eql "and"
      end
      it "should transform recursive" do
        tree = transform("true and false and true")
        tree.name.should eql "and"
        #pp tree
      end
    end

    describe "or node" do
      it "should transform" do
        tree = transform("true or false")
        tree.name.should eql "or"
        #pp tree
      end
      it "should transform recursive" do
        tree = transform("true and false or true or false or true and false")
        tree.name.should eql "or"
        #pp tree
      end
    end

    describe "not node" do
      it "should transform" do
        tree = transform("not true")
        tree.name.should eql "not"
        puts tree.to_s
      end
    end

  end
end