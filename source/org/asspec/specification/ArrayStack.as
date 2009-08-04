package org.asspec.specification
{
  import org.asspec.util.sequences.ArraySequenceContainer;
  import org.asspec.util.sequences.Sequence;
  import org.asspec.util.sequences.SequenceContainer;

  public class ArrayStack implements Stack
  {
    private const container : SequenceContainer
      = new ArraySequenceContainer;

    public function push(element : Object) : void
    { container.add(element); }

    public function pop() : void
    { container.removeAt(container.length - 1); }

    public function get top() : *
    { return container.last; }

    public function set top(value : Object) : void
    { container.set(container.length - 1, value); }

    public function get elements() : Sequence
    { return container.sequence; }
  }
}
