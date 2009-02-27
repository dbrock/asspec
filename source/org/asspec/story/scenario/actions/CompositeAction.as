package org.asspec.story.scenario.actions
{
  import org.asspec.story.scenario.interpretation.Interpreter;
  import org.asspec.util.Sequencable;

  public class CompositeAction implements Action
  {
    private var actions : Sequencable;

    public function CompositeAction(actions : Sequencable)
    { this.actions = actions; }

    public function execute(interpreter : Interpreter) : void
    {
      for each (var action : Action in actions)
        action.execute(interpreter);
    }
  }
}
