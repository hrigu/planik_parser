# encoding: utf-8
require 'spec_helper'

module PlanikParser

  module Rule

    describe WennDann do
      context "Situation: Alle Tage mit Dienste besetzt" do
        let(:situation) { SituationBuilder.new.build(
            start_datum: Date.parse("2013-01-07"),
            tage: [{name: "D1", typ: "DIENST"}, {name: "D3", typ: "DIENST"}, {name: "D1", typ: "DIENST"}, {name: "D2", typ: "DIENST"}]
        )
        }
        context "Regel hat Breite 2 (t0, t1)" do
          let(:rule) { WennDann.new("Nach D1 oder D3 kein D2", "t0.name = D1 or t0.name = D3", "not t1.name = D2") }
          it "Lösung hat situation.tage - (regel.breite Elemente - 1) Elemente" do
            wenn_dann_evaluator = WennDannEvaluator.new(rule, situation)
            wenn_dann_evaluator.evaluate.size.should eq situation.tage.size - (rule.bedingung.tree.breite-1)
            wenn_dann_evaluator.evaluate.should eq [true, true, false]
          end
        end
        context "Regel hat Breite 3 (t0, t2)" do
          let(:rule) { WennDann.new("Nach D3 am übernächsten Tage ein D2", "t0.name = D3", "t2.name = D2") }
          it "Lösung hat situation.tage - (regel.breite Elemente - 1) Elemente" do
            wenn_dann_evaluator = WennDannEvaluator.new(rule, situation)
            wenn_dann_evaluator.evaluate.size.should eq situation.tage.size - (rule.bedingung.tree.breite-1)
            puts situation
            puts rule
            wenn_dann_evaluator.evaluate.should eq [true, true]
          end
        end
      end

      context "Situation: Ein Tag leer" do
        let(:situation) { SituationBuilder.new.build(
            start_datum: Date.parse("2013-01-07"),
            tage: [{name: "D1", typ: "DIENST"}, {name: "D3", typ: "DIENST"}, nil, {name: "D2", typ: "DIENST"}]
        )
        }
        context "Dann true nach leer" do
          let(:rule) { WennDann.new("Nach D1 ein D3", "t0.name = D1", "t1.name = D3") }
          it "works" do
            wenn_dann_evaluator = WennDannEvaluator.new(rule, situation)
            puts situation
            wenn_dann_evaluator.evaluate.should eq [true, true, true] #TODO korrekt?
          end
        end
        context "wenn true vor leer" do
          let(:rule) { WennDann.new("Nach D1 ein D2", "t0.name = D1", "t1.name = D2") }
          it "works" do
            wenn_dann_evaluator = WennDannEvaluator.new(rule, situation)
            puts situation
            wenn_dann_evaluator.evaluate.should eq [false, true, true] #TODO korrekt?
          end
        end
      end


    end


  end

end