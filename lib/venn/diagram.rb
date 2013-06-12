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
      else
        ins = meth.to_s.split('_and_').map { |x| x.to_sym }
        outs = @values.keys.select { |x| ins.include?(x) == false }
        now = @values[ins.first.to_sym].select do |x|
                ins.select do |i|
                  @values[i.to_sym].include? x
                end.count == ins.count
              end
        now = now.select do |x|
          outs.select do |o|
            @values[o.to_s.to_sym].include?(x)
          end.count == 0
        end
        now
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
