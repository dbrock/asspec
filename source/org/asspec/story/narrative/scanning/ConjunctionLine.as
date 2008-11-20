package org.asspec.story.narrative.scanning
{
  import org.asspec.story.scenario.Step;

  public class ConjunctionLine extends Line
  {
    public function ConjunctionLine(step : Step)
    { super(step); }

    override public function get isConjunctionLine() : Boolean
    { return true; }
  }
}
