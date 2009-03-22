package org.asspec.util
{
  import org.asspec.basic.AbstractSuite;
  import org.asspec.util.inspection.InspectionMetaspecification;
  import org.asspec.util.mappings.MappingMetasuite;
  import org.asspec.util.sequences.SequenceMetasuite;

  public class UtilityMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    {
      add(CurryMetaspecification);
      add(InspectionMetaspecification);
      add(SequenceMetasuite);
      add(MappingMetasuite);
    }
  }
}
