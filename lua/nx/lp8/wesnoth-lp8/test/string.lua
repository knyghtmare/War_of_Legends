lp8.import 'string'
lp8.require 'utils'

assert(trim ' abc ' == 'abc')
assert(trim '  abc' == 'abc')
assert(trim '\n\f\va b\tc\t\r' == 'a b\tc')
assert(trim ' \t\n\r\f\v' == '')
assert(gtrim ' abc ' == 'abc')
assert(gtrim '  abc' == 'abc')
assert(gtrim '\n\f\va b\tc\t\r' == 'abc')
assert(gtrim ' \t\n\r\f\v' == '')

do
	assert(eval '1+2' == 3)
	assert(eval('x+2', {x = 1}) == 3)
	local r, m = pcall(eval, '!')
	assert(r == false)
	assert(m:match [[^%.%./8680s_Lua_Pack/string%.lua:%d+: can’t compile "!" — unexpected symbol near '!' %(line 1%)$]])
	r, m = pcall(eval, 'x')
	assert(r == false)
	assert(m == [[[string "return x"]:1: attempt to index upvalue '_ENV' (a nil value)]])
	assert(eval('!', nil, lp8.noop) == nil)
	assert(eval('!', nil, lp8.noop, lp8.noop) == nil)
end

assert(strtod '12345' == 12345)
assert(strtod '-0x10aFp5' == -0x10aFp5)
assert(strtod 'Inf' == 1/0)
assert(strtod 'iNfInItY' == 1/0)
assert(strtod '+Inf' == 1/0)
assert(strtod '+iNfInItY' == 1/0)
assert(strtod '-Inf' == -(1/0))
assert(strtod '-iNfInItY' == -(1/0))
-- NaN ≠ NaN…
assert(tostring(strtod 'NaN') == 'nan')
assert(tostring(strtod 'nan(abc)') == 'nan')
