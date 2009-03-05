package org.asspec.classic
{
  import org.asspec.specify;

  public function assertThrows(thunk : Function, type : Class = null) : void
  {
    if (type == null)
      specify(thunk).should.throw_error;
    else
      specify(thunk).should.throw_error_of_type(type);
  }
}
