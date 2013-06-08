module Venn
  class Diagram

    def a_is values
      @a = values
    end

    def b_is values
      @b = values
    end

    def a_only
      @a.select { |a| @b.include?(a) == false }
    end

    def b_only
      @b.select { |b| @a.include?(b) == false }
    end

    def a_and_b
      @a.select { |a| @b.include? a }
    end
  end
end

