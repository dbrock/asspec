package org.asspec.spec
{
  import org.asspec.Assert;
  import org.asspec.NamedTest;
  import org.asspec.Test;
  import org.asspec.basic.Suite;
  import org.asspec.util.It;
  import org.asspec.util.Sequence;

  public class SuiteDefinitionExecutor implements SpecificationExecutor
  {
    private var suite : Suite;
    private var factory : SpecificationFactory;

    public function SuiteDefinitionExecutor
      (suite : Suite, factory : SpecificationFactory)
    {
      this.suite = suite;
      this.factory = factory;
    }

    public function executeRequirement
      (name : String, implementation : Function) : void
    {
      const requirement : Requirement = newRequirement(name);

      ensureNameUnused(requirement.name);

      suite.add(requirement);
    }

    private function newRequirement(name : String) : Requirement
    { return new Requirement(name, factory.newSpecification()); }

    private function ensureNameUnused(name : String) : void
    {
      if (nameUsed(name))
        Assert.fail("the name »" + name + "« is already in use");
    }

    private function nameUsed(name : String) : Boolean
    { return testNames.any(It.equals(name)); }

    private function get testNames() : Sequence
    { return suite.tests.map(testName); }

    private static function testName(test : NamedTest) : String
    { return test.name; }
  }
}
