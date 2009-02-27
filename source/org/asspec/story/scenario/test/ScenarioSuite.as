package org.asspec.story.scenario.test
{
  import org.asspec.basic.AbstractSuite;
  import org.asspec.story.scenario.Scenario;
  import org.asspec.story.scenario.interpretation.Interpreter;
  import org.asspec.util.sequences.Sequence;

  public class ScenarioSuite extends AbstractSuite
  {
    private var interpreterFactory : InterpreterFactory;
    private var scenarios : Sequence;

    public function ScenarioSuite
      (interpreter : InterpreterFactory, scenarios : Sequence)
    {
      scenarios.ensureType(Scenario);

      this.interpreterFactory = interpreter;
      this.scenarios = scenarios;
    }

    override protected function populate() : void
    { scenarios.forEach(addTestForScenario); }

    private function addTestForScenario(scenario : Scenario) : void
    { add(new ScenarioTest(newInterpreter, scenario)); }

    private function get newInterpreter() : Interpreter
    { return interpreterFactory.getInterpreter(); }
  }
}
