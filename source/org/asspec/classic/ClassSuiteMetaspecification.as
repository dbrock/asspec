package org.asspec.classic
{
  import org.asspec.Test;
  import org.asspec.basic.TestLogger;
  import org.asspec.lang.RealNativeClass;
  import org.asspec.specification.AbstractSpecification;

  public class ClassSuiteMetaspecification extends AbstractSpecification
  {
    override protected function execute() : void
    {
      requirement("a test that returns normally should pass", function () : void {
        specify(logFor(Good)).should.equal("[a (Good) started][a (Good) passed]"); });

      requirement("a test that throws an exception should fail", function () : void {
        specify(logFor(Bad)).should.equal("[a (Bad) started][a (Bad) failed]"); });

      requirement("tests should be alphabetically ordered", function () : void {
        const expected : String =
          "[a (ABCDE) started][a (ABCDE) passed]" +
          "[b (ABCDE) started][b (ABCDE) failed]" +
          "[c (ABCDE) started][c (ABCDE) passed]" +
          "[d (ABCDE) started][d (ABCDE) failed]" +
          "[e (ABCDE) started][e (ABCDE) passed]";
        specify(logFor(ABCDE)).should.equal(expected); });

      requirement("privates and statics should not be run as tests", function () : void {
        specify(logFor(Junk)).should.equal("[a (Junk) started][a (Junk) passed]"); });

      requirement("each test should get a fresh class instance", function () : void {
        const expected : String = 
          "[a (Mutable) started][a (Mutable) passed]" +
          "[b (Mutable) started][b (Mutable) passed]";
        specify(logFor(Mutable)).should.equal(expected); });
    }

    private static function logFor(specClass : Class) : String
    { return TestLogger.run(createTest(specClass)); }

    private static function createTest(specClass : Class) : Test
    { return new ClassSuite(RealNativeClass.forClass(specClass)); }
  }
}

import org.asspec.specify;

class Good
{ public function a() : void {} }

class Bad
{ public function a() : void { throw new Error; } }

class ABCDE
{
  public function a() : void {}
  public function b() : void { throw new Error; }
  public function c() : void {}
  public function d() : void { throw new Error; }
  public function e() : void {}
}

class Junk
{
  public function a() : void {}
  private function x() : void {}
  public static function y() : void {}
}

class Mutable
{
  private var i : int = 0;

  public function a() : void
  { specify(i++).should.equal(0); }

  public function b() : void
  { specify(i++).should.equal(0); }
}
