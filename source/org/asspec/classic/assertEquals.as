package org.asspec.classic
{
  import org.asspec.specify;

  public function assertEquals(actual : Object, expected : Object) : void
  { specify(actual).should.equal(expected); }
}
