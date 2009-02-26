package org.asspec.assertion
{
  import org.asspec.basic.AbstractSuite;

  public class AssertionMetasuite extends AbstractSuite
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
