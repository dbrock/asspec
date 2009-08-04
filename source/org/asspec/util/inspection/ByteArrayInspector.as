package org.asspec.util.inspection
{
  import flash.utils.ByteArray;

  import org.asspec.util.sequences.ArraySequenceContainer;
  import org.asspec.util.sequences.Sequencable;
  import org.asspec.util.sequences.SequenceContainer;
  
  public class ByteArrayInspector
  {
    private var array : ByteArray;

    public function ByteArrayInspector(array : ByteArray)
    { this.array = array; }

    public function get representation() : String
    {
      const oldPosition : uint = array.position;
      
      array.position = 0;
      
      const result : String = "ByteArray[" + contentRepresentation + "]";
      
      array.position = oldPosition;
      
      return result;
    }
    
    private function get contentRepresentation() : String
    {
      if (array.length <= 20)
        return shortContentRepresentation;
      else
        return longContentRepresentation;
    }
    
    private function get longContentRepresentation() : String
    {
      return formatBytes(10)
        + " ... (" + (array.length - 10) + " more bytes)";
    }
    
    private function get shortContentRepresentation() : String
    { return formatBytes(array.length); }
    
    private function formatBytes(count : uint) : String
    { return getBytes(count).map(formatByte).join(" "); }
    
    private function getBytes(count : uint) : Sequencable
    {
      const result : SequenceContainer = new ArraySequenceContainer;
      
      for (var i : uint = 0; i < count; ++i)
        result.add(array.readByte());
        
      return result;
    }
    
    private function formatByte(value : uint) : String
    {
      if (value < 16)
        return "0" + value.toString(16);
      else
        return value.toString(16);
    }
  }
}
