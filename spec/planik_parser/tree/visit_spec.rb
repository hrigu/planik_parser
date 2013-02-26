require 'spec_helper'

module PlanikParser
  describe Transformer do
    let(:parser) { Parser.new }

    def transform string
      tree = parser.parse(string)
      puts tree
      subject.apply(tree)
    end

    it "should visit nodes top down" do
      ast = transform("not t8.wochentag !in (Mo, Fr)")
      puts ast.to_s
      ast.visit do |node|
        puts node.to_s
      end
    end

  end
end