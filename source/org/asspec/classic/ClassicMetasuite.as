package org.asspec.classic
{
  import org.asspec.basic.Suite;

  public class ClassicMetasuite extends Suite
  {
    override protected function populate() : void
    { addSpecification(ClassSuiteMetaspecification); }
  }
}
