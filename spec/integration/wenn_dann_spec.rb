require 'spec_helper'

module PlanikParser

  describe "wenn_dann" do

    let(:tree_builder) { TreeBuilder.new }

    def result
      rule = example.metadata[:description]
      tree = tree_builder.build(rule)
      tree.evaluate
    end

    describe "boolean algebra" do
      it("not false") { result.should be true }
      it("true and false") { result.should be false }
      it("not (true or false) or (true and not false)") { result.should be true }
      it("not (false or true)") { result.should be false }
      it("not false or true") { result.should be true }
    end

    describe "with expressions" do
      it("not (t0.name=D1 or t0.typ !in (DIENST, FREI))") { result() }
    end
  end


end