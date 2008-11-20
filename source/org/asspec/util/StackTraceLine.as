package org.asspec.util
{
  public class StackTraceLine
  {
    public var methodName : String;
    public var fileName : String;
    public var lineNumber : uint;

    public function StackTraceLine
      (methodName : String, fileName : String, lineNumber : uint)
    {
      this.methodName = methodName;
      this.fileName = fileName;
      this.lineNumber = lineNumber;
    }

    public static function parse(input : String) : StackTraceLine
    {
      const match : Array = input.match(/^\s+at (.*)\[(.*):(\d+)\]/);

      const methodName : String = match[1];
      const fileName : String = match[2].replace(/.*[\/\\](.*)$/, "$1");
      const lineNumber : uint = parseInt(match[3]);

      return new StackTraceLine(methodName, fileName, lineNumber);
    }

    public function toString() : String
    { return "    at " + methodName + " (" + fileName + ":" + lineNumber + ")"; }
  }
}
