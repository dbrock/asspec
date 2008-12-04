package org.asspec.util
{
  import org.asspec.Assert;
  import org.asspec.spec.Specification;

  public class ArraySequenceSpecification extends Specification
  {
    override protected function execute() : void
    {
      requirement("an empty sequence should stringify correctly", function () : void {
        Assert.equal("[]", new ArraySequence([]).toString()); });
      requirement("a sequence of numbers should stringify correctly", function () : void {
        Assert.equal("[1, 2, 3]", new ArraySequence([1, 2, 3]).toString()); });
      requirement("a sequence with an object should stringify correctly", function () : void {
        Assert.equal("[{ a: 1 }]", new ArraySequence([{ a: 1 }]).toString()); });

      requirement("empty sequences should be equal", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([])); });
      requirement("equal primitive sequences should be equal", function () : void {
        Assert.equal(new ArraySequence([1, 2]), new ArraySequence([1, 2])); });
      requirement("different primitive sequences should not be equal", function () : void {
        Assert.notEqual(new ArraySequence([1, 2]), new ArraySequence([1, 1])); });
      requirement("a number sequence should not equal a string sequence", function () : void {
        Assert.notEqual(new ArraySequence([1]), new ArraySequence(["1"])); });
      requirement("sequences of equal values should be equal", function () : void {
        Assert.equal(new ArraySequence([new Value(1)]), new ArraySequence([new Value(1)])); });
      requirement("sequences of different values should not be equal", function () : void {
        Assert.notEqual(new ArraySequence([new Value(1)]), new ArraySequence([new Value(2)])); });

      requirement("empty sequence should be empty", function () : void {
        Assert.that(new ArraySequence([]).empty); });
      requirement("non-empty sequence should not be empty", function () : void {
        Assert.that(!new ArraySequence([1]).empty); });

      requirement("empty sequence should have length zero", function () : void {
        Assert.equal(0, new ArraySequence([]).length); });
      requirement("singleton sequence should have length one", function () : void {
        Assert.equal(1, new ArraySequence([1]).length); });
      requirement("pair sequence should have length two", function () : void {
        Assert.equal(2, new ArraySequence([1, 2]).length); });

      requirement("first of empty sequence should be null", function () : void {
        Assert.equal(null, new ArraySequence([]).first); });
      requirement("first of singleton sequence should be the element", function () : void {
        Assert.equal("foo", new ArraySequence(["foo"]).first); });

      requirement("rest of empty sequence should be empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([]).rest); });
      requirement("rest of singleton sequence should be empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence(["foo"]).rest); });
      requirement("rest of two-element sequence should be singleton sequence", function () : void {
        Assert.equal(new ArraySequence(["bar"]), new ArraySequence(["foo", "bar"]).rest); });

      requirement("cons with empty sequence should be singleton", function () : void {
        Assert.equal(new ArraySequence(["foo"]), new ArraySequence([]).cons("foo")); });
      requirement("cons with singleton should be pair", function () : void {
        Assert.equal(new ArraySequence(["bar", "foo"]), new ArraySequence(["foo"]).cons("bar")); });
      requirement("cons should not modify original sequence", function () : void {
        const sequence : ArraySequence = new ArraySequence(["foo"]);
        sequence.cons("bar");
        Assert.equal(new ArraySequence(["foo"]), sequence);
      });

      requirement("map on empty sequence should be empty sequence", function () : void {
        Assert.equal(new ArraySequence([]).map(identity), new ArraySequence([])); });
      requirement("map on empty sequence should not invoke mapper", function () : void {
        new ArraySequence([]).map(Assert.fail); });
      requirement("map on singleton should map element", function () : void {
        Assert.equal(new ArraySequence(["1"]), new ArraySequence([1]).map(Reflection.inspect)); });
      requirement("map on pair should map elements", function () : void {
        Assert.equal(new ArraySequence(["1", "2"]), new ArraySequence([1, 2]).map(Reflection.inspect)); });

      requirement("‘forEach’ on empty sequence should not invoke callback", function () : void {
        new ArraySequence([]).forEach(Assert.fail); });

      requirement("‘forEach’ on singleton should invoke callback with element", function () : void {
        var actual : Object = null;
        function callback(object : Object) : void { actual = object; }
        new ArraySequence([1]).forEach(callback);
        Assert.equal(1, actual);
      });

      requirement("‘forEach’ on pair should invoke callback with elements", function () : void {
        var actuals : Array = [];
        new ArraySequence([1, 2]).forEach(actuals.push);
        Assert.equal(new ArraySequence([1, 2]), new ArraySequence(actuals));
      });

      requirement("filter on empty sequence should give empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([]).filter(constantlyTrue)); });

      requirement("passing filter on singleton should give singleton", function () : void {
        Assert.equal(new ArraySequence([1]), new ArraySequence([1]).filter(positive)); });
      requirement("blocking filter on singleton should give empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([-1]).filter(positive)); });
      requirement("contingent filter on pair should give singleton", function () : void {
        Assert.equal(new ArraySequence([+1]), new ArraySequence([+1, -1]).filter(positive)); });

      requirement("‘takeWhile’ on empty sequence should give empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([]).takeWhile(Assert.fail)); });
      requirement("‘takeWhile’ true on singleton should give singleton", function () : void {
        Assert.equal(new ArraySequence([1]), new ArraySequence([1]).takeWhile(constantlyTrue)); });
      requirement("‘takeWhile’ false on singleton should give empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([1]).takeWhile(constantlyFalse)); });
      requirement("‘takeWhile’ true/false on pair should give singleton", function () : void {
        Assert.equal(new ArraySequence([+1]), new ArraySequence([+1, -1]).takeWhile(positive)); });
      requirement("‘takeWhile’ false/true on pair should give empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([-1, +1]).takeWhile(positive)); });

      requirement("‘dropWhile’ on empty sequence should give empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([]).dropWhile(Assert.fail)); });
      requirement("‘dropWhile’ true on singleton should give empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([1]).dropWhile(constantlyTrue)); });
      requirement("‘dropWhile’ false on singleton should give singleton", function () : void {
        Assert.equal(new ArraySequence([1]), new ArraySequence([1]).dropWhile(constantlyFalse)); });
      requirement("‘dropWhile’ true/false on pair should give singleton", function () : void {
        Assert.equal(new ArraySequence([-1]), new ArraySequence([+1, -1]).dropWhile(positive)); });
      requirement("‘dropWhile’ false/true on pair should give pair", function () : void {
        Assert.equal(new ArraySequence([-1, +1]), new ArraySequence([-1, +1]).dropWhile(positive)); });

      requirement("‘takeUntil’ on empty sequence should give empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([]).takeUntil(Assert.fail)); });
      requirement("‘takeUntil’ true on singleton should give empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([1]).takeUntil(constantlyTrue)); });
      requirement("‘takeUntil’ false on singleton should give singleton", function () : void {
        Assert.equal(new ArraySequence([1]), new ArraySequence([1]).takeUntil(constantlyFalse)); });
      requirement("‘takeUntil’ true/false on pair should give empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([+1, -1]).takeUntil(positive)); });
      requirement("‘takeUntil’ false/true on pair should give singleton", function () : void {
        Assert.equal(new ArraySequence([-1]), new ArraySequence([-1, +1]).takeUntil(positive)); });

      requirement("‘dropUntil’ on empty sequence should give empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([]).dropUntil(Assert.fail)); });
      requirement("‘dropUntil’ true on singleton should give singleton", function () : void {
        Assert.equal(new ArraySequence([1]), new ArraySequence([1]).dropUntil(constantlyTrue)); });
      requirement("‘dropUntil’ false on singleton should give empty sequence", function () : void {
        Assert.equal(new ArraySequence([]), new ArraySequence([1]).dropUntil(constantlyFalse)); });
      requirement("‘dropUntil’ true/false on pair should give pair", function () : void {
        Assert.equal(new ArraySequence([+1, -1]), new ArraySequence([+1, -1]).dropUntil(positive)); });
      requirement("‘dropUntil’ false/true on pair should give singleton", function () : void {
        Assert.equal(new ArraySequence([+1]), new ArraySequence([-1, +1]).dropUntil(positive)); });

      requirement("joining empty sequence should give empty string", function () : void {
        Assert.equal("", new ArraySequence([]).join(", ")); });
      requirement("joining singleton sequence should give singleton string", function () : void {
        Assert.equal("1", new ArraySequence([1]).join(", ")); });
      requirement("joining pair should give joined string", function () : void {
        Assert.equal("1, 2", new ArraySequence([1, 2]).join(", ")); });
      requirement("joining object pair should give joined object string", function () : void {
        Assert.equal("{ a: 1 }; { b: 2 }", new ArraySequence([{ a: 1 }, { b: 2 }]).join("; ")); });

      requirement("‘any’ on empty sequence should give false", function () : void {
        Assert.equal(false, new ArraySequence([]).any(Assert.fail)); });
      requirement("‘any’ on negative singleton sequence should give false", function () : void {
        Assert.equal(false, new ArraySequence([-1]).any(positive)); });
      requirement("‘any’ on positive singleton sequence should give true", function () : void {
        Assert.equal(true, new ArraySequence([+1]).any(positive)); });
      requirement("‘any’ on contingent pair should give true", function () : void {
        Assert.equal(true, new ArraySequence([-1, +1]).any(positive)); });

      requirement("‘all’ on empty sequence should give true", function () : void {
        Assert.equal(true, new ArraySequence([]).all(Assert.fail)); });
      requirement("‘all’ on negative singleton sequence should give false", function () : void {
        Assert.equal(false, new ArraySequence([-1]).all(positive)); });
      requirement("‘all’ on positive singleton sequence should give true", function () : void {
        Assert.equal(true, new ArraySequence([+1]).all(positive)); });
      requirement("‘all’ on contingent pair should give false", function () : void {
        Assert.equal(false, new ArraySequence([-1, +1]).all(positive)); });

      requirement("‘ensureNullableType’ on empty sequence should return", function () : void {
        Assert.returnsNormally(function () : void {
          new ArraySequence([]).ensureNullableType(String); }); });
      requirement("‘ensureNullableType’ on null singleton should return", function () : void {
        Assert.returnsNormally(function () : void {
          new ArraySequence([null]).ensureNullableType(String); }); });
      requirement("‘ensureNullableType’ on compatible singleton should return", function () : void {
        Assert.returnsNormally(function () : void {
          new ArraySequence(["foo"]).ensureNullableType(String); }); });
      requirement("‘ensureNullableType’ on incompatible singleton should throw", function () : void {
        Assert.throwsError(function () : void {
          new ArraySequence([123]).ensureNullableType(String); }); });

      requirement("‘ensureType’ on empty sequence should return", function () : void {
        Assert.returnsNormally(function () : void {
          new ArraySequence([]).ensureType(String); }); });
      requirement("‘ensureType’ on null singleton should throw", function () : void {
        Assert.throwsError(function () : void {
          new ArraySequence([null]).ensureType(String); }); });
      requirement("‘ensureType’ on compatible singleton should return", function () : void {
        Assert.returnsNormally(function () : void {
          new ArraySequence(["foo"]).ensureType(String); }); });
      requirement("‘ensureType’ on incompatible singleton should throw", function () : void {
        Assert.throwsError(function () : void {
          new ArraySequence([123]).ensureType(String); }); });

      requirement("‘toArray’ on empty sequence should return empty array", function () : void {
        Assert.equal([], new ArraySequence([]).toArray()) });
      requirement("‘toArray’ on singleton should return singleton array", function () : void {
        Assert.equal([1], new ArraySequence([1]).toArray()) });
      requirement("‘toArray’ should return fresh array instance", function () : void {
        const source : Array = [];
        Assert.notSame(source, new ArraySequence(source).toArray())
      });

      requirement("‘toString’ should inspect contents", function () : void {
        Assert.equal("[{ a: 1 }]", new ArraySequence([{ a: 1 }]).toString()) });

      requirement("adding an element to an empty sequence should produce a singleton", function () : void {
        const sequence : ArraySequence = new ArraySequence([]);
        sequence.add(1);
        Assert.equal(new ArraySequence([1]), sequence)
      });

      requirement("adding an element to a singleton produce a pair", function () : void {
        const sequence : ArraySequence = new ArraySequence([1]);
        sequence.add(2);
        Assert.equal(new ArraySequence([1, 2]), sequence)
      });

      requirement("looping through an empty sequence should not do anything", function () : void {
        for each (var element : Object in new ArraySequence([]))
          Assert.fail();
      });

      requirement("looping through a pair should enumerate the pair", function () : void {
        const result : Array = [];

        for each (var element : Object in new ArraySequence([1, 2]))
          result.push(element);

        Assert.equal([1, 2], result);
      });
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

  public function equals(other : Object) : Boolean
  { return other is Value && Value(other).value == value; }
}
