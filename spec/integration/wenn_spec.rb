require 'spec_helper'

module PlanikParser

  describe "wenn" do

    let(:tree_builder) { TreeBuilder.new }

    context "combination of expressions" do
      context "same day" do
          let(:situation) { SituationBuilder.new.build(
              start_datum: Date.parse("2013-01-07"), #start an einem Montag,
              tage: [{name: "D1", typ: "DIENST"}]) }

          it "example with true" do
            tree = tree_builder.build "t0.wochentag = Mo and (t0.name = D1 or t0.typ != DIENST)"
            evaluator = Evaluator.new(tree, situation)
            evaluator.evaluate.should eq [true]
          end

          it "example with false" do
            tree = tree_builder.build "t0.typ = DIENST and t0.name !in (D1, D2)"
            evaluator = Evaluator.new(tree, situation)
            evaluator.evaluate.should eq [false]
        end
      end

      context "two days with different dienste" do
        context "or" do
          let(:situation) { SituationBuilder.new.build(
              start_datum: Date.parse("2013-01-07"), #start an einem Montag,
              tage: [{name: "D1", typ: "DIENST"}, {name: "D2", typ: "DIENST"}]) }

          it "example with true" do
            tree = tree_builder.build "t0.name = D1 and t1.name = D2"
            evaluator = Evaluator.new(tree, situation)
            evaluator.evaluate.should eq [true]
          end
          it "example with false" do
            tree = tree_builder.build "t0.typ = FERIEN or t1.name = D1"
            evaluator = Evaluator.new(tree, situation)
            evaluator.evaluate.should eq [false]
          end

        end
      end
    end

    context "Mehrere Zeitfenster" do
      let(:situation) {
        SituationBuilder.new.build(
            start_datum: Date.parse("2013-01-04"), #start Freitag
            tage: [
                {name: "D1", typ: "DIENST"},
                {name: "D2", typ: "DIENST"},
                {name: "F", typ: "FERIEN"},
                {}, #freier Tag
                {name: "D1", typ: "DIENST"}
            ]) }

      it "Regel an einem Tag" do
        tree = tree_builder.build "t0.name = D1"
        evaluator = Evaluator.new(tree, situation)
        evaluator.evaluate.should eq [true, false, false, nil, true]
      end
      it "Regel mit zwei auf einander folgenden Tage" do
        tree = tree_builder.build "t0.name = D1 or t1.typ = FERIEN"
        evaluator = Evaluator.new(tree, situation)
        evaluator.evaluate.should eq [true, true, nil, false]
      end
      it "Regel mit zwei nicht anschliessenden Tage" do
        tree = tree_builder.build "t0.name = D1 or t2.wochentag = Mo"
        evaluator = Evaluator.new(tree, situation)
        evaluator.evaluate.should eq [true, true, false]
      end
      #it "Regel mit Wochentagen Tage" do
      #  tree = tree_builder.build "t0.wochentag in (Fr, Mo)"
      #  evaluator = Evaluator.new(tree, situation)
      #  evaluator.evaluate.should eq [true, false, false, true, false]
      #end

    end


  end


end