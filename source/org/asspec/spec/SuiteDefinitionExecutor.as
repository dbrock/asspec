package org.asspec.spec
{
  import org.asspec.Assert;
  import org.asspec.Test;
  import org.asspec.basic.Suite;
  import org.asspec.util.It;
  import org.asspec.util.Sequence;

  public class SuiteDefinitionExecutor implements SpecificationExecutor
  {
    private var suite : Suite;
    private var specification : Specification;

    public function SuiteDefinitionExecutor
      (suite : Suite, specification : Specification)
    {
      this.suite = suite;
      this.specification = specification;
    }

    public function executeRequirement
      (name : String, implementation : Function) : void
    {
      const test : Test = new Requirement(name, specification);
      ensureNameUnused(test.name);
      suite.add(test);
    }

    private function ensureNameUnused(name : String) : void
    {
      if (nameUsed(name))
        Assert.fail("the name »" + name + "« is already in use");
    }

    private function nameUsed(name : String) : Boolean
    { return testNames.any(It.equals(name)); }

    private function get testNames() : Sequence
    { return suite.tests.map(testName); }

    private static function testName(test : Test) : String
    { return test.name; }
  }
}
