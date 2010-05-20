package org.asspec.basic
{
  import org.asspec.Test;
  import org.asspec.TestListener;

  public class AbstractSuiteMetaspecification implements Test
  {
    public function get name() : String { return null; }

    public function run(listener : TestListener) : void
    {
      new Empty_suite_should_do_nothing().run(listener);
      new Should_run_tests_in_order().run(listener);
      new Should_DWIM_when_adding_classes().run(listener);
    }
  }
}

import org.asspec.Test;
import org.asspec.TestListener;
import org.asspec.basic.AbstractSuite;
import org.asspec.basic.ManualTest;
import org.asspec.basic.SimpleTestLogMetatest;

class Empty_suite_should_do_nothing extends SimpleTestLogMetatest
{
  override public function get name() : String
  { return "empty suite should do nothing (AbstractSuiteMetaspecification)"; }

  override protected function createTest() : void
  { test = new AbstractSuite; }

  override protected function get expectedLog() : String
  { return ""; }
}

class Should_run_tests_in_order extends SimpleTestLogMetatest
{
  override public function get name() : String
  { return "suite should run tests in order (AbstractSuiteMetaspecification)"; }

  override protected function createTest() : void
  { test = new ExampleSuite; }

  override protected function get expectedLog() : String
  { return "[A passed][B failed]"; }
}

class ExampleSuite extends AbstractSuite
{
  override protected function populate() : void
  {
    addTest(new PassingTest);
    addTest(new FailingTest);
  }
}

class PassingTest extends ManualTest
{
  override protected function execute() : void
  { listener.handleTestPassed(this); }

  public function toString() : String
  { return "A"; }
}

class FailingTest extends ManualTest
{
  override protected function execute() : void
  { listener.handleTestFailed(this, null); }

  public function toString() : String
  { return "B"; }
}
