package org.asspec.basic
{
  import org.asspec.Suite;
  import org.asspec.Test;
  import org.asspec.TestListener;
  import org.asspec.classic.ClassSuite;
  import org.asspec.specification.SpecificationSuiteFactory;
  import org.asspec.util.Sequencable;
  import org.asspec.util.TypedArrayContainer;
  import org.asspec.util.TypedSequenceContainer;

  public class AbstractSuite implements Suite
  {
    private var initialized : Boolean = false;
    private var _tests : TypedSequenceContainer
      = new TypedArrayContainer(Test);

    public function add(test : Test) : void
    { $tests.add(test); }

    protected function addSpecification(class_ : Class) : void
    { add(SpecificationSuiteFactory.getSuiteForClass(class_)); }

    protected function addClassical(class_ : Class) : void
    { add(ClassSuite.forClass(class_)); }

    protected function addSuite(class_ : Class) : void
    { add(new class_); }

    private function get $tests() : TypedSequenceContainer
    {
      ensureInitialized();

      return _tests;
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

    public function get tests() : Sequencable
    { return $tests; }
  }
}
