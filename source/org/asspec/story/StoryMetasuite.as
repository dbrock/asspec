package org.asspec.story
{
  import org.asspec.basic.AbstractSuite;

  public class StoryMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    {
      addSpecification(StanzaCompilerMetaspecification);
    }
  }
}
