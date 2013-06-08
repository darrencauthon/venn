require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Venn::Diagram do

  let(:diagram) { Venn::Diagram.new }

  it "should exist" do
    Venn::Diagram.nil?.must_equal false
  end

  describe "simple situation" do

    before do
      diagram.a_is [1, 2]
      diagram.b_is [3, 4]
    end

    it "should return set a" do
      diagram.a_only.must_equal [1, 2]
    end

    it "should return set b" do
      diagram.b_only.must_equal [3, 4]
    end
  
    it "should return nothing for a and b" do
      diagram.a_and_b.must_equal []
    end
  end
end

