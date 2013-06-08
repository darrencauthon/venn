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

  [:a, :b, :a_only, :b_only, :a_and_b].to_objects {[
    [[1, 2], [2, 3], [1], [3], [2]],
    [['a', 'b'], ['b', 'c'], ['a'], ['c'], ['b']]
  ]}.each do |test|
    describe "one match" do
      before do
        diagram.a_is test.a
        diagram.b_is test.b
      end

      it "should return a" do
        diagram.a_only.must_equal test.a_only
      end

      it "should return b" do
        diagram.b_only.must_equal test.b_only
      end
    
      it "should return the one match for a and b" do
        diagram.a_and_b.must_equal test.a_and_b
      end
    end
  end

  describe "three sets of data with a few matches" do
    before do
      diagram.a_is ['abc', 'ab', 'ac', 'a']
      diagram.b_is ['abc', 'ab', 'bc', 'b']
      diagram.c_is ['abc', 'bc', 'ac', 'c']
    end

    it "should return a" do
      diagram.a_only.must_equal ['a']
    end

    it "should return b" do
      diagram.b_only.must_equal ['b']
    end

    it "should return c" do
      diagram.c_only.must_equal ['c']
    end

    it "should return a and b" do
      diagram.a_and_b.must_equal ['ab']
    end

    it "should return b and c" do
      diagram.b_and_c.must_equal ['bc']
    end

    it "should return a and c" do
      diagram.a_and_c.must_equal ['ac']
    end
  end
end
