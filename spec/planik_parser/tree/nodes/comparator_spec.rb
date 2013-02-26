require 'spec_helper'

module PlanikParser

  describe EqualComparator do
    context "comparator: =" do
      let(:comparator) do
        node = DienstNode.new(13, "name", "=", "D1")
        EqualComparator.new("=", node)
      end

      it "should return true when target is == value" do
        comparator.compare_with("D1").should eq true
      end
      it "should return false when target is != value" do
        comparator.compare_with("D2").should eq false
      end
      it "should return false when target is nil" do
        comparator.compare_with(nil).should eq nil
      end
    end
  end
end