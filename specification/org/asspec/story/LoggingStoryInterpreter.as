package org.asspec.story
{
  import org.asspec.story.scenario.interpretation.Interpreter;
  import org.asspec.story.scenario.test.InterpreterFactory;

  public class LoggingStoryInterpreter implements InterpreterFactory
  {
    private const interpreters : Array = [];

    public function getInterpreter() : Interpreter
    {
      const result : Interpreter = new LoggingScenarioInterpreter;

      interpreters.push(result);

      return result;
    }

    public function get log() : String
    {
      var result : String = "";

      for each (var interpreter : LoggingScenarioInterpreter in interpreters)
        result += "[" + interpreter.log + "]";

      return result;
    }
  }
}
