module PlanikParser
  class Situation
    attr_accessor :mitarbeiter
  end

  class Mitarbeiter
    attr_accessor :tage, :name
    def initialize name
     @name = name
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
      mitarbeiter = Mitarbeiter.new("Franz")
      mitarbeiter.tage = [tag]
      situation = Situation.new
      situation.mitarbeiter=[mitarbeiter]
      situation
    end
  end
end