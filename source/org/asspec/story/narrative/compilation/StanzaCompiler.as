package org.asspec.story.narrative.compilation
{
  import org.asspec.story.narrative.parsing.ParagraphParser;
  import org.asspec.story.narrative.parsing.Qualification;
  import org.asspec.story.narrative.parsing.Stanza;
  import org.asspec.story.narrative.parsing.Statement;
  import org.asspec.story.narrative.parsing.Verification;
  import org.asspec.story.scenario.Scenario;
  import org.asspec.story.scenario.Step;
  import org.asspec.story.scenario.actions.Action;
  import org.asspec.story.scenario.actions.CompositeAction;
  import org.asspec.story.scenario.actions.StepAction;
  import org.asspec.util.Sequencable;
  import org.asspec.util.TypedArrayContainer;
  import org.asspec.util.TypedSequenceContainer;

  public class StanzaCompiler
  {
    // Input.
    private var stanza : Stanza;

    // Result accumulators.
    private var context : Action;
    private var stimulationSteps : TypedSequenceContainer
      = new TypedArrayContainer(Step);

    // Output.
    public var scenarios : TypedSequenceContainer
      = new TypedArrayContainer(Scenario);

    public static function compile(text : String) : Sequencable
    { return getScenarios(ParagraphParser.parse(text)); }

    public static function getScenarios(stanza : Stanza) : Sequencable
    { return new StanzaCompiler(stanza).scenarios; }

    public function StanzaCompiler(stanza : Stanza)
    {
      this.stanza = stanza;

      compile();
    }

    private function compile() : void
    {
      compileContext();
      compileStatements(stanza.statements);
    }

    private function compileContext() : void
    { context = createCompositeAction(stanza.context); }

    private function createCompositeAction(steps : Sequencable) : Action
    { return new CompositeAction(steps.map(createStepAction)); }

    private function createStepAction(step : Step) : Action
    { return new StepAction(step); }

    private function compileStatements(statements : Sequencable) : void
    { statements.forEach(compileStatement); }

    private function compileStatement(statement : Statement) : void
    {
      if (statement is Verification)
        addScenarios(Verification(statement));
      else if (statement is Qualification)
        compileQualification(Qualification(statement));
      else
        throw new Error("unrecognized statement: " + statement);
    }

    private function addScenarios(verification : Verification) : void
    { verification.steps.forEach(addScenario); }

    private function addScenario(verificationStep : Step) : void
    { scenarios.add(createScenario(createStepAction(verificationStep))); }

    private function createScenario(verification : Action) : Scenario
    { return new Scenario(context, stimulation, verification); }

    private function get stimulation() : Action
    { return createCompositeAction(stimulationSteps); }

    private function compileQualification(qualification : Qualification) : void
    {
      qualification.qualifiers.forEach(stimulationSteps.add);

      compileStatements(qualification.statements);
    }
  }
}
