package org.asspec.util
{
  public function curry
    (uncurriedFunction : Function,
     ... givenArguments : Array) : Function
  {
    return function (... extraArguments : Array) : * {
      const combinedArguments : Array
        = givenArguments.concat(extraArguments);

      return uncurriedFunction.apply(this, combinedArguments);
    };
  }
}
