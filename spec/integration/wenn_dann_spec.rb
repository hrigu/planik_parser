require 'spec_helper'

module PlanikParser

  module Rule

    describe WennDann do
      it "works" do
        rule = WennDann.new("Nach D1 immer D2", "t0.name = D1", "t1.name = D2")
        #situation =
      end
    end


  end

end