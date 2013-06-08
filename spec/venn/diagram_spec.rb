require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Venn::Diagram do

  let(:diagram) { Venn::Diagram.new }

  it "should exist" do
    Venn::Diagram.nil?.must_equal false
  end

  [:a, :b].to_objects {[
    [[1, 2], [3, 4]],
    [[5, 6], [7, 8]]
  ]}.each do |test|
    describe "no match" do
      before do
        diagram.a_is test.a
        diagram.b_is test.b
      end

      it "should return set a" do
        diagram.a_only.must_equal test.a
      end

      it "should return set b" do
        diagram.b_only.must_equal test.b
      end
    
      it "should return nothing for a and b" do
        diagram.a_and_b.must_equal []
      end
    end
  end
end
