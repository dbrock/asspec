package org.asspec.story.narrative.parsing
{
  import org.asspec.story.scenario.Step;
  import org.asspec.util.sequences.Sequence;

  public class Stanza
  {
    public var context : Sequence;
    public var statements : Sequence;

    public function Stanza(context : Sequence, statements : Sequence)
    {
      context.ensureType(Step);
      statements.ensureType(Statement);

      this.context = context;
      this.statements = statements;
    }
  }
}
