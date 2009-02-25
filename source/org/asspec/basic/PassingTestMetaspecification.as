package org.asspec.basic
{
  public class PassingTestMetaspecification extends Suite
  {
    override protected function populate() : void
    { add(new Empty_test_should_pass); }
  }
}

import org.asspec.Test;
import org.asspec.TestListener;
import org.asspec.basic.BasicTest;

class Empty_test_should_pass implements Test, TestListener
{
  private var succeeded : Boolean = false;

  public function get name() : String
  { return "empty test should succeed (PassingTestSpecification)"; }

  public function run(listener : TestListener) : void
  {
    new EmptyTest().run(this);

    if (succeeded)
      listener.testPassed(this);
    else
      listener.testFailed(this, null);
  }

  public function testPassed(test : Test) : void
  { succeeded = true; }

  public function testFailed(test : Test, error : Error) : void
  {}
}

class EmptyTest extends BasicTest
{
  override protected function execute() : void
  {}
}
