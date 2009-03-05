package org.asspec.util.mappings
{
  import org.asspec.specification.AbstractSpecification;
  import org.asspec.specify;

  public class ArrayMappingContainerMetaspecification
    extends AbstractSpecification
  {
    private const container : ArrayMappingContainer
      = new ArrayMappingContainer;

    override protected function execute() : void
    {
      it("should not initially have ‘null’", function () : void {
        specify(container.has(null)).should.not.hold; });

      it("should not allow getting non-existing value", function () : void {
        specify(function () : void { container.get(null); })
          .should.throw_error_of_type(ArgumentError); });

      it("should not allow removing non-existing value", function () : void {
        specify(function () : void { container.remove(null); })
          .should.throw_error_of_type(ArgumentError); });

      container.set(null, null);

      it("should have null after setting it", function () : void {
        specify(container.has(null)).should.hold; });

      it("should return null after setting null to null", function () : void {
        specify(container.get(null)).should.equal(null); });

      it("should not have null after removing it", function () : void {
        container.remove(null);
        specify(container.has(null)).should.not.hold; });

      container.set(value(0), value(1));

      it("should have Value(0) after setting it", function () : void {
        specify(container.has(value(0))).should.hold; });

      it("should not have Value(1) after setting Value(0)", function () : void {
        specify(container.has(value(1))).should.not.hold; });

      it("should return Value(1) after setting Value(0) to Value(1)", function () : void {
        specify(container.get(value(0))).should.equal(value(1)); });

      it("should allow replacing a value", function () : void {
        container.set(value(0), value(2));
        specify(container.get(value(0))).should.equal(value(2)); });

      it("should remember one value after removing another", function () : void {
        container.set(value(2), value(3));
        container.remove(value(0));
        specify(container.get(value(2))).should.equal(value(3)); });
    }
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

  public function toString() : String
  { return "Value(" + value + ")"; }
}
