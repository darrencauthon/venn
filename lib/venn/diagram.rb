module Venn
  class Diagram

    def initialize
      @values = {}
    end

    def method_missing(meth, *args, &blk)
      if meth[-3, 3] == '_is'
        id = meth[0, meth.length - 3].to_sym
        value = args[0]
        set_single_value id, value
      elsif meth[-4, 4] == '_are'
        id = meth[0, meth.length - 4].to_sym
        value = args[0]
        set_single_value id, value
      elsif meth[-5, 5] == '_only'
        id = meth[0, meth.length - 5].to_sym
        find_exclusive_values_in id
      else
        ins = meth.to_s.split('_and_')
        find_the_and_matches ins
      end
    end

    private

    def set_single_value id, value
      @values[id] = value
    end

    def find_exclusive_values_in id
      @values[id].select do |value| 
        @values.keys.select { |k| k != id }.
          select { |key| is_in?(value, key) }.count == 0
      end
    end

    def find_the_and_matches(ins)
      ins = ins.map { |x| x.to_sym }
      outs = @values.keys.select { |x| ins.include?(x) == false }
      matches = @values[ins.first].select do |x|
                  ins.select do |i|
                    @values[i].include? x
                  end.count == ins.count
                end
      matches.select do |x|
        outs.select do |o|
          @values[o].include?(x)
        end.count == 0
      end
    end

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
