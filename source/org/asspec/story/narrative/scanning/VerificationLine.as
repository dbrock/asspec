package org.asspec.story.narrative.scanning
{
  import org.asspec.story.scenario.Step;

  public class VerificationLine extends Line
  {
    public function VerificationLine(step : Step)
    { super(step); }

    override public function get isVerificationLine() : Boolean
    { return true; }
  }
}
