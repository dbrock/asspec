package org.asspec.classic
{
  import org.asspec.specify;

  public function assertTrue(actual : Boolean) : void
  { specify(actual).should.hold; }
}
