package org.asspec.story.scenario.actions
{
  import org.asspec.story.scenario.interpretation.Interpreter;

  public interface Action
  { function execute(interpreter : Interpreter) : void; }
}
