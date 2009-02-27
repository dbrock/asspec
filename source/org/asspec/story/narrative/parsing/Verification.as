package org.asspec.story.narrative.parsing
{
  import org.asspec.story.scenario.Step;
  import org.asspec.util.sequences.Sequence;

  public class Verification implements Statement
  {
    public var steps : Sequence;

    public function Verification(steps : Sequence)
    {
      steps.ensureType(Step);

      this.steps = steps;
    }
  }
}
