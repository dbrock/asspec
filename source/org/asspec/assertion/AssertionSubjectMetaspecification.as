package org.asspec.assertion
{
  import org.asspec.assertion.AbstractAssertionMetaspecification;

  public class AssertionSubjectMetaspecification
    extends AbstractAssertionMetaspecification
  {
    override protected function execute() : void
    {
      requirement("specifying that true should hold should pass", function () : void {
        shouldPass(function () : void { $(true).should.hold; }); });
      requirement("specifying that false should hold should fail", function () : void {
        shouldFail(function () : void { $(false).should.hold; }); });
      requirement("specifying that false should not hold should pass", function () : void {
        shouldPass(function () : void { $(false).should.not.hold; }); });
      requirement("specifying that true should not hold should fail", function () : void {
        shouldFail(function () : void { $(true).should.not.hold; }); });

      requirement("specifying that true should not not hold should pass", function () : void {
        shouldPass(function () : void { $(true).should.not.not.hold; }); });

      requirement("specifying that [] should equal [] should pass", function () : void {
        shouldPass(function () : void { $([]).should.equal([]); }); });
      requirement("specifying that [] should equal [1] should fail", function () : void {
        shouldFail(function () : void { $([]).should.equal([1]); }); });
      requirement("specifying that [] should not equal [1] should pass", function () : void {
        shouldPass(function () : void { $([]).should.not.equal([1]); }); });
      requirement("specifying that [] should not equal [] should fail", function () : void {
        shouldFail(function () : void { $([]).should.not.equal([]); }); });

      requirement("specifying that [] should be the same object as itself should pass", function () : void {
        const foo : Array = [];
        shouldPass(function () : void { $(foo).should.be_the_same_object_as(foo); }); });
      requirement("specifying that [] should be the same object as [] should fail", function () : void {
        shouldFail(function () : void { $([]).should.be_the_same_object_as([]); }); });
      requirement("specifying that [] should not be the same object as [] should pass", function () : void {
        shouldPass(function () : void { $([]).should.not.be_the_same_object_as([]); }); });
      requirement("specifying that [] should not be the same object as itself should fail", function () : void {
        const foo : Array = [];
        shouldFail(function () : void { $(foo).should.not.be_the_same_object_as(foo); }); });

      requirement("specifying that 1 should equal either of (1, 2) should pass", function () : void {
        shouldPass(function () : void { $(1).should.equal_either_of(1, 2); }); });
      requirement("specifying that 1 should equal either of (2, 3) should fail", function () : void {
        shouldFail(function () : void { $(1).should.equal_either_of(2, 3); }); });
      requirement("specifying that 1 should equal neither of (2, 3) should pass", function () : void {
        shouldPass(function () : void { $(1).should.not.equal_either_of(2, 3); }); });
      requirement("specifying that 1 should equal neither of (1, 2) should fail", function () : void {
        shouldFail(function () : void { $(1).should.not.equal_either_of(1, 2); }); });

      requirement("specifying that throwing function should throw should pass", function () : void {
        shouldPass(function () : void { $(throwingFunction).should.throw_error; }); });
      requirement("specifying that returning function should throw should fail", function () : void {
        shouldFail(function () : void { $(returningFunction).should.throw_error; }); });
      requirement("specifying that returning function should not throw should pass", function () : void {
        shouldPass(function () : void { $(returningFunction).should.not.throw_error; }); });
      requirement("specifying that throwing function should not throw should fail", function () : void {
        shouldFail(function () : void { $(throwingFunction).should.not.throw_error; }); });

      requirement("specifying that returning function should return should pass", function () : void {
        shouldPass(function () : void { $(returningFunction).should.return_normally; }); });
      requirement("specifying that throwing function should return should fail", function () : void {
        shouldFail(function () : void { $(throwingFunction).should.return_normally; }); });
      requirement("specifying that throwing function should not return should pass", function () : void {
        shouldPass(function () : void { $(throwingFunction).should.not.return_normally; }); });
      requirement("specifying that returning function should not return should fail", function () : void {
        shouldFail(function () : void { $(returningFunction).should.not.return_normally; }); });

      requirement("specifying that [1] should look like [1] should pass", function () : void {
        shouldPass(function () : void { $([1]).should.look_like("[1]"); }); });
      requirement("specifying that [1] should look like [] should fail", function () : void {
        shouldFail(function () : void { $([1]).should.look_like("[]"); }); });
      requirement("specifying that [1] should not look like [] should pass", function () : void {
        shouldPass(function () : void { $([1]).should.not.look_like("[]"); }); });
      requirement("specifying that [1] should not look like [1] should fail", function () : void {
        shouldFail(function () : void { $([1]).should.not.look_like("[1]"); }); });
    }

    private static function returningFunction() : void {}
    private static function throwingFunction() : void { throw new Error; }
  }
}

class Entity
{}
