package org.asspec.story.scenario
{
  import org.asspec.story.scenario.actions.Action;
  import org.asspec.story.scenario.interpretation.Interpreter;

  public class Scenario
  {
    private var context : Action;
    private var stimulation : Action;
    private var verification : Action;

    public function Scenario
      (context : Action,
       stimulation : Action,
       verification : Action)
    {
      this.context = context;
      this.stimulation = stimulation;
      this.verification = verification;
    }

    public function execute(interpreter : Interpreter) : void
    {
      context.execute(interpreter);
      stimulation.execute(interpreter);
      verification.execute(interpreter);
    }
  }
}
