package org.asspec.story.scenario.test
{
  import org.asspec.basic.BasicTest;
  import org.asspec.story.scenario.Scenario;
  import org.asspec.story.scenario.interpretation.Interpreter;

  public class ScenarioTest extends BasicTest
  {
    private var interpreter : Interpreter;
    private var scenario : Scenario;

    public function ScenarioTest
      (interpreter : Interpreter, scenario : Scenario)
    {
      this.interpreter = interpreter;
      this.scenario = scenario;
    }

    override protected function execute() : void
    { scenario.execute(interpreter); }
  }
}
