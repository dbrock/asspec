package org.asspec.util
{
  import org.asspec.basic.AbstractSuite;

  public class UtilityMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    {
      addSpecification(ArrayContainerMetaspecification);
      addSpecification(SequenceMetaspecification);
      addSpecification(InspectionMetaspecification);
    }
  }
}
