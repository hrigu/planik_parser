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

    context "evaluate Breite" do
      it "evaluates Breite for an expression tree" do
        tree = subject.build("t0.name = D1 and t3.typ in (FREI, ABWESEND) or (t1.wochentag = Di or t2.wochentag = Fr)")
        tree.min_index.should eq 0
        tree.max_index.should eq 3
        tree.breite.should eq 3
      end
    end
  end

end
