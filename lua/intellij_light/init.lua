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
			surface_nc = "#ffffff", -- NormalNC background
			subtle = "#f5f8fe", -- CursorLine & CursorColumn
			border = "#d4d4d4", -- FloatBorder, Blink borders, WinSeparator/VertSplit
			status_fg = "#e0e0e0",
			status_bg = "#005f87",
			wildmenu_fg = "#444444",
			wildmenu_bg = "#d0d0d0",
			selection_fg = "none",
			selection_bg = "#a6d2ff",
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
			incsearch_bg = "#ffcdff",
			cursearch_bg = "#a6d3ff",

			-- folded_fg = "#0087af",
			-- folded_bg = "#afd7ff",
			folded_fg = "#414d41",
			folded_bg = "#e9f5e6",

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

		jet = {
			text = "#080808",
			keyword = "#0033b3",
			string = "#067d17",
			number = "#1750eb",
			comment = "#8c8c8c",
			constant = "#871094",
			func = "#00627a",
			attr = "#174ad4",
		},
	}

	---------------------------------------------------------------------------
	-- UI & Editor highlight groups
	---------------------------------------------------------------------------
	local common = {
		---------------------------------------------------------------------------
		-- Core surfaces / layout (JetBrains-like)
		---------------------------------------------------------------------------
		Normal = { fg = colors.jet.text, bg = colors.ui.surface },
		NormalNC = { fg = colors.jet.text, bg = colors.ui.surface_nc },
		MsgArea = { fg = colors.jet.text, bg = colors.ui.surface },

		-- Gutters (JetBrains light has a subtle gutter; keep it almost-white)
		SignColumn = { fg = colors.none, bg = colors.ui.surface },
		FoldColumn = { fg = "#aeb3c2", bg = colors.ui.surface },
		LineNr = { fg = "#aeb3c2", bg = colors.ui.surface },
		LineNrAbove = { fg = "#aeb3c2", bg = colors.ui.surface },
		LineNrBelow = { fg = "#aeb3c2", bg = colors.ui.surface },
		CursorLineNr = { fg = "#767a8a", bg = colors.editor.cursorline_bg },

		-- Splits / separators
		WinSeparator = { fg = colors.ui.border, bg = colors.none },
		VertSplit = { fg = colors.ui.border, bg = colors.none },

		-- Non-text / end-of-buffer
		NonText = { fg = "#c6c6c6", bg = colors.none },
		EndOfBuffer = { fg = colors.ui.surface, bg = colors.ui.surface },

		---------------------------------------------------------------------------
		-- Floating windows / popups (JetBrains-like)
		---------------------------------------------------------------------------
		NormalFloat = { fg = colors.jet.text, bg = colors.ui.surface },
		FloatBorder = { fg = colors.ui.border, bg = colors.ui.surface },
		FloatTitle = { fg = colors.jet.keyword, bg = colors.ui.surface, bold = false },
		FloatFooter = { fg = colors.jet.keyword, bg = colors.ui.surface, bold = false },

		---------------------------------------------------------------------------
		-- Cursor / line & column highlights
		---------------------------------------------------------------------------
		Cursor = { reverse = true },
		iCursor = { reverse = true },
		lCursor = { reverse = true },
		vCursor = { reverse = true },

		CursorLine = { fg = colors.none, bg = colors.editor.cursorline_bg },
		CursorColumn = { fg = colors.none, bg = colors.editor.cursorcolumn_bg },

		---------------------------------------------------------------------------
		-- Menus (completion, wildmenu)
		---------------------------------------------------------------------------
		Pmenu = { fg = colors.jet.text, bg = colors.ui.surface },
		PmenuSel = { fg = colors.none, bg = colors.ui.selection_bg },
		PmenuSbar = { bg = "#e6e6e6" },
		PmenuThumb = { bg = "#c8c8c8" },
		WildMenu = { fg = colors.jet.text, bg = "#e9eefc", bold = false },

		---------------------------------------------------------------------------
		-- Visual selection
		---------------------------------------------------------------------------
		Visual = { fg = colors.none, bg = colors.ui.selection_bg },
		VisualNOS = { fg = colors.none, bg = "#e7effd" },

		---------------------------------------------------------------------------
		-- Statusline / Tabline (more IDE-like: light neutral bar)
		---------------------------------------------------------------------------
		StatusLine = { fg = colors.jet.text, bg = "#f2f2f2", bold = false },
		StatusLineNC = { fg = "#666666", bg = "#f2f2f2", bold = false },

		TabLine = { fg = "#444444", bg = "#f2f2f2" },
		TabLineFill = { fg = "#444444", bg = "#f2f2f2" },
		TabLineSel = { fg = colors.jet.text, bg = colors.ui.surface, bold = false },

		---------------------------------------------------------------------------
		-- Search / replace (keep your tuned search colors)
		---------------------------------------------------------------------------
		Search = { fg = colors.editor.search_fg, bg = colors.editor.search_bg },
		IncSearch = { fg = colors.none, bg = colors.editor.incsearch_bg },
		CurSearch = { fg = colors.none, bg = colors.editor.cursearch_bg },
		Substitute = { fg = colors.none, bg = colors.diff.text_bg },

		---------------------------------------------------------------------------
		-- Matching / folds
		---------------------------------------------------------------------------
		MatchParen = { fg = colors.editor.matchparen_fg, bg = colors.editor.matchparen_bg },
		Folded = { fg = colors.editor.folded_fg, bg = colors.editor.folded_bg },

		---------------------------------------------------------------------------
		-- Misc UI
		---------------------------------------------------------------------------
		ColorColumn = { fg = colors.none, bg = "#f5f5f5" },
		Conceal = { fg = "#808080" },
		Directory = { fg = colors.jet.keyword },
		ModeMsg = { fg = colors.term.darkgreen },
		MoreMsg = { fg = colors.term.darkgreen },
		Question = { fg = colors.term.darkyellow },
		QuickfixLine = { fg = colors.jet.text, bg = "#e7effd" },
		SpecialKey = { fg = "#a0a0a0" },

		-- Winbar (keep subtle, close to JetBrains breadcrumb feel)
		WinBar = { fg = colors.jet.text, bg = colors.ui.surface },
		WinBarNC = { fg = "#666666", bg = colors.ui.surface_nc },

		---------------------------------------------------------------------------
		-- Diff UI (KEEP AS CLOSE AS POSSIBLE TO YOUR CURRENT LOOK)
		---------------------------------------------------------------------------
		DiffAdd = { fg = colors.diff.add_fg, bg = colors.diff.add_bg },
		DiffChange = { fg = colors.diff.change_fg, bg = colors.diff.change_bg },
		DiffDelete = { fg = colors.diff.delete_fg, bg = colors.diff.delete_bg },
		DiffText = { fg = colors.diff.text_fg, bg = colors.diff.text_bg },
		DiffChanged = { fg = colors.term.darkblue },
		DiffDeleted = { fg = colors.term.darkred },
		DiffFile = { fg = colors.term.darkcyan },
		DiffIndexLine = { fg = colors.term.darkgrey },

		---------------------------------------------------------------------------
		-- Blink borders (keep consistent with FloatBorder)
		---------------------------------------------------------------------------
		BlinkCmpMenuBorder = { fg = colors.ui.border, bg = colors.ui.surface },
		BlinkCmpDocBorder = { fg = colors.ui.border, bg = colors.ui.surface },
		BlinkCmpSignatureHelpBorder = { fg = colors.ui.border, bg = colors.ui.surface },

		---------------------------------------------------------------------------
		-- Messages / errors (non-LSP)
		---------------------------------------------------------------------------
		ErrorMsg = { fg = colors.lsp.error, bg = colors.none },
		WarningMsg = { fg = colors.lsp.warn, bg = colors.none },
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
		-- Classic Vim syntax groups (JetBrains-ish)
		Boolean = { fg = colors.jet.keyword },
		Character = { fg = colors.jet.string },
		Comment = { fg = colors.jet.comment, italic = true },
		Conditional = { fg = colors.jet.keyword },
		Constant = { fg = colors.jet.constant, italic = true },
		Debug = { fg = colors.jet.attr },
		Define = { fg = colors.jet.keyword },
		Delimiter = { fg = colors.jet.text },
		Error = { fg = colors.term.darkred },
		Exception = { fg = colors.jet.keyword },
		Float = { fg = colors.jet.number },
		Function = { fg = colors.jet.func },
		Identifier = { fg = colors.jet.text },
		Include = { fg = colors.jet.keyword },
		Keyword = { fg = colors.jet.keyword },
		Label = { fg = colors.jet.keyword },
		Macro = { fg = colors.jet.keyword },
		Number = { fg = colors.jet.number },
		Operator = { fg = colors.jet.text },
		PreCondit = { fg = colors.jet.keyword },
		PreProc = { fg = colors.jet.keyword },
		Repeat = { fg = colors.jet.keyword },
		Special = { fg = colors.jet.attr },
		SpecialChar = { fg = colors.jet.attr },
		SpecialComment = { fg = colors.jet.comment, italic = true },
		Statement = { fg = colors.jet.keyword },
		StorageClass = { fg = colors.jet.keyword },
		String = { fg = colors.jet.string },
		Structure = { fg = colors.jet.keyword },
		Tag = { fg = colors.jet.attr },
		Title = { fg = colors.jet.keyword },
		Todo = { fg = "#008dde", italic = true },
		Type = { fg = colors.jet.text },
		Typedef = { fg = colors.jet.text },
		Underlined = { fg = colors.jet.attr, underline = true },

		-- Treesitter captures (corrected to match JetBrains Light behavior)
		["@comment"] = { link = "Comment" },
		["@comment.documentation"] = { fg = colors.jet.comment, italic = true },

		["@string"] = { link = "String" },
		["@string.documentation"] = { fg = colors.jet.comment, italic = true },
		["@string.escape"] = { fg = colors.jet.attr },
		["@string.special"] = { fg = colors.jet.attr },

		["@number"] = { link = "Number" },
		["@number.float"] = { link = "Float" },
		["@boolean"] = { link = "Boolean" },

		-- Identifiers
		["@variable"] = { fg = colors.jet.text },
		["@variable.builtin"] = { fg = colors.jet.constant },
		["@variable.parameter"] = { fg = colors.jet.text },
		["@parameter"] = { fg = colors.jet.text },

		-- members/fields in JetBrains are often emphasized (purple/italic fits your icls constant color)
		["@variable.member"] = { fg = colors.jet.text },
		["@property"] = { fg = colors.jet.constant, italic = true },
		["@field"] = { fg = colors.jet.constant, italic = true },

		["@constant"] = { link = "Constant" },
		["@constant.builtin"] = { fg = colors.jet.constant, italic = true },
		["@constant.macro"] = { fg = colors.jet.constant, italic = true },

		-- Functions
		["@function"] = { fg = colors.jet.func },
		["@function.builtin"] = { fg = colors.jet.func },
		-- JetBrains highlights declarations more than calls; calls can be normal text
		["@function.call"] = { fg = colors.jet.text },

		-- Keep your original method capture names
		["@function.method"] = { fg = colors.jet.func },
		["@function.method.call"] = { fg = colors.jet.text },

		-- Also include newer aliases used by many parsers/queries
		["@method"] = { fg = colors.jet.func },
		["@method.call"] = { fg = colors.jet.text },
		["@constructor"] = { fg = colors.jet.func },

		-- FIX: imports — only keywords blue; modules/names normal
		["@keyword"] = { fg = colors.jet.keyword },
		["@keyword.import"] = { fg = colors.jet.keyword }, -- import/from
		["@keyword.operator"] = { fg = colors.jet.keyword }, -- "as" often lands here (python)
		["@keyword.return"] = { fg = colors.jet.keyword },
		["@keyword.conditional"] = { fg = colors.jet.keyword },
		["@keyword.repeat"] = { fg = colors.jet.keyword },
		["@keyword.exception"] = { fg = colors.jet.keyword },
		["@keyword.function"] = { fg = colors.jet.keyword },

		-- These often represent the imported libs / namespaces
		["@module"] = { fg = colors.jet.text },
		["@namespace"] = { fg = colors.jet.text },

		["@operator"] = { link = "Operator" },
		["@punctuation.delimiter"] = { fg = colors.jet.text },
		["@punctuation.bracket"] = { fg = colors.jet.text },
		["@punctuation.special"] = { fg = colors.jet.attr },

		["@type"] = { fg = colors.jet.text },
		["@type.builtin"] = { fg = colors.jet.keyword },
		["@type.definition"] = { fg = colors.jet.text },

		-- Attributes / decorators / annotations
		["@attribute"] = { fg = colors.jet.attr },
		["@attribute.builtin"] = { fg = colors.jet.attr },
		["@annotation"] = { fg = colors.jet.attr },
		["@decorator"] = { fg = colors.jet.attr },

		-- Markup (safe extras)
		["@markup.underline"] = { link = "Underlined" },
		["@markup.link"] = { fg = colors.jet.attr, underline = true },
		["@markup.link.url"] = { fg = colors.jet.attr, underline = true },
		["@markup.raw"] = { fg = colors.jet.string },

		-- Tags (HTML/JSX)
		["@tag"] = { fg = colors.jet.attr },
		["@tag.attribute"] = { fg = colors.jet.constant, italic = true },
		["@tag.delimiter"] = { fg = colors.jet.text },

		["@error"] = { fg = colors.term.darkred },
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

		-- Neo-tree (icons gray, names black; changed/modified names dark blue)
		NeoTreeDirectoryIcon = { fg = colors.jet.comment },
		NeoTreeFileIcon = { fg = colors.jet.comment },
		NeoTreeDotfile = { fg = colors.jet.comment },
		NeoTreeExpander = { fg = colors.jet.comment },

		NeoTreeDirectoryName = { fg = colors.jet.text },
		NeoTreeFileName = { fg = colors.jet.text },
		NeoTreeRootName = { fg = colors.jet.text },
		NeoTreeSymbolicLinkTarget = { fg = colors.jet.text },

		-- Git status names (treat any “changed” state as dark blue)
		NeoTreeGitModified = { fg = colors.jet.keyword },
		NeoTreeGitUntracked = { fg = colors.jet.keyword },
		NeoTreeGitAdded = { fg = colors.jet.keyword },
		NeoTreeGitDeleted = { fg = colors.jet.keyword },
		NeoTreeGitStaged = { fg = colors.jet.keyword },
		NeoTreeGitConflict = { fg = colors.jet.keyword },

		-- Keep ignored/hidden dimmed
		NeoTreeGitIgnored = { fg = colors.jet.comment },
		NeoTreeHiddenByName = { fg = colors.jet.comment },
		NeoTreeIgnored = { fg = colors.jet.comment },

		WhichKeyNormal = { bg = colors.ui.surface_nc },
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
