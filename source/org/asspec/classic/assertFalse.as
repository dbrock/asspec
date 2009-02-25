package org.asspec.classic
{
  import org.asspec.specify;

  public function assertFalse(actual : Boolean) : void
  { specify(actual).should.not.hold; }
}
