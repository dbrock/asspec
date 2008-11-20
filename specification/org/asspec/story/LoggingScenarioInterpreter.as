package org.asspec.story
{
  import org.asspec.story.scenario.Step;
  import org.asspec.story.scenario.interpretation.Interpreter;

  public class LoggingScenarioInterpreter implements Interpreter
  {
    public const steps : Array = [];

    public function execute(step : Step) : void
    { steps.push(step); }

    public function get log() : String
    { return steps.join(", "); }
  }
}
