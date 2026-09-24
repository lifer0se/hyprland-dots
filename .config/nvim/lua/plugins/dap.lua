return {
	'mfussenegger/nvim-dap',
	dependencies = {
		'rcarriga/nvim-dap-ui',
		'nvim-neotest/nvim-nio',
	},
	config = function()
		local dap = require('dap')

		local dapui = require("dapui")
		dapui.setup()
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		-- dap.listeners.before.event_terminated.dapui_config = function()
		-- 	dapui.close()
		-- end
		-- dap.listeners.before.event_exited.dapui_config = function()
		-- 	dapui.close()
		-- end


		vim.fn.sign_define('DapBreakpoint',
			{ text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
		vim.fn.sign_define('DapBreakpointCondition',
			{ text = 'ﳁ', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
		vim.fn.sign_define('DapBreakpointRejected',
			{ text = '', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
		vim.fn.sign_define('DapLogPoint', {
			text = '',
			texthl = 'DapLogPoint',
			linehl = 'DapLogPoint',
			numhl =
			'DapLogPoint'
		})
		vim.fn.sign_define('DapStopped',
			{ text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

		vim.keymap.set('n', '<F2>', function() require('dap').step_over() end)
		vim.keymap.set('n', '<F3>', function() require('dap').step_into() end)
		vim.keymap.set('n', '<F4>', function() require('dap').step_out() end)
		vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
		vim.keymap.set('n', '<F7>', function() require('dap').terminate() end)
		vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
		vim.keymap.set('n', '<Leader>dt', function() require('dapui').toggle() end)
		vim.keymap.set('n', '<Leader>de', function() require('dapui').eval() end)
		vim.keymap.set('n', '<Leader>df', function()
			local widgets = require('dap.ui.widgets')
			widgets.centered_float(widgets.frames)
		end)
		vim.keymap.set('n', '<Leader>ds', function()
			local widgets = require('dap.ui.widgets')
			widgets.centered_float(widgets.scopes)
		end)

		dap.adapters.godot = {
			type = "server",
			host = '127.0.0.1',
			port = 6006,
		}
		dap.configurations.gdscript = {
			{
				type = "godot",
				request = "launch",
				name = "Launch scene",
				project = "${workspaceFolder}",
				launch_scene = true,
			}
		}

		dap.adapters.codelldb = {
			type = 'server',
			port = "${port}",
			executable = {
				-- Change this to your path!
				command = '/home/amnesia/.local/share/nvim/mason/bin/codelldb',
				args = { "--port", "${port}" },
			}
		}

		dap.configurations.rust = {
			{
				name = 'Launch',
				type = 'codelldb',
				request = 'launch',
				program = function()
					return coroutine.create(function(coro)
						local opts = {}
						local pickers = require("telescope.pickers")
						local finders = require("telescope.finders")
						local conf = require("telescope.config").values
						local actions = require("telescope.actions")
						local action_state = require("telescope.actions.state")
						pickers
							.new(opts, {
								prompt_title = "Path to executable",
								finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
								sorter = conf.generic_sorter(opts),
								attach_mappings = function(buffer_number)
									actions.select_default:replace(function()
										actions.close(buffer_number)
										coroutine.resume(coro, action_state.get_selected_entry()[1])
									end)
									return true
								end,
							})
							:find()
					end)
				end,
				cwd = '${workspaceFolder}',
				stopOnEntry = false,
				args = {},
			},
		}
	end
}
