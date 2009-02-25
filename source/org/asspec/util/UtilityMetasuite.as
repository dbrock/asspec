package org.asspec.util
{
  import org.asspec.basic.Suite;

  public class UtilityMetasuite extends Suite
  {
    override protected function populate() : void
    {
      addSpecification(ArraySequenceMetaspecification);
      addSpecification(InspectionMetaspecification);
    }
  }
}
