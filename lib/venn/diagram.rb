module Venn
  class Diagram

    def initialize
      @values = {}
    end

    def a_is values
      @values[:a] = values
    end

    def b_is values
      @values[:b] = values
    end

    def c_is values
      @values[:c] = values
    end

    def c_only
      @values[:c].select do |a| 
        keys = @values.keys.select { |x| x != :c }
        keys.select do |key|
          @values[key].include?(a)
        end.count == 0
      end
    end

    def a_only
      @values[:a].select do |a| 
        keys = @values.keys.select { |x| x != :a }
        keys.select do |key|
          @values[key].include?(a)
        end.count == 0
      end
    end

    def b_only
      @values[:b].select do |a| 
        keys = @values.keys.select { |x| x != :b }
        keys.select do |key|
          @values[key].include?(a)
        end.count == 0
      end
    end

    def a_and_b
      @values[:c] ||= []
      @values[:a].select do |a|
        @values[:b].include? a and
          @values[:c].include?(a) == false
      end
    end

    def b_and_c
      @values[:b].select do |b|
        @values[:c].include? b and
          @values[:a].include?(b) == false
      end
    end

    def a_and_c
      @values[:a].select do |b|
        @values[:c].include? b and
          @values[:b].include?(b) == false
      end
    end

    def a_and_b_and_c
      @values[:a].select do |b|
        @values[:c].include? b and
          @values[:b].include?(b)
      end
    end
  end
end
