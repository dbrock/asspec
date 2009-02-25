package org.asspec.story
{
  import org.asspec.basic.Suite;

  public class StoryMetasuite extends Suite
  {
    override protected function populate() : void
    {
      addSpecification(StanzaCompilerMetaspecification);
    }
  }
}
