package org.asspec
{
  import org.asspec.assert.AssertionSpecificationSuite;
  import org.asspec.basic.BasicSpecificationSuite;
  import org.asspec.basic.Suite;
  import org.asspec.lang.NativeClassSpecification;
  import org.asspec.simple.ClassSuiteSpecification;
  import org.asspec.spec.SpecificationSpecification;
  import org.asspec.story.StorySpecificationSuite;
  import org.asspec.util.ArraySequenceSpecification;

  public class MainSpecificationSuite extends Suite
  {
    override protected function populate() : void
    {
      add(new ArraySequenceSpecification);
      add(new BasicSpecificationSuite);
      add(new SpecificationSpecification);
      add(new AssertionSpecificationSuite);
      add(new NativeClassSpecification);
      add(new ClassSuiteSpecification);
      add(new StorySpecificationSuite);
    }
  }
}
