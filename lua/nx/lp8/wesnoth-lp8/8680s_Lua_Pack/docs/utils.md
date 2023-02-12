
Miscellaneous utilities.
===============================================================================

`lp8.noop()`
-------------------------------------------------------------------------------
Does nothing. More useful than it might sound.


`lp8.idem(...)`
-------------------------------------------------------------------------------
Takes any quantity of arguments, and returns them all untouched. More useful
than it might sound.


`lp8.to_boolean(x)`
-------------------------------------------------------------------------------
If `x` is nil or false, returns false; otherwise, returns true.


`lp8.keys(table, start_key)`
-------------------------------------------------------------------------------
Returns an iterator over each key in `table`, starting at `start_key` (which
defaults to the “first” (see below) key in the table).

The order in which the keys are traversed is undefined, as with `pairs`.


`lp8.values(table, start_key)`
-------------------------------------------------------------------------------
Returns an iterator over each value in `table`, starting at the value
associated to the key `start_key` (which defaults as in `keys` above).

The order in which the values are traversed is undefined, as with `pairs`.


`lp8.ivalues(table, start_index)`
-------------------------------------------------------------------------------
Returns an iterator over each value in `table` associated to an integral index,
in ascending order, starting at `start_index` (default 1) and ending at the
first subsequent index lacking an associated value.


`lp8.load(ld, env, source)`
-------------------------------------------------------------------------------
Emulates a subset of the Lua 5.2 `load` function’s functionality in 5.2 or 5.1.

Returns a function compiled from `ld`.

`ld` can be:
  a string containing Lua source text;
  a string containing Lua bytecode; or
  a function, which is repeatedly called until it returns `""` or `nil`, and
	its results are concatenated and interpreted as one of the above.

`env` is the environment the function will use; it defaults to the global
environment.

`source` is an optional name for whatever’s being loaded, for error reporting.

If `ld` cannot be compiled (e.g., due to a syntax error), returns two values:
`nil` and an error message.


`lp8.flip(x, control)`
-------------------------------------------------------------------------------
Flips `x` however makes sense.

* If `x` is a string, returns `string.reverse(x)`.
* If `x` is a number, returns `-x`.
* If `x` is a Boolean, returns `not x`.
* If `x` is a table, returns a new table with all values of `x` with integer
  keys from `1` to `#x`, in reverse order.

If `control` is false (but not nil), `x` is not flipped but returned as is.


`lp8.dbgstr(x)`
-------------------------------------------------------------------------------
Returns `tostring(x)`, prefixed with the type of `x` (a standard Lua type, or
a userdata type).

The returned string is generally in the format “type: value”, but some
userdata types may use a different format.

`nil` is returned as simply “nil”, because the string representations of its
type and its value are the same.


`lp8.wml_vars`
-------------------------------------------------------------------------------
A WML variables interface table, as created by `helper.set_wml_var_metatable`.


`lp8.AND`, `lp8.OR`
-------------------------------------------------------------------------------
Opaque constants. Their semantics are defined by functions that take them.

