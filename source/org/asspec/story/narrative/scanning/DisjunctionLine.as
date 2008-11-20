package org.asspec.story.narrative.scanning
{
  import org.asspec.story.scenario.Step;

  public class DisjunctionLine extends Line
  {
    public function DisjunctionLine(step : Step)
    { super(step); }

    override public function get isDisjunctionLine() : Boolean
    { return true; }
  }
}
