-- Copyright 2025 Gilbert Francois Duivesteijn
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

local M = {}

function M.setup()
	local colors = {
		none = "none",

		--------------------------------------------------------------------------
		-- Base / terminal-like palette (keep all: used by syntax & some UI)
		--------------------------------------------------------------------------
		term = {
			black = "#000000",
			darkred = "#800000",
			darkorange = "#804000",
			darkgreen = "#008000",
			darkyellow = "#808000",
			darkblue = "#000080",
			darkmagenta = "#800080",
			darkcyan = "#008080",
			darkgrey = "#808080",
			lightgrey = "#c0c0c0",
			lightred = "#ff0000",
			lightorange = "#ff8000",
			lightgreen = "#00ff00",
			lightyellow = "#ffff00",
			lightblue = "#0000ff",
			lightmagenta = "#ff00ff",
			lightcyan = "#00ffff",
			white = "#ffffff",
		},

		--------------------------------------------------------------------------
		-- UI palette (surfaces, borders, separators, status/tab lines, selection)
		--------------------------------------------------------------------------
		ui = {
			surface = "#ffffff", -- NormalFloat / Pmenu background
			surface_nc = "#fbfbfb", -- NormalNC background
			subtle = "#f5f8fe", -- CursorLine & CursorColumn
			border = "#c0c0c0", -- FloatBorder, Blink borders, WinSeparator/VertSplit
			status_fg = "#e0e0e0",
			status_bg = "#005f87",
			wildmenu_fg = "#444444",
			wildmenu_bg = "#d0d0d0",
			selection_fg = "#000000", -- Visual
			selection_bg = "#d5e1ff",
		},

		--------------------------------------------------------------------------
		-- Editor palette (match braces, search, folds, cursorline/column, etc.)
		--------------------------------------------------------------------------
		editor = {
			matchparen_fg = "none",
			matchparen_bg = "#93d9d9",

			search_fg = "#444444",
			-- search_bg = "#ffff5f",
			search_bg = "#fcd47e",
			incsearch_bg = "#edebfc",
			cursearch_bg = "#a6d3ff",

			folded_fg = "#0087af",
			folded_bg = "#afd7ff",

			cursorline_bg = "#f5f8fe",
			cursorcolumn_bg = "#f5f8fe",

			nontext_fg = "#ffaa00",
			eob_fg = "#000000",
		},

		--------------------------------------------------------------------------
		-- Diff palette
		--------------------------------------------------------------------------
		diff = {
			add_fg = "#008000",
			add_bg = "#aadeaa",
			delete_fg = "#800000",
			delete_bg = "#ffc8bd",
			text_fg = "#808000",
			text_bg = "#fcd47e",
			change_fg = "#000080",
			change_bg = "#b6d2f2",
		},

		--------------------------------------------------------------------------
		-- LSP palette (severity “brand” colors)
		--------------------------------------------------------------------------
		lsp = {
			error = "#ff0000",
			warn = "#ff8000",
			info = "#0000ff",
			hint = "#00ff00",
		},
	}

	---------------------------------------------------------------------------
	-- UI & Editor highlight groups
	---------------------------------------------------------------------------
	local common = {
		-- Core surfaces / borders
		Normal = { fg = colors.term.black },
		NormalFloat = { bg = colors.ui.surface },
		NormalNC = { bg = colors.ui.surface_nc },
		FloatBorder = { fg = colors.ui.border, bg = colors.none },
		FloatTitle = { fg = colors.term.darkblue, bold = true },
		FloatFooter = { fg = colors.term.darkblue, bold = true },
		WinSeparator = { fg = colors.ui.border },
		VertSplit = { fg = colors.ui.border },

		-- Cursor / line/column
		Cursor = { reverse = true },
		iCursor = { reverse = true },
		lCursor = { reverse = true },
		vCursor = { reverse = true },
		CursorLine = { fg = colors.none, bg = colors.editor.cursorline_bg },
		CursorColumn = { fg = colors.none, bg = colors.editor.cursorcolumn_bg },
		CursorLineNr = { fg = colors.term.darkgrey, bg = colors.editor.cursorline_bg },

		-- Numbers & non-text
		LineNr = { fg = colors.term.lightgrey },
		LineNrAbove = { fg = colors.term.lightgrey },
		LineNrBelow = { fg = colors.term.lightgrey },
		NonText = { fg = colors.term.darkgrey },
		EndOfBuffer = { fg = colors.editor.eob_fg },

		-- Menus / popups
		Pmenu = { fg = colors.term.black, bg = colors.ui.surface },
		PmenuSel = { link = "Visual" },
		PmenuSbar = { bg = colors.term.lightgrey },
		PmenuThumb = { bg = colors.term.darkgrey },
		WildMenu = { fg = colors.ui.wildmenu_fg, bg = colors.ui.wildmenu_bg, bold = true },

		-- Visual selection
		Visual = { fg = colors.ui.selection_fg, bg = colors.ui.selection_bg },
		VisualNOS = { fg = colors.ui.selection_fg, bg = colors.term.lightgrey },

		-- Statusline / Tabline
		StatusLine = { fg = colors.ui.status_fg, bg = colors.ui.status_bg, bold = false },
		StatusLineNC = { fg = colors.ui.status_fg, bg = colors.ui.status_bg, bold = false },
		TabLine = { fg = colors.ui.status_fg, bg = colors.ui.status_bg },
		TabLineFill = { fg = colors.ui.status_fg, bg = colors.ui.status_bg },
		TabLineSel = { fg = colors.ui.status_bg, bg = colors.ui.status_fg },

		-- Editor: search & substitute
		Search = { fg = colors.editor.search_fg, bg = colors.editor.search_bg },
		IncSearch = { fg = colors.none, bg = colors.editor.incsearch_bg },
		CurSearch = { fg = colors.none, bg = colors.editor.cursearch_bg },
		Substitute = { fg = colors.none, bg = colors.diff.text_bg },

		-- Editor: parentheses / matching
		MatchParen = { fg = colors.editor.matchparen_fg, bg = colors.editor.matchparen_bg },

		-- Editor: folds
		FoldColumn = { fg = colors.term.lightgrey, bg = colors.none },
		Folded = { fg = colors.editor.folded_fg, bg = colors.editor.folded_bg },

		-- Misc UI
		ColorColumn = { fg = colors.none, bg = colors.none },
		Conceal = { fg = colors.term.lightgrey },
		Directory = { fg = colors.term.darkblue },
		MsgArea = { fg = colors.term.black },
		ModeMsg = { fg = colors.term.darkgreen },
		MoreMsg = { fg = colors.term.darkgreen },
		Question = { fg = colors.term.darkyellow },
		QuickfixLine = { fg = colors.term.darkgreen },
		SpecialKey = { fg = colors.term.darkmagenta },
		WinBar = { fg = colors.term.black, bg = colors.none },
		WinBarNC = { fg = colors.term.black, bg = colors.term.white },

		-- Diff UI
		DiffAdd = { fg = colors.diff.add_fg, bg = colors.diff.add_bg },
		DiffChange = { fg = colors.diff.change_fg, bg = colors.diff.change_bg },
		DiffDelete = { fg = colors.diff.delete_fg, bg = colors.diff.delete_bg },
		DiffText = { fg = colors.diff.text_fg, bg = colors.diff.text_bg },
		DiffChanged = { fg = colors.term.darkblue },
		DiffDeleted = { fg = colors.term.darkred },
		DiffFile = { fg = colors.term.darkcyan },
		DiffIndexLine = { fg = colors.term.darkgrey },

		-- Blink borders (keep these for consistency with FloatBorder)
		BlinkCmpMenuBorder = { fg = colors.ui.border },
		BlinkCmpDocBorder = { fg = colors.ui.border },
		BlinkCmpSignatureHelpBorder = { fg = colors.ui.border },

		-- Messages / errors (non-LSP)
		ErrorMsg = { fg = colors.lsp.error },
		WarningMsg = { fg = colors.lsp.warn },
	}

	---------------------------------------------------------------------------
	-- LSP & Diagnostics
	---------------------------------------------------------------------------
	local lsp = {
		-- Base severities
		DiagnosticError = { fg = colors.lsp.error },
		DiagnosticWarn = { fg = colors.lsp.warn },
		DiagnosticInfo = { fg = colors.lsp.info },
		DiagnosticHint = { fg = colors.lsp.hint },

		-- Inline virtual text (higher contrast on light bg)
		DiagnosticVirtualTextError = { fg = colors.term.darkred, bg = "#ffe9e9" },
		DiagnosticVirtualTextWarn = { fg = colors.term.darkorange, bg = "#fff4d6" },
		DiagnosticVirtualTextInfo = { fg = colors.term.darkblue, bg = "#e9f1ff" },
		DiagnosticVirtualTextHint = { fg = colors.term.darkgreen, bg = "#e9ffe9" },

		-- Underlines
		DiagnosticUnderlineError = { undercurl = true, sp = colors.term.lightred },
		DiagnosticUnderlineWarn = { undercurl = true, sp = colors.term.lightorange },
		DiagnosticUnderlineInfo = { undercurl = true, sp = colors.term.lightblue },
		DiagnosticUnderlineHint = { undercurl = true, sp = colors.term.lightgreen },

		-- Signs
		DiagnosticSignError = { fg = colors.term.lightred },
		DiagnosticSignWarn = { fg = colors.term.lightorange },
		DiagnosticSignInfo = { fg = colors.term.lightblue },
		DiagnosticSignHint = { fg = colors.term.lightgreen },

		-- Floating diagnostic window text (content color; border uses FloatBorder)
		DiagnosticFloatingError = { fg = colors.term.darkred },
		DiagnosticFloatingWarn = { fg = colors.term.darkorange },
		DiagnosticFloatingInfo = { fg = colors.term.darkblue },
		DiagnosticFloatingHint = { fg = colors.term.darkgreen },

		-- Backward-compat links (old LSP groups → new)
		LspDiagnosticsDefaultError = { link = "DiagnosticError" },
		LspDiagnosticsDefaultWarning = { link = "DiagnosticWarn" },
		LspDiagnosticsDefaultInformation = { link = "DiagnosticInfo" },
		LspDiagnosticsDefaultHint = { link = "DiagnosticHint" },
		LspDiagnosticsUnderlineError = { link = "DiagnosticUnderlineError" },
		LspDiagnosticsUnderlineWarning = { link = "DiagnosticUnderlineWarn" },
		LspDiagnosticsUnderlineInformation = { link = "DiagnosticUnderlineInfo" },
		LspDiagnosticsUnderlineHint = { link = "DiagnosticUnderlineHint" },
		LspDiagnosticsVirtualTextError = { link = "DiagnosticVirtualTextError" },
		LspDiagnosticsVirtualTextWarning = { link = "DiagnosticVirtualTextWarn" },
		LspDiagnosticsVirtualTextInformation = { link = "DiagnosticVirtualTextInfo" },
		LspDiagnosticsVirtualTextHint = { link = "DiagnosticVirtualTextHint" },
	}

	---------------------------------------------------------------------------
	-- Syntax highlight groups (kept from your original, using colors.term)
	---------------------------------------------------------------------------
	local syntax = {
		Boolean = { fg = colors.term.darkblue, bold = true },
		Character = { fg = colors.term.darkblue, bold = true },
		Comment = { fg = colors.term.darkgrey, italic = true },
		Conditional = { fg = colors.term.darkblue, bold = true },
		Constant = { fg = colors.term.darkmagenta, italic = true, bold = true },
		Define = { fg = colors.term.darkgrey },
		Delimiter = { fg = colors.term.black },
		Error = { fg = colors.term.darkred },
		Exception = { fg = colors.term.darkblue, bold = true },
		Float = { fg = colors.term.lightblue },
		Function = { fg = colors.term.black },
		Identifier = { fg = colors.term.black },
		Include = { fg = colors.term.darkblue, bold = true },
		Keyword = { fg = colors.term.darkblue, bold = true },
		Label = { fg = colors.term.darkblue, bold = true },
		Macro = { fg = colors.term.darkgrey },
		Number = { fg = colors.term.lightblue },
		Operator = { fg = colors.term.black },
		PreCondit = { fg = colors.term.darkgrey },
		PreProc = { fg = colors.term.darkgrey },
		Repeat = { fg = colors.term.darkblue, bold = true },
		Special = { fg = colors.term.black },
		SpecialChar = { fg = colors.term.black },
		SpecialComment = { fg = colors.term.black },
		Statement = { fg = colors.term.darkblue, bold = true },
		StorageClass = { fg = colors.term.black },
		String = { fg = colors.term.darkgreen },
		Structure = { fg = colors.term.black },
		Tag = { fg = colors.term.black },
		Title = { fg = colors.term.darkcyan },
		Type = { fg = colors.term.black },
		Typedef = { fg = colors.term.black },

		Debug = { fg = colors.term.black },
		Underlined = { fg = colors.none },
		Todo = { fg = colors.term.black, bg = colors.term.lightyellow },

		["@variable"] = { link = "Normal" },
		["@variable.builtin"] = { fg = colors.term.darkmagenta },
		["@variable.parameter"] = { fg = colors.term.darkmagenta },

		["@string"] = { link = "String" },
		["@string.documentation"] = { link = "Comment" },

		["@boolean"] = { fg = colors.term.darkblue, bold = true },

		["@attribute"] = { fg = "#9e880d" },
		["@attribute.builtin"] = { fg = "#9e880d" },

		["@function"] = { fg = "#00627a" },
		["@function.call"] = { link = "Function" },
		["@function.builtin"] = { fg = colors.term.darkmagenta },
		["@function.method"] = { fg = "#00627a" },
		["@function.method.call"] = { link = "Function" },

		["@keyword.import"] = { fg = colors.term.darkblue, bold = true },

		["@comment"] = { link = "Comment" },
	}

	---------------------------------------------------------------------------
	-- Extras for your loaded plugins (Telescope, DAP, which-key, GitSigns, blink)
	---------------------------------------------------------------------------
	local extras = {
		-- LSP context
		LspReferenceText = { bg = "#edebfc" },
		LspReferenceRead = { bg = "#edebfc" },
		LspReferenceWrite = { bg = "#fce8f4" },
		LspSignatureActiveParameter = { bold = true, fg = colors.term.black, bg = "#f0f4ff" },
		LspInlayHint = { fg = colors.term.darkgrey, bg = colors.ui.surface_nc },
		LspCodeLens = { fg = colors.term.darkgrey, italic = true },
		LspCodeLensSeparator = { fg = colors.term.lightgrey },
		LspInfoBorder = { link = "FloatBorder" },

		DiagnosticOk = { fg = colors.term.darkgreen },
		DiagnosticVirtualTextOk = { fg = colors.term.darkgreen, bg = "#e9ffe9" },
		DiagnosticSignOk = { fg = colors.term.darkgreen },
		DiagnosticFloatingOk = { fg = colors.term.darkgreen },

		-- Core UI odds-and-ends
		MsgSeparator = { fg = colors.ui.border },
		NormalFloatNC = { bg = colors.ui.surface_nc },
		Whitespace = { fg = colors.term.lightgrey },

		-- Telescope
		TelescopeNormal = { bg = colors.ui.surface, fg = colors.term.black },
		TelescopeBorder = { fg = colors.ui.border },
		TelescopeTitle = { fg = colors.term.darkblue, bold = true },
		TelescopePromptNormal = { bg = colors.ui.surface },
		TelescopePromptBorder = { fg = colors.ui.border },
		TelescopeResultsBorder = { fg = colors.ui.border },
		TelescopePreviewBorder = { fg = colors.ui.border },
		TelescopeSelection = { bg = colors.ui.selection_bg, fg = colors.ui.selection_fg },

		-- GitSigns inline hunks
		GitSignsAddInline = { fg = colors.term.darkgreen, bg = "#eaffea" },
		GitSignsChangeInline = { fg = colors.term.darkblue, bg = "#eef5ff" },
		GitSignsDeleteInline = { fg = colors.term.darkred, bg = "#ffe9e9" },

		-- DAP + DAP‑UI
		DapBreakpoint = { fg = colors.term.lightred },
		DapBreakpointCondition = { fg = colors.term.lightorange },
		DapBreakpointRejected = { fg = colors.term.darkgrey },
		DapStopped = { fg = colors.term.lightgreen },
		DapLogPoint = { fg = colors.term.lightblue },

		DapUIScope = { fg = colors.term.darkblue },
		DapUIType = { fg = colors.term.darkmagenta },
		DapUIValue = { fg = colors.term.black },
		DapUIVariable = { fg = colors.term.black },
		DapUIModifiedValue = { fg = colors.term.darkorange },
		DapUIDecoration = { fg = colors.ui.border },
		DapUIThread = { fg = colors.term.darkgreen },
		DapUIStoppedThread = { fg = colors.term.darkgreen },
		DapUISource = { fg = colors.term.darkcyan },
		DapUILineNumber = { fg = colors.term.darkgrey },
		DapUIWatchesError = { fg = colors.term.lightred },
		DapUIWatchesEmpty = { fg = colors.term.lightorange },
		DapUIWatchesValue = { fg = colors.term.darkgreen },
		DapUIFloatBorder = { link = "FloatBorder" },

		-- which-key
		WhichKey = { fg = colors.term.darkblue, bold = true },
		WhichKeyGroup = { fg = colors.term.darkmagenta },
		WhichKeyDesc = { fg = colors.term.black },
		WhichKeySeparator = { fg = colors.term.darkgrey },
		WhichKeyValue = { fg = colors.term.darkgrey },

		-- blink.cmp surfaces (borders already matched via FloatBorder)
		BlinkCmpMenu = { bg = colors.ui.surface, fg = colors.term.black },
		BlinkCmpDoc = { bg = colors.ui.surface, fg = colors.term.black },
		BlinkCmpSignatureHelp = { bg = colors.ui.surface, fg = colors.term.black },
	}

	-- Apply groups
	for group, opts in pairs(common) do
		vim.api.nvim_set_hl(0, group, opts)
	end
	for group, opts in pairs(lsp) do
		vim.api.nvim_set_hl(0, group, opts)
	end
	for group, opts in pairs(syntax) do
		vim.api.nvim_set_hl(0, group, opts)
	end
	for group, opts in pairs(extras) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

function M.load()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.o.termguicolors = true
	vim.g.colors_name = "intellij_light"
	vim.cmd([[ colorscheme intellij_light ]])
end

return M
