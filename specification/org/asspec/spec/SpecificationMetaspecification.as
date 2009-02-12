package org.asspec.spec
{
  import org.asspec.basic.Suite;

  public class SpecificationMetaspecification extends Suite
  {
    override protected function populate() : void
    {
      add(new Should_run_requirements);
      add(new Should_run_setup_before_each_requirement);
      add(new Should_run_context_around_each_requirement);
      add(new Should_create_fresh_instance_for_each_requirement);
      add(new Should_detect_name_conflicts);
      add(new Should_explain_name_conflicts);
    }
  }
}

import org.asspec.TestLogger;
import org.asspec.NullTestListener;
import org.asspec.Test;
import org.asspec.basic.PristineTest;
import org.asspec.spec.Specification;
import org.asspec.Assert;
import org.asspec.util.Text;
import org.asspec.spec.SpecificationSuite;
import org.asspec.SimpleTestLogMetatest;
import org.asspec.TestLogMetatest;
import org.asspec.util.UnimplementedMethodError;
import org.asspec.NamedTest;
import org.asspec.basic.NamedPristineTest;

class Should_run_requirements extends SimpleTestLogMetatest
{
  override public function get name() : String
  { return "should run requirements (SpecificationMetaspecification)"; }

  override protected function createTest() : void
  { test = SpecificationSuite.forClass(SimpleSpecification); }

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

class SpecificationLogMetatest extends TestLogMetatest
{
  private var test : Test;

  override public function get name() : String
  { throw new UnimplementedMethodError; }

  protected function get specificationClass() : Class
  { throw new UnimplementedMethodError; }

  private function createTest() : void
  { test = SpecificationSuite.forClass(specificationClass); }

  override protected function runTest() : void
  {
    createTest();

    LoggingSpecification.log = "";

    test.run(new NullTestListener);

    actualLog = LoggingSpecification.log;
  }
}

class LoggingSpecification extends Specification
{
  public static var log : String;

  protected function note(message : String) : void
  { log += message; }
}

class Should_run_setup_before_each_requirement
  extends SpecificationLogMetatest
{
  override public function get name() : String
  { return "should run setup before each requirement (SpecificationMetaspecification)"; }

  override protected function get specificationClass() : Class
  { return SetupLoggingSpecification; }

  override protected function get expectedLog() : String
  { return "**A*B*C"; }
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

class Should_run_context_around_each_requirement
  extends SpecificationLogMetatest
{
  override public function get name() : String
  { return "should run context around each requirement (SpecificationMetaspecification)"; }

  override protected function get specificationClass() : Class
  { return ContextLoggingSpecification; }

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

class Should_create_fresh_instance_for_each_requirement
  extends SpecificationLogMetatest
{
  override public function get name() : String
  { return "should create fresh instance for each requirement (SpecificationMetaspecification)"; }

  override protected function get specificationClass() : Class
  { return StatefulSpecification; }

  override protected function get expectedLog() : String
  { return "[A:0][B:0]"; }
}

class StatefulSpecification extends LoggingSpecification
{
  private var i : uint = 0;

  override protected function execute() : void
  {
    requirement("A", function () : void { note("[A:" + i++ + "]"); });
    requirement("B", function () : void { note("[B:" + i++ + "]"); });
  }
}

class Should_detect_name_conflicts extends NamedPristineTest
{
  override public function get name() : String
  { return "should detect name conflicts (SpecificationMetaspecification)"; }

  override protected function execute() : void
  {
    const test : Test = SpecificationSuite.forClass(NameConflictSpecification);

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

class Should_explain_name_conflicts extends NamedPristineTest
{
  override public function get name() : String
  { return "should explain name conflicts (SpecificationMetaspecification)"; }

  override protected function execute() : void
  {
    const test : Test = SpecificationSuite.forClass(NameConflictSpecification);

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
