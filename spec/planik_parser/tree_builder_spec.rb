require 'spec_helper'

module PlanikParser
  describe TreeBuilder do

    it "should build a tree and set parents" do
      tree = subject.build("true and false or true or false or true and false")
      root = tree.root
      root.name.should eql "Or"
      root.left.name.should eq "And"
      root.left.parent.should be root
      root.left.left.name.should eql "Boolean"
      root.left.left.parent.should be root.left
      root.right.parent.should be root
      root.right.right.parent.should be root.right

      puts root.to_s
    end
  end

end
