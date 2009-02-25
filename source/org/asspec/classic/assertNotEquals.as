package org.asspec.classic
{
  import org.asspec.specify;

  public function assertNotEquals(actual : Object, expected : Object) : void
  { specify(actual).should.not.equal(expected); }
}
