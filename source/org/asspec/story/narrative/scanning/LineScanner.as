package org.asspec.story.narrative.scanning
{
  import org.asspec.story.scenario.Step;

  public class LineScanner
  {
    private var type : String;
    private var step : Step;

    public function LineScanner(input : String)
    { parse(input); }

    private function parse(input : String) : void
    {
      const match : Array = input.match(/^(\S+)\s+(.*)$/);

      if (match == null)
        throw new ArgumentError;
      else
        {
          type = match[1].toLowerCase();
          step = new Step(match[2]);
        }
    }

    public function get line() : Line
    {
      if (type == "given")
        return new ContextLine(step);
      else if (type == "when")
        return new StimulationLine(step);
      else if (type == "then")
        return new VerificationLine(step);
      else if (type == "and")
        return new ConjunctionLine(step);
      else if (type == "or")
        return new DisjunctionLine(step);
      else
        throw new ArgumentError;
    }
  }
}
