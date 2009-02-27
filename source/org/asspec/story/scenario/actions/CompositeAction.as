package org.asspec.story.scenario.actions
{
  import org.asspec.story.scenario.interpretation.Interpreter;
  import org.asspec.util.sequences.Sequence;

  public class CompositeAction implements Action
  {
    private var actions : Sequence;

    public function CompositeAction(actions : Sequence)
    {
      actions.ensureType(Action);

      this.actions = actions;
    }

    public function execute(interpreter : Interpreter) : void
    {
      for each (var action : Action in actions)
        action.execute(interpreter);
    }
  }
}
