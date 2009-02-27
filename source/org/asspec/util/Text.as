package org.asspec.util
{
  public class Text
  {
    private var content : String;

    public function Text(string : String)
    { this.content = string; }

    public function get lines() : Sequencable
    { return new ArrayContainer(content.split("\n")); }

    public function contains(substring : String) : Boolean
    { return content.indexOf(substring) != -1; }

    public static function of(content : String) : Text
    { return new Text(content); }
  }
}
