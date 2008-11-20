package org.asspec.story.narrative.scanning
{
  import org.asspec.story.scenario.Step;

  public class Line
  {
    private var _step : Step;

    public function Line(step : Step)
    { _step = step; }

    public function get step() : Step
    { return _step; }

    public function get isContextLine() : Boolean { return false; }
    public function get isStimulationLine() : Boolean { return false; }
    public function get isVerificationLine() : Boolean { return false; }
    public function get isConjunctionLine() : Boolean { return false; }
    public function get isDisjunctionLine() : Boolean { return false; }

    public static function step(that : Line) : Step
    { return that.step; }

    public static function isContextLine(that : Line) : Boolean
    { return that.isContextLine; }
    public static function isStimulationLine(that : Line) : Boolean
    { return that.isStimulationLine; }
    public static function isVerificationLine(that : Line) : Boolean
    { return that.isVerificationLine; }
    public static function isConjunctionLine(that : Line) : Boolean
    { return that.isConjunctionLine; }
    public static function isDisjunctionLine(that : Line) : Boolean
    { return that.isDisjunctionLine; }
  }
}
