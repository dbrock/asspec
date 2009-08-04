package org.asspec.specification
{
  import org.asspec.NamedTest;
  import org.asspec.basic.AbstractSuite;
  import org.asspec.equality.Equality;
  import org.asspec.fail;
  import org.asspec.util.curry;
  import org.asspec.util.sequences.Sequence;

  public class SuiteDefinitionVisitor implements SpecificationVisitor
  {
    private var suite : AbstractSuite;
    private var factory : SpecificationProvider;

    private const contextNames : Stack = new ArrayStack;
    private const numTailContexts : Stack = new ArrayStack;

    public function SuiteDefinitionVisitor
      (suite : AbstractSuite, factory : SpecificationProvider)
    {
      this.suite = suite;
      this.factory = factory;

      numTailContexts.push(0);
    }

    public function visitRequirement(requirement : Requirement) : void
    {
      const test : RequirementTest = getNewTest(requirement.name);

      // The test name will be different from the requirement name.
      ensureNameUnused(test.name);

      suite.addTest(test);
    }

    private function getNewTest(name : String) : RequirementTest
    {
      return new RequirementTest
        (contextNames.elements, name, factory.getSpecificationCopy());
    }

    private function ensureNameUnused(name : String) : void
    {
      if (nameUsed(name))
        fail("the requirement name »" + name + "« is already in use");
    }

    private function nameUsed(name : String) : Boolean
    { return testNames.any(curry(Equality.equals, name)); }

    private function get testNames() : Sequence
    { return suite.tests.map(testName); }

    private static function testName(test : NamedTest) : String
    { return test.name; }

    // ----------------------------------------------------

    public function visitContext(context : Context) : void
    {
      pushContext(context.name);
      (context.implementation)();
      popContext();
    }

    private function pushContext(name : String) : void
    {
      contextNames.push(name);
      numTailContexts.push(0);
    }

    private function popContext() : void
    {
      contextNames.pop();
      popTailContexts();
      numTailContexts.pop();
    }

    private function popTailContexts() : void
    {
      while (currentNumTailContexts > 0)
        popTailContext();
    }

    // ----------------------------------------------------

    public function visitTailContext(name : String) : void
    { pushTailContext(name); }

    private function pushTailContext(name : String) : void
    {
      contextNames.push(name);
      ++currentNumTailContexts;
    }

    private function popTailContext() : void
    {
      contextNames.pop();
      --currentNumTailContexts;
    }

    private function get currentNumTailContexts() : uint
    { return numTailContexts.top; }

    private function set currentNumTailContexts(value : uint) : void
    { numTailContexts.top = value; }
  }
}
