package org.asspec.assertion
{
  import org.asspec.basic.AbstractSuite;

  public class AssertionMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    {
      add(BasicAssertionMetaspecification);
      add(EqualityAssertionMetaspecification);
      add(ExceptionAssertionMetaspecification);
      add(AssertionSubjectMetaspecification);
    }
  }
}
