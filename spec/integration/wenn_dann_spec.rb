require 'spec_helper'

module PlanikParser

  describe "wenn_dann" do

    let(:parser) { Parser.new }
    let(:transformer) { Transformer.new }

    def result
      rule = example.metadata[:description]
      tree = parser.parse(rule)
      transformer.apply(tree)
    end

    describe "boolean algebra" do
      it("not false") { result.should be true }
      it("true and not false") { result.should be true }
      it("not (true or false) or (true and not false)") { result.should be true }
      it("not (false or true)") { result.should be false }
      it("not false or true") { result.should be true }
    end
  end


end