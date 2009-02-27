package org.asspec.util.sequences
{
  import org.asspec.basic.AbstractSuite;

  public class SequenceMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    {
      addSpecification(ArrayContainerMetaspecification);
      addSpecification(SequenceMetaspecification);
    }
  }
}
