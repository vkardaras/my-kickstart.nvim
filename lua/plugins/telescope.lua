return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			"nvim-tree/nvim-web-devicons",
			"folke/todo-comments.nvim",
		},
		opts = {
			defaults = {
				layout_config = {
					vertical = {
						width = 0.75,
					},
				},
				path_display = {
					filename_first = {
						reverse_directories = true,
					},
				},
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					path_display = { "smart" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},
				},
				extensions = {
					fzf = {},
				},
			})

			telescope.load_extension("fzf")

			require("config.telescope.multigrep").setup()
		end,
	},
	{
		-- https://github.com/nvim-telescope/telescope-ui-select.nvim
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
