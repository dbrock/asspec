package org.asspec.story.narrative.parsing
{
  import org.asspec.story.narrative.scanning.Line;
  import org.asspec.story.narrative.scanning.Paragraph;
  import org.asspec.story.narrative.scanning.ParagraphScanner;
  import org.asspec.story.scenario.Step;
  import org.asspec.util.sequences.Sequence;
  import org.asspec.util.sequences.TypedArrayContainer;
  import org.asspec.util.sequences.TypedSequenceContainer;

  public class ParagraphParser
  {
    public static function parse(text : String) : Stanza
    { return getStanza(ParagraphScanner.getParagraph(text)); }

    public static function getStanza(paragraph : Paragraph) : Stanza
    { return new ParagraphParser(paragraph).stanza; }

    private var input : Sequence;
    private var context : Sequence;
    private var statements : Sequence;

    public function ParagraphParser(paragraph : Paragraph)
    {
      input = paragraph.lines;

      parse();
    }

    private function parse() : void
    {
      context = parseContext();
      statements = parseStatements();
    }

    private function parseContext() : Sequence
    {
      if (!currentLine.isContextLine)
        throw new Error("first line must be context line");

      const result : TypedSequenceContainer
        = new TypedArrayContainer(Step);

      while (currentLine.isContextLine)
        parseConjoinedSteps().forEach(result.add);

      return result.sequence;
    }

    private function parseConjoinedSteps() : Sequence
    {
      const first : Step = takeLine().step;
      const rest : Sequence = parseConjunctionTail();

      return rest.cons(first);
    }

    private function takeLine() : Line
    {
      const result : Line = currentLine;

      input = input.rest;

      return result;
    }

    private function parseConjunctionTail() : Sequence
    { return takeWhile(Line.isConjunctionLine).map(Line.step); }

    private function takeWhile(predicate : Function) : Sequence
    {
      const result : Sequence = input.takeWhile(predicate);

      input = input.dropWhile(predicate);

      return result;
    }

    private function parseStatements() : Sequence
    {
      const statements : TypedSequenceContainer
        = new TypedArrayContainer(Statement);

      while (hasMoreInput)
        statements.add(parseStatement());

      return statements.sequence;
    }

    private function get hasMoreInput() : Boolean
    { return !input.empty; }

    private function parseStatement() : Statement
    {
      if (currentLine.isVerificationLine)
        return parseVerification();
      else if (currentLine.isStimulationLine)
        return parseQualification();
      else
        throw new Error("unexpected line: " + currentLine);
    }

    private function parseVerification() : Verification
    { return new Verification(parseConjoinedSteps()); }

    private function parseQualification() : Qualification
    {
      const qualifiers : Sequence = parseConjoinedSteps();
      const statements : Sequence = parseStatements();

      return new Qualification(qualifiers, statements);
    }

    private function get currentLine() : Line
    { return input.first; }

    public function get stanza() : Stanza
    { return new Stanza(context, statements); }
  }
}
