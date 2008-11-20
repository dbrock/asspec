package org.asspec.story.narrative.scanning
{
  import org.asspec.util.Sequence;
  import org.asspec.util.Text;
  import org.asspec.util.TypedArraySequence;

  public class ParagraphScanner
  {
    public static function getParagraph(input : String) : Paragraph
    { return new ParagraphScanner(input).paragraph; }

    private const lines : TypedArraySequence
      = new TypedArraySequence(Line);

    public function ParagraphScanner(input : String)
    { getParagraph(Text.lines(input)); }

    public function get paragraph() : Paragraph
    { return new Paragraph(lines); }

    private function getParagraph(rawLines : Sequence) : void
    { rawLines.forEach(parseLine); }

    private function parseLine(input : String) : void
    { lines.add(new LineScanner(input).line); }

    private function get previousLine() : Line
    { return lines.last; }
  }
}
