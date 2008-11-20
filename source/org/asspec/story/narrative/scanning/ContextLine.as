package org.asspec.story.narrative.scanning
{
  import org.asspec.story.scenario.Step;

  public class ContextLine extends Line
  {
    public function ContextLine(step : Step)
    { super(step); }

    override public function get isContextLine() : Boolean
    { return true; }
  }
}
