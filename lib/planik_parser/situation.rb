module PlanikParser
  class Situation
    attr_accessor :tage
    def initialize tage
      @tage = tage
    end
  end

  class Tag
    attr_accessor :dienst, :name

    def initialize name, dienst
      @name, @dienst = name, dienst
    end
  end

  class Dienst
    attr_accessor :dienstart, :name

    def initialize dienstart
      @dienstart = dienstart
    end

    def name
      @dienstart.name
    end

    def typ
      @dienstart.typ
    end
  end
  class Dienstart
    attr_accessor :name, :typ

    def initialize name, typ
      @name, @typ = name, typ
    end
  end


  class SituationBuilder
    def simple
      diensttypen = ["DIENST", "FERIEN"]
      dienstart = Dienstart.new("D1", diensttypen[0])
      dienst = Dienst.new(dienstart)
      tag = Tag.new("Mo", dienst)
      tag.dienst = dienst
      situation = Situation.new
      situation.tage=[tag]
      situation
    end

    def create_day name, typ
      Tag.new("name", Dienst.new(Dienstart.new(name, typ)))
    end

    def build spec
      days = spec.map do |day_spec|
        create_day(day_spec[:name], day_spec[:typ])
      end
      Situation.new(days)
    end


  end
end