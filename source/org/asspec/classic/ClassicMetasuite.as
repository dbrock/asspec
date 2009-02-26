package org.asspec.classic
{
  import org.asspec.basic.AbstractSuite;

  public class ClassicMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    { addSpecification(ClassSuiteMetaspecification); }
  }
}
