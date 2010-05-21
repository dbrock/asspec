package org.asspec.specification
{
  import org.asspec.basic.AbstractSuite;

  public class SpecificationMetaspecification extends AbstractSuite
  {
    override protected function populate() : void
    {
      add(Should_run_requirements);
      add(Should_fail_on_pending_requirements);
      add(Should_run_setup_before_each_requirement);
      add(Should_run_context_around_each_requirement);
      add(Should_create_fresh_instance_for_each_requirement);
      add(Should_detect_name_conflicts);
      add(Should_explain_name_conflicts);
      add(Should_run_hierarchical_requirements);
      add(Should_allow_duplicate_names_in_different_contexts);
      add(Should_handle_abbreviated_tail_contexts);
    }
  }
}

import org.asspec.Test;
import org.asspec.basic.NamedManualTest;
import org.asspec.basic.NullTestListener;
import org.asspec.basic.SimpleTestLogMetatest;
import org.asspec.basic.TestLogMetatest;
import org.asspec.specification.AbstractSpecification;
import org.asspec.specification.SpecificationSuiteFactory;
import org.asspec.util.Text;
import org.asspec.util.UnimplementedMethodError;

class Should_run_requirements extends SimpleTestLogMetatest
{
  override public function get name() : String
  { return "should run requirements (SpecificationMetaspecification)"; }

  override protected function createTest() : void
  { test = SpecificationSuiteFactory.getSuiteForClass(SimpleSpecification); }

  override protected function get expectedLog() : String
  { return "[A (SimpleSpecification) started]"
      + "[A (SimpleSpecification) passed]"
      + "[B (SimpleSpecification) started]"
      + "[B (SimpleSpecification) failed]"
      + "[C (SimpleSpecification) started]"
      + "[C (SimpleSpecification) passed]"; }
}

class SimpleSpecification extends AbstractSpecification
{
  override protected function execute() : void
  {
    requirement("A", function () : void {});
    requirement("B", function () : void { throw new Error; });
    requirement("C", function () : void {});
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
  { test = SpecificationSuiteFactory.getSuiteForClass(specificationClass); }

  override protected function runTest() : void
  {
    createTest();

    LoggingSpecification.log = "";

    test.run(new NullTestListener);

    actualLog = LoggingSpecification.log;
  }
}

class LoggingSpecification extends AbstractSpecification
{
  public static var log : String;

  protected function note(message : String) : void
  { log += message; }
}

class Should_fail_on_pending_requirements extends SimpleTestLogMetatest
{
  override public function get name() : String
  { return "should fail on pending requirements (SpecificationMetaspecification)"; }

  override protected function createTest() : void
  { test = SpecificationSuiteFactory.getSuiteForClass(PendingSpecification); }

  override protected function get expectedLog() : String
  { return"[A (PendingSpecification) started]"
      + "[A (PendingSpecification) passed]"
      + "[B (PendingSpecification) started]"
      + "[B (PendingSpecification) failed]"
      + "[C (PendingSpecification) started]"
      + "[C (PendingSpecification) passed]"; }
}

class PendingSpecification extends AbstractSpecification
{
  override protected function execute() : void
  {
    requirement("A", function () : void {});
    requirement("B");
    requirement("C", function () : void {});
  }
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

class Should_detect_name_conflicts extends NamedManualTest
{
  override public function get name() : String
  { return "should detect name conflicts (SpecificationMetaspecification)"; }

  override protected function execute() : void
  {
    const test : Test
      = SpecificationSuiteFactory.getSuiteForClass(NameConflictSpecification);

    try
      { test.run(new NullTestListener); }
    catch (error : Error)
      {
        listener.handleTestPassed(this);

        return;
      }

    listener.handleTestFailed(this, new Error);
  }
}

class NameConflictSpecification extends AbstractSpecification
{
  override protected function execute() : void
  {
    requirement("A", function () : void {});
    requirement("foo", function () : void { throw new Error; });
    requirement("foo", function () : void { throw new Error; });
  }
}

class Should_explain_name_conflicts extends NamedManualTest
{
  override public function get name() : String
  { return "should explain name conflicts (SpecificationMetaspecification)"; }

  override protected function execute() : void
  {
    const test : Test = SpecificationSuiteFactory.getSuiteForClass
      (NameConflictSpecification);

    try
      { test.run(new NullTestListener); }
    catch (error : Error)
      {
        if (error.message != null
            && Text.of(error.message).contains("foo"))
          listener.handleTestPassed(this);
        else
          listener.handleTestFailed(this,
            new Error("error message does not mention »foo« " +
                      "(the conflicting name): " + error.message));
      }
  }
}

class Should_run_hierarchical_requirements
  extends SpecificationLogMetatest
{
  override public function get name() : String
  {
    return "should run hierarchical requirements "
      + "(SpecificationMetaspecification)";
  }

  override protected function get specificationClass() : Class
  { return HierarchicalSpecification; }

  override protected function get expectedLog() : String
  { return "{[()]}{[A]}{[(B)]}{[C]}"; }
}

class HierarchicalSpecification extends LoggingSpecification
{
  override protected function execute() : void
  {
    note("{");

    describe("when foo", function () : void {
      note("[");
      it("should do A", function () : void { note("A"); });

      describe("when bar", function () : void {
        note("(");
        it("should do B", function () : void { note("B"); });
        note(")");
      });

      it("should do C", function () : void { note("C"); });
      note("]");
    });

    note("}");
  }
}

class Should_handle_abbreviated_tail_contexts extends SimpleTestLogMetatest
{
  override public function get name() : String
  { return "should handle abbreviated tail contexts (SpecificationMetaspecification)"; }

  override protected function createTest() : void
  { test = SpecificationSuiteFactory.getSuiteForClass(TailContextSpecification); }

  override protected function get expectedLog() : String
  { return "[A 1 (TailContextSpecification) started]"
      + "[A 1 (TailContextSpecification) failed]"
      + "[B 2 (TailContextSpecification) started]"
      + "[B 2 (TailContextSpecification) failed]"
      + "[B C 3 (TailContextSpecification) started]"
      + "[B C 3 (TailContextSpecification) failed]"
      + "[B C D 4 (TailContextSpecification) started]"
      + "[B C D 4 (TailContextSpecification) failed]"
      + "[B 5 (TailContextSpecification) started]"
      + "[B 5 (TailContextSpecification) failed]"; }
}

class TailContextSpecification extends AbstractSpecification
{
  override protected function execute() : void
  {
    describe("A", function () : void {
      requirement("1");
    });

    describe("B");
    requirement("2");

    describe("C", function () : void {
      requirement("3");
      describe("D");
      requirement("4");
    });

    requirement("5");
  }
}

class Should_allow_duplicate_names_in_different_contexts
  extends NamedManualTest
{
  override public function get name() : String
  {
    return "should allow duplicate names in different contexts"
      + "(SpecificationMetaspecification)";
  }

  override protected function execute() : void
  {
    const test : Test = SpecificationSuiteFactory.getSuiteForClass
      (DuplicateNamesSpecification);

    try
      { test.run(new NullTestListener); }
    catch (error : Error)
      {
        listener.handleTestFailed(this, null);

        return;
      }

    listener.handleTestPassed(this);
  }
}

class DuplicateNamesSpecification extends LoggingSpecification
{
  override protected function execute() : void
  {
    requirement("X", function () : void {});
    describe("X", function () : void {
      requirement("X", function () : void {});
      describe("X", function () : void {
        requirement("X", function () : void {});
      });
    });
  }
}
