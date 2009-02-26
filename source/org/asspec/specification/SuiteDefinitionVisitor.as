package org.asspec.specification
{
  import org.asspec.NamedTest;
  import org.asspec.basic.AbstractSuite;
  import org.asspec.fail;
  import org.asspec.util.It;
  import org.asspec.util.Sequence;

  public class SuiteDefinitionVisitor implements SpecificationVisitor
  {
    private var suite : AbstractSuite;
    private var factory : SpecificationProvider;

    public function SuiteDefinitionVisitor
      (suite : AbstractSuite, factory : SpecificationProvider)
    {
      this.suite = suite;
      this.factory = factory;
    }

    public function visitRequirement(requirement : Requirement) : void
    {
      const test : RequirementTest = getNewTest(requirement.name);

      // The test name will be different from the requirement name.
      ensureNameUnused(test.name);

      suite.add(test);
    }

    private function getNewTest(name : String) : RequirementTest
    { return new RequirementTest(name, factory.getSpecificationCopy()); }

    private function ensureNameUnused(name : String) : void
    {
      if (nameUsed(name))
        fail("the requirement name »" + name + "« is already in use");
    }

    private function nameUsed(name : String) : Boolean
    { return testNames.any(It.equals(name)); }

    private function get testNames() : Sequence
    { return suite.tests.map(testName); }

    private static function testName(test : NamedTest) : String
    { return test.name; }
  }
}
