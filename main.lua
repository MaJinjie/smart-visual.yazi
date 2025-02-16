---@alias Yazi.tab.mode "select"|"unset"|"normal" cx.active.mode
---
---@class smart_visual.setup.Opts
---@field persist_on_toggle boolean Whether to retain the selection of the previous mode when toggling between select and unset modes.

local S = {}

--- Check if the file under the cursor is part of the previous selection.
--- @overload fun():boolean
--- @return boolean is_selected
S.hovered_is_selected = ya.sync(function()
	local hovered_filename = cx.active.current.hovered.name

	for _, url in pairs(cx.active.selected) do
		if hovered_filename == url:name() then
			return true
		end
	end
	return false
end)

--- Get the current mode.
--- @overload fun():Yazi.tab.mode
--- @return Yazi.tab.mode
S.get_mode = ya.sync(function()
	return tostring(cx.active.mode)
end)

local M = {}

---@param job {args:{[1]: "select"|"unset"|"escape"}}
function M.entry(self, job)
	local action = job.args[1]
	local opts = self.opts or {} ---@type smart_visual.setup.Opts

	local mode = S.get_mode()

	if action == "escape" then
		-- In visual mode, cancel the current selection.
		if mode ~= "normal" then
			ya.manager_emit("visual_mode", { unset = not S.hovered_is_selected() })
			ya.manager_emit("escape", { visual = true })
		else
			ya.manager_emit("escape", {})
		end
	else
		-- When the current mode matches the applied mode, or when preserving the previous selection while toggling between select and unset.
		if action == mode or opts.persist_on_toggle ~= false then
			ya.manager_emit("escape", { visual = true })
		end
		-- When the current mode does not match the applied mode, switch immediately.
		if action ~= mode then
			ya.manager_emit("visual_mode", { unset = action == "unset" })
		end
	end
end

---@param opts smart_visual.setup.Opts
function M.setup(state, opts)
	state.opts = opts
end
return M
