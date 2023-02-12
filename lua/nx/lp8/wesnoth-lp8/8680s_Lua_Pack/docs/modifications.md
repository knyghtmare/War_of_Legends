
For manipulating [object]s and other modifications.
===============================================================================

`lp8.get_objects(unit, filter, full_tags)`
-------------------------------------------------------------------------------
Returns a list of the contents of each [object] tag in the `unit`’s
[modifications] that matches `filter`.

If `full_tags` is truthy, returns the tags, rather than only their contents.


`lp8.get_object_tags(unit, filter)`
-------------------------------------------------------------------------------
Equivalent to `lp8.get_objects(unit, filter, true)`.


`lp8.get_object_cfgs(unit, filter)`
-------------------------------------------------------------------------------
Equivalent to `lp8.get_objects(unit, filter, false)`.


`lp8.objects(unit, filter, full_tags)`
-------------------------------------------------------------------------------
Returns an iterator over each entry in the list returned by
`lp8.get_objects(unit, filter, full_tags)`.


`lp8.object_tags(unit, filter)`
-------------------------------------------------------------------------------
Equivalent to `lp8.objects(unit, filter, true)`.


`lp8.object_cfgs(unit, filter)`
-------------------------------------------------------------------------------
Equivalent to `lp8.objects(unit, filter, false)`.


`lp8.remove_effect(unit, effect)`
-------------------------------------------------------------------------------
Removes the given `effect` (a tag or cfg) from `unit` (a cfg or proxy).

The effect need not have ever been applied to the unit.

Does not remove the effect tag itself from the unit (it couldn’t, if the effect
had never been applied to the unit). If the effect tag was stored in the unit,
and the unit advances, the effect may be reapplied if the effect tag is not
removed first.


`lp8.remove_object(unit, object, effects, leave_husk, fail_silently)`
-------------------------------------------------------------------------------
If `effects` is not a string, this function removes from the given `unit`
(which may be a cfg or proxy) all [effect]s of the given `object` (a tag or
cfg) that match `effects` (which may be any type of filter supported by
`wml/match_tag`, except a string).

If `effects` is the string `"skip"`, this function will not bother undoing the
object’s [effect]s, but will instead only remove the [object] tag from the
unit’s [modifications] subtag. If `effects` is `"skip"` and `leave_husk` is
truthy, an error will be raised.

If `effects` is any other string, an error will be raised.

The object must be a subtag or child of the unit’s [modifications] subtag; i.e.
it must have been applied to the unit at some point.

If the object is not in the unit’s [modifications], or if the unit has no
[modifications], an error will be raised, unless `fail_silently` is truthy.

If all [effect]s of the object are removed, the remnants of the object will
be deleted, unless `leave_husk` is truthy.


`lp8.remove_objects(unit, object_filter, effects, leave_husks)`
-------------------------------------------------------------------------------
Like `remove_object`, but removes each object matching `object_filter`.

`fail_silently` is always off, because it is irrelevant, unless another thread
is removing objects simultaneously.

