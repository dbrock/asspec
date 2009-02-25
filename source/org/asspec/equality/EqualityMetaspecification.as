package org.asspec.equality
{
  import org.asspec.specification.AbstractSpecification;
  import org.asspec.specify;

  public class EqualityMetaspecification extends AbstractSpecification
  {
    override protected function execute() : void
    {
      requirement("null should equal null", function () : void {
        specify(equal(null, null)).should.hold; });
      requirement("true should equal true", function () : void {
        specify(equal(true, true)).should.hold; });
      requirement("true should not equal false", function () : void {
        specify(equal(true, false)).should.not.hold; });
      requirement("string should equal itself", function () : void {
        specify(equal("foo", "foo")).should.hold; });
      requirement("string should not equal other string", function () : void {
        specify(equal("foo", "bar")).should.not.hold; });
      requirement("value should equal equal value", function () : void {
        specify(equal(new Value(0), new Value(0))).should.hold; });
      requirement("value should not equal different value", function () : void {
        specify(equal(new Value(0), new Value(1))).should.not.hold; });
      requirement("entity should equal itself", function () : void {
        const entity : Entity = new Entity;
        specify(equal(entity, entity)).should.hold; });
      requirement("entity should not equal other entity", function () : void {
        specify(equal(new Entity, new Entity)).should.not.hold; });
    }
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

class Entity
{}
