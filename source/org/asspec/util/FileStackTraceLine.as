package org.asspec.util
{
  public class FileStackTraceLine extends StackTraceLine
  {
    public var fileName : String;
    public var lineNumber : uint;

    public function FileStackTraceLine(methodName : String, fileName : String, lineNumber : uint)
    {
      super(methodName);

      this.fileName = fileName;
      this.lineNumber = lineNumber;
    }

    override public function toString() : String
    { return super.toString() + " (" + fileName + ":" + lineNumber + ")"; }
  }
}
