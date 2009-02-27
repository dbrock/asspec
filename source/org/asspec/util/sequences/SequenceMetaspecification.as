package org.asspec.util.sequences
{
  import org.asspec.fail;
  import org.asspec.specification.AbstractSpecification;
  import org.asspec.specify;

  public class SequenceMetaspecification extends AbstractSpecification
  {
    private function seq(... content : Array) : Sequence
    { return new Sequence(content); }

    override protected function execute() : void
    {
      requirement("looping through an empty sequence should not do anything", function () : void {
        for each (var element : Object in seq())
          fail(); });

      requirement("looping through a pair should enumerate the pair", function () : void {
        const result : Array = [];

        for each (var element : Object in seq(1, 2))
          result.push(element);

        specify(result).should.equal([1, 2]); });
    }
  }
}
