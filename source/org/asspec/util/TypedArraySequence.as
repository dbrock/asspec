package org.asspec.util
{
  public class TypedArraySequence extends ArraySequence
    implements TypedMutableSequence
  {
    private var type : Class;

    override protected function similarSequence(content : Array) : ArraySequence
    { return new TypedArraySequence(type, content); }

    public function TypedArraySequence(type : Class, content : Array = null)
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
