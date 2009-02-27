package org.asspec.util
{
  import org.asspec.util.sequences.Sequence;

  public class Text
  {
    private var content : String;

    public function Text(string : String)
    { this.content = string; }

    public function get lines() : Sequence
    { return new Sequence(content.split("\n")); }

    public function contains(substring : String) : Boolean
    { return content.indexOf(substring) != -1; }

    public static function of(content : String) : Text
    { return new Text(content); }
  }
}
