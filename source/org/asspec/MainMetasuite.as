package org.asspec
{
  import org.asspec.assertion.AssertionMetasuite;
  import org.asspec.basic.AbstractSuite;
  import org.asspec.basic.BasicMetasuite;
  import org.asspec.classic.ClassicMetasuite;
  import org.asspec.equality.EqualityMetasuite;
  import org.asspec.lang.LanguageMetasuite;
  import org.asspec.specification.SpecificationMetasuite;
  import org.asspec.story.StoryMetasuite;
  import org.asspec.util.UtilityMetasuite;

  public class MainMetasuite extends AbstractSuite
  {
    override protected function populate() : void
    {
      addSuite(BasicMetasuite);
      addSuite(SpecificationMetasuite);
      addSuite(AssertionMetasuite);
      addSuite(EqualityMetasuite);
      addSuite(UtilityMetasuite);
      addSuite(LanguageMetasuite);
      addSuite(ClassicMetasuite);
      addSuite(StoryMetasuite);
    }
  }
}
