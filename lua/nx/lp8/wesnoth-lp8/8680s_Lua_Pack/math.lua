
-- By 8680.

lp8.newLib 'math'

local lesser, greater =
	math.min, math.max

local function clamp(n, min, max)
	return greater(min, lesser(max, n))
end
lp8.export(clamp, 'clamp')

return lp8.export()
