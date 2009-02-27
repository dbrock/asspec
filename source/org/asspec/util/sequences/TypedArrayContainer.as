package org.asspec.util.sequences
{
  public class TypedArrayContainer extends ArrayContainer
    implements TypedSequenceContainer
  {
    private var type : Class;

    public function TypedArrayContainer(type : Class, content : Array = null)
    {
      super(content);

      this.type = type;

      ensureType(type);
    }

    override public function add(element : Object) : void
    {
      ensureElementHasType(element, type);

      super.add(element);
    }
  }
}
