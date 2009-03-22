package org.asspec.equality
{
  import org.asspec.basic.AbstractSuite;

  public class EqualityMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    { add(EqualityMetaspecification); }
  }
}
