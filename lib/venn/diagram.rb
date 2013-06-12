module Venn
  class Diagram

    def initialize
      @values = {}
    end

    def method_missing(meth, *args, &blk)
      if meth[-3, 3] == '_is'
        @values[meth[0, meth.length - 3].to_sym] = args[0]
      elsif meth[-5, 5] == '_only'
        id = meth[0, meth.length - 5].to_sym
        @values[id].select do |value| 
          @values.keys.select { |k| k != id }.
            select { |key| is_in?(value, key) }.count == 0
        end
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
