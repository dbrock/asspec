package org.asspec.assertion
{
  import org.asspec.AssertionError;

  public class AssertionSubjectMetaspecification
    extends AbstractAssertionMetaspecification
  {
    override protected function execute() : void
    {
      requirement("specifying that true should hold should pass", function () : void {
        shouldPass(function () : void { specify(true).should.hold; }); });
      requirement("specifying that false should hold should fail", function () : void {
        shouldFail(function () : void { specify(false).should.hold; }); });
      requirement("specifying that false should not hold should pass", function () : void {
        shouldPass(function () : void { specify(false).should.not.hold; }); });
      requirement("specifying that true should not hold should fail", function () : void {
        shouldFail(function () : void { specify(true).should.not.hold; }); });

      requirement("specifying that true should not not hold should pass", function () : void {
        shouldPass(function () : void { specify(true).should.not.not.hold; }); });

      requirement("specifying that [] should equal [] should pass", function () : void {
        shouldPass(function () : void { specify([]).should.equal([]); }); });
      requirement("specifying that [] should equal [1] should fail", function () : void {
        shouldFail(function () : void { specify([]).should.equal([1]); }); });
      requirement("specifying that [] should not equal [1] should pass", function () : void {
        shouldPass(function () : void { specify([]).should.not.equal([1]); }); });
      requirement("specifying that [] should not equal [] should fail", function () : void {
        shouldFail(function () : void { specify([]).should.not.equal([]); }); });

      requirement("specifying that [] should be the same object as itself should pass", function () : void {
        const foo : Array = [];
        shouldPass(function () : void { specify(foo).should.be_the_same_object_as(foo); }); });
      requirement("specifying that [] should be the same object as [] should fail", function () : void {
        shouldFail(function () : void { specify([]).should.be_the_same_object_as([]); }); });
      requirement("specifying that [] should not be the same object as [] should pass", function () : void {
        shouldPass(function () : void { specify([]).should.not.be_the_same_object_as([]); }); });
      requirement("specifying that [] should not be the same object as itself should fail", function () : void {
        const foo : Array = [];
        shouldFail(function () : void { specify(foo).should.not.be_the_same_object_as(foo); }); });

      requirement("specifying that 1 should equal either of (1, 2) should pass", function () : void {
        shouldPass(function () : void { specify(1).should.equal_either_of(1, 2); }); });
      requirement("specifying that 1 should equal either of (2, 3) should fail", function () : void {
        shouldFail(function () : void { specify(1).should.equal_either_of(2, 3); }); });
      requirement("specifying that 1 should equal neither of (2, 3) should pass", function () : void {
        shouldPass(function () : void { specify(1).should.not.equal_either_of(2, 3); }); });
      requirement("specifying that 1 should equal neither of (1, 2) should fail", function () : void {
        shouldFail(function () : void { specify(1).should.not.equal_either_of(1, 2); }); });

      requirement("specifying that 0 should be between 0 and 0 should fail", function () : void {
        shouldFail(function () : void { specify(0).should.be_between(0, 0); }); });
      requirement("specifying that 0 should be between -1 and +1 should pass", function () : void {
        shouldPass(function () : void { specify(0).should.be_between(-1, +1); }); });

      requirement("specifying that throwing function should throw should pass", function () : void {
        shouldPass(function () : void { specify(throwingFunction).should.throw_error; }); });
      requirement("specifying that returning function should throw should fail", function () : void {
        shouldFail(function () : void { specify(returningFunction).should.throw_error; }); });
      requirement("specifying that returning function should not throw should pass", function () : void {
        shouldPass(function () : void { specify(returningFunction).should.not.throw_error; }); });
      requirement("specifying that throwing function should not throw should fail", function () : void {
        shouldFail(function () : void { specify(throwingFunction).should.not.throw_error; }); });

      requirement("specifying that returning function should return should pass", function () : void {
        shouldPass(function () : void { specify(returningFunction).should.return_normally; }); });
      requirement("specifying that throwing function should return should fail", function () : void {
        shouldFail(function () : void { specify(throwingFunction).should.return_normally; }); });
      requirement("specifying that throwing function should not return should pass", function () : void {
        shouldPass(function () : void { specify(throwingFunction).should.not.return_normally; }); });
      requirement("specifying that returning function should not return should fail", function () : void {
        shouldFail(function () : void { specify(returningFunction).should.not.return_normally; }); });

      requirement("specifying that [1] should look like [1] should pass", function () : void {
        shouldPass(function () : void { specify([1]).should.look_like("[1]"); }); });
      requirement("specifying that [1] should look like [] should fail", function () : void {
        shouldFail(function () : void { specify([1]).should.look_like("[]"); }); });
      requirement("specifying that [1] should not look like [] should pass", function () : void {
        shouldPass(function () : void { specify([1]).should.not.look_like("[]"); }); });
      requirement("specifying that [1] should not look like [1] should fail", function () : void {
        shouldFail(function () : void { specify([1]).should.not.look_like("[1]"); }); });

      requirement("specifying that 'abc' contains 'x' should fail", function () : void {
        shouldFail(function () : void { specify("abc").should.contain("x"); }); });
      requirement("specifying that 'abc' contains 'b' should pass", function () : void {
        shouldPass(function () : void { specify("abc").should.contain("b"); }); });

      (function () : void {
        const actual : String = "abc";
        const expected : String = "x";

        const error : AssertionError = getError(function () : void
          { specify(actual).should.contain(expected); });

        requirement("containment error message should include actual value", function () : void {
          shouldContain(error.message, actual); });
        requirement("containment error message should include expected value", function () : void {
          shouldContain(error.message, expected); });
      })();
    }

    private static function returningFunction() : void {}
    private static function throwingFunction() : void { throw new Error; }
  }
}

class Entity
{}
