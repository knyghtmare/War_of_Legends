
For more easily manipulating WML objects (`cfg`s) in Lua.
===============================================================================

An `index` argument can be omitted, in which case it defaults to 1.


**NOTE**: When I say “tag” or “subtag”, I mean the whole thing, e.g.:

	{"gold",{ side=1, amount=100 }}

Not just the cfg contents, like what `helper.get_child` returns, e.g.:

	{ side=1, amount=100 }


`lp8.is_cfg(x)`
-------------------------------------------------------------------------------
Returns whether `x` is (or at least looks like) a WML cfg object (userdatas
only; cfgs represented as tables, like `unit_proxy.__cfg` and
`userdata_cfg.__parsed`, don’t count).


`lp8.is_tag(x)`
-------------------------------------------------------------------------------
Returns whether `x` is (or at least looks like) a WML tag object (both
userdatas and tables count).


`lp8.to_cfg(x, f)`
-------------------------------------------------------------------------------
If `x` is a tag, returns its cfg contents. Otherwise, returns `x`.

If `f` is specified, an error is raised if `x` is a tag but does not match the
filter `f` (see `match_tag` below).


`lp8.to_tag(x, name)`
-------------------------------------------------------------------------------
If `x` is not already a tag, returns `{name, x}` (`name` defaults to "dummy").
Otherwise, returns `x`.


`lp8.is_unit_proxy(x)`
-------------------------------------------------------------------------------
Returns whether `x` is (or at least looks like) a unit proxy.


`lp8.match_tag(tag, filter)`
-------------------------------------------------------------------------------
Returns whether `tag` matches `filter`.

`filter` can be a string, a function, a Boolean, a WML tag object, a list of
filters, or nil.

* A string filter matches if it equals the tag’s name.
* A function filter matches if `filter(tag)` is truthy.
* A tag object filter matches if `tag` contains its contents; that is, for each
  key in `filter`, `tag` has a key with the same name and value, and, for each
  subtag in `filter`, `tag` has a subtag with the same name for which
  `match_tag(tag_subtag, filter_subtag)` returns true.
* A list filter with `lp8.AND` as its first element matches if all of its
  other elements match.
* A list filter with `lp8.OR` as its first element matches if any of its
  other elements match.
* A Boolean filter matches if it is true.
* A nil filter always matches (like an empty filter in WML).

This is the function used to match tags to filters by the other functions.


`lp8.cfgs_equal(cfg1, cfg2)`
-------------------------------------------------------------------------------
Returns whether `cfg1` and `cfg2` are structurally equal.


`lp8.tags_equal(tag1, tag2)`
-------------------------------------------------------------------------------
Returns whether `tag1` and `tag2` are nominally and structurally equal.


`lp8.is_subtag(p, c)`
-------------------------------------------------------------------------------
Returns whether the tag or cfg `p` contains the tag `c`.


`lp8.is_child(p, c)`
-------------------------------------------------------------------------------
Returns whether the tag or cfg `p` contains a tag whose content is the cfg `c`.


`lp8.get_subtag(p, filter, index)`
-------------------------------------------------------------------------------
Returns the `index`-th matching subtag of the tag or cfg `p`.


`lp8.get_child(p, filter, index)`
-------------------------------------------------------------------------------
Returns the contents (like `helper.get_child`) of the `index`-th matching
subtag of the tag or cfg `p`.


`lp8.get_subtags(p, filter, flip)`
-------------------------------------------------------------------------------
Returns a list containing each matching subtag of the tag or cfg `p`.

If no matching subtags are found, the returned table is empty.

If `flip` is truthy, the order of the subtags in the returned list is opposite
from their original order in `p`.


`lp8.get_children(p, filter, flip)`
-------------------------------------------------------------------------------
Returns a list containing the contents of each matching subtag of tag/cfg `p`.

If no matching subtags are found, the returned table is empty.

`flip` works like in `get_subtags`.


`lp8.subtags(p, filter)`
-------------------------------------------------------------------------------
Returns an iterator over all matching subtags of the tag or cfg `p`.


`lp8.chilren(p, filter)`
-------------------------------------------------------------------------------
Returns an iterator over the contents of all matching subtags of tag/cfg `p`.


`lp8.remove_subtag(p, filter, index)`
-------------------------------------------------------------------------------
Removes the `index`-th matching subtag of the tag or cfg `p`.
Returns the removed subtag.


`lp8.remove_child(p, filter, index)`
-------------------------------------------------------------------------------
Removes the `index`-th matching subtag of the tag or cfg `p`.
Returns the contents of the removed subtag.


`lp8.remove_subtags(p, filter, flip)`
-------------------------------------------------------------------------------
Removes each matching subtag of the tag or cfg `p`.
Returns a list containing each removed subtag.

`flip` works the same as in `get_subtags`.


`lp8.remove_children(p, filter, flip)`
-------------------------------------------------------------------------------
Removes each matching subtag of the tag or cfg `p`.
Returns a list containing the contents of each removed subtag.

`flip` works like in `get_subtags`.


`lp8.erase_subtags(p, filter)`
-------------------------------------------------------------------------------
Like `remove_subtags`, but doesn’t save the erased subtags.


`lp8.to_unit_cfg(u)`
-------------------------------------------------------------------------------
If `u` is a unit proxy, returns `u.__cfg`. If `u` is already a unit cfg,
returns it unharmed.

Secondarily returns a Boolean indicating whether `u` was a proxy.

