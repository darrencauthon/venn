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
    describe "first example" do
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

      it "should return a and b and c" do
        diagram.a_and_b_and_c.must_equal ['abc']
      end
    end

    describe "second example" do
      before do
        diagram.a_is ['xyz', 'xy', 'xz', 'x']
        diagram.b_is ['xyz', 'xy', 'yz', 'y']
        diagram.c_is ['xyz', 'yz', 'xz', 'z']
      end

      it "should return a" do
        diagram.a_only.must_equal ['x']
      end

      it "should return b" do
        diagram.b_only.must_equal ['y']
      end

      it "should return c" do
        diagram.c_only.must_equal ['z']
      end

      it "should return a and b" do
        diagram.a_and_b.must_equal ['xy']
      end

      it "should return b and c" do
        diagram.b_and_c.must_equal ['yz']
      end

      it "should return a and c" do
        diagram.a_and_c.must_equal ['xz']
      end

      it "should return a and b and c" do
        diagram.a_and_b_and_c.must_equal ['xyz']
      end
    end
  end

  describe "setting values with are" do
    before do
      diagram.a_are ['a']
    end

    it "should have set the value" do
      diagram.a_only.must_equal ['a']
    end
  end

  describe "setting values with more than one letter" do
    before do
      diagram.good_items_are ['a', 'b']
      diagram.bad_items_are  ['b', 'c']
    end

    it "should have set the value" do
      diagram.good_items_only.must_equal ['a']
      diagram.bad_items_only.must_equal  ['c']
      diagram.good_items_and_bad_items.must_equal ['b']
    end
  end

  describe "a more complex example" do
    before do
      diagram.fizz_items_are [3,  6,  9, 12, 15, 18, 21]
      diagram.buzz_items_are [5, 10, 15, 20, 25, 30, 35]
    end

    it "should return the expected results" do
      diagram.fizz_items_only [3, 6, 9, 12, 18, 21]
      diagram.buzz_items_only [5, 10, 20, 25, 30, 35]
      diagram.fizz_items_and_buzz_items [15]
    end
  end
end
