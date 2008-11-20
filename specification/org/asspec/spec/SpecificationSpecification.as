package org.asspec.spec
{
  import org.asspec.basic.Suite;

  public class SpecificationSpecification extends Suite
  {
    override protected function populate() : void
    {
      add(new Should_run_requirements);
      add(new Should_run_setup_before_each_requirement);
      add(new Should_run_context_around_each_requirement);
      add(new Should_detect_name_conflicts);
      add(new Should_explain_name_conflicts);
    }
  }
}

import org.asspec.TestLogger;
import org.asspec.LoggingTest;
import org.asspec.NullTestListener;
import org.asspec.Test;
import org.asspec.TestLogTest;
import org.asspec.basic.PristineTest;
import org.asspec.spec.Specification;
import org.asspec.Assert;
import org.asspec.util.Text;

class Should_run_requirements extends TestLogTest
{
  override public function get name() : String
  { return "should run requirements (SpecificationSpecification)"; }

  override protected function createTest() : void
  { test = new SimpleSpecification; }

  override protected function get expectedLog() : String
  { return "[A (SimpleSpecification) passed]"
      + "[B (SimpleSpecification) failed]"
      + "[C (SimpleSpecification) passed]"; }
}

class SimpleSpecification extends Specification
{
  override protected function execute() : void
  {
    requirement("A", function () : void { });
    requirement("B", function () : void { throw new Error; });
    requirement("C", function () : void { });
  }
}

class Should_run_setup_before_each_requirement extends TestLogTest
{
  override public function get name() : String
  { return "should run setup before each requirement (SpecificationSpecification)"; }

  override protected function createTest() : void
  { test = new SetupLoggingSpecification; }

  override protected function get expectedLog() : String
  { return "**A*B*C"; }
}

class LoggingSpecification extends Specification
  implements LoggingTest
{
  private var _log : String = "";
  public function get log() : String { return _log; }

  protected function note(message : String) : void
  { _log += message; }
}

class SetupLoggingSpecification extends LoggingSpecification
{
  override protected function execute() : void
  {
    note("*");
    requirement("A", function () : void { note("A"); });
    requirement("B", function () : void { note("B"); throw new Error; });
    requirement("C", function () : void { note("C"); });
  }
}

class Should_run_context_around_each_requirement extends TestLogTest
{
  override public function get name() : String
  { return "should run context around each requirement (SpecificationSpecification)"; }

  override protected function createTest() : void
  { test = new ContextLoggingSpecification; }

  override protected function get expectedLog() : String
  { return "[][A][B][C]"; }
}

class ContextLoggingSpecification extends LoggingSpecification
{
  override protected function execute() : void
  {
    note("[");
    requirement("A", function () : void { note("A"); });
    requirement("B", function () : void { note("B"); throw new Error; });
    requirement("C", function () : void { note("C"); });
    note("]");
  }
}

class Should_detect_name_conflicts extends PristineTest
{
  override public function get name() : String
  { return "should detect name conflicts (SpecificationSpecification)"; }

  override protected function execute() : void
  {
    const test : Test = new NameConflictSpecification;

    try
      { test.run(new NullTestListener); }
    catch (error : Error)
      {
        listener.testPassed(this);

        return;
      }

    listener.testFailed(this, new Error);
  }
}

class NameConflictSpecification extends Specification
{
  override protected function execute() : void
  {
    requirement("A", function () : void {});
    requirement("foo", function () : void { throw new Error; });
    requirement("foo", function () : void { throw new Error; });
  }
}

class Should_explain_name_conflicts extends PristineTest
{
  override public function get name() : String
  { return "should explain name conflicts (SpecificationSpecification)"; }

  override protected function execute() : void
  {
    const test : Test = new NameConflictSpecification;

    try
      { test.run(new NullTestListener); }
    catch (error : Error)
      {
        if (error.message != null && Text.contains(error.message, "foo"))
          listener.testPassed(this);
        else
          listener.testFailed(this,
            new Error("error message does not mention »foo« " +
                      "(the conflicting name): " + error.message));
      }
  }
}
