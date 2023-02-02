local ok, bind = pcall(require, "misc.keymaps.bind")
if not ok then return end

-- By default the options silent and noremap are set for every keymap
-- If you need to disable any, use :no_silent() or :no_remap()
--
-- Common
local map_cmd = bind.map_cmd -- [cmd] Note: dont try to use cmd only, neovim doesnt recognize it
local cr = bind.cr -- :[cmd]<CR>
local cu = bind.cu -- :<C-u>[cmd]<CR>
local args = bind.args -- :[cmd]<Space>
local lua = bind.lua -- :lua [cmd]<CR>

-- Special bindindings
local lazy = bind.lazy -- :Lazy
local lspsaga = bind.lspsaga -- :Lspsaga
local dap = bind.dap -- :lua require('dap').
local te = bind.te -- :Telescope

-- local severity = vim.diagnostic.severity.ERROR
local keymaps = {
	["n|n"] = map_cmd("nzzzv"),
	["n|N"] = map_cmd("Nzzzv"),
	["i|jk"] = map_cmd("<esc>"),
	["n|<C-c>"] = map_cmd("<Esc>"):desc("Escape"),
	["n|<Tab>"] = map_cmd("za"):desc("Toggle fold"),
	["n|J"] = map_cmd("mzJ`z"):desc("Join line"),
	["n|<S-Tab>"] = map_cmd("zM"):desc("Close all folds"),
	["n|fp"] = map_cmd("mz=ip`zk"):desc("Format paragraph"),
	["n|=="] = map_cmd("mz=ip`zk"):desc("Format paragraph"),
	["n|<C-j>"] = map_cmd("<C-w>j"):desc("Move to window below"),
	["n|<C-k>"] = map_cmd("<C-w>k"):desc("Move to window above"),
	["n|<C-h>"] = map_cmd("<C-w>h"):desc("move to window on left"),
	["n|<C-l>"] = map_cmd("<C-w>l"):desc("Move to window on right"),

	["n|<S-l>"] = cr("bnext"):desc("Open next buffer"),
	["n|<leader>q"] = cr("Bdelete"):desc("Close buffer"),
	["n|<leader>w"] = cr("silent update"):desc("Save file"),
	["n|<S-h>"] = cr("bprevious"):desc("Open previous buffer"),
	["n|<C-A-k>"] = cr("resize +2"):desc("Resize window upward"),
	["n|<C-A-j>"] = cr("resize -2"):desc("Resize window downward"),
	["n|<C-A-h>"] = cr("vertical resize -2"):desc("Resize window to left"),
	["n|<C-A-l>"] = cr("vertical resize +2"):desc("Resize window to left"),
	["n|;r"] = cr("silent w | SaveSession | so %"):desc("Source actual noevim file"),

	-- l.keymap('n', '<leader>/', function()
	--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown{ winblend = 10, previewer = false, }) end,
	--   { desc = '[/] Fuzzily search in current buffer]' }),
	-- l.keymap("n", "U", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
	-- Stay in indent mode

	-- Move text up and down
	["x|J"] = map_cmd(":move '>+1<CR>gv-gv"):desc(""),
	["x|K"] = map_cmd(":move '<-2<CR>gv-gv"):desc(""),
	["x|<A-j>"] = map_cmd(":move '>+1<CR>gv-gv"):desc(""),
	["x|<A-k>"] = map_cmd(":move '<-2<CR>gv-gv"):desc(""),
	["v,n|<A-k>"] = map_cmd(":m .-2<CR>=="):desc("Move text up"),
	["v,n|<A-j>"] = map_cmd(":m .+1<CR>=="):desc("Move text down"),

	-- Neotree
	["n|<leader>e"] = cr("Neotree toggle"):desc("Neotree: toggle"),
	["n|gg"] = lua("_Lazygit_toggle()"):desc("Lazygit: toggle"),
	["n|<leader>r"] = lua("_Rust_toggle()"):desc("Rust Cargo Run: terminal"),

	["n|;f"] = cr("Format"):desc("LSP: format file"),
	["n|gh"] = lspsaga("lsp_finder"):desc("Finder"),
	["n|go"] = lspsaga("outline"):desc("[g]oto [o]utline"),
	["n|gr"] = lspsaga("rename"):desc("Rename inside file"),
	["n,v|ga"] = lspsaga("code_action"):desc("Code Action"),
	["n|K"] = lspsaga("hover_doc"):desc("Hover documentation"),
	["n|gd"] = lspsaga("peek_definition"):desc("Peek definition"),
	["n|gD"] = lspsaga("goto_definition"):desc("[g]oTo [D]efinition"),
	["n|gR"] = lspsaga("rename ++projecj"):desc("Rename in whole project"),
	["n|gE"] = lspsaga("diagnostic_jump_prev"):desc("Jump next diagnostic"),
	["n|ge"] = lspsaga("diagnostic_jump_next"):desc("Jump previous diagnostic"),
	["n|gs"] = lspsaga("lua vim.lsp.buf.signature_help()"):desc("[G]oTo [S]ignature"),
	["n|<Leader>ci"] = lspsaga("incoming_calls"):desc("Incoming Calls"),
	["n|<Leader>co"] = lspsaga("outgoing_calls"):desc("Outgoing Calls"),
	["n|<leader>sl"] = lspsaga("show_line_diagnostics"):desc("[S]how [L]ine diagnostics"),
	["n|<leader>sb"] = lspsaga("show_buf_diagnostics"):desc("[S]how [B]uffer diagnostics"),
	["n|<leader>sc"] = lspsaga("show_cursor_diagnostics"):desc("[S]how [C]ursor diagnostics"),

	-- Lazy
	["n|<leader>po"] = lazy(""):desc("[O]pen"),
	["n|<leader>pl"] = lazy("log"):desc("[L]og"),
	["n|<leader>ps"] = lazy("sync"):desc("[S]ync"),
	["n|<leader>pc"] = lazy("check"):desc("[C]heck"),
	["n|<leader>pd"] = lazy("debug"):desc("[D]ebug"),
	["n|<leader>pu"] = lazy("update"):desc("[U]pdate"),
	["n|<leader>pp"] = lazy("profile"):desc("[P]rofile"),
	["n|<leader>pi"] = lazy("install"):desc("[I]nstall"),

	-- DAP
	["n|,o"] = dap("step_over()"):desc("step [O]ver"),
	["n|,p"] = dap("step_out()"):desc("Step out (prev)"),
	["n|,d"] = dap("continue()"):desc("Open dap interface"),
	["n|,n"] = dap("step_into()"):desc("step [I]nto (next)"),
	["n|,c"] = dap("terminate() require('dapui').close()"):desc("[C]lose"),
	["n|,b"] = dap("set_breakpoint(vim.fn.input('Breakpoint condition: '))"):desc("set [B]reakpoint"),
	["n|,rc"] = dap("run_to_cursor()"):desc("[R]un to [C]ursor"),
	["n|,ro"] = dap("repl.open()"):desc("[R]EPL [O]pen"),
	["n|,rl"] = dap("run_last()"):desc("[R]un [l]ast"),

	-- Telescope
	["n|<leader>fp"] = te("project"):desc("[F]ind [P]rojects"),
	["n|<leader>fe"] = te("frecency"):desc("[F]ind fr[E]cency"),
	["n|<leader>fb"] = te("file_browser"):desc("[F]ind Browser"),
	["n|<leader>fr"] = te(".oldfiles()"):desc("[F]ind [R]ecent"),
	["n|<leader>ff"] = te(".find_files()"):desc("[F]ind [F]iles"),
	["n|<leader>fw"] = te(".grep_string()"):desc("[F]ind [W]ord"),
	["n|<leader>sh"] = te(".help_tags()"):desc("[S]earch [H]elp"),
	["n|<leader>sg"] = te(".live_grep()"):desc("[S]earch [G]rep??"),
	["n|<leader>sk"] = te(".l.keymaps()"):desc("[S]earch [K]eymaps"),
	["n|<leader>fg"] = te(".git_files()"):desc("[F]ind [G]it files"),
	["n|<leader>sd"] = te(".diagnostics()"):desc("[S]earch [D]iagnostics"),
	["n|<leader><space>"] = te(".buffers()"):desc("[S]earch [B]uffers"),
}

bind.load_mapping(keymaps)