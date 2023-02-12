
lp8 loading and module management.
===============================================================================

This module is automatically loaded if any other lp8 module is loaded.
However, if you want to control the loading of lp8 dynamically from Lua rather
than statically from WML, you can load just this module from WML:

	{8680/lua-pack load}


`lp8.lp8dir`
-------------------------------------------------------------------------------
The directory where lp8 is loaded from (a string).


`lp8.require(module_name)`
-------------------------------------------------------------------------------
Loads the specified lp8 module into the `lp8` table, if it was not already
loaded.

Returns the module, and secondarily a Boolean-ish value indicating whether it
was already loaded.

Example: `lp8.require 'wml'` would load the `wml` module into `lp8`.


`lp8.import(module_name_string, target_table)`
-------------------------------------------------------------------------------
Loads the specified lp8 module into the `lp8` table and imports its contents
into `target_table`, which defaults to the global environment.

Example: `lp8.import 'wml'` would load the `wml` module into `lp8` and into
the global environment.


`lp8.import(module_table, target_table)`
-------------------------------------------------------------------------------
Loads the contents of `module_table` into `target_table`, which defaults to
the global environment.

Example: `lp8.import(lp8.wml)` would load the `wml` module, assuming it was
already `require`d, into the global environment.


`lp8.new_module(name)`
-------------------------------------------------------------------------------
Begins defining a module. Creates a hidden “symbol table” that stores the
module’s contents.

Currently, only one module may be defined at a time — calling this function
while another module is being defined will result in an error.


`lp8.export(symbol, name)`
-------------------------------------------------------------------------------
Adds the `symbol` (a variable or function) to the symbol table of the module
currently being defined (it is an error to call this when not defining a
module). The symbol will be named `name`.

Returns `symbol`.


`lp8.export()`
-------------------------------------------------------------------------------
Called without arguments, `export` ends the module definition process and
returns the module’s symbol table.
