package org.asspec.basic
{
  import org.asspec.Test;
  import org.asspec.TestListener;

  public class SuiteSpecification implements Test
  {
    public function get name() : String { return null; }

    public function run(listener : TestListener) : void
    {
      new Empty_suite_should_do_nothing().run(listener);
      new Should_run_tests_in_order().run(listener);
    }
  }
}

import org.asspec.Test;
import org.asspec.TestLogTest;
import org.asspec.basic.NamedTest;
import org.asspec.basic.Suite;

class Empty_suite_should_do_nothing extends TestLogTest
{
  override public function get name() : String
  { return "empty suite should do nothing (SuiteSpecification)"; }

  override protected function createTest() : void
  { test = new Suite; }

  override protected function get expectedLog() : String
  { return ""; }
}

class Should_run_tests_in_order extends TestLogTest
{
  override public function get name() : String
  { return "suite should run tests in order (SuiteSpecification)"; }

  override protected function createTest() : void
  { test = new ExampleSuite; }

  override protected function get expectedLog() : String
  { return "[A passed][B failed]"; }
}

class ExampleSuite extends Suite
{
  override protected function populate() : void
  {
    add(new PassingTest("A"));
    add(new FailingTest("B"));
  }
}

class PassingTest extends NamedTest
{
  public function PassingTest(name : String)
  { super(name); }

  override protected function execute() : void
  { listener.testPassed(this); }
}

class FailingTest extends NamedTest
{
  public function FailingTest(name : String)
  { super(name); }

  override protected function execute() : void
  { listener.testFailed(this, null); }
}
