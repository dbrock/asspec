package org.asspec.equality
{
  import org.asspec.specification.AbstractSpecification;

  public class EqualityMetaspecification extends AbstractSpecification
  {
    override protected function execute() : void
    {
      require_equal(null, null);
      require_equal(true, true);
      require_unequal(true, false);
      require_equal("foo", "foo");
      require_unequal("foo", "bar");
      require_equal(new Value(0), new Value(0));
      require_unequal(new Value(0), new Value(1));

      const entity1 : Entity = new Entity;
      const entity2 : Entity = new Entity;
      require_equal(entity1, entity1);
      require_unequal(entity1, entity2);
    }

    private function require_equal(a : Object, b : Object) : void
    {
      requirement(a + " should equal " + b, function () : void {
        specify(equal(a, b)).should.hold; });
    }

    private function require_unequal(a : Object, b : Object) : void
    {
      requirement(a + " should not equal " + b, function () : void {
        specify(equal(a, b)).should.not.hold; });
    }

    private function equal(a : Object, b : Object) : Boolean
    { return Equality.equals(a, b); }
  }
}

import org.asspec.util.EqualityComparable;

class Value implements EqualityComparable
{
  private var value : int;

  public function Value(value : int)
  { this.value = value; }

  public function toString() : String
  { return "Value(" + value + ")"; }

  public function equals(other : EqualityComparable) : Boolean
  { return other is Value && Value(other).value == value; }
}

class Entity
{}
