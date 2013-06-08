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

    def a_only
      @values[:a].select do |value| 
        is_not_in?(value, :b) && is_not_in?(value, :c)
      end
    end

    def b_only
      @values[:b].select do |value| 
        is_not_in?(value, :a) && is_not_in?(value, :c)
      end
    end

    def c_only
      @values[:c].select do |value| 
        is_not_in?(value, :a) && is_not_in?(value, :b)
      end
    end

    def a_and_b
      @values[:a].select do |value|
        is_in?(value, :b) && is_not_in?(value, :c)
      end
    end

    def a_and_c
      @values[:a].select do |value|
        is_in?(value, :c) && is_not_in?(value, :b)
      end
    end

    def b_and_c
      @values[:b].select do |value|
        is_in?(value, :c) && is_not_in?(value, :a)
      end
    end

    def a_and_b_and_c
      @values[:a].select do |value|
        is_in?(value, :b) && is_in?(value, :c)
      end
    end

    private
    def is_in?(value, key)
      @values[key].include? value
    rescue
      false
    end

    def is_not_in?(value, key)
      @values[key].include?(value) == false
    rescue
      true
    end
  end
end
