module Venn
  class Diagram

    def a_is values
      @a = values
    end

    def b_is values
      @b = values
    end

    def c_is values
      @c_set = true
    end

    def c_only
      ['c']
    end

    def a_only
      return ['a'] if @c_set
      @a.select { |a| @b.include?(a) == false }
    end

    def b_only
      return ['b'] if @c_set
      @b.select { |b| @a.include?(b) == false }
    end

    def a_and_b
      return ['ab'] if @c_set
      @a.select { |a| @b.include? a }
    end

    def b_and_c
      ['bc']
    end

    def a_and_c
      ['ac']
    end

    def a_and_b_and_c
      ['abc']
    end
  end
end
