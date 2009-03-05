package org.asspec.util.sequences
{
  import org.asspec.fail;
  import org.asspec.specification.AbstractSpecification;
  import org.asspec.specify;
  import org.asspec.util.inspection.Inspection;

  public class ArrayContainerMetaspecification extends AbstractSpecification
  {
    private function seq(... content : Array) : SequenceContainer
    { return new ArrayContainer(content); }

    private const seq123 : SequenceContainer = seq(1, 2, 3);

    override protected function execute() : void
    {
      requirement("an empty sequence should stringify correctly", function () : void {
        specify(seq()).should.look_like("[]"); });
      requirement("a sequence of numbers should stringify correctly", function () : void {
        specify(seq(1, 2, 3)).should.look_like("[1, 2, 3]"); });
      requirement("a sequence with an object should stringify correctly", function () : void {
        specify(seq({ a: 1 })).should.look_like("[{ a: 1 }]"); });

      requirement("empty sequences should be equal", function () : void {
        specify(seq()).should.equal(seq()); });
      requirement("equal primitive sequences should be equal", function () : void {
        specify(seq(1, 2)).should.equal(seq(1, 2)); });
      requirement("different primitive sequences should not be equal", function () : void {
        specify(seq(1, 2)).should.not.equal(seq(1, 1)); });
      requirement("a number sequence should not equal a string sequence", function () : void {
        specify(seq(1)).should.not.equal(seq("1")); });
      requirement("sequences of equal values should be equal", function () : void {
        specify(seq(value(1))).should.equal(seq(value(1))); });
      requirement("sequences of different values should not be equal", function () : void {
        specify(seq(value(1))).should.not.equal(seq(value(2))); });

      requirement("empty sequence should be empty", function () : void {
        specify(seq().empty).should.hold; });
      requirement("non-empty sequence should not be empty", function () : void {
        specify(seq(1).empty).should.not.hold; });

      requirement("empty sequence should have length zero", function () : void {
        specify(seq().length).should.equal(0); });
      requirement("singleton sequence should have length one", function () : void {
        specify(seq(1).length).should.equal(1); });
      requirement("pair sequence should have length two", function () : void {
        specify(seq(1, 2).length).should.equal(2); });

      requirement("empty sequence should not have index 0", function () : void {
        specify(seq().hasIndex(0)).should.not.hold; });
      requirement("empty sequence should not have index -1", function () : void {
        specify(seq().hasIndex(-1)).should.not.hold; });
      requirement("singleton sequence should have index 0", function () : void {
        specify(seq(1).hasIndex(0)).should.hold; });
      requirement("singleton sequence should have index -1", function () : void {
        specify(seq(1).hasIndex(-1)).should.hold; });
      requirement("singleton sequence should not have index 1", function () : void {
        specify(seq(1).hasIndex(1)).should.not.hold; });
      requirement("singleton sequence should not have index -2", function () : void {
        specify(seq(1).hasIndex(-2)).should.not.hold; });

      requirement("empty sequence should not contain null", function () : void {
        specify(seq().contains(null)).should.not.hold; });
      requirement("sequence with null should contain it", function () : void {
        specify(seq(null).contains(null)).should.hold; });
      requirement("sequence with Value(0) should contain it", function () : void {
        specify(seq(null, value(0)).contains(value(0))).should.hold; });

      requirement("attempt to retrieve index of non-existing value should throw", function () : void {
        specify(function () : void { seq().getIndexOf(null); })
          .should.throw_error_of_type(ArgumentError); });
      requirement("index of null in [null] should be 0", function () : void {
        specify(seq(null).getIndexOf(null)).should.equal(0); });
      requirement("index of Value(0) in [null, Value(0)] should be 1", function () : void {
        specify(seq(null, value(0)).getIndexOf(value(0))).should.equal(1); });

      it("should not allow taking the first of empty sequence", function () : void {
        specify(function () : void { seq().first; })
          .should.throw_error_of_type(ArgumentError); });
      it("should allow taking the first of non-empty sequence", function () : void {
        specify(function () : void { seq(null).first; })
          .should.not.throw_error; });

      it("should return the correct first element", function () : void {
        specify(seq(1, 2, 3).first).should.equal(1); });

      it("should not allow taking the rest of empty sequence", function () : void {
        specify(function () : void { seq().rest; })
          .should.throw_error_of_type(ArgumentError); });
      it("should allow taking the rest of non-empty sequence", function () : void {
        specify(function () : void { seq(null).rest; })
          .should.not.throw_error; });

      requirement("rest of [1] should be empty sequence", function () : void {
        specify(seq(1).rest).should.equal(seq()); });
      requirement("rest of [1, 2] should be [2]", function () : void {
        specify(seq(1, 2).rest).should.equal(seq(2)); });
      requirement("rest of [1, 2, 3] should be [2, 3]", function () : void {
        specify(seq(1, 2, 3).rest).should.equal(seq(2, 3)); });

      it("should not allow taking the last of empty sequence", function () : void {
        specify(function () : void { seq().last; })
          .should.throw_error_of_type(ArgumentError); });
      it("should allow taking the last of non-empty sequence", function () : void {
        specify(function () : void { seq(null).last; })
          .should.not.throw_error; });

      requirement("last of [1, 2, 3] should be 3", function () : void {
        specify(seq(1, 2, 3).last).should.equal(3); });

      it("should not allow getting a high non-existing element", function () : void {
        specify(function () : void { seq().get(0); })
          .should.throw_error_of_type(ArgumentError); });
      it("should not allow getting a low non-existing element", function () : void {
        specify(function () : void { seq().get(-1); })
          .should.throw_error_of_type(ArgumentError); });
      it("should allow getting an existing element", function () : void {
        specify(function () : void { seq("a").get(0); })
          .should.not.throw_error; });

      requirement("getting value 0 should return the first value", function () : void {
        specify(seq("a", "b").get(0)).should.equal("a"); });
      requirement("getting value 1 should return the second value", function () : void {
        specify(seq("a", "b").get(1)).should.equal("b"); });

      requirement("getting value -1 should return the last value", function () : void {
        specify(seq("a", "b").get(-1)).should.equal("b"); });
      requirement("getting value -2 should return the second-to-last value", function () : void {
        specify(seq("a", "b").get(-2)).should.equal("a"); });

      requirement("cons with empty sequence should be singleton", function () : void {
        specify(seq().cons("foo")).should.equal(seq("foo")); });
      requirement("cons with singleton should be pair", function () : void {
        specify(seq("foo").cons("bar")).should.equal(seq("bar", "foo")); });
      requirement("cons should not modify original sequence", function () : void {
        seq123.cons(0);
        specify(seq123).should.equal(seq(1, 2, 3)); });

      requirement("map on empty sequence should be empty sequence", function () : void {
        specify(seq().map(identity)).should.equal(seq()); });
      requirement("map on empty sequence should not invoke mapper", function () : void {
        seq().map(fail); });
      requirement("map on singleton should map element", function () : void {
        specify(seq(1).map(Inspection.inspect)).should.equal(seq("1")); });
      requirement("map on pair should map elements", function () : void {
        specify(seq(1, 2).map(Inspection.inspect)).should.equal(seq("1", "2")); });

      requirement("‘forEach’ on empty sequence should not invoke callback", function () : void {
        seq().forEach(fail); });

      requirement("‘forEach’ on singleton should invoke callback with element", function () : void {
        const result : Array = [];
        seq(1).forEach(result.push);
        specify(result).should.equal([1]); });

      requirement("‘forEach’ on pair should invoke callback with elements", function () : void {
        const result : Array = [];
        seq(1, 2).forEach(result.push);
        specify(result).should.equal([1, 2]); });

      requirement("filter on empty sequence should give empty sequence", function () : void {
        specify(seq().filter(constantlyTrue)).should.equal(seq()); });

      requirement("passing filter on singleton should give singleton", function () : void {
        specify(seq(1).filter(positive)).should.equal(seq(1)); });
      requirement("blocking filter on singleton should give empty sequence", function () : void {
        specify(seq(-1).filter(positive)).should.equal(seq()); });
      requirement("contingent filter on pair should give singleton", function () : void {
        specify(seq(+1, -1).filter(positive)).should.equal(seq(+1)); });

      requirement("‘takeWhile’ on empty sequence should give empty sequence", function () : void {
        specify(seq().takeWhile(fail)).should.equal(seq()); });
      requirement("‘takeWhile’ true on singleton should give singleton", function () : void {
        specify(seq(1).takeWhile(constantlyTrue)).should.equal(seq(1)); });
      requirement("‘takeWhile’ false on singleton should give empty sequence", function () : void {
        specify(seq(1).takeWhile(constantlyFalse)).should.equal(seq()); });
      requirement("‘takeWhile’ true/false on pair should give singleton", function () : void {
        specify(seq(+1, -1).takeWhile(positive)).should.equal(seq(+1)); });
      requirement("‘takeWhile’ false/true on pair should give empty sequence", function () : void {
        specify(seq(-1, +1).takeWhile(positive)).should.equal(seq()); });

      requirement("‘dropWhile’ on empty sequence should give empty sequence", function () : void {
        specify(seq().dropWhile(fail)).should.equal(seq()); });
      requirement("‘dropWhile’ true on singleton should give empty sequence", function () : void {
        specify(seq(1).dropWhile(constantlyTrue)).should.equal(seq()); });
      requirement("‘dropWhile’ false on singleton should give singleton", function () : void {
        specify(seq(1).dropWhile(constantlyFalse)).should.equal(seq(1)); });
      requirement("‘dropWhile’ true/false on pair should give singleton", function () : void {
        specify(seq(+1, -1).dropWhile(positive)).should.equal(seq(-1)); });
      requirement("‘dropWhile’ false/true on pair should give pair", function () : void {
        specify(seq(-1, +1).dropWhile(positive)).should.equal(seq(-1, +1)); });

      requirement("‘takeUntil’ on empty sequence should give empty sequence", function () : void {
        specify(seq().takeUntil(fail)).should.equal(seq()); });
      requirement("‘takeUntil’ true on singleton should give empty sequence", function () : void {
        specify(seq(1).takeUntil(constantlyTrue)).should.equal(seq()); });
      requirement("‘takeUntil’ false on singleton should give singleton", function () : void {
        specify(seq(1).takeUntil(constantlyFalse)).should.equal(seq(1)); });
      requirement("‘takeUntil’ true/false on pair should give empty sequence", function () : void {
        specify(seq(+1, -1).takeUntil(positive)).should.equal(seq()); });
      requirement("‘takeUntil’ false/true on pair should give singleton", function () : void {
        specify(seq(-1, +1).takeUntil(positive)).should.equal(seq(-1)); });

      requirement("‘dropUntil’ on empty sequence should give empty sequence", function () : void {
        specify(seq().dropUntil(fail)).should.equal(seq()); });
      requirement("‘dropUntil’ true on singleton should give singleton", function () : void {
        specify(seq(1).dropUntil(constantlyTrue)).should.equal(seq(1)); });
      requirement("‘dropUntil’ false on singleton should give empty sequence", function () : void {
        specify(seq(1).dropUntil(constantlyFalse)).should.equal(seq()); });
      requirement("‘dropUntil’ true/false on pair should give pair", function () : void {
        specify(seq(+1, -1).dropUntil(positive)).should.equal(seq(+1, -1)); });
      requirement("‘dropUntil’ false/true on pair should give singleton", function () : void {
        specify(seq(-1, +1).dropUntil(positive)).should.equal(seq(+1)); });

      requirement("joining empty sequence should give empty string", function () : void {
        specify(seq().join(", ")).should.equal(""); });
      requirement("joining singleton sequence should give singleton string", function () : void {
        specify(seq(1).join(", ")).should.equal("1"); });
      requirement("joining pair should give joined string", function () : void {
        specify(seq(1, 2).join(", ")).should.equal("1, 2"); });
      requirement("joining object pair should give joined object string", function () : void {
        specify(seq({ a: 1 }, { b: 2 }).join("; "))
          .should.equal("{ a: 1 }; { b: 2 }"); });

      requirement("‘any’ on empty sequence should give false", function () : void {
        specify(seq().any(fail)).should.equal(false); });
      requirement("‘any’ on negative singleton sequence should give false", function () : void {
        specify(seq(-1).any(positive)).should.equal(false); });
      requirement("‘any’ on positive singleton sequence should give true", function () : void {
        specify(seq(+1).any(positive)).should.equal(true); });
      requirement("‘any’ on contingent pair should give true", function () : void {
        specify(seq(-1, +1).any(positive)).should.equal(true); });

      requirement("‘all’ on empty sequence should give true", function () : void {
        specify(seq().all(fail)).should.equal(true); });
      requirement("‘all’ on negative singleton sequence should give false", function () : void {
        specify(seq(-1).all(positive)).should.equal(false); });
      requirement("‘all’ on positive singleton sequence should give true", function () : void {
        specify(seq(+1).all(positive)).should.equal(true); });
      requirement("‘all’ on contingent pair should give false", function () : void {
        specify(seq(-1, +1).all(positive)).should.equal(false); });

      requirement("‘ensureNullableType’ on empty sequence should return", function () : void {
        specify(function () : void { seq().ensureNullableType(String); })
          .should.return_normally; });
      requirement("‘ensureNullableType’ on null singleton should return", function () : void {
        specify(function () : void { seq(null).ensureNullableType(String); })
          .should.return_normally; });
      requirement("‘ensureNullableType’ on compatible singleton should return", function () : void {
        specify(function () : void { seq("foo").ensureNullableType(String); })
          .should.return_normally; });
      requirement("‘ensureNullableType’ on incompatible singleton should throw", function () : void {
        specify(function () : void { seq(123).ensureNullableType(String); })
          .should.throw_error; });

      requirement("‘ensureType’ on empty sequence should return", function () : void {
        specify(function () : void { seq().ensureType(String); })
          .should.return_normally; });
      requirement("‘ensureType’ on null singleton should throw", function () : void {
        specify(function () : void { seq(null).ensureType(String); })
          .should.throw_error; });
      requirement("‘ensureType’ on compatible singleton should return", function () : void {
        specify(function () : void { seq("foo").ensureType(String); })
          .should.return_normally; });
      requirement("‘ensureType’ on incompatible singleton should throw", function () : void {
        specify(function () : void { seq(123).ensureType(String); })
          .should.throw_error; });

      requirement("‘getArrayCopy’ on empty sequence should return empty array", function () : void {
        specify(seq().getArrayCopy()).should.equal([]) });
      requirement("‘getArrayCopy’ on singleton should return singleton array", function () : void {
        specify(seq(1).getArrayCopy()).should.equal([1]) });
      requirement("‘getArrayCopy’ should return fresh array instance", function () : void {
        const original : Array = [];
        specify(seq(original).getArrayCopy())
          .should.not.be_the_same_object_as(original); });

      requirement("‘toString’ should inspect contents", function () : void {
        specify(seq({ a: 1 })).should.look_like("[{ a: 1 }]"); });

      requirement("adding an element to an empty sequence should produce a singleton", function () : void {
        const foo : SequenceContainer = seq();
        foo.add(1);
        specify(foo).should.equal(seq(1)); });
      requirement("adding an element to a singleton should produce a pair", function () : void {
        const foo : SequenceContainer = seq(1);
        foo.add(2);
        specify(foo).should.equal(seq(1, 2)); });

      it("should not allow setting high non-existing element", function () : void {
        specify(function () : void { seq().set(0, null); })
          .should.throw_error_of_type(ArgumentError); });
      it("should not allow setting low non-existing element", function () : void {
        specify(function () : void { seq().set(-1, null); })
          .should.throw_error_of_type(ArgumentError); });
      it("should allow setting existing element", function () : void {
        specify(function () : void { seq(null).set(0, null); })
          .should.not.throw_error; });

      requirement("setting element 0 should change its value", function () : void {
        seq123.set(0, "x");
        specify(seq123).should.equal(seq("x", 2, 3)); });
      requirement("setting element 1 should change its value", function () : void {
        seq123.set(1, "x");
        specify(seq123).should.equal(seq(1, "x", 3)); });
      requirement("setting element -1 should change its value", function () : void {
        seq123.set(-1, "x");
        specify(seq123).should.equal(seq(1, 2, "x")); });
      requirement("setting element -2 should change its value", function () : void {
        seq123.set(-2, "x");
        specify(seq123).should.equal(seq(1, "x", 3)); });

      it("should not allow removing element at high non-existing index", function () : void {
        specify(function () : void { seq().removeAt(0); })
          .should.throw_error_of_type(ArgumentError); });
      it("should not allow removing element at low non-existing index", function () : void {
        specify(function () : void { seq().removeAt(-1); })
          .should.throw_error_of_type(ArgumentError); });
      it("should allow removing element at existing index", function () : void {
        specify(function () : void { seq(null).removeAt(0); })
          .should.not.throw_error; });

      requirement("removing element 0 should remove the first element", function () : void {
        seq123.removeAt(0);
        specify(seq123).should.equal(seq(2, 3)); });
      requirement("removing element 1 should remove the second element", function () : void {
        seq123.removeAt(1);
        specify(seq123).should.equal(seq(1, 3)); });
      requirement("removing element -1 should remove the last element", function () : void {
        seq123.removeAt(-1);
        specify(seq123).should.equal(seq(1, 2)); });
      requirement("removing element -2 should remove the second-to-last element", function () : void {
        seq123.removeAt(-2);
        specify(seq123).should.equal(seq(1, 3)); });

      requirement("empty sequence should not have value for first slot", function () : void {
        specify(seq().getSlotAt(0).hasValue).should.not.hold; })
      requirement("singleton sequence should have value for first slot", function () : void {
        specify(seq(null).getSlotAt(0).hasValue).should.hold; })

      it("should not allow first slot of empty sequence to return value", function () : void {
        specify(function () : void { seq().getSlotAt(0).value; })
          .should.throw_error_of_type(ArgumentError); });
      it("should allow first slot of singleton sequence to return value", function () : void {
        specify(function () : void { seq(null).getSlotAt(0).value; })
          .should.not.throw_error; });

      it("should return correct value through slot 0", function () : void {
        specify(seq(1, 2, 3).getSlotAt(0).value).should.equal(1); });
      it("should return correct value through slot 1", function () : void {
        specify(seq(1, 2, 3).getSlotAt(1).value).should.equal(2); });
      it("should return correct value through slot -1", function () : void {
        specify(seq(1, 2, 3).getSlotAt(-1).value).should.equal(3); });

      it("should set value through slot 0 correctly", function () : void {
        seq123.getSlotAt(0).value = "x";
        specify(seq123).should.equal(seq("x", 2, 3)); });
      it("should set value through slot 1 correctly", function () : void {
        seq123.getSlotAt(1).value = "x";
        specify(seq123).should.equal(seq(1, "x", 3)); });
      it("should set value through slot -1 correctly", function () : void {
        seq123.getSlotAt(-1).value = "x";
        specify(seq123).should.equal(seq(1, 2, "x")); });

      requirement("slot -1 should always refer to the last slot", function () : void {
        const lastSlot : SequenceContainerSlot = seq123.getSlotAt(-1);
        seq123.add(4);
        specify(lastSlot.value).should.equal(4); });

      it("should remove slot 0 correctly", function () : void {
        seq123.getSlotAt(0).remove();
        specify(seq123).should.equal(seq(2, 3)); });
      it("should remove slot 1 correctly", function () : void {
        seq123.getSlotAt(1).remove();
        specify(seq123).should.equal(seq(1, 3)); });
      it("should remove slot -1 correctly", function () : void {
        seq123.getSlotAt(-1).remove();
        specify(seq123).should.equal(seq(1, 2)); });

      requirement("additional slot should not have value", function () : void {
        specify(seq123.getAdditionalSlot().hasValue).should.not.hold; });
      requirement("additional slot with value should have value", function () : void {
        const slot : SequenceContainerSlot = seq123.getAdditionalSlot();
        slot.value = 4;
        specify(slot.hasValue).should.hold; });
      requirement("additional slot should remember its value", function () : void {
        const slot : SequenceContainerSlot = seq123.getAdditionalSlot();
        slot.value = 4;
        specify(slot.value).should.equal(4); });
      requirement("setting value of additional slot should add value", function () : void {
        seq123.getAdditionalSlot().value = 4;
        specify(seq123).should.equal(seq(1, 2, 3, 4)); });
      requirement("removing additional slot without value should not be allowed", function () : void {
        specify(function () : void { seq123.getAdditionalSlot().remove(); })
          .should.throw_error_of_type(ArgumentError); });
      requirement("removing additional slot with value should be allowed", function () : void {
        const slot : SequenceContainerSlot = seq123.getAdditionalSlot();
        slot.value = 4;
        specify(function () : void { slot.remove(); })
          .should.not.throw_error; });
      requirement("removing additional slot should remove the value", function () : void {
        const slot : SequenceContainerSlot = seq123.getAdditionalSlot();
        slot.value = 4;
        slot.remove();
        specify(seq123).should.equal(seq(1, 2, 3)); });
      requirement("removed additional slot at the end should not have value", function () : void {
        const slot : SequenceContainerSlot = seq123.getAdditionalSlot();
        slot.value = 4;
        slot.remove();
        specify(slot.hasValue).should.not.hold; });
      requirement("removed additional slot in the middle should have value", function () : void {
        const slot : SequenceContainerSlot = seq123.getAdditionalSlot();
        slot.value = 4;
        seq123.add(5);
        slot.remove();
        specify(slot.hasValue).should.hold; });
      requirement("removed additional slot in the middle should have the right value", function () : void {
        const slot : SequenceContainerSlot = seq123.getAdditionalSlot();
        slot.value = 4;
        seq123.add(5);
        slot.remove();
        specify(slot.value).should.equal(5); });
      requirement("additional slots should be independent", function () : void {
        const slot1 : SequenceContainerSlot = seq123.getAdditionalSlot();
        const slot2 : SequenceContainerSlot = seq123.getAdditionalSlot();
        slot1.value = 4;
        specify(slot2.hasValue).should.not.hold; });
      requirement("looping through the slots of [1, 2, 3] should work correctly", function () : void {
        for each (var slot : SequenceContainerSlot in seq123.slots)
          slot.value *= 10;

        specify(seq123).should.equal(seq(10, 20, 30)); });

      requirement("looping through an empty sequence should not do anything", function () : void {
        for each (var element : Object in seq())
          fail(); });

      requirement("looping through a pair should enumerate the pair", function () : void {
        const result : Array = [];

        for each (var element : Object in seq(1, 2))
          result.push(element);

        specify(result).should.equal([1, 2]); });
    }

    private static function identity(object : Object) : Object
    { return object; }
    private static function constantlyTrue(object : Object) : Object
    { return true; }
    private static function constantlyFalse(object : Object) : Object
    { return false; }

    private static function positive(number : int) : Boolean
    { return number > 0; }
  }
}

import org.asspec.util.EqualityComparable;

function value(value : int) : Value
{ return new Value(value); }

class Value implements EqualityComparable
{
  private var value : int;

  public function Value(value : int)
  { this.value = value; }

  public function equals(other : EqualityComparable) : Boolean
  { return other is Value && Value(other).value == value; }
}
