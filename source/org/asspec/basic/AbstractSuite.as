package org.asspec.basic
{
  import org.asspec.Suite;
  import org.asspec.Test;
  import org.asspec.TestListener;
  import org.asspec.classic.ClassSuite;
  import org.asspec.specification.SpecificationSuiteFactory;
  import org.asspec.util.sequences.Sequence;
  import org.asspec.util.sequences.TypedArrayContainer;
  import org.asspec.util.sequences.TypedSequenceContainer;

  public class AbstractSuite implements Suite
  {
    private var initialized : Boolean = false;
    private var testContainer : TypedSequenceContainer
      = new TypedArrayContainer(Test);

    public function addTest(test : Test) : void
    { testContainer.add(test); }

    protected function addSpecification(class_ : Class) : void
    { addTest(SpecificationSuiteFactory.getSuiteForClass(class_)); }

    protected function addClassical(class_ : Class) : void
    { addTest(ClassSuite.forClass(class_)); }

    protected function addSuite(class_ : Class) : void
    { addTest(new class_); }

    public function get tests() : Sequence
    {
      ensureInitialized();

      return testContainer.sequence;
    }

    private function ensureInitialized() : void
    {
      if (!initialized)
        {
          initialized = true;
          populate();
        }
    }

    protected function populate() : void
    {}

    public function run(listener : TestListener) : void
    {
      for each (var test : Test in tests)
        test.run(listener);
    }
  }
}
