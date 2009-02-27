package org.asspec.util
{
  import org.asspec.fail;
  import org.asspec.specification.AbstractSpecification;
  import org.asspec.specify;
  import org.asspec.util.inspection.Inspection;

  public class ArrayContainerMetaspecification extends AbstractSpecification
  {
    private function seq(... content : Array) : Sequencable
    { return new ArrayContainer(content); }

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
        specify(seq(new Value(1))).should.equal(seq(new Value(1))); });
      requirement("sequences of different values should not be equal", function () : void {
        specify(seq(new Value(1))).should.not.equal(seq(new Value(2))); });

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

      requirement("first of empty sequence should be null", function () : void {
        specify(seq().first).should.equal(null); });
      requirement("first of singleton sequence should be the element", function () : void {
        specify(seq("foo").first).should.equal("foo"); });

      requirement("rest of empty sequence should be empty sequence", function () : void {
        specify(seq().rest).should.equal(seq()); });
      requirement("rest of singleton sequence should be empty sequence", function () : void {
        specify(seq("foo").rest).should.equal(seq()); });
      requirement("rest of two-element sequence should be singleton sequence", function () : void {
        specify(seq("foo", "bar").rest).should.equal(seq("bar")); });

      requirement("cons with empty sequence should be singleton", function () : void {
        specify(seq().cons("foo")).should.equal(seq("foo")); });
      requirement("cons with singleton should be pair", function () : void {
        specify(seq("foo").cons("bar")).should.equal(seq("bar", "foo")); });
      requirement("cons should not modify original sequence", function () : void {
        const foo : Sequencable = seq("foo");
        foo.cons("bar");
        specify(foo).should.equal(seq("foo")); });

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
        const foo : ArrayContainer = new ArrayContainer;
        foo.add(1);
        specify(foo).should.equal(seq(1)); });

      requirement("adding an element to a singleton should produce a pair", function () : void {
        const foo : ArrayContainer = new ArrayContainer([1]);
        foo.add(2);
        specify(foo).should.equal(seq(1, 2)); });

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

class Value implements EqualityComparable
{
  private var value : int;

  public function Value(value : int)
  { this.value = value; }

  public function equals(other : EqualityComparable) : Boolean
  { return other is Value && Value(other).value == value; }
}
