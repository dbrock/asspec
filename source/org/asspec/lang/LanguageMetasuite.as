package org.asspec.lang
{
  import org.asspec.basic.AbstractSuite;

  public class LanguageMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    { addSpecification(NativeClassMetaspecification); }
  }
}
