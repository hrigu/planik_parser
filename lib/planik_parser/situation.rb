require 'date'

module PlanikParser
  class Situation
    attr_accessor :tage, :start_date
    def initialize start_date
      @start_date = start_date
    end

  end

  class Tag
    attr_accessor :dienst, :date
    @@wochentage = ["So", "Mo", "Di", "Mi", "Do", "Fr", "Sa"]

    def initialize dienst
      @dienst = dienst
    end

    def wochentag
      @@wochentage[date.wday]
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
      situation = Situation.new Date.parse("2013-01-07")
      diensttypen = ["DIENST", "FERIEN"]
      dienstart = Dienstart.new("D1", diensttypen[0])
      dienst = Dienst.new(dienstart)
      tag = Tag.new(dienst)
      tag.dienst = dienst
      situation.days = [tag]
      situation
    end

    def create_day day_spec
      if (day_spec.empty?)
        Tag.new(nil)
        else
          Tag.new(Dienst.new(Dienstart.new(day_spec[:name], day_spec[:typ])))
      end
    end

    def build spec
      start_date = spec[:start_datum] ||= Date.parse("2013-01-07") #start an einem Montag
      situation = Situation.new(start_date)
      days = spec[:tage].map do |day_spec|
        create_day(day_spec)
      end

      days.each_with_index do |d, i|
        d.date = start_date.next_day(i)
      end
      situation.tage = days;
      situation
    end


  end
end