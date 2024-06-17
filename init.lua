local windowFilter = hs.window.filter.new()

windowFilter:setDefaultFilter({})
windowFilter:setSortOrder(hs.window.filter.sortByFocusedLast)

local function currentWindows()
	local windows = {}

	for i, v in ipairs(windowFilter:getWindows()) do
		table.insert(windows, v)
	end

	return windows
end

local function focusByApp(appName)
	local windows = currentWindows()

	for i, v in ipairs(windows) do
		if string.find(v:application():name(), appName) then
			v:focus()
			return v
		end
	end

	return nil
end

hs.hotkey.bind({ "alt" }, "z", function()
	focusByApp("zoom")
end)
