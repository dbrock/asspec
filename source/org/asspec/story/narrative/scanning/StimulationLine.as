package org.asspec.story.narrative.scanning
{
  import org.asspec.story.scenario.Step;

  public class StimulationLine extends Line
  {
    public function StimulationLine(step : Step)
    { super(step); }

    override public function get isStimulationLine() : Boolean
    { return true; }
  }
}
