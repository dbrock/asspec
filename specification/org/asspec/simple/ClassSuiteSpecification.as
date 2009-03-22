package org.asspec.simple
{
  import org.asspec.Assert;
  import org.asspec.Test;
  import org.asspec.TestLogger;
  import org.asspec.lang.RealNativeClass;
  import org.asspec.spec.Specification;

  public class ClassSuiteSpecification extends Specification
  {
    override protected function execute() : void
    {
      requirement("a test that returns normally should pass", function () : void {
        assertLog("[a passed]", Good); });

      requirement("a test that throws an exception should fail", function () : void {
        assertLog("[a failed]", Bad); });

      requirement("tests should be alphabetically ordered", function () : void {
        assertLog("[a passed][b failed][c passed][d failed][e passed]", ABCDE); });

      requirement("privates and statics should not be run as tests", function () : void {
        assertLog("[a passed]", Junk); });

      requirement("each test should get a fresh class instance", function () : void {
        assertLog("[a passed][b passed]", Mutable); });
    }

    private static function assertLog(expected : String, specClass : Class) : void
    { Assert.equal(expected, runClass(specClass)); }

    private static function runClass(specClass : Class) : String
    { return TestLogger.run(createTest(specClass)); }

    private static function createTest(specClass : Class) : Test
    { return new ClassSuite(RealNativeClass.forClass(specClass)); }
  }
}

import org.asspec.Assert;

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
  { Assert.equal(0, i++); }

  public function b() : void
  { Assert.equal(0, i++); }
}
