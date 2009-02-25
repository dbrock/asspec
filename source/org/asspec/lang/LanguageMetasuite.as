package org.asspec.lang
{
  import org.asspec.basic.Suite;

  public class LanguageMetasuite extends Suite
  {
    override protected function populate() : void
    { addSpecification(NativeClassMetaspecification); }
  }
}
