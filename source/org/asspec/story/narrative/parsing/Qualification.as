package org.asspec.story.narrative.parsing
{
  import org.asspec.story.scenario.Step;
  import org.asspec.util.Sequence;

  public class Qualification implements Statement
  {
    public var qualifiers : Sequence;
    public var statements : Sequence;

    public function Qualification
      (qualifiers : Sequence, statements : Sequence)
    {
      this.qualifiers = qualifiers.ensureType(Step);
      this.statements = statements.ensureType(Statement);
    }
  }
}