print("Hello world!")

-- This is a comment. It starts with two dashes
--[[ This is also 
      a comment.
      
      But it spans multiple lines
--]]

-- functions

local function hello(name)
	print("Hello!", name)
end

hello("Bill")

local greet = function(name)
	-- .. is string concatenation
	print("Greetings, " .. name .. "!")
end

greet("Bill")

local higher_order = function(value)
	return function(another)
		return value + another
	end
end

local add_one = higher_order(1)
print("add_one(2) -> ", add_one(2))

-- multiple returns
local returns_four_values = function()
	return 1, 2, 3, 4
end

first, second, last = returns_four_values()

print("first:", first)
print("second:", second)
print("last:", last)
-- the `4` is discarded

-- multiple returns with arguments
local variable_arguments = function(...)
	local arguments = { ... }
	for i, v in ipairs({ ... }) do
		print(i, v)
	end
	return unpack(arguments)
end

print("================")
print("1:", variable_arguments("hello", "world", "!"))
print("================")
print("2:", variable_arguments("hello", "world", "!"), "<lost>")

-- function calling
local single_string = function(s)
	return s .. " - WOW!"
end

local x = single_string("h1")
local y = single_string("h1")
print(x, y)

-- function calling with table
local setup = function(opts)
	if opts.default == nil then
		opts.default = 17
	end

	print(opts.default, opts.other)
end

setup({ default = 12, other = false })
setup({ other = true })

-- tables
-- As list
local list = {
	"first",
	2,
	false,
	function()
		print("Fourth!")
	end,
}
print("Yup, 1-indexed:", list[1])
print("Fourth is 4 ...:", list[4]())

-- As map
local t = {
	literal_key = "a string",
	["an expression"] = "also works",
	[function() end] = true,
}
print("literal_key:", t.literal_key)
print("an expression:", t["an expression"])
print("function() end:", t[function() end])

-- Control flow
-- for
local favorite_accounts = { "teej_dv", "Theprimeagen", "terminaldotshop" }
for index = 1, #favorite_accounts do
	print(index, favorite_accounts[index])
end

for index, value in ipairs(favorite_accounts) do
	print(index, value)
end

-- for in maps
local reading_scores = { teej_dv = 9.5, Theprimeagen = "N/A" }
for index, value in pairs(reading_scores) do
	print(index, value)
end

-- if
local function action(loves_coffee)
	if loves_coffee then
		print("Check out `ssh terminal.shop` - it's coll!")
	else
		print("Check out `ssh terminal.shop` - it's still coll!")
	end
end

-- "falsey": nil, false
action() -- Same as: action(nil)
action(false)

-- Everything else is "truthy"
action(true)
action(0)
action({})

-- Metatables
local vector_mt = {}
vector_mt.__add = function(left, right)
	return setmetatable({
		left[1] + right[1],
		left[2] + right[2],
		left[3] + right[3],
	}, vector_mt)
end

local v1 = setmetatable({ 3, 1, 5 }, vector_mt)
local v2 = setmetatable({ -3, 2, 2 }, vector_mt)
local v3 = v1 + v2
vim.print(v3[1], v3[2], v3[3])
vim.print(v3 + v3)

--

local fib_mt = {
	__index = function(self, key)
		if key < 2 then
			return 1
		end
		-- Update the table, to save the intermediate results
		self[key] = self[key - 2] + self[key - 1]
		-- Return the result
		return self[key]
	end,
}

local fib = setmetatable({}, fib_mt)

print(fib[5])
print(fib[1000])
