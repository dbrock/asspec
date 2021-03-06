package org.asspec.basic
{
  public class BasicTestMetaspecification extends AbstractSuite
  {
    override protected function populate() : void
    {
      add(Empty_test_should_start);
      add(Empty_test_should_pass);
      add(Throwing_test_should_return_normally);
      add(Throwing_test_should_fail);
      add(Throwing_test_should_give_error_to_listener);
    }
  }
}

import org.asspec.Test;
import org.asspec.NamedTest;
import org.asspec.TestListener;
import org.asspec.basic.BasicTest;
import org.asspec.basic.NullTestListener;

class Empty_test_should_start implements NamedTest, TestListener
{
  private var started : Boolean = false;

  public function get name() : String
  { return "empty test should start (BasicTestMetaspecification)"; }

  public function run(listener : TestListener) : void
  {
    listener.handleTestStarted(this);

    new EmptyTest().run(this);

    if (started)
      listener.handleTestPassed(this);
    else
      listener.handleTestFailed(this, null);
  }

  public function handleTestStarted(test : Test) : void
  { started = true; }

  public function handleTestPassed(test : Test) : void
  {}

  public function handleTestFailed(test : Test, error : Error) : void
  {}
}

class EmptyTest extends BasicTest
{
  override protected function execute() : void
  {}
}

class Empty_test_should_pass implements NamedTest, TestListener
{
  private var succeeded : Boolean = false;

  public function get name() : String
  { return "empty test should pass (BasicTestMetaspecification)"; }

  public function run(listener : TestListener) : void
  {
    new EmptyTest().run(this);

    if (succeeded)
      listener.handleTestPassed(this);
    else
      listener.handleTestFailed(this, null);
  }

  public function handleTestStarted(test : Test) : void
  {}

  public function handleTestPassed(test : Test) : void
  { succeeded = true; }

  public function handleTestFailed(test : Test, error : Error) : void
  {}
}

class Throwing_test_should_return_normally implements NamedTest
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

        listener.handleTestPassed(this);
      }
    catch (error : Error)
      { listener.handleTestFailed(this, null); }
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

class Throwing_test_should_fail implements NamedTest, TestListener
{
  private var failed : Boolean = false;

  public function get name() : String
  { return "throwing test should fail (BasicTestMetaspecification)"; }

  public function run(listener : TestListener) : void
  {
    new ThrowingTest(new Error).run(this);

    if (failed)
      listener.handleTestPassed(this);
    else
      listener.handleTestFailed(this, null);
  }

  public function handleTestStarted(test : Test) : void
  {}

  public function handleTestPassed(test : Test) : void
  {}

  public function handleTestFailed(test : Test, error : Error) : void
  { failed = true; }
}

class Throwing_test_should_give_error_to_listener
  implements NamedTest, TestListener
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
      listener.handleTestPassed(this);
    else
      listener.handleTestFailed(this, null);
  }

  public function handleTestStarted(test : Test) : void
  {}

  public function handleTestPassed(test : Test) : void
  {}

  public function handleTestFailed(test : Test, error : Error) : void
  { actualError = error; }
}
