package org.asspec.story.narrative.parsing
{
  import org.asspec.story.scenario.Step;
  import org.asspec.util.Sequence;

  public class Stanza
  {
    public var context : Sequence;
    public var statements : Sequence;

    public function Stanza(context : Sequence, statements : Sequence)
    {
      this.context = context.ensureType(Step);
      this.statements = statements.ensureType(Statement);
    }
  }
}
