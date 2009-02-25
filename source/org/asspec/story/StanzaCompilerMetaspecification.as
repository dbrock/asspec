package org.asspec.story
{
  import org.asspec.Test;
  import org.asspec.basic.NullTestListener;
  import org.asspec.specification.AbstractSpecification;
  import org.asspec.specify;
  import org.asspec.story.narrative.compilation.StanzaCompiler;
  import org.asspec.story.scenario.test.ScenarioSuite;

  public class StanzaCompilerMetaspecification extends AbstractSpecification
  {
    override protected function execute() : void
    {
      const interpreter : LoggingStoryInterpreter
        = new LoggingStoryInterpreter;

      it("should handle a simple couplet", function () : void {
        shouldProduceLog("[G, T]", ["Given G", "Then T"]); });

      it("should handle a couplet with a complex context", function () : void {
        shouldProduceLog("[G1, G2, T]", ["Given G1", "Given G2", "Then T"]); });

      it("should handle a simple tercet", function () : void {
        shouldProduceLog("[G, W, T]", ["Given G", "When W", "Then T"]); });

      it("should handle a tercet with a complex stimulation", function () : void {
        shouldProduceLog("[G, W1, W2, T]",
          ["Given G", "When W1", "When W2", "Then T"]); });

      it("should handle a forked couplet", function () : void {
        shouldProduceLog("[G, T1][G, T2]",
          ["Given G", "Then T1", "Then T2"]); });

      it("should handle a balanced forked tercet", function () : void {
        shouldProduceLog("[G, W, T1][G, W, T2]",
          ["Given G", "When W", "Then T1", "Then T2"]); });

      it("should handle an unbalanced forked tercet", function () : void {
        shouldProduceLog("[G, T1][G, W, T2]",
          ["Given G", "Then T1", "When W", "Then T2"]); });

      it("should handle context conjunction", function () : void {
        shouldProduceLog("[G1, G2, G3, G4, T]",
          ["Given G1", "And G2", "And G3", "Given G4", "Then T"]); });

      it("should handle stimulation conjunction", function () : void {
        shouldProduceLog("[G, W1, W2, W3, W4, T]",
          ["Given G", "When W1", "And W2", "And W3", "When W4", "Then T"]); });

      it("should handle verification conjunction in couplet", function () : void {
        shouldProduceLog("[G, T1][G, T2][G, T3][G, T4]",
          ["Given G", "Then T1", "And T2", "And T3", "Then T4"]); });

      it("should handle verification conjunction in tercet", function () : void {
        shouldProduceLog("[G, W, T1][G, W, T2][G, W, T3][G, W, T4]",
          ["Given G", "When W", "Then T1", "And T2", "And T3", "Then T4"]); });

//      it("should handle stimulation disjunction", function () : void {
//        shouldProduceLog("[G, W1, T][G, W2, T]",
//          ["Given G", "When W1", "Or W2", "Then T"]); });

      function shouldProduceLog(expected : String, steps : Array) : void
      {
        runScenario(steps.join("\n"));
        specify(interpreter.log).should.equal(expected);
      }

      function runScenario(text : String) : void
      { runTest(new ScenarioSuite(interpreter, StanzaCompiler.compile(text))); }
    }

    private static function runTest(test : Test) : void
    { test.run(new NullTestListener); }
  }
}
