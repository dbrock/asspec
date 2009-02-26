package org.asspec.basic
{
  import org.asspec.Test;
  import org.asspec.TestListener;
  import org.asspec.classic.ClassSuite;
  import org.asspec.specification.SpecificationSuiteFactory;
  import org.asspec.util.Sequence;
  import org.asspec.util.TypedArraySequence;
  import org.asspec.util.TypedMutableSequence;

  public class AbstractSuite implements Test
  {
    private var initialized : Boolean = false;
    private var _tests : TypedMutableSequence
      = new TypedArraySequence(Test);

    public function add(test : Test) : void
    { $tests.add(test); }

    protected function addSpecification(class_ : Class) : void
    { add(SpecificationSuiteFactory.getSuiteForClass(class_)); }
    protected function addClassical(class_ : Class) : void
    { add(ClassSuite.forClass(class_)); }
    protected function addSuite(class_ : Class) : void
    { add(new class_); }

    private function get $tests() : TypedMutableSequence
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

    public function get tests() : Sequence
    { return $tests; }
  }
}
