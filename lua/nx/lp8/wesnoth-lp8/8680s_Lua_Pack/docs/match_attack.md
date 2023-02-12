
Lua implementation of WML attack filter.
===============================================================================

`lp8.match_attack(attack, filter, tag_name)`
-------------------------------------------------------------------------------
Returns whether `attack` matches `filter`.
`tag_name` is the name of the tag containing the filter, for error reporting;
it defaults to `"filter_attack"`.


`lp8.match_attack_damage(attack, damage)`
-------------------------------------------------------------------------------
Returns whether `attack` has damage `damage`.
`damage` works the same as a `damage=` attribute in a WML attack filter: it can
be a list, range, or list of ranges.


`lp8.match_attack_special(attack, special)`
-------------------------------------------------------------------------------
Returns whether `attack` has a special with id `special`.


