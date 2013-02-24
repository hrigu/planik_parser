require 'spec_helper'

module PlanikParser



  describe "boolean algebra" do
    let(:tree_builder) { TreeBuilder.new }

    def result
      rule = example.metadata[:description]
      tree = tree_builder.build(rule)
      tree.evaluate "dummy_evaluator"
    end

    it("not false") { result.should be true }
    it("true and false") { result.should be false }
    it("not (true or false) or (true and not false)") { result.should be true }
    it("not (false or true)") { result.should be false }
    it("not false or true") { result.should be true }
  end


end