local windowFilter = hs.window.filter.new()
local spaceFilter = hs.window.filter.new()

windowFilter:setDefaultFilter({})
windowFilter:setSortOrder(hs.window.filter.sortByFocusedLast)
spaceFilter:setDefaultFilter({})
spaceFilter:setCurrentSpace(true)
spaceFilter:setSortOrder(hs.window.filter.sortByCreated)

local function currentWindows()
	local windows = {}

	for i, v in ipairs(windowFilter:getWindows()) do
		table.insert(windows, v)
	end

	return windows
end

local function focusNextOnThisSpace(direction)
	local currWindow = hs.window.focusedWindow()
	local windows = spaceFilter:getWindows()

	for i, window in ipairs(windows) do
		if window:isVisible() then
			if window:id() == currWindow:id() then
				local selected = i + direction

				if selected <= 0 then
					selected = #windows
				elseif selected > #windows then
					selected = 1
				end

				windows[selected]:focus()
				return true
			end
		end
	end

	return false
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

hs.hotkey.bind({ "alt" }, "tab", function()
	focusNextOnThisSpace(1)
end)

hs.hotkey.bind({ "alt", "shift" }, "tab", function()
	focusNextOnThisSpace(-1)
end)
