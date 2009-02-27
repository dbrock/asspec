package org.asspec.util
{
  import org.asspec.basic.AbstractSuite;
  import org.asspec.util.inspection.InspectionMetaspecification;
  import org.asspec.util.sequences.SequenceMetasuite;

  public class UtilityMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    {
      addSuite(SequenceMetasuite);
      addSpecification(InspectionMetaspecification);
    }
  }
}
