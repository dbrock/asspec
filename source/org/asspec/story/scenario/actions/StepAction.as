package org.asspec.story.scenario.actions
{
  import org.asspec.story.scenario.Step;
  import org.asspec.story.scenario.interpretation.Interpreter;

  public class StepAction implements Action
  {
    private var step : Step;

    public function StepAction(step : Step)
    { this.step = step; }

    public function execute(interpreter : Interpreter) : void
    { interpreter.execute(step); }

    public static function create(step : Step) : StepAction
    { return new StepAction(step); }
  }
}
