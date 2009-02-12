package org.asspec
{
  import org.asspec.assert.AssertionSuite;
  import org.asspec.basic.BasicSuite;
  import org.asspec.basic.Suite;
  import org.asspec.lang.NativeClassSpecification;
  import org.asspec.simple.ClassSuiteSpecification;
  import org.asspec.spec.SpecificationMetasuite;
  import org.asspec.spec.SpecificationSuite;
  import org.asspec.story.StorySuite;
  import org.asspec.util.UtilitySuite;

  public class MainSuite extends Suite
  {
    override protected function populate() : void
    {
      add(new BasicSuite);
      add(new SpecificationMetasuite);
      add(new AssertionSuite);
      add(new UtilitySuite);
      add(SpecificationSuite.forClass(NativeClassSpecification));
      add(SpecificationSuite.forClass(ClassSuiteSpecification));
      add(new StorySuite);
    }
  }
}
