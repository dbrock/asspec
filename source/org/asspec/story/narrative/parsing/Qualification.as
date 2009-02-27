package org.asspec.story.narrative.parsing
{
  import org.asspec.story.scenario.Step;
  import org.asspec.util.sequences.Sequence;

  public class Qualification implements Statement
  {
    public var qualifiers : Sequence;
    public var statements : Sequence;

    public function Qualification
      (qualifiers : Sequence, statements : Sequence)
    {
      qualifiers.ensureType(Step);
      statements.ensureType(Statement);

      this.qualifiers = qualifiers;
      this.statements = statements;
    }
  }
}
