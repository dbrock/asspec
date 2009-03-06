package org.asspec.util.mappings
{
  import org.asspec.specification.AbstractSpecification;
  import org.asspec.specify;
  import org.asspec.util.sequences.ArrayContainer;
  import org.asspec.util.sequences.SequenceContainer;

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

      it("should not allow ‘for .. in container’", function () : void {
        specify(function () : void {
          for (var string : String in container)
            ; }).should.throw_error; });
      it("should not allow ‘for each .. in container’", function () : void {
        specify(function () : void {
          for each (var element : Object in container)
            ; }).should.throw_error; });
      it("should allow ‘for each .. in container.keys’", function () : void {
        specify(function () : void {
          for each (var key : Object in container.keys)
            ; }).should.not.throw_error; });
      it("should allow ‘for each .. in container.values’", function () : void {
        specify(function () : void {
          for each (var key : Object in container.values)
            ; }).should.not.throw_error; });
      it("should allow ‘for each .. in container.pairs’", function () : void {
        specify(function () : void {
          for each (var key : Object in container.pairs)
            ; }).should.not.throw_error; });

      it("should enumerate keys by ‘for each .. in container.keys’", function () : void {
        const result : SequenceContainer = new ArrayContainer;

        for each (var key : Object in container.keys)
          result.add(key);

        specify(result.length).should.equal(2);
        specify(result.contains(null)).should.hold;
        specify(result.contains(value(0))).should.hold; });

      it("should enumerate values by ‘for each .. in container.values’", function () : void {
        const result : SequenceContainer = new ArrayContainer;

        for each (var value_ : Object in container.values)
          result.add(value_);

        specify(result.length).should.equal(2);
        specify(result.contains(null)).should.hold;
        specify(result.contains(value(1))).should.hold; });

      it("should enumerate pairs by ‘for each .. in container.pairs’", function () : void {
        const result : SequenceContainer = new ArrayContainer;

        for each (var pair : Object in container.pairs)
          result.add(pair);

        specify(result.length).should.equal(2);
        specify(result.contains(Pair.of(null, null))).should.hold;
        specify(result.contains(Pair.of(value(0), value(1)))).should.hold; });
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
