package org.asspec.story
{
  import org.asspec.basic.Suite;

  public class StorySpecificationSuite extends Suite
  {
    override protected function populate() : void
    {
      add(new StanzaCompilerSpecification);
    }
  }
}
