module Venn
  class Diagram

    def a_is values
      @a = values
    end

    def b_is values
      @b = values
    end

    def a_only
      @a
    end

    def b_only
      @b
    end

    def a_and_b
      []
    end
  end
end

