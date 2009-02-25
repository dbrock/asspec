package org.asspec
{
  public function fail(message : String = null) : void
  { throw new AssertionError(message); }
}
