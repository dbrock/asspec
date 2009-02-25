package org.asspec.equality
{
  import org.asspec.basic.Suite;

  public class EqualityMetasuite extends Suite
  {
    override protected function populate() : void
    { addSpecification(EqualityMetaspecification); }
  }
}
