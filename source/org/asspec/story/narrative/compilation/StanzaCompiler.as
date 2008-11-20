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
  import org.asspec.util.Sequence;
  import org.asspec.util.TypedArraySequence;
  import org.asspec.util.TypedMutableSequence;

  public class StanzaCompiler
  {
    // Input.
    private var stanza : Stanza;

    // Result accumulators.
    private var context : Action;
    private var stimulationSteps : TypedMutableSequence
      = new TypedArraySequence(Step);

    // Output.
    public var scenarios : TypedMutableSequence
      = new TypedArraySequence(Scenario);

    public static function compile(text : String) : Sequence
    { return getScenarios(ParagraphParser.parse(text)); }

    public static function getScenarios(stanza : Stanza) : Sequence
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

    private function createCompositeAction(steps : Sequence) : Action
    { return new CompositeAction(steps.map(createStepAction)); }

    private function createStepAction(step : Step) : Action
    { return new StepAction(step); }

    private function compileStatements(statements : Sequence) : void
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
