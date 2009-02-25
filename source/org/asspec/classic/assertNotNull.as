package org.asspec.classic
{
  import org.asspec.specify;

  public function assertNotNull(actual : Object) : void
  { specify(actual).should.not.equal(null); }
}
