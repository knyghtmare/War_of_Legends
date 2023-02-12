lp8.import 'type'

assert(type(Type) == 'table')
assert(tostring(Type) == 'Type')

local TestType = Type 'TestType'
assert(type(TestType) == 'table')
assert(Type.of(TestType) == Type)
assert(tostring(TestType) == 'TestType')

local testTypeObj = TestType()
assert(type(testTypeObj) == 'table')
assert(Type.of(testTypeObj) == TestType)

local TestTypetag = Typetag 'TestTypetag'
assert(type(TestTypetag) == 'table')
assert(Type.of(TestTypetag) == Typetag)
assert(tostring(TestTypetag) == 'TestTypetag')

testTypetagObj = TestTypetag(setmetatable({a=1, b=2, c=3}, {x=1, y=2, z=3}))
assert(type(testTypetagObj) == 'table')
assert(Type.of(testTypetagObj) == TestTypetag)
assert(testTypetagObj.a == 1)
assert(testTypetagObj.b == 2)
assert(testTypetagObj.c == 3)
local testTypetagObj_mt = getmetatable(testTypetagObj)
assert(testTypetagObj_mt.x == 1)
assert(testTypetagObj_mt.y == 2)
assert(testTypetagObj_mt.z == 3)

-- `Class` doesn’t exist yet.
do return end

local TestClass = Class 'TestClass' {
	ClassField  'string'  's';
	ClassField  'number'  'n';
	ClassField (TestType) 'x';
	ClassMethod 'foo(string a, TestType b)' [[
		return n+1, s..a, {x, b}, self.bar()
	]];
	ClassVar 'boolean' 'b' (true);
	ClassFunc 'bar()' [[
		return self.b;
	]];
}

assert(type(TestClass) == 'table')
assert(Type.of(TestClass) == Class)
assert(tostring(TestClass) == 'TestClass')

assert(TestClass.b == true)
assert(TestClass.bar() == true)
TestClass.b = false
assert(TestClass.bar() == false)

local testClassObj = TestClass {
	s = 'abc';
	n = 5;
	x = testTypeObj;
}
assert(type(testClassObj) == 'table')
assert(Type.of(testClassObj) == TestClass)
assert(testClassObj.s == 'abc')
assert(testClassObj.n == 5)
assert(testClassObj.x == testTypeObj)
assert(testClassObj.bar() == false)
TestClass.b = true
assert(testClassObj.bar() == true)

do
	local testTypeObj2 = TestType()
	local n, s, x, b = testClassObj:foo('xyz', testTypeObj2)
	assert(n == 6)
	assert(s == 'abcxyz')
	assert(x[1] == testTypeObj)
	assert(x[2] == testTypeObj2)
	assert(b == true)
end

-- vim: tabstop=4:
