package org.asspec.basic
{
  public class FailingTestMetaspecification extends Suite
  {
    override protected function populate() : void
    {
      add(new Should_return_normally);
      add(new Should_fail);
      add(new Should_give_error_to_listener);
    }
  }
}

import org.asspec.Test;
import org.asspec.TestListener;
import org.asspec.basic.BasicTest;
import org.asspec.basic.NullTestListener;

class Should_return_normally implements Test
{
  public function get name() : String
  { return "throwing test should return normally (FailingTestSpecification)"; }

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

class Should_fail implements Test, TestListener
{
  private var failed : Boolean = false;

  public function get name() : String
  { return "throwing test should fail (FailingTestSpecification)"; }

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

class Should_give_error_to_listener implements Test, TestListener
{
  private var actualError : Error;

  public function get name() : String
  { return "throwing test should give error to listener (FailingTestSpecification)"; }

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
