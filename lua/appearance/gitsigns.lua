return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			virt_text_delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		on_attach = function(buffer)
			local gs = require("gitsigns")
			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			end
			map("n", "]c", gs.next_hunk, "[Git] next hunk")
			map("n", "[c", gs.prev_hunk, "[Git] prev hunk")
			map({ "n", "v" }, "<leader>ghs", gs.stage_hunk, "[Git] stage hunk")
			map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, "[Git] reset hunk")
			map("n", "<leader>ghS", gs.stage_buffer, "[Git] stage buffer")
			map("n", "<leader>ghu", gs.undo_stage_hunk, "[Git] undo stage hunk")
			map("n", "<leader>ghR", gs.reset_buffer, "[Git] reset buffer")
			map("n", "<leader>ghp", gs.preview_hunk, "[Git] preview hunk")
			map("n", "<leader>ghb", function()
				gs.blame_line({ full = true })
			end, "[Git] blame line")
			map("n", "<leader>ghd", gs.diffthis, "[Git] diff this")
			map("n", "<leader>ghD", function()
				gs.diffthis("~")
			end, "[Git] diff this ~")
			map("n", "<leader>ghw", gs.toggle_words, "[Git] toggle words")
		end,
	},
}
