package org.asspec.story.scenario.actions
{
  import org.asspec.Assert;

  public class ConjunctiveVerification implements ScenarioResponse
  {
    private var alternatives : Array;

    public function ConjunctiveVerification(alternatives : Array)
    { this.alternatives = alternatives; }

    public function verify(interpreter : Interpreter) : void
    {
      for each (var response : ScenarioResponse in alternatives)
        try
          {
            response.verify(interpreter);

            break;
          }
        catch (error : Error)
          {}

      Assert.fail();
    }
  }
}
