package org.asspec.assertion
{
  import org.asspec.basic.Suite;

  public class AssertionMetasuite extends Suite
  {
    override protected function populate() : void
    {
      addSpecification(BasicAssertionMetaspecification);
      addSpecification(EqualityAssertionMetaspecification);
      addSpecification(ExceptionAssertionMetaspecification);
      addSpecification(AssertionSubjectMetaspecification);
    }
  }
}
