package org.asspec.basic
{
  public class BasicTestMetaspecification extends AbstractSuite
  {
    override protected function populate() : void
    {
      addTest(new Empty_test_should_pass);
      addTest(new Throwing_test_should_return_normally);
      addTest(new Throwing_test_should_fail);
      addTest(new Throwing_test_should_give_error_to_listener);
    }
  }
}

import org.asspec.Test;
import org.asspec.TestListener;
import org.asspec.basic.BasicTest;
import org.asspec.basic.NullTestListener;

class Empty_test_should_pass implements Test, TestListener
{
  private var succeeded : Boolean = false;

  public function get name() : String
  { return "empty test should pass (BasicTestMetaspecification)"; }

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

class Throwing_test_should_return_normally implements Test
{
  public function get name() : String
  {
    return "throwing test should return normally "
      + "(BasicTestMetaspecification)";
  }

  public function run(listener : TestListener) : void
  {
    try
      {
        new ThrowingTest(new Error).run(new NullTestListener);

        listener.testPassed(this);
      }
    catch (error : Error)
      { listener.testFailed(this, null); }
  }
}

class ThrowingTest extends BasicTest
{
  private var error : Error;

  public function ThrowingTest(error : Error)
  { this.error = error; }

  override protected function execute() : void
  { throw error; }
}

class ExampleError extends Error
{}

class Throwing_test_should_fail implements Test, TestListener
{
  private var failed : Boolean = false;

  public function get name() : String
  { return "throwing test should fail (BasicTestMetaspecification)"; }

  public function run(listener : TestListener) : void
  {
    new ThrowingTest(new Error).run(this);

    if (failed)
      listener.testPassed(this);
    else
      listener.testFailed(this, null);
  }

  public function testPassed(test : Test) : void
  { }

  public function testFailed(test : Test, error : Error) : void
  { failed = true; }
}

class Throwing_test_should_give_error_to_listener
  implements Test, TestListener
{
  private var actualError : Error;

  public function get name() : String
  {
    return "throwing test should give error to listener "
      + "(BasicTestMetaspecification)";
  }

  public function run(listener : TestListener) : void
  {
    const expectedError : Error = new Error;

    new ThrowingTest(expectedError).run(this);

    if (actualError == expectedError)
      listener.testPassed(this);
    else
      listener.testFailed(this, null);
  }

  public function testPassed(test : Test) : void
  { }

  public function testFailed(test : Test, error : Error) : void
  { actualError = error; }
}
